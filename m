Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3223D1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeHNB1A (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:27:00 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:43977 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNB1A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:27:00 -0400
Received: by mail-qt0-f201.google.com with SMTP id d25-v6so14333445qtp.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mn6E7/A/58Jnlt2BMIGp9cPr25OPda8upIOHOv6A8a8=;
        b=SfDinkV8s6tHbMGFmMuH+Wc7TLUbT59o+Py0stSNvh1uWLS0Q6Z9l20u1z1ivK6MXi
         n3M0/6an4IqOin7xIWS/JrbnY0viq3OdspDvQKYEphWvmVyiQ+I5wJOofQeolBnx89xb
         zQSHz/FrWdDXhColLN+CzWyLqcRxWqC6DJjVBHf5KnT2Yv8sOVnMjnK8UAMG2BgQrbuO
         l4MfR5vTp61fcjASHgcDJiVttulSJCieNqEm9eXadF9RmCnT5Fe7YCpTeFf6pSZzu7A2
         4i2jihB2Vi4dJZQL2w15fO+7SvQCIkvcXDAxTIDYJZKSgJ8ZGBFt5TKTl18QfmtDDZVO
         weWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mn6E7/A/58Jnlt2BMIGp9cPr25OPda8upIOHOv6A8a8=;
        b=C3DnSrWIVZyyOMfdO53LEMVs9ADLADQmx9kuuKr85t0nRFG4m1fq11igHgq2qxEaKo
         EeBSnkMu/ny0TT8na216vxUcMZxqSvN0LZJB7O07q/T1t6hYHNK4UxqEFw88AsRO2eKi
         327S3Ru22GEKALjxVUUNPKyVEpAojTfPLIcCATFQ/1Qu7ZOlQW+dxqcH0ZZgBarJIelh
         JkjlBOSZyJzYp5QUVmAPexMqbpSWGdWJPaQ/1GwS8kwzOcOW1thM0HVqnqrMqjrfsu0c
         nn6qzuk34majLqmf6868afzVXdsfG2Ek0pLV32iXx1YNacu0weMk6fb63dxqVmnFNJ+H
         rOBg==
X-Gm-Message-State: AOUpUlE6FtC37jKE6LXdVTMyZRknvEoRIhWgB62z13TMZE0bknhTPQzt
        WJ68KObqKz73/VdXQ28fBlqMloCMMSB6
X-Google-Smtp-Source: AA+uWPxS42uRMTLzV03/0tle8Gr28ddpMkn7OuAwxrc5QYvoMMYJ1eEX/6DBJE1b0g2NW3GzFNsNPbDxSNXP
X-Received: by 2002:a0c:adad:: with SMTP id w42-v6mr10091374qvc.7.1534200163876;
 Mon, 13 Aug 2018 15:42:43 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:42:29 -0700
In-Reply-To: <20180813224235.154580-1-sbeller@google.com>
Message-Id: <20180813224235.154580-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 1/7] git-submodule.sh: align error reporting for update mode
 to use path
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All other error messages in cmd_update are reporting the submodule based
on its path, so let's do that for invalid update modes, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b5ad59bdee..5a58812645d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -632,7 +632,7 @@ cmd_update()
 				must_die_on_failure=yes
 				;;
 			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
 			esac
 
 			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
-- 
2.18.0.865.gffc8e1a3cd6-goog

