Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85A01F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeDMVTZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39923 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDMVTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:14 -0400
Received: by mail-io0-f193.google.com with SMTP id v13so11765207iob.6
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lhRWeLVg1zCawmNRAXtrtUp8rnM6jXOa7H19zJzMb2E=;
        b=ZgIxfUqc9ahXfhsrh/+LtHOIoHLE3VbeWEueftDDNAzs9XPIWCYtoIkF6kw3uqnku2
         qNb+5o67Qjn30mapvarrA0DuSMuMIlcH8VTylnRZeFHUCxidyfWBHmtz3KNztkuhuSME
         n4FOVheo+0x7RuaAuEGL58Esr+4pyBuzburKDCK8lyjZmAMEnDtsQJBW7isWtCkCCuSg
         rFdazuHbek/lPbLZerfdVAr5pFMfkAOl1CGKdbusWcIIcMyMuKN+8YieFUC9AwVU87PP
         Pe6qpOA6idI080vOWhPN+UYkA+V97WLQe+YDW+Ct90vnOR/wCkM+S8M1GSsIsOHJeUV/
         KDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lhRWeLVg1zCawmNRAXtrtUp8rnM6jXOa7H19zJzMb2E=;
        b=fj1SA4bzaDvko8iCLLb3t7Tp7856EqymDTXF4M9ZEDwJXuf3paGkMj6vu+3dEfDelG
         Bt+c5DPRd1InD/xF4lXGwHStYcOmUEwTLHXVrw3IdrgayQasCB60m3ReQ8tPWhCi8jGP
         gs3qCbVtw83bYmGqlYF8IP1wTLKoS84872joNy2hY5MP49s+msGdZvpf9kdcvDh+iR8P
         rIe0xV7T1gaL9d9s6cI5mHv7pQg1/710HH+vtULqdSYRfF5eggvfEe+iLbpJ3rwT8wr1
         j1QFEqT6DbFB8gRRAKSfmcZKIWQZXKMyS4oTWhlfxAL9vs5A3p/BklX35wdewl/8myC1
         0bcg==
X-Gm-Message-State: ALQs6tASn7Pgy1ahw/g0SJz6MapBf8P7sZdSbpaYF4hGxmNgFhP7Pbgc
        FHYD7u3o49nHwe0Z4YtoZPtGKzNw5F0=
X-Google-Smtp-Source: AIpwx4+uasyUdhZ5mbrZgNMdGYWEXCUdni8vsBpdoxY0PywXFDgaTVs8/a0MwaKTsmJDV4JkmWHFqA==
X-Received: by 10.107.40.147 with SMTP id o141mr14842168ioo.72.1523654352824;
        Fri, 13 Apr 2018 14:19:12 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:12 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 4/9] gpg-interface: use size_t for signature buffer size
Date:   Fri, 13 Apr 2018 15:18:32 -0600
Message-Id: <20180413211837.99415-5-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180413211837.99415-1-mastahyeti@gmail.com>
References: <20180413211837.99415-1-mastahyeti@gmail.com>
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Even though our object sizes (from which these buffers would
come) are typically "unsigned long", this is something we'd
like to eventually fix (since it's only 32-bits even on
64-bit Windows). It makes more sense to use size_t when
taking an in-memory buffer.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ben Toews <mastahyeti@gmail.com>
---
 gpg-interface.c | 2 +-
 gpg-interface.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 08de0daa41..ac852ad4b9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -101,7 +101,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }

-size_t parse_signature(const char *buf, unsigned long size)
+size_t parse_signature(const char *buf, size_t size)
 {
 	char *eol;
 	size_t len = 0;
diff --git a/gpg-interface.h b/gpg-interface.h
index 2c40a9175f..a5e6517ae6 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -31,7 +31,7 @@ void signature_check_clear(struct signature_check *sigc);
  * offset where the embedded detached signature begins, or the end of
  * the data when there is no such signature.
  */
-size_t parse_signature(const char *buf, unsigned long size);
+size_t parse_signature(const char *buf, size_t size);

 void parse_gpg_output(struct signature_check *);

--
2.15.1 (Apple Git-101)
