Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED9DEB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 12:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFVMii (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 08:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFVMig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 08:38:36 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B7DE
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:38:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5704fce0f23so73799067b3.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687437515; x=1690029515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zS0oCmJM7cvi25w6JkKNu8pv2Q0gHVys33nNw+AtO+Y=;
        b=YsF5oay1HTYmgRZ3RMBPW7hoNARbNXPIxaESJO08cQMtoFSwa+JQdSc39QfaKrWppB
         FP0nc5elD3p7MKVrfldy9GRhdOHbNL9gfZhrFfZ6Fkiyax7SIpkexKrwPrtO/MrqNTcl
         cg+NAUBlSlLGyh3bhUNoJJob1uPNUazd1xWKIxw81EBAW4CqOQfBx8yyWCfVs6ADdY8u
         c5oeW7KXNlagYJUxCelz//Xjce214ua6i2wobV8ANTs24WTJ4IMS8VZofzycr0bHjXSx
         HI3w29UWpeRxQuJLur7kzOtvMGIuipomzzgUNNCigHDvOmZkNRQxlntu1JaZ/I0YnKCN
         No5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437515; x=1690029515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS0oCmJM7cvi25w6JkKNu8pv2Q0gHVys33nNw+AtO+Y=;
        b=L4nAhEmFqewm6DPR0q5bCICQVmjkB2ts4uz7BCQOtz0pfgMDMp6Awpmxpr50sb6KvQ
         YUS68tO6K2pVJe2Kx2zr9tQ0zL2ezlY53Wf2ug1VNgCntcUSa2cn+XVi5Zburxu+ba7K
         R3g2Qqlucs7i9Uqf/MoKCsbajqGJE3VdcQ8Bx6Mxx4s1YkDbxJl6369ZWkOSzTYRMh4O
         LxN7cMhI1/XVtZ5NuCcXdL4G48bF8iiHZd0hDz5vTo4CBNYR864I7HtnkJvyeJCT2X1V
         IZvHvclV5buHnQuFds3SCLbk8u3PA4R9t/or4M/8ZZYJV2wZ6LQw/gKhYf6UqetT/1Ec
         OMNA==
X-Gm-Message-State: AC+VfDy17yrRDW7H3VE9MP/VYaLbEHd/SDFDvJ+Ek4oRxz43NpB7ogDe
        PkZp+jk38ajhXMp02HO0fR798A==
X-Google-Smtp-Source: ACHHUZ6DY15mwF1XT7IyF/+2CkE6RZUmEr1P41Hc1wZWvCSIQlWBJvG6bN9REAmsao6tWiSfyqKMJw==
X-Received: by 2002:a0d:e2d6:0:b0:55a:3ce9:dc3d with SMTP id l205-20020a0de2d6000000b0055a3ce9dc3dmr18213899ywe.13.1687437514868;
        Thu, 22 Jun 2023 05:38:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a65-20020a0dd844000000b0054f56baf3f2sm1787248ywe.122.2023.06.22.05.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:38:34 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:38:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] docs: add git-hash-object -t option's possible
 valuesync-mailbox>
Message-ID: <ZJRAsU6LfSwFIdbw@nand.local>
References: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 12:46:34AM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>
> For newer users of Git, the possible values of -t in git-hash-object may
> not be apparent. In fact the current verbiage under NAME could
> lead one to conclude that git-hash-object(1) can only be used to create
> blobs.

In the above, these days we would say "git hash-object" instead of
"git-hash-object" (but "git-hash-object(1)" is correct to refer to the
manual page).

Not worth a reroll on its own, of course, but something to keep in mind
for the future.

Otherwise, this patch looks good to me.

Thanks,
Taylor
