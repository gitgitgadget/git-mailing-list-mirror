Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EB0C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2573820842
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp9AQy+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHDVVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgHDVVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:21:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56CC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 14:21:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so32612713ljn.11
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CMKlFmbQpQrYyIJGgUhcwVYSBwYFi6/W/z5HZSJctqI=;
        b=Kp9AQy+xk34vEUtloFI4iAQ2SgAQCluPEUuWjiR1kuWesMaKj6cBQn9kyK3VfGOJxe
         qScgapOyt65Bhxo/hIKGdiJAFMgcBzViuOcbqsfKjTYNExcaAU1aq7NwR4BcFyd0FHVE
         XI9ALH01LjqoXarUWTDup/+iI53TQZAyHIAreg7x5+uTxxIzutY0lEPNAi2/bnd6uR9B
         iVrtS5GdxrEGtd2ri5ncG73M1E4ybDffMdrUSdPYaFjEsszDScGJbs/bnE9VMo/TbhYF
         YDO4lTWwr3vYvYBkRT9grHwpqRvi+OndPqf8ClFI16oNvxq6jChESJeKuf40MJJmQKGE
         eG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=CMKlFmbQpQrYyIJGgUhcwVYSBwYFi6/W/z5HZSJctqI=;
        b=MT2YJmTkwXTNbalLPtGPwYwgYM6SYu7Vw4HkGmPvy5+0vTzH0jYznsH3XkHzRKrVtZ
         MYEsas8Mt99TytHm2iRd5vdXDwuztr8w/KK4kJQqIhdz7u5wKt6S92/5igzJeMuFUS0I
         aR+jqEBrZwH948amgC+jp36t3nOYIfluOwFqQl/l7yC+lmqgU0AWkG7ki87y1pSHAm8F
         9ZE5Dst/5RSNc/1e2EMdKPW3NT/BcZrkE2GLCGs6yI7G0YtNvJ8FsT8FZmMAFUoBjrLY
         t3wzsEZ1gkZW7nRglQLj4GrFnlPFe3YJ4UeSIqO14Hgd1O63hfqHn5newLt2JC2ukYdL
         Ei7w==
X-Gm-Message-State: AOAM530UIru4Nc4Lu86XN1eWA9JMAUUEZR2XvRTEvu7TKoeYlcuXMbyb
        HxY0JTX3yJll613dUILOGvA=
X-Google-Smtp-Source: ABdhPJyUL8GVepiBFE2icNAtjkVw/sFrWUMoc9hhBRpAUqhnYhQvNAN//FF95gVg0FfetgxACeyhIQ==
X-Received: by 2002:a2e:b00f:: with SMTP id y15mr5806977ljk.223.1596576067714;
        Tue, 04 Aug 2020 14:21:07 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i7sm5992384lja.130.2020.08.04.14.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:21:04 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 00:21:03 +0300
In-Reply-To: <20200804200018.GB2014743@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 16:00:18 -0400")
Message-ID: <87wo2eyuo0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2020 at 12:42:45PM -0700, Junio C Hamano wrote:
>
>> As a minimum patch, I think it is OK to have just 'all' and 'none'
>> (not even c or cc, let alone the one with ultra-long name whose
>> effect is mystery) before we let the result graduate to 'master'.
>> Others can be added on top, as the primary focus of Peff's series is
>> to make sure "-m" can be countermanded, for which being able to say
>> "no" is sufficient, and the primary reason why we are further
>> futzing with the series with this addition is to leave the door open
>> for later additions of different "modes" in which how
>> "--diff-merges" option can operate (iow, Peff's was merely on/off,
>> but you are making sure others such as <num> can be added over
>> time).
>
> I like that suggestion very much. It solves the "optional arguments are
> evil" problem without having to worry about the other bits.

Here is the patch reduced to absolute minimum, both functionally and
textually. I removed even 'all', as it has its own subtleties that need
further discussion, so the patch only introduces --diff-merges=off.

If it looks OK, I'll do documentation and tests parts.

Thanks,
-- Sergey


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-revision-change-diff-merges-option-to-require-parame.patch

From 34cba8c49e2c40fbc228b9904491633939792b6d Mon Sep 17 00:00:00 2001
From: Sergey Organov <sorganov@gmail.com>
Date: Tue, 4 Aug 2020 16:48:27 +0300
Subject: [PATCH  RFC v2] revision: change "--diff-merges" option to require
 parameter

--diff-merges=off is the only accepted form for now, a synonym for
--no-diff-merges.

This patch is a preparation for adding more values, as well as supporting
--diff-merges=<parent>, where <parent> is single parent number to output diff
against.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 669bc856694f..88a0bfdb4a4c 100644
--- a/revision.c
+++ b/revision.c
@@ -2323,8 +2323,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
-	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
+	} else if (!strcmp(arg, "-m")) {
 		revs->ignore_merges = 0;
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
+		if (!strcmp(optarg, "off")) {
+			revs->ignore_merges = 1;
+		} else {
+			die("--diff-merges: unknown value '%s'.", optarg);
+		}
+		return argcount;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		revs->ignore_merges = 1;
 	} else if (!strcmp(arg, "-c")) {
-- 
2.20.1


--=-=-=--
