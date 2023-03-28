Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC10C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 23:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC1X2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 19:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC1X2l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 19:28:41 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6383269D
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 16:28:40 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-177ca271cb8so14510325fac.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 16:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680046117;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a0LxwS94UruetpZExluWmLpJBlih1Ff/fUN4xCyfHfw=;
        b=ElhD8C2YbXzXZLtvNnhzX0qMJuDsoYEv6YUYegdOt3lZBR791vRqtZxKUoeyCaZh9h
         AxwXCxkWOs4StlyQjDxa+2LtpZ8bq2hwHKFDzC+PFWZeqDw5JBsoFZD7vIgf3uxS7e89
         KG15pBvIiDE4dDZTgd6gVlU4T7tQTr6FxTEwBD/reXgLkzrNU1zBeALmL78kH+Y/wAEP
         U5MOKtrp8kZFU20Ephm/AiEyMu6obSq4XLETIxHlr1Q0tXWjbwO6eW8HodTUsxodbWTX
         5CiGGmBZ+/nR0o2dTYXFBGSWpwbXT2c6hqMPBO3vbela6nKowJR6Jn/Wm5FEhM2XKsxO
         rP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680046117;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0LxwS94UruetpZExluWmLpJBlih1Ff/fUN4xCyfHfw=;
        b=Yd2vjQcz7eI8+7wQkCme2z1/BjS6XHgFOs+NpBogSrIoMzAxAbViMCz3w21/ouKgF2
         /LnTlLJJSfGKob/m8tMN5vdrRIsNxehXJyK5jhcIxgCzzFRjZ6BYJDw341dH+5g9QN5L
         tH6+gwPNEVcTXKYty9ZG2wYGEl+xfMPyX9uiTVnSFUK0VTc3OMaMkUczGlKef33y5zt8
         qfB/XdK2AuAyzpJVLUO8NG17BWR3BM9Vh7AWZLdVAy4UMeArEzsM4m8LMjb7GItjK9LY
         xiQ5uhsRrP1fczXQXvcq8ibq6mBOry5ItL4CyFInThIp/HUzWTAoQcPk3I4q15PtUmOM
         kHjw==
X-Gm-Message-State: AO0yUKUWBu5mUE1w0Ro9sESnQ0v8yLNwkXaBGlelddL3DBJJJDt4N2Xf
        wacyOSoSokWmv73ZbhMWuj+cNRwg548=
X-Google-Smtp-Source: AKy350YCJV35OUm5AEWZPT4wCzRl936O8DDl4h7zkbnfC/asfRfgFe7BDBIyTg2sgD2O2NSXrd7sJQ==
X-Received: by 2002:a05:6870:910c:b0:176:3849:4e96 with SMTP id o12-20020a056870910c00b0017638494e96mr11894542oae.13.1680046117394;
        Tue, 28 Mar 2023 16:28:37 -0700 (PDT)
Received: from [192.168.112.116] (68-251-61-155.lightspeed.sntcca.sbcglobal.net. [68.251.61.155])
        by smtp.gmail.com with ESMTPSA id zp2-20020a0568718e0200b0017b21991355sm10480728oab.20.2023.03.28.16.28.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 16:28:36 -0700 (PDT)
Message-ID: <83c29b890e7c31e0f174b8a5da22c5b20ce647da.camel@gmail.com>
Subject: Removing old objects from partial clone
From:   uzytkownik2@gmail.com
To:     git@vger.kernel.org
Date:   Tue, 28 Mar 2023 16:28:35 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'd like to periodically remove objects which:

 - Are not reachable from newest N commits from any branch
 - Can be fetched from server if needed

Unfortunatly I work on large repo and git gc doesn't work as all
objects are still technically reachable.


