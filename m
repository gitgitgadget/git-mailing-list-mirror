Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B44C433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiI2TTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiI2TTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:19:34 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4013F5A
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:19:31 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e205so1692065iof.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=iq/w41in/GpCsaq+WxKb31XO2Z73lLZKqpokQshyNhw=;
        b=Oz9PGlwA/BqtTeg8c0QAnWKp3cjlk7KzI9BNb914eTeQWJW9RdmDEluZ8inBAKhUbY
         uamIirBkdcgD+wWUogL6q+UjoZAkHJc4P0wbtoqYPIliLE/OJgMyEsZuzB5cwQ8VlLML
         iUPHTZO6BAqEOqnJxCySCO8vhFd9bWsscjLGXvtlXfarfRS6i3qGVldE7sNGNMvc5BJS
         ZWEOVf3Tu9Bkbu7+rok7mg+tHbe6gCjpD4mu0TulYZWtGPXddjXfQdA7MKv4lXumG09w
         lSQ77YDKReJa1rr9frdmyOYJaTLI9waHEqkIW0NrBnmhxtKkFnMCpFbWRcLbVyY/zjEc
         Lofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iq/w41in/GpCsaq+WxKb31XO2Z73lLZKqpokQshyNhw=;
        b=2oiQMTCJlYf+QeCHKBq0yZkZYHfWKAZ+NTvOAjKQP1p8zlM6tG/D5xqBycclySARS2
         N4hy6M+GBWMednCJWlmlL5EvhuvNXB4OR+j9FGsR//UAIC/ZNL/kn8feKLr64TwsL4V1
         PDpsQdA/f47yxJA/1TRG9breGBkQIvBCI1g9WqnIqHvcP92E9uaZwfbfGCCZVZHN4QNV
         gZ1g3qtb6SN2NVoRALQX3vs4hBuqtEO+HcI6Y9oBJ1fbqPe96+MLJbshZlqTgUBiw1/t
         lK2iLD/y3EegoZKy71kOHs2LEL2cKr+URBZOPLCxiV8uc0q2MGqh+nj4iwQTqoMLc2or
         BBMg==
X-Gm-Message-State: ACrzQf2AlI+YuCEJIjKeqhO7Ejhbft8mrMGXDvcz+xMu9rpdoFBTT64s
        0f2FtLkOJop8XNyBSv/tmN07nuqACUX50Q==
X-Google-Smtp-Source: AMsMyM6njvlMgQb0QGsZLUYYiEnYE5rJ4TByKSyl2Vu5ndR2CVJXPnp44KBzOh+c6kZEg0Jpz0ySjA==
X-Received: by 2002:a6b:670b:0:b0:6a0:d9db:5ae5 with SMTP id b11-20020a6b670b000000b006a0d9db5ae5mr2186393ioc.62.1664479171237;
        Thu, 29 Sep 2022 12:19:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m20-20020a0566022e9400b00688eee7588asm123891iow.32.2022.09.29.12.19.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:19:30 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:19:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 1/8] Bundle URIs
Message-ID: <YzXvwv/zK5AjhVvV@nand.local>
References: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzXvMRc6X60kjVeY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Bundle URIs (Stolee)

- Unlike packfile URIs, includes refs, does not need to be delta-ed
	against what server sends
- Doc checked into Documentation/technical
- URI can be provided by user at CLI or advertised by server
- Most users won't experience anything if they git-clone, but it will
	only benefit the git hosting providers. It will allow them to offload
	data to CDNs, being closer to the client.
- With bundle files you can download them and start of from there and
	fetch the objects you're missing in a regular manner.
- Jrnieder: Packfile URIs and Bundle URIs are trying to achieve the same
	thing.  How can we duplicate efforts? E.g. how can we prevent the
	client from leaking information to a possibly untrusted server?
- Stolee: Are you want to provide a way to provide authentication?
- Jrnieder: Analogy to the web - you don't want to leak information to
	websites you don't trust. The security model is pretty complicated, we
	don't want to replicate things like same origin policies.
- Stolee: So, e.g. the server provides a hash of the content expected at
	the bundle URI and the client can verify? We wanted to explicitly
	avoid that because we don't want the server and bundle provider to
	need to know anything about each other.
- Jrnieder: Compare to packfile URIS - Packfile URIs are only advertised
	for the server, so the security model is mostly the same as a
		"regular" fetch/clone
- Jonathantanmy: Another difference: the objects in bundles must be
	associated with refs, you can't just have e.g. large objects.
	Packfiles can contain arbitrary objects.
- Stolee: Let's talk about the security model more on the mailing list
- Ævar: We're also open for a breakout session on this topic
