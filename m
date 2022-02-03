Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E6FC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351999AbiBCSn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiBCSn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:43:59 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C5EC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:43:59 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id j16so2928343plx.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TAAUpxe3jOMh9Itj6BZ3rXM9UnnsDM7TaFLot6CuIGk=;
        b=l/JSh8zrdUGLUtLb7lXdOX0fy2ACr92NzoSnsID6J5LMjoKlURaXFWxFe8qlQPy9WN
         8ajIVZDZyx9thlIIZ1ROJSxzntYmpuJoZCbRAT11f5M+WB+2rb8vMPJEpaWHOIW/xYhW
         8KE8ScBq01J7XXruD22IT+8XmCEtbf+gpH50/xaixeW3U1s7ow51wBhHoKSMEHzREeLe
         Or8IWAtXItuxHauWtko4ujLka6e7/1XLOxPk3Y404UB/o/9T5IjRCfTb6XVXAHY3Vxbz
         BtoI0HSHIgg1PdWnmnafHxi/Af4zx1j5h0MntoXxDcsFlM0VRVI4woXOUiW1DndGUiBO
         NCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TAAUpxe3jOMh9Itj6BZ3rXM9UnnsDM7TaFLot6CuIGk=;
        b=jaSlVe2awuWYVEd0jBZz7VeFnlsSW0PEIA/z75ONY3oFGquY56B3NHQJM7PNt7j6Xr
         NLPytKlDgMllZ2L+GNmQpIfUTseX6arSPA6ufLQPScS4GeoJ0KP9RGOjc6o1mTBcUO1P
         NQ6Mmpy9zAzh+sy64Rvhe5w9BYMPzh8fZngelZhx3DDfWxhKEAhKp4UklxVXubP+Epu2
         wfGbYGvAZ/IxXUtallhqjlrmi3QX9pVJZinMxKZjF9LxIfmIT1/WRonxTQ/L4cjBRmK4
         8DIWNc7/PnS8WERbjKz5F9TrHI5xevuGmxwdrznbAI78mH2lsULhAblh45K8dRa1Wvfi
         O5tw==
X-Gm-Message-State: AOAM5319XcsPKkOoFbb+L1RY6yPq5B51mpwScjJgkLEUYhq5dZVY/P2G
        GHVSnkKYsAxxE93H0EoyErNJRiabrCE=
X-Google-Smtp-Source: ABdhPJzaPKt2mjRDoKYM59DQYL1YEywThelIILNztamrv+bc7FCmMAr7DXVUox1KDWTM6JyR7exfAQ==
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr15019633pjb.19.1643913838428;
        Thu, 03 Feb 2022 10:43:58 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id i17sm17445925pgv.8.2022.02.03.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:43:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Matthias Maier <tamiko-GITVGER@43-1.org>, git@vger.kernel.org
Subject: Re: Using principal wildcards in gpg.ssh.allowedSignersFile
References: <87zgoziwfo.fsf@gentoo.org> <20211217094235.i2fwildp7rcjcgtz@fs>
        <20220203124104.77ioij3jqqqyoc54@fs>
Date:   Thu, 03 Feb 2022 10:43:57 -0800
In-Reply-To: <20220203124104.77ioij3jqqqyoc54@fs> (Fabian Stelzer's message of
        "Thu, 3 Feb 2022 13:41:04 +0100")
Message-ID: <xmqqfsozvlhu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>> Thanks for your report. I tested the described behaviour and I think
>> this is a bug in openssh. find-principals will never match on a CA 
>> cert with wildcard principals whereas wildcards for non-CA keys work
>> just fine. I've emailed the openssh maintainer about it and will 
>>prepare a patch.
>
> Just for reference to the git list:
> This issue was fixed with
> https://github.com/openssh/openssh-portable/commit/15b7199a1fd37eff4c695e09d573f3db9f4274b7
> which should be in the next openssh release.

Thanks for a heads-up.
