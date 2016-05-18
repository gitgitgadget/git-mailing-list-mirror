From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: [PATCH] pull: warn on --verify-signatures with --rebase
Date: Wed, 18 May 2016 12:18:27 +0200
Message-ID: <20160518101827.GA14475@netblarch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 12:08:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2yOf-0000Bt-Kr
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 12:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbcERKIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 06:08:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35770 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbcERKIA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 06:08:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id g17so4931673wme.2
        for <git@vger.kernel.org>; Wed, 18 May 2016 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3DiiVbvp612cP7rnQFj9FcaNOY/64z4FzeiQSPxCLe8=;
        b=gapAMOXRutK2+mO6FByhuhEfg0zt8zSOZkbC1Ol2u6nbcXdOyw8ypYqUouiDGnSEwB
         VawnEmzeKrJwMU7HeGGRdFemQFprv0VuKnJgpFSIbux8FaLE+To35AzH0YXAmX+UHNKR
         EBSe83xso3YzakpSCyAgN04+k3o7d5NrZjqPFB0avNZX+6m7r6hpiAWId0UBXMCVdKcN
         2QNYYer4plZDRPQxDUCtick++RfIadBggBf5DKuiVWnChMkzYJj7hVtWPOjLNXns/qKH
         kexqEOKFX71LbGFoJPDBROxqCr8++XKWt/RT5u/YHshP79ksMUqNAjyrSXGOeENfjkAN
         PMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3DiiVbvp612cP7rnQFj9FcaNOY/64z4FzeiQSPxCLe8=;
        b=PB5n4f63IePYKwL/VeTgx6FF84A1sAsVYOAp5DHcnIongz+AT0T5GrU5AUiYqitgPA
         JOjKJMW0TotkBaMF7QOUlZY4xdUultnROCHTq/Glg8zmZzN+nTFhXDPJ2BCO8TlUbDxz
         xs0w+AomHEf4r2A6oAwEYBCjKOkomJ9QZUnGa4aOLN3Td0Lk1Rfu6Wtuh3n/YPOwBPHB
         r1f+6Sfj3MxkrTbX2iwm12eGHOXJTE9kN5l58j5PUqTjXbLvXig8+XCV4s5ctcWYJhdw
         TareZSetSDalq1MFlFfhYCJaQ4PBoj9vHGsUJOneWe9/6Txkqt7P8x/lpyrxTccc2GSk
         ZARQ==
X-Gm-Message-State: AOPr4FXLBlCx1vSj9YK1fd2HQShs+oPUf0pPq5NXBqoVf4F+rekZH1yFkfCD5A9zf4PE6w==
X-Received: by 10.28.7.197 with SMTP id 188mr30134148wmh.101.1463566078601;
        Wed, 18 May 2016 03:07:58 -0700 (PDT)
Received: from netblarch (s4414.dyn.hrz.tu-darmstadt.de. [130.83.217.158])
        by smtp.gmail.com with ESMTPSA id ib1sm7768759wjb.48.2016.05.18.03.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 May 2016 03:07:57 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294938>

Previously git-pull silently ignored the --verify-signatures option for
--rebase.

Signed-off-by: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
---

Sorry it took so long for the update.
I made git-pull warn instead or error and explained why "the
--verify-signatures option does not work for --rebase" in the message.

 builtin/pull.c  |  2 ++
 t/t5520-pull.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1d7333c..0eafae7 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -815,6 +815,8 @@ static int run_rebase(const unsigned char *curr_head,
 		argv_array_push(&args, "--no-autostash");
 	else if (opt_autostash == 1)
 		argv_array_push(&args, "--autostash");
+	if (opt_verify_signatures && strcmp(opt_verify_signatures, "--verify-signatures") == 0)
+		warning(_("git-rebase does not support --verify-signatures"));
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 739c089..d605450 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -341,6 +341,22 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success "pull --rebase warns on --verify-signatures" '
+	git reset --hard before-rebase &&
+	git pull --rebase --verify-signatures . copy 2>err &&
+	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test new = "$(git show HEAD:file2)" &&
+	test_i18ngrep "git-rebase does not support --verify-signatures" err
+'
+
+test_expect_success "pull --rebase does not warn on --no-verify-signatures" '
+	git reset --hard before-rebase &&
+	git pull --rebase --no-verify-signatures . copy 2>err &&
+	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test new = "$(git show HEAD:file2)" &&
+	test_i18ngrep ! "verify-signatures" err
+'
+
 # add a feature branch, keep-merge, that is merged into master, so the
 # test can try preserving the merge commit (or not) with various
 # --rebase flags/pull.rebase settings.
-- 
2.8.2
