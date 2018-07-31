Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86CFA1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 07:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeGaJNI (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 05:13:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35677 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbeGaJNH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 05:13:07 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so12145240iob.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B48UyS3GIFdJr//J23PUePrSj8tuXyyaWNHVXScWSWU=;
        b=TJ0bWgHwjf1V1l21OZFcUC+S7W7uiZ8jaCFdoZeaChiGMKUkMX04PywHWpAP9d0L1n
         w8XLvI49iJgLsJCFZqmyA2HGTTNaEkNIk8jTqSSRMIMX4egDgKAuqKDH1nr19JGDJwTn
         Z7u0cb8JMRpQ3gK63enZZd3vm7/CFOwPh9xJ06b9KWBLvPUmDcPljUUq5DUpCZaL0tdV
         eDFTRmPswg7ciGVdWrf9dWnFCel9vDnSIdzjm0TGd+dMOBlF01HePn28rFMbHxj4IeVU
         0ESYfUoTItiuYdSMuHDGzqdpZczw0qWxUcO9hyIbUnaKchuuJMWdGPGghd3+eCLAvTpR
         MRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=B48UyS3GIFdJr//J23PUePrSj8tuXyyaWNHVXScWSWU=;
        b=oag6sQfKEv6BTzf/FitX7cXsVv9ShIBffdoTapzCZztT3x0DjdFeLjvq+cl2eDKfQM
         RZUc4ox8MUgCDrJd3PtAQrZcOssCqiXEQez3qJ/7MGLquF/77IWbEvoLoa2nHUW9tb0b
         BcUKMo2JtZVcgj/POlsec6j31Y0ZtMDLQECbu+TjnG2Hf58lm7VlS7HHTqxeulN4LooX
         c8lHS+ZG3qE0Jn9tuX8xJtbrzBkJymgJiWHyV5aMtOAa3ziS5ojUK4YTIK43JDdpgMDN
         FFeCw+4A5GEUeq7+AKcITdsAA3QfD/TMFRhhus/GnF0DRx5pJ3SotBuZpfXnQdK/Fq3T
         wViA==
X-Gm-Message-State: AOUpUlEErI0YhOCpB0SwIZprA4N5tO1VjZDbZNli4we/Tbchg0uzAYg8
        bJhTt+TxZ/rFdxtHoqR1o9ZZyev3
X-Google-Smtp-Source: AAOMgpeIgBUH1E0b35p9xKdVU73OBglZkHVa6ohs4HSgJ6JQN4/HMf6s0m17WCzh8AE2zJbRL+0h4Q==
X-Received: by 2002:a5e:8515:: with SMTP id i21-v6mr15713776ioj.301.1533022448464;
        Tue, 31 Jul 2018 00:34:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m1-v6sm2371058iok.81.2018.07.31.00.34.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 00:34:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] sequencer: don't die() on bogus user-edited timestamp
Date:   Tue, 31 Jul 2018 03:33:31 -0400
Message-Id: <20180731073331.40007-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_author_ident() is careful to handle errors "gently" when parsing
"rebase-merge/author-script" by printing a suitable warning and
returning NULL; it never die()'s. One possible reason that parsing might
fail is that "rebase-merge/author-script" has been hand-edited in such a
way which corrupts it or the information it contains.

However, read_author_ident() invokes fmt_ident() which is not so careful
about failing "gently". It will die() if it encounters a malformed
timestamp. Since read_author_ident() doesn't want to die() and since
it's dealing with possibly hand-edited data, take care to avoid passing
a bogus timestamp to fmt_ident().

A more "correctly engineered" fix would be to add a "gentle" version of
fmt_ident(), however, such a change it outside the scope of the bug-fix
series. If fmt_ident() ever does grow a "gentle" cousin, then the manual
timestamp check added here can be retired.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 sequencer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 15a66a334c..9b6cdb6ff8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -742,6 +742,15 @@ static const char *read_author_ident(struct strbuf *buf)
 		return NULL;
 	}
 
+	/* validate date since fmt_ident() will die() on bad value */
+	if (parse_date(val[2], &out)){
+		warning(_("invalid date format '%s' in '%s'"),
+			val[2], rebase_path_author_script());
+		strbuf_release(&out);
+		return NULL;
+	}
+
+	strbuf_reset(&out);
 	strbuf_addstr(&out, fmt_ident(val[0], val[1], val[2], 0));
 	strbuf_swap(buf, &out);
 	strbuf_release(&out);
-- 
2.18.0.267.gbc8be36ecb

