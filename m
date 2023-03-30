Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4AAC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 15:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjC3PwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjC3PwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 11:52:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD0BE3
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:51:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a19cf1b8ddso163715ad.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680191510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1rr402v5GsPuXHlgfApMtcRYpmUCe1FHXqNSo3qZJE=;
        b=IZQ9vfVuyORMI6uhnAhFAtaVM4Kv9m/jQK4noydWAnrjx3yPtnr+VeZu6bEhkH8rid
         63buw56ucUHY1ow0OdhUo6bASvlRrzN4Lnxu4H68klXODATSD4To0zmt97Lk3P2P6XHV
         dIwX2PxzMcBwyjDdAjFeMOEMeSygmtcgYha2HdwBLGOTVrsDHwDi/KoqUM1BLqm348E7
         rmirVHPA2ccmpc9QpElMX5emGVxNLZHC4mte/oVBkFUC2KopDx2YPifoY9zBlD2z2bs/
         OL4JZeTzpcGWVekJ7LxRFIODiiWxwQ2fXkqU2+1IjnJ2qauZo9HMMLSuVse6iWofOYOu
         oXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680191510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1rr402v5GsPuXHlgfApMtcRYpmUCe1FHXqNSo3qZJE=;
        b=YJlz0lTf0Np6evfqcFfMhUoqMMOjnpczeUco9I5vwooCnImn0MX2ps1UW8obIXeP9x
         d2nFsifdw7oIBVjKNMcEgvtisrmq8ClzJ8hi0HAgtnY0N6/kjYMka8zV2lfJO3j8Rgaz
         rpvpT3wLv2unppPZmWUZXhNjy5wqvfaIB0MqVFVtejzPRDYaMHWCQ+7rpDE7bDqAmUPd
         HLuHVghvZmQZrOEwQiCZdc87JdOM+GrD8VTNFjbG1vzFCCJF7ho1p5F41vx40kBy9L2V
         RQDjBQqNKWC87hK1Iw/A5bHWsKyfrwy+Z09VFoLPueSiK38AUKdqxTuqRjH5b4FNAEdt
         pYNg==
X-Gm-Message-State: AAQBX9d/OP2Bmp+3p+/wBqb33lWecdIWZiq8o8VhX27YrbvNkm7Ap5GW
        jBGAHWLUssk4Df2f/UjgdHGQ/A==
X-Google-Smtp-Source: AKy350apc5gIAG/JzRn6fidAfEHOXiAXFJo3D8CO4PBT1dEuN5++u/j8/f/3siR90uvLfnCgKstZmQ==
X-Received: by 2002:a17:902:8687:b0:1a1:af2b:ba47 with SMTP id g7-20020a170902868700b001a1af2bba47mr237836plo.2.1680191509869;
        Thu, 30 Mar 2023 08:51:49 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:c499:34f6:2e72:c0b9])
        by smtp.gmail.com with ESMTPSA id l26-20020a62be1a000000b0058dbd7a5e0esm44096pff.89.2023.03.30.08.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:51:48 -0700 (PDT)
Date:   Thu, 30 Mar 2023 08:51:44 -0700
From:   Emily Shaffer <nasamuffin@google.com>
To:     Siddharth Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Jonathan Tan [ ]" <jonathantanmy@google.com>,
        Siddharth Singh <siddharthsingh3099@gmail.com>,
        Siddharth Singh <siddhartth@google.com>
Subject: Re: [PATCH] hashmap.h: fix minor typo
Message-ID: <ZCWwEIw+Pc0E2w8w@google.com>
References: <pull.1506.git.1680190083688.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1506.git.1680190083688.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 03:28:03PM +0000, Siddharth Singh via GitGitGadget wrote:
> 
> 
> The word "no" should be "not".
> 
> Signed-off-by: Siddharth Singh <siddhartth@google.com>
> ---
>     hashmap.h: fix minor typo
>     
>     Hi folks ! I'm Siddharth from Google, I'm working on libification of
>     Git, while going through the hashmap.h I found a minor typo in the
>     documentation comment.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1506%2Fs-i-d-d-i-s%2Ffix-typo-in-hashmap.h-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1506/s-i-d-d-i-s/fix-typo-in-hashmap.h-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1506
> 
> Hi folks ! I'm Siddharth from Google, I'm working on
> libification of Git, while going through the hashmap.h
> I found a minor typo in the documentation comment.

Hi Siddharth!

The reason that your description showed up twice is because you included
it both in the GitGitGadget description[1] and the commit message[2]. As
you can see, either way works to get it into the patch description, but
if you use both it will be printed twice :) It's not a big deal as this
is part of the description and won't be part of the commit history, but
in case you want to avoid it in the future, now you know.

Of course the diff looks good to me - nice catch with the typo fix.

I'll also add for the rest of the list that git-core @ Google team
encouraged Siddharth to send this patch even though it's minor enough
that the list would often it churn, because it's Siddharth's first patch
to Git (of hopefully many) and it seemed like a good chance for him to
practice the workflow as well as introduce himself :)

Thanks for sending it, Siddharth.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>


> ---
>  hashmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hashmap.h b/hashmap.h
> index 7251687d730..e2cf9c78d84 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -270,7 +270,7 @@ void hashmap_clear_(struct hashmap *map, ssize_t offset);
>  #define hashmap_clear(map) hashmap_clear_(map, -1)
>  
>  /*
> - * Similar to hashmap_clear(), except that the table is no deallocated; it
> + * Similar to hashmap_clear(), except that the table is not deallocated; it
>   * is merely zeroed out but left the same size as before.  If the hashmap
>   * will be reused, this avoids the overhead of deallocating and
>   * reallocating map->table.  As with hashmap_clear(), you may need to free
> 
> base-commit: 8d90352acc5c855620042fdcc6092f23a276af6d
> -- 
> gitgitgadget

1: https://github.com/gitgitgadget/git/pull/1506#issue-1647302362
2: https://github.com/gitgitgadget/git/pull/1506/commits/a657138270f422ff43ac835884961c3dba1fe507
