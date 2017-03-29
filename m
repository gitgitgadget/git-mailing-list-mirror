Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E90120958
	for <e@80x24.org>; Wed, 29 Mar 2017 13:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbdC2NeZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 09:34:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33611 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbdC2NeY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 09:34:24 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so3073409wrc.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cs01Zehhh9oBuBKosKiBNSI1inAZQS8D9cSroL9aV3A=;
        b=AMsI734qzU4uMSOn9DEzoS6MJKlhb6Q6KPIbhF1acXQ+g10OfFMnOcl5ORdKVHQDiV
         nPBrEYvPuAzuXn4akwI/CJTMdUnT6PUCtX94QP4VLi88m5yZI+CvHNOf67GMGlkfNUZ6
         5whkndDIbORjcFMVRLVSpzR9l4ja7NCqVBeR76RfaBLHqrgJ/5kWbLAKRn5eY9N5L4qp
         7pr+EF3LQnquvYhdrveu2Hnib27KAMypahP1ftHXOT35V02OmBxmU+iUFTfCFYi1aDUt
         36N6NbcPJPCVOHePqrE1TLxfjKeeBUqt4xbOPyDxTp5zdByhT+dFK5JXL2YHrtyGWgsc
         nk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cs01Zehhh9oBuBKosKiBNSI1inAZQS8D9cSroL9aV3A=;
        b=ZmV0haiN9tscL3/QtdtxzlqMOKFsR5Ipy5nb4++osGbzWP349Fd4iXR9X0lDZHF71u
         c2z8kG6JEu4QASAHsz9gzw7GilsRCSiOt6ye/dm0bwSH1P9H2HacnGxbuw4eQTsA+ijA
         ZkUH5qo5BsjzYvSAjHIbd0lnrzfHbIZXaZaBBDRWiix72TMtoGKtYisJ2194pH02Sm3W
         6K+QXitR7toIGHYWN8uUBto2Wu2ZKa7LnUrKSMpiY5lMHaLL/HhtMxFqaWDvoXMIfTGc
         CP8Q6VleOg0Rfcalw1aOse+THoemz9BKffqHmbsP5bbvZxBS3SqcS6DAV0usCKkhIamR
         7F8Q==
X-Gm-Message-State: AFeK/H35APZOfZz6ubjHkyz7W2EoVAs2mdp7RuXyCwHLSke0cGOwUUTtr5PAcyWtHFKV9g==
X-Received: by 10.28.73.197 with SMTP id w188mr1465396wma.46.1490794447594;
        Wed, 29 Mar 2017 06:34:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k43sm9456329wrk.42.2017.03.29.06.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Mar 2017 06:34:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] perl: regenerate perl.mak if perl -V changes
Date:   Wed, 29 Mar 2017 13:33:59 +0000
Message-Id: <20170329133359.5992-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170329132924.31321-1-avarab@gmail.com>
References: <20170329132924.31321-1-avarab@gmail.com>
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

Maybe this'll set some sort of record for a v2 submission, but anyway,
this should clearly be >> not >, we don't want to overwrite the list
of *.pm files we just added.

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9f8b35ad41..485c453ca2 100644
--- a/Makefile
+++ b/Makefile
@@ -1851,6 +1851,7 @@ perl/perl.mak: perl/PM.stamp
 
 perl/PM.stamp: FORCE
 	@$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
+	$(PERL_PATH) -V >>$@+ && \
 	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
 	$(RM) $@+
 
-- 
2.11.0

