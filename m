Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0996C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AC8611EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhIKDtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 23:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhIKDtH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:07 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF79C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:47:55 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t190so4346822qke.7
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XFW+Hp5T4rDP0STKOPB7qXpPspB//EDmAoSFQqQcBjg=;
        b=oyorJa5qq52JOzxfvhkY1qr/a/SCVKYQPoUpIHfwT5JDdpgqGHac12ZMVcH1+6+nyj
         jMGOmyIB467RxQRtaYho3PSnf4SIPBlgO2DAUkvjIbEgoYsNiIStHBMSOOglhdlEU8c8
         DOLdw69NibyurY413q4wcxaO3fZQRqal8AivRykaE8GiVt4WNingrOsLxfnMCYOhSze3
         yiXqt3DsSG4gf333P71p49RvoCl5iQt2rbgY+poZhnakviQvuG2pnQGi/TXVPLSaxYK3
         Wh9rgA7F8DcXqVn5slyjrv4UBKG26ouTV5ZsSnCna0AHfEG3Y1ZS8oWGeHQ0pMbbVI5+
         HfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XFW+Hp5T4rDP0STKOPB7qXpPspB//EDmAoSFQqQcBjg=;
        b=YiE+v2KSByGoIlCR3SIZhR8h5wLm2Fvl+rkxtTorNAwtF3gzzXQGtL2H/LFJmci0u3
         kmZ6UumYWOrXAyk5mZBKpZHrfS6WeyQvi+Z1QW/316sNuXwSeIHBIt16PHC7PsSIpsrZ
         PpzXzlpecPmclogmHEd+L5idVaDeYVARlgUp+1FGm5TLhJrKPMKxfk2H8Q34QlmR6rI8
         IL+wwe6q2+8mfqnrYU0DMjZQOwAYs4A7wHEf3L7TQcRL6FDyMxAcRDUUIQq6FaMXuKkN
         Pj1ar+oYUMiuSOD9cz5Nc86IW+L8OtXolFSt0yTlGZuKLhUauLvZrv2g8FpA5+Lf0zcI
         /5/A==
X-Gm-Message-State: AOAM530HJE4ed75jg4opbwyxsxcko62smivoXkopyWsL6JkG4lB11t2O
        NFJgczcVGXtB8wslW/trwyc=
X-Google-Smtp-Source: ABdhPJwyOMRPiScyx2nJ0kXsKf9hRQuC+TBOZVaGkWMjgV9K1KJXyTnyo7uUahbpHbkBpgqI5zpOnA==
X-Received: by 2002:a05:620a:448e:: with SMTP id x14mr594094qkp.526.1631332074464;
        Fri, 10 Sep 2021 20:47:54 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a22sm405617qtd.56.2021.09.10.20.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:47:53 -0700 (PDT)
Date:   Fri, 10 Sep 2021 20:47:51 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/6] git.c: add a NEED_UNIX_SOCKETS option for
 built-ins
Message-ID: <YTwm57pp/cvfR5rg@carlos-mbp.lan>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
 <patch-v2-2.6-d6c44402715-20210910T153147Z-avarab@gmail.com>
 <xmqqr1dwotmn.fsf@gitster.g>
 <87mtojaklj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtojaklj.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, if this is silly, but why is this not better (at least as a starting
point, since it obviously will need more work?

Undefined symbols for architecture x86_64:
  "_cmd_credential_cache", referenced from:
      _commands in git.o
  "_cmd_credential_cache_daemon", referenced from:
      _commands in git.o

Carlo
---- >8 ----
diff --git a/Makefile b/Makefile
index 44734f916a..2a60685c37 100644
--- a/Makefile
+++ b/Makefile
@@ -1098,8 +1098,10 @@ BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
+ifndef NO_UNIX_SOCKETS
 BUILTIN_OBJS += builtin/credential-cache--daemon.o
 BUILTIN_OBJS += builtin/credential-cache.o
+endif
 BUILTIN_OBJS += builtin/credential-store.o
 BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
