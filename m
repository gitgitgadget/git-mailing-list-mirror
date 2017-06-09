Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8C81FAED
	for <e@80x24.org>; Fri,  9 Jun 2017 08:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbdFIIyH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 04:54:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36207 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdFIIyD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 04:54:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id d17so5874681wme.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MrkPwBNsWQQNECr6h4S1jHcRzIP4jYguMRUNmKs0UuY=;
        b=ED4a/vqRpPtDJLyQdDdj3Vh/tJn+a6VzdwLHOiIGO/0QkZaI1qqYvEoX7ZRnfu66Vy
         tFd1C//LZGT2MI/PbdUBnWb0mQF+b8nAJpJ19pbvcThQlnQjwQ7+yLbjc+4vIlJLWrlD
         +EmcruZRi4Jx6QrfnHCHtANC7gEGzER7EASOY1HK1Kn0ZzM14EWP4+qNfeNPZyU/MjtG
         aSqTe5DCP1P2JEJzcuJDrK03LpOh4N4Oi696g81D5NmL3nCi64N7VT4yZAOR4PZxGada
         X4Y7eQLuIPHmmBRVsOtTgYLXYjlpcClWmycvR8s9apfzcfeR1dpwL3M1vL0b2LVErD1c
         hiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MrkPwBNsWQQNECr6h4S1jHcRzIP4jYguMRUNmKs0UuY=;
        b=GQKJz1Tr4xJ04zV9l2UEDehTKi9ttYR2G2x58tD8zN2hQ/8UU4EidivhUDNRs3FybK
         LvzIfyIGMmhhL19ZtisBLI8V5h/3rds7tlUUoP6Gzw0FXGpDtyqKbtpf2jlr7zEu1fmu
         L2gJFfjsWu+dNjsrbC93fy38LAZsQ2GwGm/c6HdMR0WKNa3nv/iIKQ5OWYnnZboZ+lPO
         xGWpBaM8lIwkUD8/N/maMzQFQsMX1L/6Y1IJNDKgS7bb0PPkpYDRNOleCS/thHEMv+Y/
         0w6whL0oFjxipDNfvnLY4KDmotuTWjZWgedNfbHkzld9Vi1ogCGQzNdMkkdK9GNfPTbZ
         I40Q==
X-Gm-Message-State: AODbwcClGbroj6qfy6KgIyideMoEqtWgI4HB6nLDDdzrc5r856VRLxnV
        cxJuZafwRwhQUlWCd5Y=
X-Received: by 10.80.161.166 with SMTP id 35mr32056278edk.96.1496998442115;
        Fri, 09 Jun 2017 01:54:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w48sm399405edb.49.2017.06.09.01.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 01:54:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] git-compat-util: add a freez() wrapper around free(x); x = NULL
Date:   Fri,  9 Jun 2017 08:53:45 +0000
Message-Id: <20170609085346.19974-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
In-Reply-To: <20170609085346.19974-1-avarab@gmail.com>
References: <20170609085346.19974-1-avarab@gmail.com>
In-Reply-To: <20170608234100.188529-8-bmwill@google.com>
References: <20170608234100.188529-8-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a freez() wrapper for the common pattern of freeing a pointer and
assigning NULL to it right afterwards.

The implementation is the same as the (currently unused) XDL_PTRFREE
macro in xdiff/xmacros.h added in commit 3443546f6e ("Use a *real*
built-in diff generator", 2006-03-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4b7dcf21ad..21e3710755 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -787,6 +787,7 @@ extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
 extern void *xmallocz_gently(size_t size);
+#define freez(p) do { if (p) { free(p); (p) = NULL; } } while (0)
 extern void *xmemdupz(const void *data, size_t len);
 extern char *xstrndup(const char *str, size_t len);
 extern void *xrealloc(void *ptr, size_t size);
-- 
2.13.0.506.g27d5fe0cd

