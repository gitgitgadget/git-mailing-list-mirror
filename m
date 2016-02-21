From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v2 5/5] merge-recursive: find-renames resets threshold
Date: Sun, 21 Feb 2016 19:59:05 -0300
Message-ID: <1456095545-20201-6-git-send-email-felipegassis@gmail.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 00:00:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXczo-0001wN-P7
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbcBUXAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:00:52 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35215 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbcBUXAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:00:50 -0500
Received: by mail-qg0-f49.google.com with SMTP id y89so99913065qge.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W8F9ozoBYFAymPw5bZK33mut+tGamzeSbET+yD3Ed5U=;
        b=bOy/xrSRSUZqeugHQ3hdjbJAKrLGE9v09qyBH59WMdG4ahdjrpXWS9AAqSLKLWZN5I
         y6+zrdSJ7N0/2rZDDw6G1OTpLz9Vf9QIUTolv++hoOR9dn7LLzq+uyVMWjJ2ci2FSzf+
         5Tsu4QlTGk016mh2pB/VzsvvjkEBO93+hul4X8HuJTpiADR5CyuuX+k+dtvkZ+S4Jz8v
         liTWr6IhoK7nyaAW/y38Rx9JELgEMaYjMewj47N6+DmKec1hpQTYqsGYYsNOL6OO5GQ+
         1I9rOU0k/wpGaUTcNUbDd/z4m06JFLPNWijOW3ydDcdK+M+UUy2EQT/k9bZXC8KioLYK
         PsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=W8F9ozoBYFAymPw5bZK33mut+tGamzeSbET+yD3Ed5U=;
        b=bpgi1+1CvFQ0eSg+J4q+qUUlkIU2sUw9f6EKxcIoeWl0hk04g6Svx+aKs82GyUVJ82
         zg3pImKLxoK5YEpVQaJdFXFUbX0w5mxvJCo83DWTaEWTBCJ+RVTNWUBALhq3o1dVfE/E
         aHoL3foyQKPTolnosNTjpaCS2ObtLhwpmEHMxh/pvT3t7keZWusoNQf0kKBnrjTQJwAc
         maFXeqfzUqu1pBGf39IKm6DzSh799xVpJG3+odXccRLC/stMn2O/iQGf1yROz9ocqbF+
         595X2XAeJdQfKnizh7tN7NjNLUiN2pIhyhzDgyGVTCoL4AiRo3xXMM7lwW4lpqtDzHzQ
         3Umg==
X-Gm-Message-State: AG10YOTiTMHBfIGVsSrCzvTpL1aJ831FHoNpWLJMd4rmm3rtkmdpwuw4qvj5af4fFATEew==
X-Received: by 10.140.157.214 with SMTP id d205mr32875052qhd.3.1456095650149;
        Sun, 21 Feb 2016 15:00:50 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id f83sm9177201qkb.25.2016.02.21.15.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 15:00:49 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286838>

Make the find-renames option follow the behaviour in git-diff, where it
resets the threshold when none is given. So, for instance,
"--find-renames=3D25 --find-renames" should result in the default
threshold (50%) instead of 25%.

Add corresponding test.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---

Now bundles the relevant test.

 merge-recursive.c                         | 4 +++-
 t/t3034-merge-recursive-rename-options.sh | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7bff5be..b880ae5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2094,8 +2094,10 @@ int parse_merge_opt(struct merge_options *o, con=
st char *s)
 		o->renormalize =3D 0;
 	else if (!strcmp(s, "no-renames"))
 		o->detect_rename =3D 0;
-	else if (!strcmp(s, "find-renames"))
+	else if (!strcmp(s, "find-renames")) {
 		o->detect_rename =3D 1;
+		o->rename_score =3D 0;
+	}
 	else if (skip_prefix(s, "find-renames=3D", &arg) ||
 		 skip_prefix(s, "rename-threshold=3D", &arg)) {
 		if ((o->rename_score =3D parse_rename_score(&arg)) =3D=3D -1 || *arg=
 !=3D 0)
diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index d4f9742..54d5f1b 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -146,6 +146,12 @@ test_expect_success 'last wins in --find-renames=3D=
<m> --find-renames=3D<n>' '
 	check_find_renames_75
 '
=20
+test_expect_success '--find-renames resets threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D25 --find-renames=
 HEAD^ -- HEAD master &&
+	check_find_renames_50
+'
+
 test_expect_success 'last wins in --no-renames --find-renames' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git merge-recursive --no-renames --find-renames HEAD^ =
-- HEAD master &&
--=20
2.7.1.492.gd821b20
