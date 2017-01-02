Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F911FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 10:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932825AbdABKkb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 05:40:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:62475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbdABKka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 05:40:30 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsfrR-1cV2VV0ZDt-012LRA; Mon, 02
 Jan 2017 11:40:24 +0100
Date:   Mon, 2 Jan 2017 11:40:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2] mingw: add a regression test for pushing to UNC paths
In-Reply-To: <9fb8a9f405b19db087379ea5bbad80c3fbac8e4e.1482513055.git.johannes.schindelin@gmx.de>
Message-ID: <9f1d1286b7993cc3bd93a8358c041ef4de001e91.1483353603.git.johannes.schindelin@gmx.de>
References: <9fb8a9f405b19db087379ea5bbad80c3fbac8e4e.1482513055.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ahLt49C/uT7R5b5WU9gnFk4iSJfn+zhjcH5zKu0JsMCRFIV6xrT
 MHQvSV0u+jRDW0N1J2AejRKxepgCBWIcy4MVTLg5QwNj+r9eaIG+BCayuDyqNyEi8XodhQZ
 zlBmXqOnBhkOAiUOxM4lzx8R1qi9L+rWVD89VrpFcmIGSMMC2SLxQZxcJjhu7FVgjCREdOf
 zvKC2Ddtm1WlFiGq91caw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cf+wTCq6V2U=:rAPINCV+zKwxvdn6QdyR9Z
 hzNcPcG1AV88oFK/kyI7VqBGZ3jGLkvNzXy6/oxjgPsTGcvYdfCxhHKbo5+lBOzsRShOtpxD0
 lW3tLbEN/h5theNsGi306YBxnzJZ9Z201mjwbZJq4kFWViJQvF7vneoRgd5+66L47t9/ZAWlP
 NCNjQkcA/YWX4Q9Ljil8R8Ukku9tUfXVia+hmas8QUJk7GdihDJ3DSpqQvYV4sltzi7GYTegW
 +y+w4m2xWApy5RaAFOvU1PxCDjLrxHuwIc4d9ZHqzPoYe1Rx9b2PCX12sGj76bJKelS1KeX95
 8Yn2A4aWuoDaUTYlCwHyxIeesa4HieOpx6EgolXSVKp4wyvNUPSmZLle07dusRg3JRLO17tyy
 8M8ogIYWf0Nu7/3jhrKyZtoxHrXQ2W5kM+5iVdBtHOaG7iduKkFznbg//6uarcgGe+8b4IBkx
 zWiVLGDybMtsFZfuG7Nki/ZlcOG943avop+FvAktdlcSqiHzthQkuoiDfCmXcAs5LnSX8JtVe
 C2E4IbANQAmtKeil3b1MqnVwRMTfTtY5FT8UIcBnDuR9ZDKMuCKnkDzh10qUyQNYl6jJySf9y
 5jIolcey871Ro2s/+gY1GEcG3XAd2i3QcBvn+UlF2ypp5W57HONZYiFKx5DLWuwTroRuP9DKy
 Th0HB5xeZD8IsdvvlGm0LV36JaUQcr51MXKFdnDMYVERh2VLeY3u4psYY5rlq2VTS2kwBLp2a
 0lDUqNjABDgCe6OBAxOXOWfsJjD+X3zzbphYl6w8ZFSRZoU0gSGFZqms1olIY8XDTYUqTAoxs
 bOoM2xX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, there are "UNC paths" to access network (AKA shared)
folders, of the form \\server\sharename\directory. This provides a
convenient way for Windows developers to share their Git repositories
without having to have a dedicated server.

Git for Windows v2.11.0 introduced a regression where pushing to said
UNC paths no longer works, although fetching and cloning still does, as
reported here: https://github.com/git-for-windows/git/issues/979

This regression was fixed in 7814fbe3f1 (normalize_path_copy(): fix
pushing to //server/share/dir on Windows, 2016-12-14).

Let's make sure that it does not regress again, by introducing a test
that uses so-called "administrative shares": disk volumes are
automatically shared under certain circumstances, e.g.  the C: drive is
shared as \\localhost\c$. The test needs to be skipped if the current
directory is inaccessible via said administrative share, of course.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/unc-paths-test-v2
Fetch-It-Via: git fetch https://github.com/dscho/git unc-paths-test-v2
Interdiff vs v1:

 diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
 index e06d230724..b195f71ea9 100755
 --- a/t/t5580-clone-push-unc.sh
 +++ b/t/t5580-clone-push-unc.sh
 @@ -40,7 +40,9 @@ test_expect_success push '
  		git checkout -b to-push &&
  		test_commit to-push &&
  		git push origin HEAD
 -	)
 +	) &&
 +	rev="$(git -C clone rev-parse --verify refs/heads/to-push)" &&
 +	test "$rev" = "$(git rev-parse --verify refs/heads/to-push)"
  '
  
  test_done


 t/t5580-clone-push-unc.sh | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 t/t5580-clone-push-unc.sh

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
new file mode 100755
index 0000000000..b195f71ea9
--- /dev/null
+++ b/t/t5580-clone-push-unc.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='various UNC path tests (Windows-only)'
+. ./test-lib.sh
+
+if ! test_have_prereq MINGW; then
+	skip_all='skipping UNC path tests, requires Windows'
+	test_done
+fi
+
+UNCPATH="$(pwd)"
+case "$UNCPATH" in
+[A-Z]:*)
+	# Use administrative share e.g. \\localhost\C$\git-sdk-64\usr\src\git
+	# (we use forward slashes here because MSYS2 and Git accept them, and
+	# they are easier on the eyes)
+	UNCPATH="//localhost/${UNCPATH%%:*}\$/${UNCPATH#?:}"
+	test -d "$UNCPATH" || {
+		skip_all='could not access administrative share; skipping'
+		test_done
+	}
+	;;
+*)
+	skip_all='skipping UNC path tests, cannot determine current path as UNC'
+	test_done
+	;;
+esac
+
+test_expect_success setup '
+	test_commit initial
+'
+
+test_expect_success clone '
+	git clone "file://$UNCPATH" clone
+'
+
+test_expect_success push '
+	(
+		cd clone &&
+		git checkout -b to-push &&
+		test_commit to-push &&
+		git push origin HEAD
+	) &&
+	rev="$(git -C clone rev-parse --verify refs/heads/to-push)" &&
+	test "$rev" = "$(git rev-parse --verify refs/heads/to-push)"
+'
+
+test_done

base-commit: c69c2f50cfc0dcd4bcd014c7fd56e344a7c5522f
-- 
2.11.0.rc3.windows.1
