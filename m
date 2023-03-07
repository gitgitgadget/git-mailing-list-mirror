Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28163C61DA4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCGAdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCGAdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:33:39 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218C25E1A
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:33:38 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id t129so4808003iof.12
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678149218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2CqQESBMWoE5BQRmOM42kczLe9aODXOSe7LDtVTr8/I=;
        b=iBia89O1WidJ2gnZArBE5rOwneif8xcb6S610aBrnFUeHLMGgPuWerHS1r1hV28o1p
         KFVAo4cwR8P6S71VQexG05aBb2yEecd3l1DU2IShb+AyX+FRPW+T6IA1FHvU3Sdapsg0
         qG1dY3C1GCXnc0yEpBRN3uNosxYrxUk7Io8s3UELeZjIhCMjJfmEzd8e0uECua/Sl5n5
         LGariGvF7kVUL3gqKEX5+TEV4V5SrtcwAY34e2aQnX8fsYW8Fn11sp9QFQYcHOBbaktz
         vWiE0ib+71STFLxvAZTcfnW3KTZ+87cs1WAl5pMCXJ6Yc42EZ0YvNjFiMI0DjqY/+dhg
         HDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678149218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CqQESBMWoE5BQRmOM42kczLe9aODXOSe7LDtVTr8/I=;
        b=qkqFIs0Cj5J9T1mB4wPh93Cr14JCO7TmLCPHQdwH1vtOHM9s3Nm1DmCEqGVb1nlHWq
         4XTMLfTTiYj0rWEaSd2Buhr5xYx4oJupz2SAlxhvITBNyerTmwZIi3uyKjbAwEkKty5u
         A+1eQWkZzZQLl9uHL2+5QFUO27zEhgTkivdo83EE1j8mf3pqItc6MFgi+1++Cad7oQqO
         RpV/vbOWI5mZNscjw1w9rhZWXvQkjrvb0cTEFN9h1b3MplJX32QjDs5VDyZD7YMwWj+0
         G9Z1ZGrC7EAjfpOowbvqztMbRy4SmA/hkghwLInZJYrf2QEMHZCkOZiwrC7d6O/V6etu
         wwvg==
X-Gm-Message-State: AO0yUKVUehiDp0oJu2lLtkuDDuoziO3dkLjPaLaUol4lo2TWxJZe9oOD
        ZY2bo+IvZmFjbDYawggPoZLYEA==
X-Google-Smtp-Source: AK7set9+XhEdht/cdg2V2bESKpDDZM0QDx4g+XjxsXcXn3mfe7r4Zb0ZlekyxbiyUg5/DS74wzXBnA==
X-Received: by 2002:a6b:3b0f:0:b0:74c:9907:e5b4 with SMTP id i15-20020a6b3b0f000000b0074c9907e5b4mr12699052ioa.6.1678149217969;
        Mon, 06 Mar 2023 16:33:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u2-20020a92da82000000b00313ca4be5e1sm3284081iln.12.2023.03.06.16.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:33:37 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:33:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/8] ahead-behind: new builtin for counting multiple
 commit ranges
Message-ID: <ZAaGYA8grLSt6Ukt@nand.local>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 02:06:30PM +0000, Derrick Stolee via GitGitGadget wrote:
> This series introduces the 'git ahead-behind' builtin, which has been used
> at $DAYJOB for many years, but took many forms before landing on the current
> version.

Thanks for a helpful summary of all of the details here. I am of course
familiar with your use of this builtin at our common $DAYJOB, but it was
nice to see a from-scratch explanation of what you're trying to do here.

Now let's take a look at how the patches came together... ;-).

Thanks,
Taylor
