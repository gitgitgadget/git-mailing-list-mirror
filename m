Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F5C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 00:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E80A61606
	for <git@archiver.kernel.org>; Tue, 11 May 2021 00:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhEKArs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 20:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKArs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 20:47:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8748C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 17:46:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i128so10117360wma.5
        for <git@vger.kernel.org>; Mon, 10 May 2021 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KeZI9eWfAZBOvrwEB3TRM6oYnfrJD7+JYKcnciiWjF8=;
        b=uDAdo+molSjje10py74YnmAd/guXCsYZckx1OJrj54pFqtZQT+xM8nqSHU8VMQMbPD
         wwuhpdP5qowE5bPcBVHwmsdnnz5cbpu/1vCcXmDhGWiF4+5V939hkA7gmSel7KPlW3E7
         ZmU1my1wKqCBSeJF7yY5O690Voz3Z7LG+EGG6CiFyNt6uGVDAo4QO/X7ITa0deyiI0Sp
         aFFdi8oYcrE6L99HKO18fdFgikrhzfk3lxSV5rn8HwOuwlRb6IWEdn5OAsM0fK0Qtzc7
         IgxxmUQ3eQ1sP2HU2kH+Ocs0OJGzND8SBZYFMSjHKxjl0IdXirRdB+f+rL1OJpuuM92U
         R+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KeZI9eWfAZBOvrwEB3TRM6oYnfrJD7+JYKcnciiWjF8=;
        b=FfNaSE0/I9y0Mba3gd73paYmVeZwsiD3vWn2TkAkCEWhMnQ0AnfuFAmZ1Qvql89U5S
         V14PwmNeBEIV0b5a5uqjEgJVqH2Y5+orPgz5yEbH5VtefGRuJDqtcwZyzGRbHyoBOeQa
         nqSU2zXYdKBfc6lrf7QSzsQuOG9zv6GrFCE/BAodsXiOXJ1nWv0kgCArBi65SJBKiN/+
         G9DIpK8pFFf/XICvgu9Z6T1vtEw7uzHAkmdjJdIWBQ9UMfpe4xzTZ4KzQbInkkswSQhz
         IaX5LOVHcdD1jmlt0Wz5edNO2ESVYUqgzWze5kbCY3O4Itut28wr+Sk24qOYo91dMFrE
         2H5g==
X-Gm-Message-State: AOAM531PgSp47JEcOsmtI62FaOzDmzOfq4Qpi8+g7H6rXb48hPRE73LY
        51ANwCzT0MpavfViblWhym8=
X-Google-Smtp-Source: ABdhPJxE/6OJCXd8u2w5+u10f2WZu19z4C9MDr+ft47UUkOEYdF3vahyIlO4CqVhgu68Rl1UfbFZGA==
X-Received: by 2002:a05:600c:4b88:: with SMTP id e8mr29038597wmp.74.1620694001606;
        Mon, 10 May 2021 17:46:41 -0700 (PDT)
Received: from Inspiron (2a01cb04010c4200a87bd4460637fee8.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:a87b:d446:637:fee8])
        by smtp.gmail.com with ESMTPSA id r2sm26348677wrv.39.2021.05.10.17.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:46:41 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: RE: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
In-Reply-To: <60949be8613c1_8c2220882@natae.notmuch>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <60949be8613c1_8c2220882@natae.notmuch>
Date:   Tue, 11 May 2021 02:46:40 +0200
Message-ID: <87wns6f66n.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Firmin Martin wrote:
>> Currently, git-format-patch, along with the option --cover-letter,
>> unconditionally overwrites a cover letter with the same name (if
>> present). Although this is a desired behaviour for patches which are
>> auto-generated from Git commits log, it might not be the case for a
>> cover letter whose the content is meticulously written manually.
>
> This is one of the reasons I never use git format-patch directly, but I
> use a tool on top: git send-series[1].

This is good to know. As a newcomer to email-based workflow, I ignored
how people use git format-patch/send-mail efficiently.

> It would be nice if git format-patch grabbed the text of the body from
> somewhere,
In v2, I planned to grab the letter body from the cover letter subject
to being overwritten. Maybe if such a letter doesn't exist, we can instead
inherit the content of the cover letter from prior series.

> and even better if git branch learned --edit-cover-letter.
> None of this invalidates the usefulness of your patches, of course.

>
> Cheers.
>
> [1] https://github.com/felipec/git-send-series
>
> -- 
> Felipe Contreras

Thanks for your comment,

Firmin
