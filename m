Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C7CD4846
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 16:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjIVQvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIVQvV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 12:51:21 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC0114
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:51:15 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-770ef334b4fso140537285a.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1695401474; x=1696006274; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMNgPJcIyRmrL59F/0B2w1gF2HcSkOyRurmXEjBY45o=;
        b=BOYJYcn7oht7EpLoiuGPRWHmQclpX0feauKRZWgX8QphwSzUVSRIAWHRIrnYHODHQm
         4z8l8OZb0zwaG+pS/vbK2YiUK4U/DFz8VCY4z3BOa+S4GyXW2l84+SX03XtY0Dh533Ma
         MDqXMB7747RkvwWnUzUbYQpUupU180O1iZP6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695401474; x=1696006274;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMNgPJcIyRmrL59F/0B2w1gF2HcSkOyRurmXEjBY45o=;
        b=FbNOhBYo7Ga0XUcZPKfQcFyCTNFyX4j5rgrJbE4nyeZDAs4/C4Nmf+Kkkeo+3Qfy/o
         GLLwN+yknHq4NPe4SxBCpSpruc1lc3OBb/qVknTIZcsa3A2nkf+MfJtbIELVx3FOSCgW
         6plxeEDmVztoDyaXVc6r9edHKoy/75gF6LcjeVlfA2hLfi9nmErjQYn4YkvF7Cr8uL2s
         aaCjybKGWeDMcyO3+TX14GxWnLyfas9eheYL3WsaFnnudIolH6U5jt/i2SjJ5Uuip7j8
         UfOA5zPTLVbTVXMREC0obECuSECIqjHj9zNDOukgkYTaJu4yiQScMrDg95vSoNE+Dsoy
         h2nQ==
X-Gm-Message-State: AOJu0Yw0K01qylb00CB5PJGQ4OL9EkfNBE91mFqErKN1Hkls+wsLwMH1
        3XtcR0q0AnDju/MgNXFOy7x9IkAyZICliYSaYmWbrw==
X-Google-Smtp-Source: AGHT+IFlqgAhukYFHYxyVI+WGfYPtxxYfBrPZV7RUyaZWD2HlXn+IC5W4EmH8O/tWgUOLgjg3Ytuyg==
X-Received: by 2002:a05:620a:2489:b0:76c:a952:c70f with SMTP id i9-20020a05620a248900b0076ca952c70fmr313654qkn.35.1695401474422;
        Fri, 22 Sep 2023 09:51:14 -0700 (PDT)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id l7-20020a05620a0c0700b0077414748e92sm912946qki.96.2023.09.22.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:51:13 -0700 (PDT)
Date:   Fri, 22 Sep 2023 12:51:12 -0400
From:   'Ben Boeckel' <ben.boeckel@kitware.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <ZQ3GAJ/AHsM9e9a6@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe>
 <ZQ21NsLmp+xQU5g+@farprobe>
 <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 12:13:00 -0400, rsbecker@nexbridge.com wrote:
> On Friday, September 22, 2023 11:40 AM, Ben Boeckel wrote:
> >On Sat, Aug 12, 2023 at 15:36:56 -0400, Ben Boeckel wrote:
> >> I found an issue where `git describe` doesn't find a "closer" tag than
> >> another tag as the correct one to base the description off of. I have
> >> a reproducer, but I'll first give details of the real world issue.
> >
> >Bump. Can anyone provide guidance as to what the best solution to this might be?
> 
> Can you provide details? `git describe` is sensitive to --first-parent
> and whether the tag has annotations.

I provided more details and a reproducer in the original email:

    https://lore.kernel.org/git/ZNffWAgldUZdpQcr@farprobe/T/#u

Thanks,

--Ben
