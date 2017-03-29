Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7CB20958
	for <e@80x24.org>; Wed, 29 Mar 2017 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbdC2N3i (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 09:29:38 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33782 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932098AbdC2N3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 09:29:36 -0400
Received: by mail-wr0-f174.google.com with SMTP id w43so15589982wrb.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldtLfP3BsyTIr7z2MDdWAN+yvbmPvnZCjutWHmkkAs8=;
        b=gIT7UFplTLUpdRjcSo93rhpKiQlLuF1F1nkobK/vWVi0becctXO0SZ6puDAKoP1eOK
         AaPGgFEJ36l/T8Mba6kSjOfSpMlxNuAkXL0wb4zg6wzk1+1TEy83elXTVHFnvCHXyhOK
         nqPoqBZkdbhymTLW3IfZ/QyS6+MKJfQieuUbAzoZ2Gv1KJdFc06bKOefqIxiTyu9Qbsa
         AWxakBpJbptaadKYu5GPq2PxlhII6wR/wmeiC9IL7d5y6lazA0JFwLdfxVPFQC7vtwar
         gmRgyqFXxtdBT2hGqnD0R68SfKhOCJvRZM4sNFjmij+w1ru9/hoSk4nDtrQoFYDY3hOv
         islw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldtLfP3BsyTIr7z2MDdWAN+yvbmPvnZCjutWHmkkAs8=;
        b=ty9HDmUC6d7Mklqdrd6YwCyqW57pSk6+/Sj9IxcMOytJYOW0gyWhDejyEg6peXTbfe
         PG2C5+ltNJlxjARKZfTlZWL5Aqi89DGhOcTWbqr75OYgZ9glz+w2rNMXdnivzcbxsDe8
         BSXDbLk7kVAtPGoxbWQSlfPmvaQXtvZC1c47LW9zTTfciO3WD9pT/bsT4ryA2HizbqWD
         GozW0yCyuzosDGsJn8GOyhIaivsqVmRphPKSeNoJtwjRy5ttxoi5nPMEm4/a+m2V8KLs
         q4m5vveFtJ2ag29mILk58WNPRNu7txWwCIZ80ZIlr+H+YTdEDnY8zMWHZm+Byw1fFNi5
         yv6w==
X-Gm-Message-State: AFeK/H1a4ASCMFIvLUmqqJoSeMiC28hKaX6CPU/n3+YUB3poeJZ+gKI+YgsPL7gDqGjKNw==
X-Received: by 10.223.148.230 with SMTP id 93mr506248wrr.111.1490794174466;
        Wed, 29 Mar 2017 06:29:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c76sm8208222wme.23.2017.03.29.06.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Mar 2017 06:29:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] perl: regenerate perl.mak if perl -V changes
Date:   Wed, 29 Mar 2017 13:29:24 +0000
Message-Id: <20170329132924.31321-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170329021807.voys2r65knn6tdwg@sigill.intra.peff.net>
References: <20170329021807.voys2r65knn6tdwg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the perl/perl.mak build process so that the file is re-made if
the output of "perl -V" changes.

Before this change updating e.g. /usr/bin/perl to a new major version
would cause the next "make" command to fail, since perl.mak has
hardcoded paths to perl library paths retrieved from its first run.

Now the logic added in commit ee9be06770 ("perl: detect new files in
MakeMaker builds", 2012-07-27) is extended to regeneratio
perl/perl.mak if there's any change to "perl -V".

This will in some cases redundantly trigger perl/perl.mak to be
re-made, e.g. if @INC is modified in ways the build process doesn't
care about through sitecustomize.pl, but the common case is that we
just do the right thing and re-generate perl/perl.mak when needed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Mar 29, 2017 at 4:18 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 28, 2017 at 09:03:43PM -0400, Jeffrey Walton wrote:
>[...]

At first I thought Jeffrey was running into this longstanding issue
with the perl Makefile. Looks like not, and he just wasn't passing
PERL_PATH correctly, but fix this related issue while it's fresh in my
mind.

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index c80fec2920..c0c5510238 100644
--- a/Makefile
+++ b/Makefile
@@ -1850,6 +1850,7 @@ perl/perl.mak: perl/PM.stamp
 
 perl/PM.stamp: FORCE
 	@$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
+	$(PERL_PATH) -V >$@+ && \
 	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
 	$(RM) $@+
 
-- 
2.11.0

