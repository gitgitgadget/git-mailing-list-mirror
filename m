From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: [PATCH] pull: make --rebase --verify-signatures illegal
Date: Thu, 28 Apr 2016 11:52:54 +0200
Message-ID: <20160428095254.GA5205@netblarch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 11:43:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aviTJ-0002xG-F4
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 11:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbcD1Jmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 05:42:53 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36147 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcD1Jmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 05:42:52 -0400
Received: by mail-wm0-f49.google.com with SMTP id n129so58259927wmn.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4eS66ig0M7R2aXOhp9EQtRcSjmWMVoDboSyagmpM/bI=;
        b=xNuCmpslgpSTZLvMveLqemkQb3YypaRPFUVr5rSC6s3/FUIGz3CHryT7HX1w500sIo
         3pkqJjwlWUHNYW/SMeG1PGnW7BlfImn9RYJsLkZ1WDZFFZ1BJrdmxzpAODicwtNattwT
         vicYWESE8MGU4G743jRXaS+1z3gpwoSmmXP/yLwX2vlJ4FUCBd1lWs/b7NSFDP+SFhPf
         QWT6734pCbzB79pOuOcGcF5XbeTnv1/U+5vwQQZQZ1YmNcpwuVzqlbF1PylC6a6nqnOn
         Q+ggKDNtaemT7FVhj/ZxnTGg5OhFpCk6a7EuPt4ysckP5TXq3XkDTa6duduZdH+mQ0SW
         1Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4eS66ig0M7R2aXOhp9EQtRcSjmWMVoDboSyagmpM/bI=;
        b=NtT9Zxi6KwFqbNmWmYg7Qv5dMUPOso65WtfQdZdavmwkOkcxRI6W8OYN44JyPntKfD
         T0b3qyb4IVvsiz+H0yb28qxz/cnr+8DDoaS0f6apSBVhbF7fPwxbX1XJQvz1AFBFKAW3
         Eh0n1oAe9PnKdZQQlP25OW7EVbMkk4LpRIgqI5D/H4AINyfKl2B41gnN3tyQgU8yUQYT
         cGavO0MeynXAbLGswU/PY17G5hrLJWfefRuJrn7mr36Xsm6We76gnaT77z8GAMMCxpfl
         rYTJHKMXvRcbvSsa0tSzq7llCJzxHHTzgVVluYSuF2coDZ9YzATu4H50qqXTQErLoasQ
         udsw==
X-Gm-Message-State: AOPr4FW7zlGuXwh1TfpMe6gfKcnMa/QZEmqwO8PvVj5VYwE838nBmRuSBNW5Rd+DMbh+5w==
X-Received: by 10.194.90.76 with SMTP id bu12mr13994189wjb.79.1461836570614;
        Thu, 28 Apr 2016 02:42:50 -0700 (PDT)
Received: from netblarch (s5372.dyn.hrz.tu-darmstadt.de. [130.83.221.92])
        by smtp.gmail.com with ESMTPSA id yr1sm8746956wjc.9.2016.04.28.02.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2016 02:42:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292858>

Previously git-pull would silently ignore the --verify-signatures
option.

Signed-off-by: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
---

We had some discussion back in December about a patch that added
--verify-signatures to git-pull, that was declined.
I proposed making git-pull --rebase --verify-signatures illegal then,
although it still remained open whether to just warn or make it an
error.

In this patch I opted into making it an error, which breaks the
previously accepted git pull --rebase --verify-signatures of course,
albeit I'd argue that it probably didn't do what the user expected
anyways.
I don't know if there are compatibility concerns with this though.

 builtin/pull.c  |  2 ++
 t/t5520-pull.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index d98f481..b6e1507 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -809,6 +809,8 @@ static int run_rebase(const unsigned char *curr_head,
 		argv_array_push(&args, "--no-autostash");
 	else if (opt_autostash == 1)
 		argv_array_push(&args, "--autostash");
+	if (opt_verify_signatures && strcmp(opt_verify_signatures, "--verify-signatures") == 0)
+		die(_("The --verify-signatures option does not work for --rebase."));
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 739c089..cb8f741 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -341,6 +341,20 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success "pull --rebase --verify-signatures is illegal" '
+	git reset --hard before-rebase &&
+	test_must_fail git pull --rebase --verify-signatures . copy 2>err &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
+	test_i18ngrep "The --verify-signatures option does not work for --rebase." err
+'
+
+test_expect_success "pull --rebase --no-verify-signatures" '
+	git reset --hard before-rebase &&
+	git pull --rebase --no-verify-signatures . copy &&
+	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test new = "$(git show HEAD:file2)"
+'
+
 # add a feature branch, keep-merge, that is merged into master, so the
 # test can try preserving the merge commit (or not) with various
 # --rebase flags/pull.rebase settings.
-- 
2.8.0
