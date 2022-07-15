Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15308C433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbiGOCCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiGOCCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:02:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A6173596
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:02:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id ck6so2851245qtb.7
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SElMZu1kyUD9EH+LXLfdw2XzaLw3RaUlpMwkLY+Plvw=;
        b=RAAw6GE76wSEZMlKNZJoSQ28yyjIShaB220bmemznMZWwOJmfEKXwZz0HgkcOt4w6w
         51ATHtvO8E6NKb2SbsBUqqO8cWGOPYngp0DySqTqNEDa26e8xq6dCwoTaPLmOpUADx1X
         yLfVD5xscstOAElQyurAfDqlk5N07MyndxErZ052MO625Lo2jGyXzAai+lxDTjKqleQB
         nGDbaqf3ulRj2FwHWcj8vE38U/f3DEnKhD3k0TTPydjXXBeCdYxmHNolkUy4WOZku0o2
         k7LPLD/fRmf3wuCpnudUDjjE0pHyvx4XMWsOrfObR6jndICnPeVvSEPJ00AyJmcYHNBU
         podw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SElMZu1kyUD9EH+LXLfdw2XzaLw3RaUlpMwkLY+Plvw=;
        b=Zct0wfrOQst0vQatHE4wFdMltwQ047BNgGZXxwnq5o/+yBaiu98iugQbiv3rmA0FqM
         nZ3mIo44n0kSkY1NaRsiD9kW1m6yJGoaog8cmJtm1hm5S8wn6liWW+Csp3vknISnPsOb
         WshTN0PJ0uIm3gkgaOhxmNk6PibHJjz/xKZQGWX2QFtrgDDL95fMnEDZV/RH8udhWBJW
         T4ogwCo143gEE6ZgBUg33lLLoCPg23E9vQNwchS3jAfLi23ysSS8M7WOZJ7bTS3DqXTb
         3bgd489FU6AtAiAcGBhrIiyj4HzIAm8KhTJ809MYT93aXigQ8GxEng+9QUHqTW1JHK6D
         fE/Q==
X-Gm-Message-State: AJIora89f355SI4F3K9H8CGVkPl6Rhw7KlGhzlqSNCmNUYzfmnxAtr5i
        B0XVPeygJxV95QKVgYNXwPNn/w==
X-Google-Smtp-Source: AGRyM1tZsiv7nQjaxsx0bhbqVEfs3AkUHJLpanf/z8H/KyEJ8WF+lnqf26zMllSffpwpfdTDWxbGbw==
X-Received: by 2002:a05:622a:143:b0:31e:9c61:c1d7 with SMTP id v3-20020a05622a014300b0031e9c61c1d7mr10321966qtw.128.1657850524331;
        Thu, 14 Jul 2022 19:02:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i12-20020a37c20c000000b006a6a6f148e6sm2664949qkm.17.2022.07.14.19.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:02:03 -0700 (PDT)
Date:   Thu, 14 Jul 2022 22:02:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, peff@peff.net,
        ps@pks.im, wfc@wfchandler.org
Subject: Re: [PATCH 0/3] commit-graph: fix corruption during generation v2
 upgrade
Message-ID: <YtDKmo72LgqzEycD@nand.local>
References: <cover.1657667404.git.me@ttaylorr.com>
 <xmqqk08gdi5i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk08gdi5i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 10:41:45AM -0700, Junio C Hamano wrote:
> Thanks.  Do we know where this breaks?  Applying [1/3] on Git 2.32,
> 2.34, and 2.35 seems to claim that "known breakage vanished".

With a script like:

--- >8 ---
#!/bin/sh

set -e

rm -fr repo
git init -q repo
cd repo

echo "x" >x
git add x
GIT_AUTHOR_DATE="@2 +0000" \
  GIT_COMMITTER_DATE="@2 +0000" git commit -q -m "$(cat x)"

git repack -d -q

git.compile -c commitGraph.generationVersion=1 commit-graph write
git.compile -c commitGraph.generationVersion=2 commit-graph write \
  --changed-paths

git.compile rev-list --all
--- 8< ---

You can bisect it to 3b0199d4c3 (commit-graph: start parsing generation
v2 (again), 2022-03-01), but only because that patch teaches Git to
recognize the existence of the generation v2 chunks.

I suspect (but haven't confirmed) that it was probably broken before
3b0199d4c3. But such breakage wouldn't have mattered, since despite
understanding generation v2, previous versions of Git never read those
chunks, which would have masked over this bug.

Thanks,
Taylor
