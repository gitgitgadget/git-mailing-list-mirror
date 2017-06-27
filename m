Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3F320401
	for <e@80x24.org>; Tue, 27 Jun 2017 12:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbdF0MRt (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:17:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33600 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbdF0MRq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:17:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id j85so5467781wmj.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HiwCldtOYGri+AN8WwzrEnivZ0bK5AEE0I811EzAsE8=;
        b=JBiwvsDukYMiaBlLjfClrOn8VThZ8UtRs9Hzy53GcKvqKL6rpwlNlAIyooZIvCMkPq
         L3kZNjLJSJnG2ZyfxiIg59Yd8ZUpO2ltuE3Ptwja11DDq7/y16unfUFWr9ea/2M3C5KO
         wnchooOy3AV0167rDqJ/rzjqHVD7c1cT5ClifK97rMIa6+WF+mndAm87HSPciRBkLsrx
         9I8j72WOFMO3BI70eqY6LI2NYfc4KXA2OSBbM821/6BCsgroqRvbvoV4dJhcXM+l9FVX
         6X292f6ltDM0uQ3nLIlPiWw2eaVylrHFVEMKv5tt9T2xARmnmhN1I0uxy3GidZxZyDn3
         Me5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HiwCldtOYGri+AN8WwzrEnivZ0bK5AEE0I811EzAsE8=;
        b=UJUT15iWxUtO6VkoqG91L9w4Vnmdk5ruBQ3NLTCmmRzL0+9xh1pstSYnf7DHtH+QxQ
         CABgSQGhnyw2YBfTRDCU53glucloLqIOOj4U10B8gt3mG4Lbu4dxp24Cs7yEFg1Msvug
         KyVsHKbPBmQS7/pJ7WOZOYoHXEb76TdrCsOEv9Dea3BB7F7Jt3hZRlBKpDPWZ4oX0+Do
         jj0CxiD4V2QCZWhsbM2qmedQyGoRHj8KA24Am1uoEERo6cIgRpISvI4uG/yl6Gme7yBn
         CQnm9x9x/g8cAGz3PcSwfZZIWAAeJdFoMJW7BXNZNRZ9BmyuhqMBjkUerxaM/HnhWCso
         PIDw==
X-Gm-Message-State: AKS2vOznQhjI58m9ErwjAdExWA4n5ikwWKyViH/O9ILFuw/ZW1/OCC6k
        jCN+M2h7FEUOGxA0+qQ=
X-Received: by 10.80.182.71 with SMTP id c7mr3800369ede.55.1498565854816;
        Tue, 27 Jun 2017 05:17:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l17sm1510926edc.39.2017.06.27.05.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 05:17:33 -0700 (PDT)
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
Subject: [PATCH 3/3] sha1collisiondetection: automatically enable when submodule is populated
Date:   Tue, 27 Jun 2017 12:17:18 +0000
Message-Id: <20170627121718.12078-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
In-Reply-To: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
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

