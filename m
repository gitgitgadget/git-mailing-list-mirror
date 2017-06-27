Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB59D20401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbdF0UeO (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:34:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33164 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbdF0UeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:34:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id j85so7893413wmj.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HiwCldtOYGri+AN8WwzrEnivZ0bK5AEE0I811EzAsE8=;
        b=qvvZgV0KZ0z9Lqjntkw3I7UmyWCGclzUmdzgTV02H7sNNLxEfZKOoGIzCdsF3XmXJI
         vC75p+7Um8d2kzehUw4HvhudrkPRY+dOcrAm+mW+EFR3YrGV5ZrvChIhPP3uAaQkK/ON
         rxOSjJL4TOYAk2en/qNAM+cdhzcCBImBe6LFZV2hPmKWKjaMMLDiD+y1AKjmqqyjLJhe
         soz320iuExlJ4QOfFzacEIzcbp5tY9ZYVIK0zoeB/uRIyhsfzboUtVB20kNfFo6LUIxu
         mvAuI80aGx2ZeFvGElJChJTIGJKhyK72Od5wuKdtZUn/fSAPPAIi4Q0upzPlU3R9DS7W
         Qf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HiwCldtOYGri+AN8WwzrEnivZ0bK5AEE0I811EzAsE8=;
        b=QuqaFrdtcIR+lW3l8icH6VHelV0LgmMt4ixTl/eZy5YRkpoXo7WhoJNz8HMLwaHXP6
         GZNC7uXhx6XjEvDr3zTOU1I4pXOrbtjzypFjS8tHN3dfExdhBqg43aN96OJyYTYrhsSL
         +gxan9rn82TEoOTkG2qUWJUSjAp9gSbABY3kmUB1bmvnAtwPhVGofOC6f8ljJyqSjgHc
         1ZNmQD0C9g1yNPA735+xsl2+NK89eAltlhMqaArOQsOpEumSkTF5rw+chPTogvQq4rSK
         kyS0vQmH3OaHSrqu9ZVDj45anzfCj2URzXGy5BF9aFQS6n++jGepMQU4jQg0eU/MkrHx
         gUEg==
X-Gm-Message-State: AKS2vOxfqOmCxNAEPLbbNOwM75zRtebdMCe5pB9Do0KkdKbmlOidNenQ
        d+n2/Vhx0y6ez+znXtA=
X-Received: by 10.80.148.118 with SMTP id q51mr5214818eda.28.1498595646604;
        Tue, 27 Jun 2017 13:34:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a18sm104862edd.23.2017.06.27.13.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 13:34:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] sha1collisiondetection: automatically enable when submodule is populated
Date:   Tue, 27 Jun 2017 20:33:48 +0000
Message-Id: <20170627203348.19827-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170627203348.19827-1-avarab@gmail.com>
References: <20170627203348.19827-1-avarab@gmail.com>
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

If a user wants to experiment with the version of collision
detecting sha1 from the submodule, the user needed to not just
populate the submodule but also needed to turn the knob.

A Makefile trick is easy enough to do so, so let's do this.  When
somebody with a copy of the submodule populated wants not to use it,
that can be done by overriding it in config.mak or from the command
line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index f0cac1f246..3baa1eac0b 100644
--- a/Makefile
+++ b/Makefile
@@ -1009,6 +1009,10 @@ EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
+ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
+DC_SHA1_SUBMODULE = auto
+endif
+
 include config.mak.uname
 -include config.mak.autogen
 -include config.mak
-- 
2.13.1.611.g7e3b11ae1

