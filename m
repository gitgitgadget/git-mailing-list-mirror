Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D0DC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 22:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhLKWJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 17:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhLKWJp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 17:09:45 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC68C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 14:09:45 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z26so14350628iod.10
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w75kpVYwRwmbV6nw0jB+VmhId+iPDD613rWx7cX4ss0=;
        b=IzbabdIYu0Vt5PPY9a4aCXuNdYq8fwsha4LuRg+X0Eh4Xz0CgouGWgezX6QE2PY21N
         yjuNCVpt1NpDArqKyD3ATUFa1wbaZAUTzLcF0xUUsRoqfG3DGLsS12N0cj29Se8rKDxQ
         LXQ+TliFGmNhE9MSW/SksKlBOEETVYorqfDakXhnXnfruGMpNcRNHM1eavTL1RIW3Rxw
         EB30OlEKhDLxOet/t0Nas4a2hBk1PWnfQhZ8aOUsicG4Vku7N/FKuDuUXE5C2dvKxWjk
         cRjSnkugBBfa0s48MWcq/uZODdahA3CJKDJL34X4fA/HN/u8eS4iEEU1xfqzrnHIae07
         ziFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w75kpVYwRwmbV6nw0jB+VmhId+iPDD613rWx7cX4ss0=;
        b=U3mSsC4F108M9IxGcLs3Lr1OlduTbTwOqMqaCNtPimfTPSL0DRfXoIMOE5yP6Zebx8
         x1J3nkuji6An0iLUOJ+uz+IbIpRHC8+AL1XYjdWCqhipZhYvLjsEHpiOS3V/Hnw/RKMj
         akjajN3ZMO+cpJUojGh7Q6NfvT0GTlhucmXi2xso/ePj9XGNpaP6APJn8bP/VqNN300L
         RCyspTJZgsLcyeeDm6cqhYqPmE9hPdumqIN7VjvrkNfzDCxc5grJwNxBV9yYKFGV5z/g
         YkTDkYZV+d+VgyJb+oK+7U7uDzNA4MqIkt9Y/crF5T9gMFYnNy+OwGdEx6tP+x4MlDhB
         OrBA==
X-Gm-Message-State: AOAM53333sRzTsdSxPwiI/q7KczZDASAH/PbtVdbauxEKouSD7bVcxNF
        MytBFdd9BMbCjmq8vsJYmJlXxiKyIzwdpY89
X-Google-Smtp-Source: ABdhPJxgpDpBBUD73oAGNov7SRW9EvSJKtLgPwzKf/en3sC4vjigyj94QfSXlxuVHOL/QDsd1Yr58A==
X-Received: by 2002:a5e:c807:: with SMTP id y7mr27646215iol.9.1639260584483;
        Sat, 11 Dec 2021 14:09:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g2sm2356527ile.88.2021.12.11.14.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 14:09:44 -0800 (PST)
Date:   Sat, 11 Dec 2021 17:09:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/midx-bitmap-corruption-fix
Message-ID: <YbUhp2OnD7gVEGJm@nand.local>
References: <xmqqilvvluoa.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilvvluoa.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 06:52:37PM -0800, Junio C Hamano wrote:
> * tb/midx-bitmap-corruption-fix (2021-12-08) 2 commits
>  - midx.c: make changing the preferred pack safe
>  - t5326: demonstrate bitmap corruption after permutation
>
>  A bug that made multi-pack bitmap and the object order out-of-sync
>  (hence the .midx data gets corrupted) has been fixed.
>
>  Will merge to 'next'?
>  source: <cover.1638991570.git.me@ttaylorr.com>

Let's wait. The patch does fix the bug, but somewhat accidentally. I
have a few proposed directions in the discussion beginning at:

  https://lore.kernel.org/git/YbOeEjNic5ETGcdy@nand.local/

but I want to hear from others before deciding on a direction.

Thanks,
Taylor
