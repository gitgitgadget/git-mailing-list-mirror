Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E315C61DA4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 00:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBJAMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 19:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBJAMU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 19:12:20 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6FE23641
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 16:12:19 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id n132so3146811oih.7
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 16:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7kLIyvMIjUbka5ugUp2xj6BXENnIdbAuNuOGVYpwKDw=;
        b=kjvrLeadKDWpakHgeO5APSTISMxuY+HoIPH7QITBcNtlw/fsRro1Y8VeMZdgXDPpVO
         1jEelvFKbNWTnfhR84O3O8PaYwJTZWEoiuA0wC2qIXInCiltjEuJ+2ZTzKuxufW2FxD4
         3Snd69MWyAMsw+1WZSKjPfITvKysOQmLdi6Q+a9yvGLccwJxQKDi2OdeBb3qFv19Qrsa
         HGwExr1qnysN07aWLHtvnOYis2ejREeNFyTsWk5zaLzkV+mcVrzfnHj22cJ/eyLRNtmh
         QmiqC9Bx6AN7IuY+psdf7TMVAu3imfuMQ2k6TkF4YGH+UgIzGsUmqMMaUGPp3vELagsZ
         Wxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kLIyvMIjUbka5ugUp2xj6BXENnIdbAuNuOGVYpwKDw=;
        b=Isb6sr94GTOt1MbXzupunX5QTWXF97O+uRBymvTcusryQi1OxAMOZKDEFlC8mO1cDU
         zehumiAvmeys7OaX0DtlbH1+lw7C86YSnHHZ1z+fwjqfo7yv+DA7XR/JkCcbEKQy/D9L
         UsVPNINVMOgZMOMjIpg8fFvREXcXrGhQVsE8dzrZt9btVZnaiglQRBSAzFKXYiHBLmXG
         YdZmfQggPZk971ipqF41rPqMcvuVRWq2UQTJs2wH9uMk4/ECdx9Yak7NqgLTuIboorPC
         GyflbsnZxOQEnUdnsiaoSzYjlDTEv2wBRNXz36TX0ptMnjbpffitxfHDLEYiDA/X4dnN
         yU0Q==
X-Gm-Message-State: AO0yUKWikl9C654X/e+iqMla7DYrw4Rq2Xywjy5wo8Oz9tQPq7tK2aTN
        d8/Cqr8JunI/M5LUWocnGOR3RTcu58oQYYnNoC81IILr
X-Google-Smtp-Source: AK7set9ZC7RbNvU+qGma6c2oyYVVNZG6oYhSQhaXpJBonKjThaKAcDZ3UpM6f6Q7NQcwy0hUh+iUK2SS3NKc3uUXqeM=
X-Received: by 2002:a05:6808:191f:b0:35c:4435:fc2e with SMTP id
 bf31-20020a056808191f00b0035c4435fc2emr985605oib.244.1675987938611; Thu, 09
 Feb 2023 16:12:18 -0800 (PST)
MIME-Version: 1.0
References: <CABBAUF+acoMScQfHFQGooPx9eng2FBeb-Z2619DsnCt5QmhQPQ@mail.gmail.com>
 <Y+V0Mu/v/FO5318/@tapette.crustytoothpaste.net> <CABBAUFKv64xhJtwRk9kMWBov=nV_QzvR-jJqhJxKQyej3pcYCQ@mail.gmail.com>
In-Reply-To: <CABBAUFKv64xhJtwRk9kMWBov=nV_QzvR-jJqhJxKQyej3pcYCQ@mail.gmail.com>
From:   Michael Rienstra <mrienstra@gmail.com>
Date:   Thu, 9 Feb 2023 16:12:02 -0800
Message-ID: <CABBAUFKAQNpNQ4mu2uDUuPod5WhQLx6pN5YyzX+TOGfFSOn1Ew@mail.gmail.com>
Subject: Re: Markdown release notes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops, didn't mean to include a full quote at the bottom, sorry, my
plain text email skills are a smidge rusty.
