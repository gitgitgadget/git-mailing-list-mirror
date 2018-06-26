Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E161F516
	for <e@80x24.org>; Tue, 26 Jun 2018 10:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933715AbeFZKF4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 06:05:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55889 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932963AbeFZKFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 06:05:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so1198022wmv.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 03:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ltXQwE4zgMm9gp8loSGR+rRhI/tVe9CEcSf+nO7VzQ=;
        b=dBoJHrpPWGCz73H7lehU4/277peaM8BFMdaFEZSot435Ql9ggt7YVoom63brOTIPoW
         /6QfyDcuG0o49G4+e+ave29hsBu1RqAiLw96YyapwvB7pZMjgL1l5fDWXCcp6ePHVabL
         CV5j+2L/2gmVtOHZqBNUPxoL6kmEqGmBp1ffd6qXS6ros/QiqGguYPNSX3+lsbrwGhxy
         BQtdqJ9TS2RbIX6N4zHphU+ZmXTQWW5kzNtr1V20sIbp4Fj1NKs9bLWknCZHG60QVR5W
         k3CX9GGZELcEu5UZzX1CBntC1SlRlAekJCz7128Sz1RGZs7FFryqkGDWBrBr5Plry8rI
         suzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ltXQwE4zgMm9gp8loSGR+rRhI/tVe9CEcSf+nO7VzQ=;
        b=cf0Hw8sZVBoisLuzgn6Kal3GGyqsSo3kcTtV0RgYAeToJAlWVheuLkKjtiVn4fUI32
         3HjiNkcFeLEMmpQI21KkV628rRc41LAqyaGLVqagB7uI04JCFOrx/dPw7KatXvEUftd4
         lb6o+gc+CAvbuZp+PfwccUEvAWnKta49fFl5tXbMC+76Waa7YWty8sGeApWu8GyPUilQ
         nSIz/wzfeTPyB6kFjjBA9M9Uv601WaU1ERmgzhYsPLl3FrDtSAgeM4keFQ+f4M64ecLL
         1A51AXlm7wbC/PZLowXRnBdyoZIM/fWwm1xgX4+yjTyVQlWXdrKadavZc+f020X/QVWG
         HcUg==
X-Gm-Message-State: APt69E1vz8QGD2C7AlCcCInH3GWSVwIdCLxMvss/51u2oJAEeh/9rU22
        UglLL8XwynL3wDvxTUe1Gzb+dZ7M
X-Google-Smtp-Source: AAOMgpdOTcSEw2lCXS7JIWYO4fXrVP26hvuqtOfZxNhMovHP1BaB+rV/KlBWK5ImXpVSxGKp/XqLPw==
X-Received: by 2002:a1c:2dd5:: with SMTP id t204-v6mr1101504wmt.94.1530007552625;
        Tue, 26 Jun 2018 03:05:52 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id y8-v6sm1855050wrq.35.2018.06.26.03.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:05:51 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 1/1] sequencer: print an error message if append_todo_help() fails
Date:   Tue, 26 Jun 2018 12:04:29 +0200
Message-Id: <20180626100429.10169-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626100429.10169-1-alban.gruin@gmail.com>
References: <20180626100429.10169-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds an error when append_todo_help() fails to write its message to
the todo file.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7cc76332e..7c4bdbb99 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4380,6 +4380,9 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 	}
 
 	ret = fputs(buf.buf, todo);
+	if (ret)
+		error_errno(_("Could not append help text to '%s'"), rebase_path_todo());
+
 	fclose(todo);
 	strbuf_release(&buf);
 
-- 
2.18.0

