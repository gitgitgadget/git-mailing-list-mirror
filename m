From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] format-patch: add --filename-prefix to prepend a prefix 
	to output file names
Date: Mon, 15 Jun 2009 09:32:37 +1000
Message-ID: <fcaeb9bf0906141632l5f39e6et7b37cfad9d274df8@mail.gmail.com>
References: <7vr5xsozcm.fsf@alter.siamese.dyndns.org> <1244963400-1739-1-git-send-email-pclouds@gmail.com> 
	<4A34B4ED.6060301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 01:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFzCG-0004xr-GK
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 01:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbZFNXc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbZFNXc4
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 19:32:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:35355 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983AbZFNXcz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2009 19:32:55 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2329056ywb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LFcz+Phfb67EbAScYOTpXDAbCVC+gEMAK4MlGCEdsEM=;
        b=Aw0FxDQ5awJtpCbYSJheFBr0e8wxhHe88Lj2aMMJdnavUCip2CqDOzuP6vBSZrhVIv
         9IrDocdoaKJqHCp3jjIMDe+6dmnkvEXyghr7KM+78fGudot6pJtHpvRh48/1euNaAokk
         BHSvFHy628gHeImn5Pss099H5fU/UDBQxwtxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EKKjC5cv1JmzAihc+OV6zTkXvF1zYjTrguCJPt1/A/oXndqfjooi4eSNEWla27QlmG
         JMWTijXNyMmjuIHfC7vhInLd1r2HDUv7MUKVymtGlFfkTRq2r2ejwCZGKrw44Bh/0leR
         rHlp4T3RXAeryRKWzZYAP0Xy6DMztBULZzBbo=
Received: by 10.100.46.10 with SMTP id t10mr7995968ant.116.1245022377108; Sun, 
	14 Jun 2009 16:32:57 -0700 (PDT)
In-Reply-To: <4A34B4ED.6060301@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121572>

2009/6/14 Stephen Boyd <bebarino@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> diff --git a/log-tree.c b/log-tree.c
>> index 59d63eb..139c8b5 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -180,12 +180,13 @@ static int has_non_ascii(const char *s)
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> -void get_patch_filename(struct commit *commit, int nr, const char *=
suffix,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct strbuf *buf)
>> +void get_patch_filename(struct commit *commit, int nr, const char *=
prefix,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *suffix, struct strbuf *buf)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int suffix_len =3D strlen(suffix) + 1;
>> - =C2=A0 =C2=A0 int start_len =3D buf->len;
>> + =C2=A0 =C2=A0 int start_len =3D buf->len + strlen(prefix);
>>
>> + =C2=A0 =C2=A0 strbuf_addstr(buf, prefix);
>> =C2=A0 =C2=A0 =C2=A0 strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
>> =C2=A0 =C2=A0 =C2=A0 if (commit) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int max_len =3D sta=
rt_len + FORMAT_PATCH_NAME_MAX - suffix_len;
>>
>
> Why does the prefix length not count against the filename length? I
> think you want to subtract a prefix_len.
>
> Also, this doesn't replace the numbering (0001, 0002, etc.) which I
> consider to be a prefix. Does anyone else feel the same way?
>
> This is kind of a funny thought, but I'll throw it out there. Could y=
ou
> just put the desired prefix in your patch subjects, and then add an
> option for no-numbered-files? So in your case, you add "dbus 1.2.3" a=
t
> the start of each subject during git-commit and then format-patch wit=
h
> --no-numbered-files. This way you get git to insert the dashes you wa=
nt,
> other people get files with no numbers, and you don't have to deal wi=
th
> slashes and directory prefixes.

Well, for true flexibility, I would implement something like printf
format. But that would be overkill.

> I'm kind of confused about this though. The patches you're generating
> for Gentoo are not being read by humans; merely being applied by port=
age
> correct? Are you going back and removing the mail headers and commit
> messages from these patches? What I'm getting at is for your case
> format-patch may be overkill.

They are read by human, i.e. ebuild developers, and uptream developers
too when they are submitted upstream (which is great because if
upstream uses Git, you don't have to do anything else). Plain patches
are enough for portage, other information is for human ;-)
--=20
Duy
