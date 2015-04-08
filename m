From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/25] list-files: delete redundant cached entries
Date: Tue, 07 Apr 2015 19:39:01 -0700
Message-ID: <xmqqzj6jbayi.fsf@gitster.dls.corp.google.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-19-git-send-email-pclouds@gmail.com>
	<CAPig+cTDHf5Wh92SLHfQ0_GRY0cbpz+ALfiukJJHed6d=QmLdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:39:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfftX-000071-3T
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 04:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbbDHCjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 22:39:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753219AbbDHCjD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 22:39:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 371C147E03;
	Tue,  7 Apr 2015 22:39:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DkAIL9VIWiUa
	KSIEDOGsRAwUdf0=; b=XJFFOUG77J91KwgOjMAzk6lxaelGMKIHGRTctKcFNcg4
	Z9j/f7rXjhhte0wDnZvPtHks5O2Wxiu8T0xEtMrJom07CjsruSr/4eHMujkbE7LU
	ItqPeqyEKoYRRvs7oveCBoBerx3x5Nue3Bz6HlFrvph+iI2lJcGxG/FZng9HOdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VuJvCB
	g2tiRoaTHDyOryXYW1B4/dOOKOCs5dYKI61dZZtP5JEdEmLKmH/TtSzmdMetS/fu
	DBCxwo172hsCArsh9Itt7PBuEp1fUJmgQiVoikQ/kx9IYeRdGkm+5I08ekUhqqux
	8Me4gPGdpE1k/L44PJmsShdvBnVDOtEOOJdKM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F51C47E00;
	Tue,  7 Apr 2015 22:39:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EC6F47DFF;
	Tue,  7 Apr 2015 22:39:02 -0400 (EDT)
In-Reply-To: <CAPig+cTDHf5Wh92SLHfQ0_GRY0cbpz+ALfiukJJHed6d=QmLdg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 6 Apr 2015 17:35:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6AECC89C-DD98-11E4-B560-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266947>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> When both --cached and one of -amdAMD is used together we may have t=
wo
>> entries of the same path, e.g. "  foo" and "MM foo". In this case it=
's
>> pretty clear that "foo" must be tracked, no need to display "   foo"=
=2E
>> The new function does that.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/builtin/list-files.c b/builtin/list-files.c
>> index 14ffd62..31c2336 100644
>> --- a/builtin/list-files.c
>> +++ b/builtin/list-files.c
>> @@ -93,7 +93,10 @@ static int compare_item(const void *a_, const voi=
d *b_)
>>  {
>>         const struct item *a =3D a_;
>>         const struct item *b =3D b_;
>> -       return strcmp(a->path, b->path);
>> +       int ret =3D strcmp(a->path, b->path);
>> +       if (ret)
>> +               return ret;
>> +       return strncmp(a->tag, b->tag, 2);
>>  }
>>
>>  static void free_item(struct item *item)
>> @@ -132,7 +135,12 @@ static void remove_duplicates(struct item_list =
*list)
>>         for (src =3D dst =3D 1; src < list->nr; src++) {
>>                 if (!compare_item(list->items + dst - 1, list->items=
 + src))
>>                         free_item(list->items + src);
>> -               else
>> +               else if ((list->items[dst - 1].tag[0] =3D=3D ' ' &&
>> +                         list->items[dst - 1].tag[1] =3D=3D ' ' &&
>> +                         !strcmp(list->items[src].path, list->items=
[dst - 1].path))) {
>> +                       free_item(list->items + dst - 1);
>> +                       list->items[dst - 1] =3D list->items[src];
>
> I was wondering if you could drop this backward-patching case by
> having tag=3D=3D"  " items sort after tag=3D"xx" items and just fold =
out the
> tag=3D=3D"  " items normally in the preceding 'if', however, when I
> started coding it, I found that the resulting code wasn't any more
> pleasant.


You may read from wt-status and then index (or the other way around)
into the set of files to be listed---instead of deduping at the end,
you should logically do "add in from index only for entries we did
not see in wt-status output".  So some deduping is necessary.

But I actually think that the worst aspect of the series this part
of the code shows is the same issue I raised in the previous review
round in the approach, which has not been addressed at all as far as
I can see in this round.

Why does tag[] record the semantic meaning in textual form?  Isn't
this a sympotom that shows the code is turning the information into
textual form way too early, which makes the code very unpleasant to
read and hard to maintain and modify.
