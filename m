Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6994C04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjHHTAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjHHTAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:00:03 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FB85845
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691515587; x=1692120387; i=tboegi@web.de;
 bh=felXP/PsSuYg0SFc3Z1+7UQaVDgmE1jbwNNNG3fK95A=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=AkXqzIX2AQchEf/3o6md+eF+9WZn2H5I9hFKnMbnU6SI6XKUR1lA/LEz0sapfbsYY9CzFEE
 IWwwNyNomwetIUvBTQAEbWMGRxaVjEHYLw58KovbsRHYKUVftmi8wQ/9Zs8vT9LN85h0SwNWn
 iPjEMqLCMNhQuZvNOn9alP/Jg9vWerHW7NDillugnQlS0sqHt8tIDWsuEewGDieXdE5BTgBZv
 UZJ6Sxy1se81bizmzq8S3E2cfjTKKOS6DcZCCciMNjRu9JRZmFbNNYjQc9UYJsiZSD9JOdpTi
 hx2ef34THSejZhoVtd6rsmjD92/9HOGX7X/lT16R+EkznRD6ZiSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAcpW-1qeNmF0EjA-00BIy5; Tue, 08
 Aug 2023 19:26:27 +0200
From:   tboegi@web.de
To:     tboegi@web.de, git@vger.kernel.org, friebetill@gmail.com,
        phillip.wood123@gmail.com
Subject: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
Date:   Tue,  8 Aug 2023 19:26:24 +0200
Message-ID: <20230808172624.14205-1-tboegi@web.de>
X-Mailer: git-send-email 2.41.0.394.ge43f4fd0bd
In-Reply-To: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h6lu5jBjHQOK8tSYL5i9qkbfdKC19oUIPBR8K3R/+WKTzSME52L
 VMrrVOEAt6PM8nNflKah9ANDq+28QgqsMEJaeNOcayH3gxkSQ2RU/wXxe2rzvsxbSLOrfqg
 fwaxiyQJAWgWziI/iFxYCYproCjIiywp/gM5mzCY3OM5oM3u4v5pt8Qso7euOOYOsOSlRa5
 9oxxRFJqX66+TMma1sv6w==
UI-OutboundReport: notjunk:1;M01:P0:rBMAkxu6Cwc=;kxL+EbDGD/odGfJsJamTtt9wtG2
 tu8Sov8EqkvrRSCUw4IfaToxUHU6Lq143dDbhOuKfMekMFjFsVckJX9ryGZrnFPsaDTNMvVi0
 6i0KZy1B1ZlC5LERCG2O9rpxgveeO/fAMG+QAjBg7EAvjotLT3l2PxXo3UX43OderyGzin02q
 rSKItfZVxmhkpQiZljM1GUqrODaS+6V2C5WuATGWnHcOwOghvyl2FQyfqkADLsVXz+lvnAnTf
 V7spIz9hAtAkblFZo4UW/wAqN+/L20X8rYnziTXEUioEmTKoSvRLr4cf30LI4tApM+QJLEzKF
 oF5+RiLobbnTQz1ppOmT17vUl3CrH2yqz7cSJTUvXSfJYilkp9yMAY+BmV8OXuGry/Rh3EReS
 /v0/JjWwEJBJi3T+8bPHtP1JUBhKb8wej/n34IYVMKK+yVFEyOekuvAlQ3kgscd35ewMxSmRH
 7PLsCIuuEDvtOjrI2DqavJ88Rs6uMuFtWKwIsxotbku91XmO6/rN49f10nPOCSW27huHXNp7L
 Lp2n9vKGp8zI3znPAiLJ1u7NnQV+uzKb9ERbjKl7DqNtRZYfDHDw58dJD9HVweDSORg3JwEu8
 rJ/E5ZltF1ydUuqtYmSKmh8dqNrcskfds4COG5pU74oYl1dX09l9n8KTKnVFK+gxSmPwItQaF
 4Ki0FJO5pvbf1EG46LDz0GbGdRvxOv7RjvEybaAjPPjd2xN1VSWbEDidwMJ44gumTj/fghfyV
 T9wo76idQwzQIW9DK5XLRdInp35/xaV7eXqmdAet0TynTO7qm7zLg59WJnLDNsKAoCYRPL496
 CAx9cl3NlSVmZ4ofC0CHVZw+DEgSh9uDQEKME/XQbdDT9CIXqL2/p3eIo8ML5aOqXgB/zNtkS
 XL8ZPuQ+sY+U3Cgvt4hcJP6SXgQ+3o0FMhwqbDVfI3lOlmKS6Ku/vsxo963MY+lHxV9A//c88
 bNOgnA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The following sequence leads to loss of work:
 git init
 mkdir README
 touch README/README
 git add .
 git commit -m "Init project"
 echo "Test" > README/README
 mv README/README README2
 rmdir README
 mv README2 README
 git stash
 git stash pop

