Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5BDC11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA0624670
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="jvTRC7UA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgBUBeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:34:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40995 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgBUBeI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 20:34:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id d11so439607qko.8
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 17:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hR3MwDQVGfWz3BwPSpplWNtP2r0r6uMG3Qbw1ojHbCc=;
        b=jvTRC7UAkPS61q/chW2+CjOVwRXF8m5WqLqCx9rXniPmS0HeBO5k6jS4+puO/qUuIH
         4aatHbjhSSrnc9iKofMHPO+OUKzkiGk/AXjS7e3weNCF9GzC5pVQ02J0UZXMN0h8mmpx
         YINw0ik59CogpRF/RTzSgvmWGSydPjdFeHC6JQo3n9rJMbOhBTdkHGqLFoyHGjoY9ZA5
         uSzd9ictoheXIeypG4DAxV+ww8tTrtaXWJTqOmTeSj91yceNpigcBeskhwqbdWi0wK8o
         KCiOZONI/iHoCU0cwKk57XTSqN7O5AOcbQPqgPgnnG/bDCX5z+huJUq5cp3aaphMOPzc
         yfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hR3MwDQVGfWz3BwPSpplWNtP2r0r6uMG3Qbw1ojHbCc=;
        b=WBMMH0nWDHU4dPKoNLXaoT6IwiXrkxRuQSScUxiYlKmM+8EwJdURH+8Ex25qNco4BM
         QPfOScC8AFwgaCoWfeCvySWVv1Cwqqxs/A9c5YjAyIMrjfOe0SqcTio8K8r8SYSmfHt5
         ZVdrhQYQ4Bl88MkkwJmr/QkDABmEHU3+qOORGXXNbK2mXucXrAGakH/XqR/SECgc4V4t
         AfccqFpt8+I+UwU2NYPqR9Cqlue3Azp04OBGvZ78mReYVnvLd4a8CqWQrzP86s5SqJxk
         K3E7Ql3+a30ce2EdXsSyeA8EDwLoxz4WMJsrm1C0M6tnXa/QSCUBAi0zAY2xwzthFbln
         dQ9g==
X-Gm-Message-State: APjAAAUpfj0cdL2JTAzQnUPMQE+SkSIEzc7u1LfqK1RgiQS8XiAXK4wI
        cB3SagicVxBT1JTqkIVw30RSAw==
X-Google-Smtp-Source: APXvYqzHziJWJhfGWCA1pSXHHT2L7wMWTdh9rDKwQrEWHoD9wdK/a4aEaLturQAb804KHn+ciY/JIg==
X-Received: by 2002:a05:620a:1036:: with SMTP id a22mr30748315qkk.338.1582248847248;
        Thu, 20 Feb 2020 17:34:07 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id z196sm752421qkb.125.2020.02.20.17.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 17:34:06 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br, peff@peff.net,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Date:   Thu, 20 Feb 2020 22:33:57 -0300
Message-Id: <20200221013357.26795-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <xmqqftf49862.fsf@gitster-ct.c.googlers.com>
References: <xmqqftf49862.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 7:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>
> > I now this is just an illustration, but shouldn't this example be "git
> > describe --contains v1.0-bob~1"?
>
> No, none of the patches discussed in this thread would not affect
> anything in --contains (as it is a completely different program).

Ok, thanks for the clarification.

> > Another case that came to my mind is when the user runs `git describe
> > --abrev=0 HEAD` and v1.0-bob points to HEAD~. In this case, v1.0 will
> > be displayed without suffix,...
>
> In this case, v1.0-1- is followed by the full object name, I think.

I might be doing something wrong, but this is how I tried to test this: First I
set the desired scenario with:

$ git tag -am "" v1.0 HEAD~
$ mv .git/refs/tags/v1.0 .git/refs/tags/v1.0-bob

Then, running git-describe on v1.0-bob^0 I got what we want, which is the forced
long output (even with --abbrev=0):

$ git describe --abbrev=0 HEAD~
warning: tag 'v1.0-bob' is externally known as 'v1.0'
v1.0-0-g310a1f27be54ecf16fd36ff987304c1a2f8524b5

But running on the commit after v1.0-bob^0, I got:

$ git describe --abbrev=0 HEAD
warning: tag 'v1.0-bob' is externally known as 'v1.0'
v1.0

Then we cannot directly use the output. I think we can fix this forcing the long
output for this case as well, which can be done with:

diff --git a/builtin/describe.c b/builtin/describe.c
index 5e8484f654..f71bddff4a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -452,7 +452,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	}
 
 	append_name(all_matches[0].name, dst);
-	if (abbrev)
+	if (all_matches[0].name->misnamed || abbrev)
 		append_suffix(all_matches[0].depth, &cmit->object.oid, dst);
 	if (suffix)
 		strbuf_addstr(dst, suffix);

