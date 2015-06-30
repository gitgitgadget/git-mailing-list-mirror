From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Tue, 30 Jun 2015 10:13:48 -0700
Message-ID: <xmqqioa56rw3.fsf@gitster.dls.corp.google.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:13:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9z6b-0003kd-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 19:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbbF3RNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 13:13:54 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34978 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbF3RNw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 13:13:52 -0400
Received: by igblr2 with SMTP id lr2so79808336igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fUkPwnUcZ9RRhjUOhN8gXvQsCzM7tRjaTE5R7vASuFw=;
        b=s2IwOz3/kfMjeKaWskFO5Ae8Pk83URblHT/qk4v+4Ps8MmydW5Rg4iB+xo6sC1aC1Q
         HMn6HJAcXhXT9UZmdwIsGLx7vW6+tY71eJsdSm+GfxK894Ay/wzXYgL1Qi1niLnwlySg
         kFzvKo1fWBADLsbuIsnFfMNreUuOL4bGm2xdXGTqHqJ4Uw4UbN0WjrUZRrPegC97ShM9
         zFXEb2MX+DLy+EteE2MBkmgU2GQbNK2ypTDyyeZYzK7IOJieOWAlunXRTNL/NTrBjfx8
         I8Fq8updyy5kHUJJuDOL8LyXnG16FxsC4iPUpqiqfDarxQwYrBjuT49h9efwV5PUhFiV
         a4Sg==
X-Received: by 10.50.61.241 with SMTP id t17mr26112634igr.34.1435684431424;
        Tue, 30 Jun 2015 10:13:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id qh9sm8132196igb.20.2015.06.30.10.13.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 10:13:50 -0700 (PDT)
In-Reply-To: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 30 Jun 2015 00:56:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273087>

Eric Sunshine <sunshine@sunshineco.com> writes:

> * t2025-checkout-to.sh became t2025-worktree-new.sh. I'm not sure if the
>   test number still makes sense or if it should be changed, however, it
>   resides alongside its t2026-prune-linked-checkouts.sh counterpart.

You'd need to adjust t7410 as well, perhaps like so:

diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index 8f30aed..d037e51 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -33,7 +33,7 @@ rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1
 test_expect_success 'checkout main' \
     'mkdir default_checkout &&
     (cd clone/main &&
-	git checkout --to "$base_path/default_checkout/main" "$rev1_hash_main")'
+	git worktree new "$base_path/default_checkout/main" "$rev1_hash_main")'
 
 test_expect_failure 'can see submodule diffs just after checkout' \
     '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
@@ -41,7 +41,7 @@ test_expect_failure 'can see submodule diffs just after checkout' \
 test_expect_success 'checkout main and initialize independed clones' \
     'mkdir fully_cloned_submodule &&
     (cd clone/main &&
-	git checkout --to "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
+	git worktree new "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
     (cd fully_cloned_submodule/main && git submodule update)'
 
 test_expect_success 'can see submodule diffs after independed cloning' \
