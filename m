Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8733DC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 20:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBPUFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBPUFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 15:05:20 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D714AFD4
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:05:08 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id k14so1205342ilo.9
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzL9DkCr1klkVsoSucARoOk8IjG0SDWE9NODr5/2aXs=;
        b=lYXaZVQ0+l0qZnYp4psG6CPK2OsFXaI8cCXS+WwA5RLZ+ntwFZXp97qd5MCZsHz9sx
         Zbsx31eU7AVqo1xdibxP4goOusXpt/TfcyrQk70GsnIBsaAUFkDa/UKD5VRpkSR8KCYA
         DnuymupE4IsXwZX+wpxnin8Wmor1YzQlDOO013oCm8mrR7s8OAeLa7awXZt3h0pGNSCz
         lxJjoxagDEshlWrCMt6aAnMZ2UwL6GjbpglOU/G8pabDVjc6jTMS9sDCpvu2LGscpNyD
         T1ov5YZV5cbMu8rgXN+FCC5bNmAYEKxcp4Clk5ZIuSKaDqnmBytYAU87BOtTeEAEYKn8
         8kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzL9DkCr1klkVsoSucARoOk8IjG0SDWE9NODr5/2aXs=;
        b=vOKC+KQkcM2IuYoLx02keIDnZqSGQJyrso97CtIMZ239/XM/UlPRLXTzzPYfe1dfnd
         z1Q+npddYBJ2/FT0vDMP+Nv+OE/oqKU0wWhsMuLrGngBa6uGzCfGEc6yAQ0b5gX806Xy
         onyekNy6DreU7MAN1YnC+tTmIsxul2/c0X9pj6bkDblRTR69C4pYcyZ9DWOUiNdMxx5p
         D1xlSc/Rdo6p0ADJwX0t4iK0W9nTgXljv9Z5PmNXOeVdCFDjKhf7QxkXaXy5f1hDlhdR
         TTQSjeZzfjxrIZijvIiIsgGHSPZgAlXNPeMlwQ9YSfNHa+2wf9DlbO5T3NY2ktE+9hfc
         IySw==
X-Gm-Message-State: AO0yUKX6m26dMW9DEQu7hk0eS21XLXfkFZF0Yyi6KlyyxBwtnTFMSpBW
        v3HR72rsA3oBZXfsz/Y9/df1TlsqtMhlvYLnyjQ=
X-Google-Smtp-Source: AK7set9Kdvecy4jWBPxIBL0Runn3ofrNtMHpsyZ6OhdMhdwTV7rUKgJajOX8OQrW+Ncsz89vvp8a6A==
X-Received: by 2002:a05:6e02:194f:b0:315:313f:c03b with SMTP id x15-20020a056e02194f00b00315313fc03bmr7515747ilu.28.1676577907672;
        Thu, 16 Feb 2023 12:05:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e020ed000b0031552f6cd44sm717899ilk.14.2023.02.16.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:05:07 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:05:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.tavb@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] dir-iterator: drop unused `DIR_ITERATOR_FOLLOW_SYMLINKS`
Message-ID: <Y+6Mcnng0u6sz+C6@nand.local>
References: <9bb10b607e46f867a3f8f5c71abf13c990d1ecfe.1676572031.git.me@ttaylorr.com>
 <Y+560+/G4pelldXF@coredump.intra.peff.net>
 <Y+6L9R9HkkUc7PkX@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+6L9R9HkkUc7PkX@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 03:03:01PM -0500, Taylor Blau wrote:
> I have no idea either. From a cursory scan, I think I'd err on the side
> of it being vestigial. But Matheus (cc'd) should be able to tell us for
> sure.

Oops. That email (Matheus Tavares <matheus.bernardino@usp.br>) is
deactivated, which I should have known from 38645f8cb19 (mailmap: update
email address of Matheus Tavares, 2022-12-09).

I CC'd the right address instead.

Thanks,
Taylor
