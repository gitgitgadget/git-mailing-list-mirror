From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Mon, 16 Jul 2012 09:57:50 +0200
Message-ID: <87y5mkm935.fsf@thomas.inf.ethz.ch>
References: <5001644F.10901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 09:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqgBr-000309-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 09:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab2GPH5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jul 2012 03:57:55 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:50260 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568Ab2GPH5y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 03:57:54 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 16 Jul
 2012 09:57:49 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 16 Jul
 2012 09:57:51 +0200
In-Reply-To: <5001644F.10901@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Sat, 14 Jul 2012 14:21:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201495>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Now it appeared on next as well, so it's time to look a little bit de=
eper.
>
> This test case of t1450 fails:
> test_expect_success 'tag pointing to something else than its type' '
>
> To debug more, I added an exit 0 here to inspect the file named out:
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 5b79c51..f1f45c9 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -179,6 +179,7 @@ test_expect_success 'tag pointing to something el=
se than its type' '
>         test_when_finished "git update-ref -d refs/tags/wrong" &&
>         test_must_fail git fsck --tags 2>out &&
>         cat out &&
> +       exit 0
>         grep "error in tag.*broken links" out
>  '
>
> Linux:
> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, not=
 a commit
> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not load=
 tagged object
>
> Mac OS X:
> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, n=
ot a blob
> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or mi=
ssing

What OS X are you running?  I started a loop

  while : ; do ./t1450-fsck.sh || break; done

and it hasn't failed yet.  It is

  $ uname -a
  Darwin mackeller.inf.ethz.ch 11.4.0 Darwin Kernel Version 11.4.0: Mon=
 Apr  9 19:32:15 PDT 2012; root:xnu-1699.26.8~1/RELEASE_X86_64 x86_64

> I reverted the last change in fsck.c (Use the streaming interface), b=
ut that doesn't help
>
> Looking into the trash directory and looking at the files, we can see=
 that the .git/index is different
> between Linux and Mac OS X.
>
> Is there a good way to debug the index file?

You can run 'git ls-files --debug' which should give you all the data i=
n
the index, and then perhaps run diff over that to determine the
differences...

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
