Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FC0C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbiFCUDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiFCUD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 16:03:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8F2872C
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 13:03:26 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a67so3077938qkc.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jmlSP0CB0tCbaVrRwisdgzmfb50Y5HjTey98Ug/0wd8=;
        b=7+2MLGG1tYhwtmqY4CoiGKmeiz/hV6bW2ptW/wJcZQL2Xo8FAYn6ZpxGZwFILo75X8
         pY6DpqUbUhoDT+hNU7wu8j2SIQSxZLL2Xt/WmntPB1ZXjl4ozcspAb05dCZgjDeBQBtm
         OuY+UEKaAhg/E7tBTcdU1A+6wyIynzGDAeHKk8HCclQVAxD86VcRyjpeT9OBjc3DYVdB
         t9f+6zWvg51qgQn205MoUIouIOHd/t6jWgDTrfGrgHkzgzhPQ05CmYWGWRIy6Ip87KrY
         iaFan33+sCUJ8lWUZ4UfyXR64HhO0hak7Wo5eTk+EfStHX/vUx9a9RLVh6oiMW2Ikxkc
         dOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jmlSP0CB0tCbaVrRwisdgzmfb50Y5HjTey98Ug/0wd8=;
        b=QRG46f7pPwh2npgDDaNY08uBfdwaEreflzvxGuJq7SO7SG4dRf2mmyLLJZjn8g4pEJ
         kfr7nYF544lHU8s1yp+bLqc+LboFV8HCbxI+n5J0OcXgOIwWcTl3MLnSvz0WldlDDXAk
         GC2I0r06ym1vlsFub/dRfQ62hea6tdFqtQ9TNJkxmq8FtJ4unjNvE/kZF0TId8vRx8gT
         WHbH4IR04TzHHFt4l84mCPRTEDFXWZtziek3Vg13yCFzzzVC0nAgxUa/hku9RGI+ojl3
         F3qzEvxrQIBlL+1up1vFC7E0zpA4tv8xaqGpiOW3DT7Qv78dpMW/ut69SPGKMl5sjDto
         5dqw==
X-Gm-Message-State: AOAM5337HnP6nipPGYCdv+UUA1VBU2Lfpeih0ysAhm+R91shClWSS/MG
        wfNtgjfGDXs2PPrWQ+o4BGQqqg==
X-Google-Smtp-Source: ABdhPJwiXy63zoxn+hQ5+kTec8okqA8qThK61P7V/MyQQscsCwTLfySdhoDawfdpUj3h/CrMKUrHbQ==
X-Received: by 2002:a37:b13:0:b0:6a6:8eb1:b5f7 with SMTP id 19-20020a370b13000000b006a68eb1b5f7mr5218561qkl.764.1654286605108;
        Fri, 03 Jun 2022 13:03:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bi37-20020a05620a31a500b006a6a550d371sm911648qkb.121.2022.06.03.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 13:03:24 -0700 (PDT)
Date:   Fri, 3 Jun 2022 16:03:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
Message-ID: <YpppCx24rn9UTXe2@nand.local>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <YppSl4rOvVciLuXE@nand.local>
 <9d2752dd-6029-e71a-4149-0641fea879fe@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d2752dd-6029-e71a-4149-0641fea879fe@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 03, 2022 at 03:59:00PM -0400, Jeff Hostetler wrote:
> Should this take a branch pattern/regex to limit the set of branches
> that are updated (or offered to be updated)?  For example, if I have
> an intermediate commit in the series that has 2 branch names pointing
> at it, do we want to offer to update both of them or only the one
> that matches some pattern related to the tip?  Or is it sufficient to
> just enumerate them at the bottom of the todo list and let the user
> delete the lines they don't want?

That could be a useful feature to layer on top. I don't think it's
required here, though, since (as you note) users can remove lines from
the update-ref invocation(s) at the bottom that they don't want to
perform.

> Should we actually do the update-ref's or should we write a script
> that lets the user do it later?  The latter would let us also write
> out the commands to force update the remote refs if that would be
> helpful.

That seems like it would be outside the bounds of what `rebase` should
provide, but others may feel differently.

Thanks,
Taylor
