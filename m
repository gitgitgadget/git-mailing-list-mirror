Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE94CD4850
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjIVSo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjIVSo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 14:44:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7845A9
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:44:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ab2436b57dso1618725b6e.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1695408261; x=1696013061; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0vuf8MxIIAxLEutn3KwzJI66PLlWXvsYq9L+VtxhAE=;
        b=k4UgWEEWOC0G3YyyvxFbqYDrYGj5mq18zGNsaaIu2bBwmHp7syfnxea3jBi1jlAh9+
         rhGO/+aAvNiYCJrYCOLnKRylUfdbbmucOalfvG3LyzBtBIVRnqWCgzzpak0SE3zxNxIw
         OrAWdY6dL/BksZYMZCnjS450xhRynSD2Z2cBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408261; x=1696013061;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0vuf8MxIIAxLEutn3KwzJI66PLlWXvsYq9L+VtxhAE=;
        b=RpZFDCzwolaFfAb9JZqYWa2JRLnbUuEPuZu5Sjh8tIYSFrOvWYMFhoi0Nax7gnDbMj
         zvjbsdBr/l81ZwVWHEXObcWfBjSwKJpby9Emwf3j4yjTEwYoDoe7ePO/qwZ0qXthk+hV
         a2SZx2ZoH3Ms0pb6zjxTm/doDUSQ80j6UTe+fN8a7J+LOnqRSDATDXelVEJVt4Gi9NWT
         JuJIUKFVHCwcWqkR96T4PJlry0NZshFw77YhbavcEiwR3vMBVdpabL9Vr7owOQwR2LTy
         YgJq5I04jPjvLUyoYZ0Mqj1qRghuh4bjNPRW/DiSTJhanNeqE9VmN7BywZxIwwCczU8N
         9YAQ==
X-Gm-Message-State: AOJu0Yxa4wjvi7tfq1ByL084ZDZ2p0gIXUSgomqW68j5a5NbuPcoVJpB
        V/lMY4NJ1IMwH2Rqjq96LX86tX3RWT83ps3lCIT65w==
X-Google-Smtp-Source: AGHT+IE8ZQGz8dvpqLMhnTHWNWQ2mQrlU2NIcgjJt9a/io8qlO+/CxZsq+PdBmv5H0uD31RR2HDHXg==
X-Received: by 2002:a05:6808:1486:b0:3a7:5cc1:69b0 with SMTP id e6-20020a056808148600b003a75cc169b0mr653604oiw.7.1695408260963;
        Fri, 22 Sep 2023 11:44:20 -0700 (PDT)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id jv24-20020a05622aa09800b00417d56d432asm1655978qtb.40.2023.09.22.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:44:20 -0700 (PDT)
Date:   Fri, 22 Sep 2023 14:44:19 -0400
From:   'Ben Boeckel' <ben.boeckel@kitware.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <ZQ3ggxA7KOysXrba@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe>
 <ZQ21NsLmp+xQU5g+@farprobe>
 <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
 <ZQ3GAJ/AHsM9e9a6@farprobe>
 <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
 <xmqqediq2j0g.fsf@gitster.g>
 <032d01d9ed80$5e569670$1b03c350$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <032d01d9ed80$5e569670$1b03c350$@nexbridge.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 14:12:31 -0400, rsbecker@nexbridge.com wrote:
> What confuses me is how, in the other subthread, that adding sleep 1 to the
> construction of history should make any difference. My understanding is that
> the path to the tag is invariant of the commit-date.

Yes. It is explained that the commit date stored is only to 1 second
granularity. Since the commits are stored in commit-date, an equal
commit date ends up "twisting" the history and traversing some ancestors
of commits before the commits themsevles. This loses the "seen" bit
tracking that is done and ends up labeling way more commits as "not part
of" ancestors. By sleeping for a second, the commit dates can be totally
ordered reliably.

And this tracks with my and the other thread's result that the traversal
is not paying attention to the topological history properly.

--Ben
