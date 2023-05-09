Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD0C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 21:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjEIVf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbjEIVf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 17:35:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883496A5A
        for <git@vger.kernel.org>; Tue,  9 May 2023 14:35:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9d881ad689so8282644276.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683668075; x=1686260075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=06UKc/yO7nrqBeIUTG0rm0f2iUGEMitq+FXetXoOrus=;
        b=UUE/AEgQMnwobZS1at0Fzj81wK/4CaHQim5Hkus+YNl7OpLObst1ggQqMM/VysRMms
         8UL9jlE8/RAx3oRibZ3z4X5rXmEWGPaRsj2xS//yBCGIo2EExCwwAD3vtCosCx2SoEPv
         0ZnN51z/lPR4KFqseIeORETBm1F7fnYKRlDVbSQjnUnkp37OFy5ONmQHJkrjJLKfg6A6
         nLGJqjLT+RAHYPYtuirYdR+QB4E03LB8/3PqbFgrB1swpPEbApPu83QoZAawqU5znPxb
         R4eSTK/YEvd/se1xYG0TKEdej9gyXmqQpb/r+M4EB8G4ByCkYPcbjLgGq7yhamN1hIHX
         5emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683668075; x=1686260075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06UKc/yO7nrqBeIUTG0rm0f2iUGEMitq+FXetXoOrus=;
        b=iV9CLjMEwGooJf7ZfMvbX2hmVg2R6Y10388Dj1rlA2YsIt3Hk0kKdyTJgs8+d9DNyv
         vIQoSNXxsxuywTf6vmWzO7XGYUX/R38frfaiKbDzIlDddSdNayUekLJtWVZeFNSGk24a
         scGunmyOT/Rq0JxhVPOmKbR8saNqioGvzfuJALQbt0BVFSFiSczvU1eXzK8ijyWsaAu+
         JioBW6G8PgIq4jvtW8mZL4JNyz31u6Wq2gpujZ8fcrRWNxNu/q7HNPwBAI4RRBzQ+Vc5
         QQTf1U9l71O5mcn8nM9S8KfxdoF+3NIO1+Wek3AOPwFl8lRy+aVi3kkF7dJBwRJqOciJ
         x7BA==
X-Gm-Message-State: AC+VfDz8KB18IputW4o90nnRdFOEdnZxFFdukrk78EzfeHOI1A0zr1Zx
        tfQ4t1sAx+QjRn6PVsMN9nGUqg==
X-Google-Smtp-Source: ACHHUZ5zHbbplT7l4yH0Qa7oxz1KriRW7trXuATnr0/epHDmARwqV9qzkpDxh7rla9aMVCaQhl/F6w==
X-Received: by 2002:a25:d40c:0:b0:b9e:45e1:2081 with SMTP id m12-20020a25d40c000000b00b9e45e12081mr19726190ybf.45.1683668074989;
        Tue, 09 May 2023 14:34:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u9-20020a252e09000000b00b9d255709f9sm3228657ybu.2.2023.05.09.14.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 14:34:34 -0700 (PDT)
Date:   Tue, 9 May 2023 17:34:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/15] upload-pack.c: avoid enumerating hidden refs where
 possible
Message-ID: <ZFq8aYppuhjlkChK@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <44bbf85e73676b2c89a82c09f7d355122ce6e805.1683581621.git.me@ttaylorr.com>
 <ZFpjpsmCxDTUG-z3@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFpjpsmCxDTUG-z3@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2023 at 05:15:50PM +0200, Patrick Steinhardt wrote:
> On Mon, May 08, 2023 at 06:00:26PM -0400, Taylor Blau wrote:
> > @@ -601,11 +601,32 @@ static int get_common_commits(struct upload_pack_data *data,
> >  	}
> >  }
> >
> > +static int allow_hidden_refs(enum allow_uor allow_uor)
> > +{
> > +	return allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1);
> > +}
> > +
> > +static void for_each_namespaced_ref_1(each_ref_fn fn,
> > +				      struct upload_pack_data *data)
>
> I know it's common practice in the Git project, but personally I tend to
> fight with functions that have a `_1` suffix. You simply cannot tell
> what the difference is to the non-suffixed variant without checking its
> declaration.
>
> `for_each_namespaced_ref_with_optional_hidden_refs()` is definitely a
> mouthful though, and I can't really think of something better either.

Yeah, I know. It's not my favorite convention, either, but I also
couldn't come up with anything shorter ;-).

> > +{
> > +	/*
> > +	 * If `data->allow_uor` allows updating hidden refs, we need to
> > +	 * mark all references (including hidden ones), to check in
> > +	 * `is_our_ref()` below.
>
> Doesn't this influence whether somebody can _fetch_ objects pointed to
> by the hidden refs instead of _updating_ them?

Oops, yes. Thanks for catching my obvious typo.

Thanks,
Taylor
