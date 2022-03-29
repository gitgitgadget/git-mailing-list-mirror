Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EE2C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 23:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiC2XLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 19:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbiC2XLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 19:11:34 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E322D370D
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:09:51 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e22so22847435ioe.11
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P1hZOMViLr090F9uaVbaCoGpnBE97APyo8Jz2JluP6c=;
        b=bP7idGc5NIAIcm4d4McRZb58A0870u2NaJZzcH04n1SducNLn0lnRHVhS2ZR1ycQ6B
         22g6PATDyYoeL8rt5NPHX7aHKGK7bdZ3eVd72JhGObdaU9v46n/i7dto8RRAr/tbKIU0
         MRkdjv/yCDgcAXK+VO/N8NMVHGTM6NDQZndsI18SWr3xGeqQ5NTeeezFazN3m7qWbkm7
         MtfiBdLGD9rF39sC7AINBVf5EO95qYaHXwO3PG6hPH9oQqAlJEC4vIePMTSTG6Y/BaxF
         FGo3z+ev/D4lqQ6TLYFgbtGOPWDNqCZv7f7OcezlwdCvbWmaciIQYEmS2AjoaiC8KhQ5
         xBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P1hZOMViLr090F9uaVbaCoGpnBE97APyo8Jz2JluP6c=;
        b=slnCYX3HwP9JyJVi/qMhSy/x/KJNPMkXYFTG8fWbMMcrcr5waEaST/jp6626yhAbnU
         wUHkOqDh3zfE/QAyowMNPx//H196rky5EYMPUiNxhkXYYdcYxYkC5j7IDLLfR7I8G1s7
         0hp6RBL8OhRQ7PpQ91sQu8TIC5rKspYEixCk3xH6H0quA14vFl3eUC++Dx54UuB5f21E
         14k5aEBmxBRHlkeFawjsPETekyWIe2bZ7Fwlr3+hA0zeiYHIzyXodtg627AfYPIVw/y5
         Rv/M+SLfkPhJdfdJvkk+chc0IPf4XC4IkoCVpYxtuPaCMWBbf4Mxe0qut8pp0+Ap0YRa
         hYow==
X-Gm-Message-State: AOAM5339vzh/VetVEtxcpVckKXl2Ibdwm7eSsjjq60PpCM67I2mWjVX3
        hYfivvTIGbFx4dOxYByyyDONaw==
X-Google-Smtp-Source: ABdhPJyHZPQ/0eOk359+NAxp4YgW2p5TRvkiigqusj/5u3lTHWl9hths9VLBXhbRh3GKsKjAfJlLBQ==
X-Received: by 2002:a02:9a07:0:b0:31a:2642:9e1d with SMTP id b7-20020a029a07000000b0031a26429e1dmr17281470jal.159.1648595390490;
        Tue, 29 Mar 2022 16:09:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c2-20020a92cf02000000b002c9ae102048sm4781509ilo.77.2022.03.29.16.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:09:50 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:09:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Subject: Re: [PATCH v3 2/3] transfer.advertiseObjectInfo: add object-info
 config
Message-ID: <YkORvY3duS7dQRRY@nand.local>
References: <20220208235631.732466-1-calvinwan@google.com>
 <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-3-calvinwan@google.com>
 <xmqqy20sqtfe.fsf@gitster.g>
 <CAFySSZB5aTAsYn=Oqd_hUCQu+X1+GCgpvscLYqk+qzGQc3sAVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFySSZB5aTAsYn=Oqd_hUCQu+X1+GCgpvscLYqk+qzGQc3sAVw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 03:48:28PM -0700, Calvin Wan wrote:
> > It strikes me somewhat odd that this is the _first_ such capability
> > that needs a variable here to control if it is advertised or not
> > depending on the configuration file settings.
>
> > In other words, "Why doesn't transfer.advertiseSID also have a
> > similar thing in this file?" should be the first question that comes
> > to any reviewers' mind.
>
> It doesn't exist in protocol-caps.c, but instead in serve.c. Would be
> a good discussion for whether the advertise function should be serve.c
> or protocol-caps.c

Most of the others are defined statically within serve.c, but there are
a couple of exceptions:

  - `ls_refs_advertise()` is defined in ls-refs.c, and
  - `upload_pack_advertise()` is defined in upload-pack.c.

Even though cap_object_info() is defined in protocol-caps.c, I think we
should probably keep the definition of `object_info_advertise()` local
to serve.c.

If there were a object-info.c, it would make sense to put it there, but
since there isn't, it makes more sense to keep it local to serve.c,
which avoids us having to declare the function in a header file.

Thanks,
Taylor
