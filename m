Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C608C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56397611C1
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbhDFOA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhDFOAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 10:00:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2789C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 07:00:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so7370159wmj.2
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zayaExMxKQe6pccMfh7QAilyo1WfFt+GYSTPpuJgr2Q=;
        b=t8nlq9mT/k3bZaC2xTvC83bQNgEOqfFnC32VHmG0pfoPlLhjoh2zFjd1bXXHn4xg6P
         DGlJ0/qjcaIVltrAN0cTkWRuSwM09TBZciDFfJ0hR4FYpj9BFdUYlDTpCNU7W1GGPJ6Q
         2Lny2mlpYUQS5yceYHy3WgW9PgOBvbIP/de9Oj1F1AVXWmuZe6ntgMQBBLrQ+nXZDj80
         KosykquYtuvHdUWYoKToe7zOE7oauLCVEXGERBS1fCM6vHHEN4qDUuWLMIMoQ4RGWkLE
         nUKLyRNssKmIehY8i/OlAgsZX/TlgnFqOUbjO28cyO6Ga8nhFFXK8wNcI97W1obrTUQb
         o+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zayaExMxKQe6pccMfh7QAilyo1WfFt+GYSTPpuJgr2Q=;
        b=hEPEXd/bJ/vhYUJtM/9h8UbLWFncVw7DYrbO4NGFU60cuEjJP0GJFD8yWf0LHsrpty
         YfaZY4rWv9FFeX7blPNub38rcBlQrOGWaC/NuMKgqENC6hEC0Az3F+MGeFXmYV5WAtqq
         whnf1FcD5UoMxmzQUPsm8SI4rLzi/ckwT+gDUbQh5zt5GZcvu7Eoe6Gx1bWnFRA671nE
         TQGPNc7HTXj/G9W1QvZNYMD1fwkSU5ftADJHRH4OEfY1LfSPPJbK2uxMykaOo4Ek8dPZ
         rd+wfpaMAjUaQUN+0M8J1UPvLGLrfdilZbhZoZ2xyRy3hAC2YkXnNDqzdJGqDWccUPj8
         nqAA==
X-Gm-Message-State: AOAM532ZMEvKKiqNXosiA3femi7YqG41ZpOLq2HkD/EKCtD2sOeNiRqm
        VJ7o9IOjgqXJQjQiJ3Q/s2Rnn/axF68=
X-Google-Smtp-Source: ABdhPJzGABSNMYHiLqJCwXPBPKxwgtWU4AgfES1NmEljehTS93jP70Wglcm4ImHB7Wr5eB1yYfQvtQ==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr4328191wmh.78.1617717646200;
        Tue, 06 Apr 2021 07:00:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h6sm20029696wrr.21.2021.04.06.07.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:00:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] refactor duplicate $? checks into a function + improve errors
Date:   Tue,  6 Apr 2021 16:00:34 +0200
Message-Id: <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version 3 yields the TREESAME end result as v2[1], but re-arranges the
way we get there to make the progression more understandable, along
with a minor commit message update.

I also peeled off the previous 1st patch, as Junio's picked it up
separately and marged it into "next" already.

1. http://lore.kernel.org/git/cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (3):
  git-send-email: test full --validate output
  git-send-email: refactor duplicate $? checks into a function
  git-send-email: improve --validate error output

 git-send-email.perl   | 45 +++++++++++++++++++++++++++----------------
 t/t9001-send-email.sh | 35 +++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 25 deletions(-)

