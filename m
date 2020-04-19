Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46019C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 14:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0D6212CC
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 14:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKqISGrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDSOaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSOaL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 10:30:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C012C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 07:30:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r4so3729118pgg.4
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IoYd4PxYDxeAhChHKy76PoCH7KgReWu5xsY1QImjM1E=;
        b=oKqISGrTtPDhBOzHJ+KueOaLftmVAZNUXZGX+3osd0o8oOnTGL0RXgaj/qCcV1AKH2
         wZARrnB9cUOorVVPpzQlQ6VueEUwV3yg6MPodesLcxPp+v7WR4JuEe4t3OR09XNlFkHu
         SY3HqagL04Cp0r8w0QTtPOgEAe3MfBQ1pWawf2+anW4MY8FWF6RozVqypIkPm0d0K8c+
         73MUETid8HD1IPo8dyIGFJQSRMbSR0E8lxSVqXu8+WRleGariudsSdnjkO+t2hewcNt+
         oBmG6ZCZYtSagTkfpNo/MsohZXh4Eg1i+I1d0ZSjp+NbsS6VFGn6zyOP7p4R3D7i2MWz
         /4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IoYd4PxYDxeAhChHKy76PoCH7KgReWu5xsY1QImjM1E=;
        b=br9vrYDtyIj2ddspUUcG9WJaCAsbd7HQZDDfXPDw0FtsLZDM5cgGg857sNTUSZurx+
         bFwwdQMYbPE/eefhahey6BilLc/IwoD8WfNGWE2w84OkD0RtV+xQW5JaUWFNUKHc0Bcl
         ZJYukB+fBrwFsplBdWK1VsMXoAFYE4wdfFMQ3Z4UVx1fI3bwtmezfaVgmvRaN80EDle/
         1gEOho2xcOJwIK40XUrKD7j7avfXiNbScs3BkGoxt7H2KpZlQTc0EhFZmRb1xUZg85GI
         q3NkLIGrVuoXiZYq0bscjUA1XRTSaFhZ7k10Zc3Ytg68M205J2/gt1i1fKif7NRI7Ggf
         mZ5g==
X-Gm-Message-State: AGi0PuZJp+/ZCLNtaqDKroLZo4wCsRhIJwiFC9edCcavb/xTg/L5k1Lo
        V3rqZN2AJD9R6GoshM//c4/B+c8z
X-Google-Smtp-Source: APiQypLWO9IaHDEUoVOjTaN3UXK+IG8PJFOMn757gY2i8Ux0CJ4JXPyhEmwufgl5mOhvTEXFWpTprw==
X-Received: by 2002:a63:6c83:: with SMTP id h125mr12811426pgc.168.1587306610925;
        Sun, 19 Apr 2020 07:30:10 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id q200sm23621197pgq.68.2020.04.19.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 07:30:10 -0700 (PDT)
Date:   Sun, 19 Apr 2020 21:30:08 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Glax <glax@dragon.best>
Cc:     git@vger.kernel.org
Subject: Re: gitk crashes if the diff contains certain unicode characters
Message-ID: <20200419143008.GD28207@danh.dev>
References: <edace460-d252-2742-7576-e7601b6e959c@dragon.best>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edace460-d252-2742-7576-e7601b6e959c@dragon.best>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-19 14:15:06+0200, Glax <glax@dragon.best> wrote:
> Looks like certain characters cause gitk to crash when it tries to
> render a diff.
> 
> 
> How to repro:
> 
> 	git init
> 	echo foo >foo
> 	git add foo
> 	git commit -m foo
> 	# The following assumes bash builtin echo
> 	echo -e '\u2754' >foo
> 	gitk
> 
> Now `foo` should contain the character U+2754 encoded as utf-8.
> 
> If on gitk you click on "Local uncommitted changes", it'll crash with
> the following message:
> 
> 	X Error of failed request:  BadLength (poly request too large or
> internal Xlib length error)
> 	  Major opcode of failed request:  139 (RENDER)
> 	  Minor opcode of failed request:  20 (RenderAddGlyphs)
> 	  Serial number of failed request:  4220
> 	  Current serial number in output stream:  4247

U+2754 is *WHITE* QUESTION MARK ORNAMENT
The error message is very familiar to me.

I /think/ it's a bug in libXft, it can't handle colored emoji, yet.

There're similar issue reported to Google Noto Emoji font:
https://github.com/googlefonts/noto-emoji/issues/183


-- 
Danh
