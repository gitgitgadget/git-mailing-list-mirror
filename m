Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C2620401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbdFOVK6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:10:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32933 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFOVK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:10:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so1762480wmh.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMtk+gv9ymkQyDuWGqnRlIgCF879OOYQO+29XmwDx/o=;
        b=jLUxz9IxeaKwJSV5MVYRWmSCjYGc6FByO7H1np+8WSPg8WK2fSGhYHtVKA9NeQneG5
         JJQAUd7bztTjLmreO66LzKZevmQzcjB6C192cQtzw5GfmOXafmYwGUSqOKKG52LNF4mC
         HfC3Tj7zdi1xGZVWEUslofKOYIRsV0r8gyIiBcq3iw4MWoNG6cMWlD9k4O96vvD1xNeA
         VYS6TCi7aOqPuVOk50oXWRFWjuUepqogctX7k8Y0w1SRzn7nu09/vwGSZ1AC4Ul5OT8P
         KldxlJ/hAZNFxXm5ZIkmu2zImBQmG3uoldooFdiixXUOVM9puH8HemkavLNn6xyQfLJm
         uIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMtk+gv9ymkQyDuWGqnRlIgCF879OOYQO+29XmwDx/o=;
        b=tK05+2UUUt6ZamTKvqYBzW3i9shiWvW/ZbgFFLvZ8xkN+0QVcaY+fgWHwRzeWZRwzC
         Yz0f8Ha/TRJc6n17SHgP6/dkelnGHgfJpobx9CBg6pMAwn1FotmmfN9SdOK9BZAcVjnI
         VvxYDTDjniIEZ7puvxSQUmtSdCn20E5Frz75GARCWX/qAvqwH3O01csnwqkpWqX8tjg8
         17lC+BTte5hLBJLhml7x0OdVPtnMNKpLfH/vIkf1zv/CKcZGNn557cuWHi6E9gHpMErd
         PtF77YY6dqMaqIbrgYJo1quOkqmnRZUjV1CyJRRfdmaAEDFWwpmz6yjzrpzH8ort+cUY
         zX7w==
X-Gm-Message-State: AKS2vOzx8ed5NQbhdXLIW38rfoF+OYttx7JjguB0AtmfLa2rDj3e3/PD
        e+aPIcQnbrjGr96Yp2A=
X-Received: by 10.80.175.34 with SMTP id g31mr4865450edd.24.1497561055777;
        Thu, 15 Jun 2017 14:10:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g48sm257468edc.9.2017.06.15.14.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 14:10:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] wildmatch test: cover a blind spot in "/" matching
Date:   Thu, 15 Jun 2017 21:10:41 +0000
Message-Id: <20170615211041.22768-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <CAPc5daWy3eq-ODwDSbvhvRPH87QR0WMttZQUhmKfcZxs4qvdaQ@mail.gmail.com>
References: <CAPc5daWy3eq-ODwDSbvhvRPH87QR0WMttZQUhmKfcZxs4qvdaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A negated character class that does not include '/', e.g. [^a-z]:

 - Should match '/' when doing "wildmatch"
 - Should not match '/' when doing "pathmatch"

Add two tests to cover these cases.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Now with updated commit message, no other changes. Sorry about the
delay.

 t/t3070-wildmatch.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 7ca69f4bed..8fd70d3aa2 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -82,6 +82,7 @@ match 1 0 'foo/bar' 'foo/**/bar'
 match 1 0 'foo/bar' 'foo/**/**/bar'
 match 0 0 'foo/bar' 'foo?bar'
 match 0 0 'foo/bar' 'foo[/]bar'
+match 0 0 'foo/bar' 'foo[^a-z]bar'
 match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 0 'foo' '**/foo'
@@ -225,6 +226,7 @@ pathmatch 0 foo/bba/arr 'foo/*z'
 pathmatch 0 foo/bba/arr 'foo/**z'
 pathmatch 1 foo/bar 'foo?bar'
 pathmatch 1 foo/bar 'foo[/]bar'
+pathmatch 1 foo/bar 'foo[^a-z]bar'
 pathmatch 0 foo '*/*/*'
 pathmatch 0 foo/bar '*/*/*'
 pathmatch 1 foo/bba/arr '*/*/*'
-- 
2.13.1.508.gb3defc5cc

