From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: [PATCH v2] pull: warn on --verify-signatures with --rebase
Date: Fri, 20 May 2016 23:00:54 +0200
Message-ID: <20160520210054.GA1856@netblarch.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 22:50:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3rNX-0003fG-1Q
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 22:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbcETUu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 16:50:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34302 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbcETUu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 16:50:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so32200666wmn.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EY03WRHT8P7TYbWsGDiM2xI+u/YBGsQ/iuIFjXNCtrw=;
        b=ZaZcl2hq4Ql1jbD+0Hp8BKYpc56woOA+ChqQUeJ7gDNkhT6UFreQeA2weTYJjuAMXs
         ovs04loc5K7EgB1Rzkc59rCA1xILCvNb8DJxVjB+tmcO2507L8Y+QNCoOlpOeZaj0B26
         jbx5MONObAZcZOoO+JTwdHOOFjxyAaM3aV5yymHx+GG0IJU50ZzzjPJAsFv6o7OWQRoP
         pwRg8qvCqfIujOTgxzt8qIPSgd1JsNxpX+ZLp+qPPFr9VstUBMOguE7VurlRvTPx+Gc3
         b6gFYOOmQewbSKe56xB96weoupUK9YTsfwX0A/fjwSG/wxxCqjv1xxfuLKU5ggNHDuq2
         AZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EY03WRHT8P7TYbWsGDiM2xI+u/YBGsQ/iuIFjXNCtrw=;
        b=JBTW/wydWjHChscdEZ73OuT6u57Cv7jn377vQNu3fvHl2SZsJah3MRnNGO4J63ACwC
         57sG7amGgqE4aCDw0Zjhq53ENBfn17gxDB6a/BAJMdJ5atgAvKfJ5r5YOqJpLbZypV2V
         Z5lmYFe77Lv+NmUnR6v5CrEthrrwbouAn3nWvAIihuT4CWKI1q4Ot0a8fRimrLZGcl0Q
         MLeOvvb5PgkF4hSriYz/Cs5IgtMP7MoUYST8l6/1skFZE6dQ8/yA36NzX+YFVfe37q16
         k9PY1NgZnNyoNdG4LyvjwiDLqfdFUWWyX95pfmef0DvXgN6UrRHhoUZdwx5Sh5C83d96
         hEsA==
X-Gm-Message-State: AOPr4FXznFxdQM8oZuGpO+Tq+9X2UJgwKWupf/pBFFTJ04KgCfhnNWRMpQQyKudvO8lZug==
X-Received: by 10.28.20.144 with SMTP id 138mr5640262wmu.103.1463777427500;
        Fri, 20 May 2016 13:50:27 -0700 (PDT)
Received: from netblarch.fritz.box (dslb-088-068-242-091.088.068.pools.vodafone-ip.de. [88.68.242.91])
        by smtp.gmail.com with ESMTPSA id d86sm2610889wmh.4.2016.05.20.13.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 May 2016 13:50:26 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295208>

Previously git-pull silently ignored the --verify-signatures option for
--rebase, potentially leaving users in the believe that the rebase
operation would check for valid GPG signatures.

Implementing --verify-signatures for git-rebase was talked about, but
doubts for a valid workflow rose up.
Since you usually merge other's branches into your branch you might have
an interest that their side has a valid GPG signature.
Rebasing, on the other hand, is you building something on top of
another's branch, essentially giving you the power to keep things sane.
If a valid use case is found, where --verify-signatures for git-rebase
looks sensible, that feature may be added then.

A warning was chosen in favor of emitting an error to prevent potential
breakage. A warning keeps things running, scripts for instance, while
still informing users about possibly unexpected behavior.

Signed-off-by: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
---

The warning message was changed to make it clear that the pull (and
rebase) operation still proceeds.

And the commit message was amended with more reasoning about the change
and why alternative approaches were not used.

 builtin/pull.c  |  3 +++
 t/t5520-pull.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1d7333c..b03bc39 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -815,6 +815,9 @@ static int run_rebase(const unsigned char *curr_head,
 		argv_array_push(&args, "--no-autostash");
 	else if (opt_autostash == 1)
 		argv_array_push(&args, "--autostash");
+	if (opt_verify_signatures &&
+		strcmp(opt_verify_signatures, "--verify-signatures") == 0)
+		warning(_("ignoring --verify-signatures for rebase"));
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 739c089..3159956 100755
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
+	test_i18ngrep "ignoring --verify-signatures for rebase" err
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