Range-diff:
2:  15b59c226d4 = 1:  6e1009e5bed git-send-email: test full --validate output
1:  f236f083e36 ! 2:  4ee582d8301 git-send-email: refactor duplicate $? checks into a function
    @@ git-send-email.perl: sub is_format_patch_arg {
      		}
      	}
      }
    -@@ git-send-email.perl: sub unique_email_list {
    - 	return @emails;
    - }
    - 
    -+sub validate_patch_error {
    -+	my ($fn, $error) = @_;
    -+	die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
    -+		    $fn, $error);
    -+}
    -+
    - sub validate_patch {
    - 	my ($fn, $xfer_encoding) = @_;
    - 
     @@ git-send-email.perl: sub validate_patch {
      			chdir($repo->wc_path() or $repo->repo_path())
      				or die("chdir: $!");
      			local $ENV{"GIT_DIR"} = $repo->repo_path();
     -			$hook_error = "rejected by sendemail-validate hook"
     -				if system($validate_hook, $target);
    -+			if (my $msg = system_or_msg([$validate_hook, $target])) {
    -+				$hook_error = __("rejected by sendemail-validate hook");
    -+			}
    ++			$hook_error = system_or_msg([$validate_hook, $target]);
      			chdir($cwd_save) or die("chdir: $!");
      		}
     -		return $hook_error if $hook_error;
    -+		validate_patch_error($fn, $hook_error) if $hook_error;
    ++		if ($hook_error) {
    ++			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
    ++				       "warning: no patches were sent\n"), $fn);
    ++		}
      	}
      
      	# Any long lines will be automatically fixed if we use a suitable transfer
    @@ git-send-email.perl: sub validate_patch {
      		while (my $line = <$fh>) {
      			if (length($line) > 998) {
     -				return sprintf(__("%s: patch contains a line longer than 998 characters"), $.);
    -+				validate_patch_error($fn, sprintf(__("%s: patch contains a line longer than 998 characters"), $.));
    ++				die sprintf(__("fatal: %s: %d: patch contains a line longer than 998 characters\n" .
    ++					       "warning: no patches were sent\n"),
    ++					    $fn, $.);
      			}
      		}
      	}
3:  a1edceb4913 ! 3:  8a67afd3404 git-send-email: improve --validate error output
    @@ Commit message
     
         Improve the output we emit on --validate error to:
     
    -     * Say "FILE:LINE" instead of "FILE: LINE".
    +     * Say "FILE:LINE" instead of "FILE: LINE", to match "grep -n",
    +       compiler error messages etc.
     
          * Don't say "patch contains a" after just mentioning the filename,
            just leave it at "FILE:LINE: is longer than[...]. The "contains a"
    @@ git-send-email.perl: sub system_or_msg {
      }
      
      sub system_or_die {
    -@@ git-send-email.perl: sub unique_email_list {
    - 	return @emails;
    - }
    - 
    --sub validate_patch_error {
    --	my ($fn, $error) = @_;
    --	die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
    --		    $fn, $error);
    --}
    --
    - sub validate_patch {
    - 	my ($fn, $xfer_encoding) = @_;
    - 
     @@ git-send-email.perl: sub validate_patch {
    - 			chdir($repo->wc_path() or $repo->repo_path())
    - 				or die("chdir: $!");
    - 			local $ENV{"GIT_DIR"} = $repo->repo_path();
    --			if (my $msg = system_or_msg([$validate_hook, $target])) {
    --				$hook_error = __("rejected by sendemail-validate hook");
    --			}
    -+			$hook_error = system_or_msg([$validate_hook, $target]);
    - 			chdir($cwd_save) or die("chdir: $!");
      		}
    --		validate_patch_error($fn, $hook_error) if $hook_error;
    -+		if ($hook_error) {
    -+			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
    + 		if ($hook_error) {
    + 			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
    +-				       "warning: no patches were sent\n"), $fn);
     +				       "%s\n" .
     +				       "warning: no patches were sent\n"), $fn, $hook_error);
    -+		}
    + 		}
      	}
      
    - 	# Any long lines will be automatically fixed if we use a suitable transfer
     @@ git-send-email.perl: sub validate_patch {
      			or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
      		while (my $line = <$fh>) {
      			if (length($line) > 998) {
    --				validate_patch_error($fn, sprintf(__("%s: patch contains a line longer than 998 characters"), $.));
    +-				die sprintf(__("fatal: %s: %d: patch contains a line longer than 998 characters\n" .
    +-					       "warning: no patches were sent\n"),
    +-					    $fn, $.);
     +				die sprintf(__("fatal: %s:%d is longer than 998 characters\n" .
     +					       "warning: no patches were sent\n"), $fn, $.);
      			}
-- 
2.31.1.527.g9b8f7de2547