The problem is, that `git stash` needs to create the directory README/
and to be able to do this, the file README needs to be removed.
And this is, where the work was lost.
There are different possibilities preventing this loss of work:
a)
  `git stash` does refuse the removel of the untracked file,
   when a directory with the same name needs to be created
  There is a small problem here:
  In the ideal world, the stash would do nothing at all,
  and not do anything but complain.
  The current code makes this hard to achieve
  An other solution could be to do as much stash work as possible,
  but stop when the file/directory conflict is detected.
  This would create some inconsistent state.

b) Create the directory as needed, but rename the file before doing that.
  This would let the `git stash` proceed as usual and create a "new" file,
  which may be surprising for some worlflows.

This change goes for b), as it seems the most intuitive solution for
Git users.

Introdue a new function rename_to_untracked_or_warn() and use it
in create_directories() in entry.c

Reported-by: Till Friebe <friebetill@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 entry.c          | 25 ++++++++++++++++++++++++-
 t/t3903-stash.sh | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index 43767f9043..76d8a0762d 100644
=2D-- a/entry.c
+++ b/entry.c
@@ -15,6 +15,28 @@
 #include "entry.h"
 #include "parallel-checkout.h"

+static int rename_to_untracked_or_warn(const char *file)
+{
+	const size_t file_name_len =3D strlen(file);
+	const static char *dot_untracked =3D ".untracked";
+	const size_t dot_un_len =3D strlen(dot_untracked);
+	struct strbuf sb;
+	int ret;
+
+	strbuf_init(&sb, file_name_len + dot_un_len);
+	strbuf_add(&sb, file, file_name_len);
+	strbuf_add(&sb, dot_untracked, dot_un_len);
+	ret =3D rename(file, sb.buf);
+
+	if (ret) {
+		int saved_errno =3D errno;
+		warning_errno(_("unable rename '%s' into '%s'"), file, sb.buf);
+		errno =3D saved_errno;
+	}
+	strbuf_release(&sb);
+	return ret;
+}
+
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
 {
@@ -48,7 +70,8 @@ static void create_directories(const char *path, int pat=
h_len,
 		 */
 		if (mkdir(buf, 0777)) {
 			if (errno =3D=3D EEXIST && state->force &&
-			    !unlink_or_warn(buf) && !mkdir(buf, 0777))
+			    !rename_to_untracked_or_warn(buf) &&
+			    !mkdir(buf, 0777))
 				continue;
 			die_errno("cannot create directory at '%s'", buf);
 		}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0b3dfeaea2..1a210f8a5a 100755
=2D-- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1512,4 +1512,27 @@ test_expect_success 'restore untracked files even w=
hen we hit conflicts' '
 	)
 '

+test_expect_success 'stash mkdir README needed - README.untracked created=
' '
+	git init mkdir_needed_file_untracked &&
+	(
+		cd mkdir_needed_file_untracked &&
+		mkdir README &&
+		touch README/README &&
+		git add . &&
+		git commit -m "Add README/README" &&
+		echo Version2 > README/README &&
+		mv README/README README2 &&
+		rmdir README &&
+		mv README2 README &&
+		git stash &&
+		test_path_is_file README.untracked &&
+		echo Version2 >expect &&
+		test_cmp expect README.untracked &&
+		rm expect &&
+		git stash pop &&
+		test_path_is_file README.untracked &&
+		echo Version2 >expect &&
+		test_cmp expect README.untracked
+	)
+'
 test_done
=2D-
2.41.0.394.ge43f4fd0bd

