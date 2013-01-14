From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] archive-tar: fix sanity check in config parsing
Date: Mon, 14 Jan 2013 09:17:57 +0100
Message-ID: <kd0evl$ac0$1@ger.gmane.org>
References: <50F2F1E9.1040700@lsrfire.ath.cx> <20130113200044.GA3979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 09:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TufFc-0006Kd-5N
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 09:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab3ANISQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 03:18:16 -0500
Received: from plane.gmane.org ([80.91.229.3]:51552 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab3ANISP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 03:18:15 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TufFU-0006Ck-Mp
	for git@vger.kernel.org; Mon, 14 Jan 2013 09:18:28 +0100
Received: from dsdf-4d0a0508.pool.mediaways.net ([77.10.5.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 09:18:28 +0100
Received: from jojo by dsdf-4d0a0508.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 09:18:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4d0a0508.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213474>

Jeff King wrote:
> On Sun, Jan 13, 2013 at 06:42:01PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> When parsing these config variable names, we currently check that
>> the second dot is found nine characters into the name, disallowing
>> filter names with a length of five characters.  Additionally,
>> git archive crashes when the second dot is omitted:
>>
>> $ ./git -c tar.foo=3Dbar archive HEAD >/dev/null
>> fatal: Data too large to fit into virtual memory space.
>>
>> Instead we should check if the second dot exists at all, or if
>> we only found the first one.
>
> Eek. Thanks for finding it. Your fix is obviously correct.
>
>> --- a/archive-tar.c
>> +++ b/archive-tar.c
>> @@ -335,7 +335,7 @@ static int tar_filter_config(const char *var,
>>  const char *value, void *data) if (prefixcmp(var, "tar."))
>>  return 0;
>>  dot =3D strrchr(var, '.');
>> - if (dot =3D=3D var + 9)
>> + if (dot =3D=3D var + 3)
>>  return 0;
>
> For the curious, the original version of the patch[1] read:
>
> +       if (prefixcmp(var, "tarfilter."))
> +               return 0;
> +       dot =3D strrchr(var, '.');
> +       if (dot =3D=3D var + 9)
> +               return 0;
>
> and when I shortened the config section to "tar" in a re-roll of the
> series, I missed the corresponding change to the offset.

Wouldn't it then be better ti use strlen("tar") rather than a 3? Or at =
least=20
a comment?

Bye, Jojo=20
