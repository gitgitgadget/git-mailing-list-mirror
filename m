Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0351C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9706C2076B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="imwWI1kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFAX1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:27:49 -0400
Received: from avasout03.plus.net ([84.93.230.244]:41034 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFAX1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 19:27:49 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id ftqGj5iEoNXR9ftqHjWHmI; Tue, 02 Jun 2020 00:27:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1591054065; bh=SCU7Ck1U5a/UpHzUfsVVBKJjDLHIA5g3tmzzr+i71dw=;
        h=To:Cc:From:Subject:Date;
        b=imwWI1kYp9sweHNn9YhvDv7NbngAjUodRjfuFSNvimGgBq0VrdLN/nACWVDKavcAj
         MG3DiTXAPKcAY+eOJwJ+2jU7szL1RZtt/HYTcwAR4pxtSEaefhOPmdFulIiW6HK0ZX
         xuZmp/vhBVkh//xomjtIkkDNsD+Vhmoucb9ay9i5Mq+eu8lUMQeRo/OxLROj0k/lgD
         uSMfOsVfk3kj1cnT1dlcuOPRdUNta3knBbKmwX3SvoQy5VbpzYI7WKGaO0o679nYJ6
         9gqhqYcZNXdU0c7FpTS4pc7mNOm9oF9Wbflh69Ry+hZs/L0B1w2L1UnKUhR2aQmknu
         6FZBVfjG1pMqQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ZemGyvdA c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=uyT1YxFDGUNa-xvaTxYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] git.c: fix sparse warning
Message-ID: <d9686e75-0792-33f7-dd70-3dc8ca6c4d66@ramsayjones.plus.com>
Date:   Tue, 2 Jun 2020 00:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCokVZ+Q40NYY+Rkiua0GSMBgyYOOYjL9z0xKUOQOsqbMcxrSxvpz6Sr25g6lnshJyjYjfPo6I0bUBClBQTfTdM0BOHRMJ0JWV8taCcZ3lBm9yJs3pub
 a3HQL0EB3xdfQC7ouCDoFFqaay+dPdZEkWZoZDpM1vJ5NrP50t8d49qU5EsWsQLUj+UeYdPWsZg/3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 4acc44d720 (config: add setting to ignore sparsity patterns in
some cmds, 2020-05-27) adds an external symbol definition without a
corresponding external symbol declaration. This causes sparse to
complain: "symbol 'opt_restrict_to_sparse_paths' was not declared.
Should it be static?".

In order to suppress the warning, #include the 'sparse-checkout.h'
header file, which contains the required extern declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Matheus,

If you need to re-roll your 'mt/grep-sparse-checkout' branch, could you
please squash this into the relevant patch.

[This is the minimum fix - but I might be tempted to move the definition
of the variable to 'sparse-checkout.c' as well.]

Thanks!

ATB,
Ramsay Jones

 git.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git.c b/git.c
index 07de4363ef..6e62001f2f 100644
--- a/git.c
+++ b/git.c
@@ -5,6 +5,7 @@
 #include "run-command.h"
 #include "alias.h"
 #include "shallow.h"
+#include "sparse-checkout.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
-- 
2.26.2
