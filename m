Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26800208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 07:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbeHGJix (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 05:38:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36080 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbeHGJiw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 05:38:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so14711341wro.3
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 00:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hPunYmC92IsEwMHeoHDUH64TcFIXPZt320IhCStJTKs=;
        b=ciFXdUlpvXl2b/0Hdu+n7DhOn1RqWdL3UvlgKv9d2wh++soRpJd7coQrrlga7WSfID
         dz1l7hBOZ9ZFwjaqRkIEISklyNpON0fkqC3snhZr0qU5VRoZFS4PPXgJ6usgCpRkdquD
         JLVnsc/iVQr79Uo+zgNCIdFlmArUq4JyL2Vu960Wp7++ICNTgBcE36ro6k9kG1Y3OVfK
         H4XcyMCkYhg2d+TTCF/ecaA22LnTF5qYXbpyOX3ORCRav1KgFLd4mcHNlMjvlgzuUBCW
         o/TwotISBWWfK8JJkhvimS3HeL7Gn71LfdPSamSAhPz2F2htzeF5NM2ZxB2wLG82myWz
         fb7A==
X-Gm-Message-State: AOUpUlFXX2e2O9xC5wHC/dw1tYBYe96sYvPYRjbm90jHe9ViIzq8pjlR
        9Oj5+XAT3WQqsz5so01NKocYShMi20ivZQ==
X-Google-Smtp-Source: AAOMgpff4d6Ngu5ksTnaEQp9UF/NZhCKGEbDfTlwx3V9no/4fiTePi4Rfy4lWYZmt7clbTH59lUDFw==
X-Received: by 2002:a5d:4acc:: with SMTP id y12-v6mr10988622wrs.132.1533626750862;
        Tue, 07 Aug 2018 00:25:50 -0700 (PDT)
Received: from skisela-redhat.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q70-v6sm1055255wmd.39.2018.08.07.00.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 00:25:49 -0700 (PDT)
From:   Sebastian Kisela <skisela@redhat.com>
To:     git@vger.kernel.org
Cc:     skisela@redhat.com
Subject: [PATCH 1/2] git-instaweb: support Fedora/Red Hat apache module path
Date:   Tue,  7 Aug 2018 09:25:47 +0200
Message-Id: <20180807072548.12764-1-skisela@redhat.com>
X-Mailer: git-send-email 2.14.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fedora-derived systems, the apache httpd package installs modules
under /usr/lib{,64}/httpd/modules, depending on whether the system is
32- or 64-bit.  A symlink from /etc/httpd/modules is created which
points to the proper module path.  Use it to support apache on Fedora,
CentOS, and Red Hat systems.

Written with assistance of Todd Zullinger <tmz@pobox.com>

Signed-off-by: Sebastian Kisela <skisela@redhat.com>
---
 git-instaweb.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 47e38f34c..e42e58528 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -332,6 +332,8 @@ apache2_conf () {
 			module_path="/usr/lib/httpd/modules"
 		test -d "/usr/lib/apache2/modules" &&
 			module_path="/usr/lib/apache2/modules"
+		test -d "/etc/httpd/modules" &&
+			module_path="/etc/httpd/modules"
 	fi
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
-- 
2.18.0.99.gd2ee41e0e

