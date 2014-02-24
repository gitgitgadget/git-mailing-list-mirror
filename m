From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] difftool: support repositories with .git-files
Date: Mon, 24 Feb 2014 21:10:32 +0000
Message-ID: <530BB548.3050603@web.de>
References: <1393211555-50270-1-git-send-email-davvid@gmail.com> <xmqqr46s9yzx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?R8OhYm9yIExpcHTDoWs=?= <gabor.liptak@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 22:10:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI2nX-0003BV-8c
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 22:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbaBXVKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 16:10:39 -0500
Received: from mout.web.de ([212.227.17.11]:54168 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbaBXVKi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 16:10:38 -0500
Received: from [192.168.1.102] ([90.174.2.98]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0MNx4F-1WJPZh36TL-007XXr for <git@vger.kernel.org>; Mon,
 24 Feb 2014 22:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqr46s9yzx.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:8xKaaYEB5dd95NTo7dI5IjJWTQUgMV+fMovYsV0gtZcgmKbpVc8
 ZtV215GCuASlt7t9qARmC9Q3mygNR9ZxvvS2fc1192xTJ6SwtXQOXFvy3ApyC5y/L6DTaps
 wRcnwOHq/bl4uhWhp886FUoerbvw2Ki3qPP09VShKlgoxchY+/o/sgSQ3K7YWjy2fTXoZ29
 l+F1EbzhM/JrefQ8C3Kag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242648>

Am 24.02.2014 17:55, schrieb Junio C Hamano:
> David Aguilar <davvid@gmail.com> writes:
>=20
>> Modern versions of "git submodule" use .git-files to setup the
>> submodule directory.  When run in a "git submodule"-created
>> repository "git difftool --dir-diff" dies with the following
>> error:
>>
>> 	$ git difftool -d HEAD~
>> 	fatal: This operation must be run in a work tree
>> 	diff --raw --no-abbrev -z HEAD~: command returned error: 128
>>
>> core.worktree is relative to the .git directory but the logic
>> in find_worktree() does not account for it.
>>
>> Use `git rev-parse --show-toplevel` to find the worktree so that
>> the dir-diff feature works inside a submodule.
>>
>> Reported-by: G=C3=A1bor Lipt=C3=A1k <gabor.liptak@gmail.com>
>> Helped-by: Jens Lehmann <jens.lehmann@web.de>
>> Helped-by: John Keeping <john@keeping.me.uk>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>=20
> Looks good; thanks.


=46WIW:
Tested-by: Jens Lehmann <jens.lehmann@web.de>

What about squashing this in to detect any future regressions?

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 2418528..d86ad68 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -434,4 +434,12 @@ test_expect_success PERL 'difftool --no-symlinks d=
etects conflict ' '
 	)
 '

+test_expect_success PERL 'difftool properly honours gitlink and core.w=
orktree' '
+	git submodule add ./. submod/ule &&
+	(
+		cd submod/ule &&
+		git difftool --tool=3Decho  --dir-diff --cached
+	)
+'
+
 test_done
