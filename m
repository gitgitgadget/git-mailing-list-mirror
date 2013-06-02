From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for
 merges
Date: Sun, 02 Jun 2013 19:54:03 +0200
Message-ID: <51AB86BB.3080203@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx> <CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 19:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjCTz-0001xl-IJ
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 19:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab3FBRyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 13:54:11 -0400
Received: from india601.server4you.de ([85.25.151.105]:58141 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab3FBRyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 13:54:10 -0400
Received: from [192.168.2.105] (p579BEDD3.dip0.t-ipconnect.de [87.155.237.211])
	by india601.server4you.de (Postfix) with ESMTPSA id 115591FD;
	Sun,  2 Jun 2013 19:54:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226170>

Am 02.06.2013 19:25, schrieb Felipe Contreras:
> On Sun, Jun 2, 2013 at 10:46 AM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> +               for (i =3D 0; i < n; i++) {
>> +                       struct cache_entry *ce =3D src[i + o->merge]=
;
>> +                       if (ce !=3D o->df_conflict_entry)
>
> It's possible that ce is NULL, but you didn't add that check because
> free(NULL) still works? Or because ce cannot be NULL?
>
> If it's the former, I think it's clearer if we check that ce is not
> NULL either way.

It is NULL if one tree misses an entry (e.g. a new or removed file).=20
free handles NULL and we generally avoid duplicating its NULL-check.

You're probably referring to the non-merge case as the example for=20
checking.  That one is different, though, because there we call=20
do_add_entry instead of free, which does not handle NULL.  And it=20
doesn't have to, as it is mostly called through add_entry, which never=20
passes NULL.

Ren=C3=A9
