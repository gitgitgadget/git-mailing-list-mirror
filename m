Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75363C00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 20:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiLLUiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 15:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiLLUiS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 15:38:18 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3713CEA
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:38:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mg21-20020a17090b371500b00219767e0175so563758pjb.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DHRtscmSJqfY98YJUXSyQ4kPnt98oyziNAqJYLGFHrI=;
        b=BqLg9bsmgARbg4ha9MircZcu4cv82ou7dbFF4DnyUWjA83KWHLBE1sYRa6L3TFwATx
         yt6klcNbxPlxMTFC/LxAxTjMpcfu2pqq9w1BeT483x+TbClzBddmr1aywrMbrTn1OBRZ
         BV09hjWYHmMUNXSxVdeIlWEsQXcglBtDf80OLNFY4oJbv12Zu7O2xmlHSBCijWNJmlO2
         EYrU/gwvFHdRK0t0WDg0jzstWeF+HObeK3Tzm9vv/JawI+9LBiPa3BiAsuF4Ao+gap8E
         bbqzphzuvEauf/L7uaZ4Acl8812V33bue8Y/bZnr+hBZOdlLgJsTCEWosRNSnq+ZmzBS
         02aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHRtscmSJqfY98YJUXSyQ4kPnt98oyziNAqJYLGFHrI=;
        b=K/askbS221kc28p8Pp1RaYulcsypxwqmBZs9v+S+I2YxyloCpHJ1B4Emspm6u6Ppg7
         5qK+C0e+oWTY4PtNV1dyfn781cL7ohox7RGR92FarTy/l6v7PxnJEuS9BC0bn+jUVm/7
         tj7E/tqo9Rl5C0rR56Q2qlvFBeo5dMy7q2D8pu/rSH08J6gudSwZv4JLa1IxV43My2L/
         84RGWuFg/5G8pCCXtzAO51nZScdUjgdDdB61I2TczrBpp+9txA/a5sP7/QMp0lgP7k6O
         4+rxwi1bV1OsDOX/Fsix12/wCobSAoDGbff6WPwnJWQpLi5dIBU9RzuZ9IhGKh7v/0oV
         jE9w==
X-Gm-Message-State: ANoB5pnrOpo1sAsl8MaOhU+IKJf4jVtXdIAj8lsXXGLj96mv2jo/KXBL
        /v4+Hoc6RnUIlasrBLuqK23ng7OpeDdGrejkwG49
X-Google-Smtp-Source: AA0mqf7UmHX7TtMShkOO333JVr4YmWabhSMGAPwooekExakVdURnuXNUVghgh1TWcjxTJHKnuz22k4C5UviL8EApzkln
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:dac6:b0:189:7105:59e8 with
 SMTP id q6-20020a170902dac600b00189710559e8mr59287272plx.50.1670877496850;
 Mon, 12 Dec 2022 12:38:16 -0800 (PST)
Date:   Mon, 12 Dec 2022 12:38:11 -0800
In-Reply-To: <xmqqv8mkxgd1.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212203811.77228-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +	fd = open_loose_object(r, oid, &path);
> > +	if (fd < 0) {
> > +		if (errno != ENOENT)
> > +			error_errno(_("unable to open loose object %s"), path);
> > +		return -1;
> > +	}
> 
> I know there was a discussion in the previous round, but is this use
> of path truly safe?  Currently it may happen to be as long as there
> is at least one element on the odb list, but when thinking things
> through with future-proofing point of view, I do not think assuming
> that path is always computable is a healthy thing to do in the
> longer term.
> 
> Our "struct object_id" may be extended in the future and allow us to
> express "invalid" object name, in which case the error return we get
> may not even be about "loose object file not openable" but "there
> will never be a loose object file for such an invalid object name",
> in which case there won't be any path returned from the function.

Ah, good point. I think what I can do is to document the function to
only return a path if a path was involved in the error somehow, and make
anything that uses "path" in the caller check for NULL.
 
> Other than that, the series looks quite clearly written.  Nicely
> done.
> 
> Thanks.

Thanks for taking a look.
