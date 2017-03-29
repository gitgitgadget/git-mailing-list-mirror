Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43EC320958
	for <e@80x24.org>; Wed, 29 Mar 2017 13:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756139AbdC2N5Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 09:57:16 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34004 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755195AbdC2N5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 09:57:15 -0400
Received: by mail-lf0-f53.google.com with SMTP id z15so9054392lfd.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Zccrhkw/Y5fEl+LgGfsWbxNzHlj+/xbpL+VSRYSuS4=;
        b=rQOqrS2Ha/78QTM6tifKNNw4pGNm4bPiWftVTlsaKQmajZryi7DH37oEVvtlWp+eQs
         w9th15w9HMXHKRSBfgAtb8bpZQacR8BuWURFAuT3V7xRg48OQFTfFhN6228SR81ruJm7
         xjqBItC0dUMcWwBvl7YA0mW7WfA6UdgwfVROSnR1sYc9de24t3ShziCki2CbDQ5UoJq7
         uyPnHe1btdjbM2pgukQAlGdIxZnvnd/YbC7zZ+PyZm5CPFgAxUe6J4avJ6ILMMPP3Sha
         2k2611JFasC8kV6jlEb4ESsWQC7tENJMOaBS6WAEVB+bGXLFyF96HBW5Ns0E4yefWs9u
         rf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Zccrhkw/Y5fEl+LgGfsWbxNzHlj+/xbpL+VSRYSuS4=;
        b=rPrx1Ml3rntJ6nh1fmGfA4ATORxgwjjaQKESCpJ9DKmBPgEsMHI+s1HSvGzoM1aQnI
         L110rhprAg3GiOotAp03acN6GxpGqZat+TCOX6JFOhX3qdwtGCIbGITSrGtG9ImFDrU2
         +D30fm3u9D17W78nAmHUbrNoU1f0MTFz8dzQ6yzS2niiIfEUYwlLjeGTCvGE0+hamjeF
         b2Kh0NanQwCS05KBapgUK+xM9H6qZmjtLQY3xVbt2ymLqT25Ttd17F/CDWjgLO7OqKL9
         FV/Hl8J+nZFbzcEyPaudAhHZjHKYfrpMPN4plJeSue8zjisQRPEG8biC2+iUANhbfrBc
         94GQ==
X-Gm-Message-State: AFeK/H3Y3B9SUodJSjrQMjGdxUghgoC5mJB2gZ9nv2HhtwdefhF4kHh3r9ysB7/2XZvaag==
X-Received: by 10.28.194.7 with SMTP id s7mr940133wmf.34.1490795833451;
        Wed, 29 Mar 2017 06:57:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m186sm8247843wmd.21.2017.03.29.06.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Mar 2017 06:57:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        stefan.naewe@atlas-elektronik.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] perl: regenerate perl.mak if perl -V changes
Date:   Wed, 29 Mar 2017 13:57:03 +0000
Message-Id: <20170329135703.18860-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <39b203e9-c3a9-80c3-ec24-649e04ef5620@atlas-elektronik.com>
References: <39b203e9-c3a9-80c3-ec24-649e04ef5620@atlas-elektronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the perl/perl.mak build process so that the file is regenerated
if the output of "perl -V" changes.

Before this change updating e.g. /usr/bin/perl to a new major version
would cause the next "make" command to fail, since perl.mak has
hardcoded paths to perl library paths retrieved from its first run.

Now the logic added in commit ee9be06770 ("perl: detect new files in
MakeMaker builds", 2012-07-27) is extended to regenerate
perl/perl.mak if there's any change to "perl -V".

This will in some cases redundantly trigger perl/perl.mak to be
re-made, e.g. if @INC is modified in ways the build process doesn't
care about through sitecustomize.pl, but the common case is that we
just do the right thing and re-generate perl/perl.mak when needed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Mar 29, 2017 at 3:36 PM,  <stefan.naewe@atlas-elektronik.com> wrote:
> Am 29.03.2017 um 15:33 schrieb Ævar Arnfjörð Bjarmason:
> [...]
>> Now the logic added in commit ee9be06770 ("perl: detect new files in
>> MakeMaker builds", 2012-07-27) is extended to regeneratio
>
> s/regeneratio/regenerate/
>
>> [...]
>
>
> /S

Thanks!


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

