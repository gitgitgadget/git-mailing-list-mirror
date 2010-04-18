From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git diff too slow for a file
Date: Sun, 18 Apr 2010 20:01:09 +0200
Message-ID: <4BCB48E5.9090303@lsrfire.ath.cx>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx> <7vpr1y2eev.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:01:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3YoW-00049x-Ej
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267Ab0DRSBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Apr 2010 14:01:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:51879 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165Ab0DRSB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:01:29 -0400
Received: from [10.0.1.100] (p57B7D1E8.dip.t-dialin.net [87.183.209.232])
	by india601.server4you.de (Postfix) with ESMTPSA id 6A6732F805A;
	Sun, 18 Apr 2010 20:01:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vpr1y2eev.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145224>

Am 17.04.2010 19:10, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Am 29.03.2010 03:42, schrieb SungHyun Nam:
>>>  ...
>>> Well, though the files are ascii file, they includes a random
>>> hexa-decimal datas, so that I don't interest the diff result at
>>> all.
>> ...
>> The following patch is not meant for inclusion, but rather to start =
a
>> dicussion.  Is XDF_NEED_MINIMAL a good default to have?
>=20
> This is a very valid question to ask.  The choice of the default was =
done
> without any benchmarking nor analysis on performance impact at all.
>=20
> What we should do next would be to:
>=20
>  - see how much performance impact we have been getting from more nor=
mal
>    set of files (say, "git log -p" in the kernel archive) by our use =
of
>    MINIMAL;  I suspect that git.git itself is too small to observe an=
y
>    meaningful difference.  We already _know_ that MINIMAL is more
>    expensive, so this is not very important, but it would be good to
>    know.
>=20
>  - inspect the difference of the quality of output for not using MINI=
MAL,
>    again for more normal set of files.  We know that the quality does=
 not
>    matter for pathological cases like the one in this thread --- the =
user
>    is not even "interested in the diff result at all".

To see the what difference it makes to the output, I did the following:

	git rev-list --no-merges HEAD |
	while read commit
	do
		a=3D$(git show $commit | md5sum)
		b=3D$(git show --quick $commit | md5sum)
		test "$a" =3D "$b" || echo $commit
	done

=46or git, it reports those 2 out of 18095 total commits as being
different with and without XDF_NEED_MINIMAL:

  f522c9b5  717b8311

=46or Linux, these 161 out of 178107 commits are affected:

  90d49b4f  83f3c715  3b5dd52a  e97bd974  4e092d11  96b3c83d  4c96e893
  1210db95  ca97b838  52bbe3c7  a3a4f7e1  de0710aa  8e730c15  b54f78a8
  71034ba8  120a5d0d  1532ecea  0a18d7b5  3d0f8bc7  35c1b462  0f29f587
  2cf71d2e  4d295db0  4953550a  c0a5962f  5176fae4  51f94a7b  5d4f98a2
  cb6492e4  4f774513  da0436e9  3772a991  20b09c29  dd4969a8  b4a4d568
  a7fefd10  d93f87c8  9b7895ef  a72bdb1c  96b8e145  b960074f  56bec294
  f74df6fb  89cb7e7f  e8324357  5ef3041e  833dfbe7  65f9f619  02227c28
  56afef56  5db8dcc9  6261ab3a  deee7c81  e7594072  2b82032c  f1dc5600
  060ae855  5503ac56  54168ed7  e2d1d6c0  1a40e23b  d1310b2e  9c6bd790
  8feceb67  9ac19a90  60f8b39c  ef1a628d  95b86a9a  0391c828  a7707adf
  3f038d80  f5b728a1  5915eb53  287ac01a  c41f8cbd  b497549a  6802e340
  f8d79e79  34f80b04  c18487ee  c9df406f  03718234  d10c2e46  584fffc8
  624d5c51  6446a860  f1410647  1c45607a  b21a15f6  0e078e2f  8e09f215
  99ca4e58  8bf5e5ca  402aa76a  195a4ef6  a9de9248  20510f2f  ae0b78d0
  51219358  1a4f550a  b2c258fb  e2ebc74d  27c868c2  c3a2f0df  8e18257d
  05ffdd7b  328d5752  92d7f7b0  39279cc3  4b19fcc3  f23a06f0  7699acd1
  a1005012  eea221ce  dcd0538f  48b4554a  56b6aeb0  e05d723f  3cee5a60
  4d0b4af9  9e89dde2  483dfdb6  02f1175c  a8dea4ec  28a6d671  933a27d3
  572d3138  1450e6be  4ac4360b  9c7f852e  16a53ecc  5bb0b55a  2722971c
  6a2900b6  c752666c  5c04a7b8  c92f222e  a966f3e7  3ebc284d  a1a5ea70
  df694daa  7a88488b  afbf30a2  b095c381  ea2b26e0  12d30d89  09af7b44
  5e83d430  37448f7d  544393fe  d203a7ec  73a25462  bd4c625c  330a115a
  22e2c507  e9edcee0  303b86d9  47b5d69c  2d7edb92  cb624029  f4f051eb

I have briefly looked at a few of them.  They were big and not obvious
with or without XDF_NEED_MINIMAL, but the flag clearly helped to cut
them down a bit.


XDF_NEED_MINIMAL doesn't seem to affect the overall runtime for the
Linux repo:

	time git log --stat HEAD >/dev/null

	real	4m37.378s
	user	4m28.070s
	sys	0m9.310s

	time ../git/git log --stat --quick >/dev/null

	real	4m37.239s
	user	4m26.590s
	sys	0m10.620s

The difference between the times for git's own repo are in the noise, t=
oo.
