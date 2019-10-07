Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65101F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 09:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfJGJ1G (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 05:27:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34141 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfJGJ1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 05:27:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id j11so8571349wrp.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUUMnyIz1afOKGnFdMztYX7pRXFgr1vwP/km10ffbOY=;
        b=X/DwjMgQ7bg1IMndfGvoikCZ+wTNXylGbNgelmcwLpldrTvED4KvCF+lSHUpu2Et9Y
         TbHCl+aL7qauIKEUKl++iZamsGQgCKFo+JucRUmnGqzPlB0GL/46xg5maX7OPM0GCDl3
         meaQscApdkpBorQlX1kJ5Stm5PAf5uVA9a3OFMqMK/w3Zx5coe9Jq96SI/iOX45KQh4j
         G1/5eoMdx9wEuCPLkHMmtHkV0bqbF8Buo5SG2Chfn8lXrfAz6fmjLu5gnoadf3FOXz/+
         uTRkht099ejFsWwVmK6GbC5uFEEHyEShVWU1AQAzulCx2F2/nkxDIeofQTkH1acJmElp
         fuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUUMnyIz1afOKGnFdMztYX7pRXFgr1vwP/km10ffbOY=;
        b=PAR9qRDPbFaBC3/dse49T5si5hS8mycxfm5o3dq0+qm5m/qbSMs5cAlW1Q6ambCeCp
         OWqdisP7EMiZ8Do1vS1aQgiog2p0MwWgGlyWLnjf7H8F9Sqi8Gv+9iAEpcJRmnzfBWIf
         z9/ISU/DthYksFNvGrFlBwJwE/ioaA5ghS5iMh0FV33Nu0WXEFQVZk1UiUl5HdtrvYNQ
         Mwl6qZv6ufMzUNEXYdx+nyH9X3O3UwmZNZ9qQithJChHV5o7NxSge96YjMXg/NfDtJf9
         LzH45bxUjayPqPjI5ltTlRyR2S+DUZBW6aJsPTs49rQU9N/h7i44wBh+8COchZvbF1vM
         pmug==
X-Gm-Message-State: APjAAAWA+3r02IL44N563PKUlg0C6Xz4DodO+ciQvaAmz/aimK9nm40R
        IygKFQ1zFGzyYf6xaW0E1hJ2ENO7
X-Google-Smtp-Source: APXvYqxHsD7PyTFJd4VBxECCnHDRrCEJqERokdEOiD6SlhuquSOwYAXSG4uPsvOMAEBySbtvxkTYXQ==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr20785517wru.242.1570440423921;
        Mon, 07 Oct 2019 02:27:03 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.googlemail.com with ESMTPSA id w125sm25250914wmg.32.2019.10.07.02.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 02:27:03 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 4/5] rebase: fill `squash_onto' in get_replay_opts()
Date:   Mon,  7 Oct 2019 11:26:40 +0200
Message-Id: <20191007092641.12661-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007092641.12661-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20191007092641.12661-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the get_replay_opts() function does not initialise the
`squash_onto' field (which is used for the `--root' mode), only
read_populate_opts() does.  That would lead to incorrect results when
calling pick_commits() without reading the options from the disk first.

Let’s change that.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Reworded commit.

builtin/rebase.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e8319d5946..2097d41edc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -117,6 +117,11 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	if (opts->strategy_opts)
 		parse_strategy_opts(&replay, opts->strategy_opts);
 
+	if (opts->squash_onto) {
+		oidcpy(&replay.squash_onto, opts->squash_onto);
+		replay.have_squash_onto = 1;
+	}
+
 	return replay;
 }
 
-- 
2.23.0

