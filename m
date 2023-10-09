Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD0E95A9F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 16:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377129AbjJIQIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377014AbjJIQIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 12:08:36 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE991
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 09:08:34 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41820eecff2so30395001cf.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696867714; x=1697472514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBuOe1RmXnhEjNtCAN730DgOisgZomahcDvVxEqLDr8=;
        b=pgcwQLwHsjc7GPCTr4Hw7b+SZyVN8ex53c+rkPge9hD6c0ALQOXw2pJdmx8d7bZAng
         6sg+FBkNacDoFBw4S3E32dNfxdQ2uLLdVUIiybHL6HYbbjM25jiz2WGJpKX3IGv3EXHX
         J7KtB07bOCcVj1RiZL9CbB1GTj2Wnd0aLI/5iJxYjt8ghJAdKI+ScoxyihPFH9Z64wdv
         fMnCKffTI99E1cCGsnQlVC6JptzulGsHEl66Foy/DY1tgt8GIUG14xnPTNTkchp6+Qgy
         8mGd4Jh7jo+xgKxiDsSobmjMzN6hvpUlq7h5yl2Ko1cdOVTN1rmLPuqLhs5hwGdKOiHe
         rtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867714; x=1697472514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBuOe1RmXnhEjNtCAN730DgOisgZomahcDvVxEqLDr8=;
        b=jtX0SIJtLCbxTKA6cXL0NhyPGT5CqSpYt+1urZgXFoUqDGMyPlTGzlBfF8MZHXzbxn
         PpcTmwO18Xa0y3vkymXuqpxnL/2djA/Zh48ynTmsP0v9Q3BPuq4kmCyj35A5c9l4iJis
         WTUV+bo3akagqrX/f0Cx8OImPl6QC3eKtD6gA5DbXZ4OQ3RcaN5TkdFOmYEdj79y2btD
         jwgN/Hd0S1pAwwFWzm066B+gny0PkcJ4wmu1JpLy3gfGIJFt6n7ubXlcTVmYY3WsOZxU
         WIzOOMyhlRwZBfQpy5e7GaBJ3BU7TiY7qQE2BAqRm2J6gObbphcMMjUW/KkRRGhoNOIu
         I0zA==
X-Gm-Message-State: AOJu0YwwMHfV/otpRmrkMntITx+nwGQamSNHpeG2gLiwWNEwSf0MX82V
        mi0j1EphCJyt0Quwm/RnR33gdA==
X-Google-Smtp-Source: AGHT+IFHM0ewWbvsNSK5vlnuJ9AiyyZRA0e6dLJLhvhf4Xv2wt9gEoIgp5rgcqdQd8wuNgzX5sVr4A==
X-Received: by 2002:ac8:5992:0:b0:417:a01e:e39 with SMTP id e18-20020ac85992000000b00417a01e0e39mr19150900qte.63.1696867713729;
        Mon, 09 Oct 2023 09:08:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o12-20020ac8698c000000b004179e79069asm3760527qtq.21.2023.10.09.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:08:33 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:08:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZSQlgLDv+MrYmSp8@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g>
 <ZSCR7e6KKqFv8mZk@nand.local>
 <ZSPb1OYRrQSUugtg@tanuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSPb1OYRrQSUugtg@tanuki>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 12:54:12PM +0200, Patrick Steinhardt wrote:
> In Gitaly, we usually set up quarantine directories for all operations
> that create objects. This allows us to discard any newly written objects
> in case either the RPC call gets cancelled or in case our access checks
> determine that the change should not be allowed. The logic is rather
> simple:
>
>     1. Create a new temporary directory.
>
>     2. Set up the new temporary directory as main object database via
>        the `GIT_OBJECT_DIRECTORY` environment variable.
>
>     3. Set up the main repository's object database via the
>        `GIT_ALTERNATE_OBJECT_DIRECTORIES` environment variable.

Is there a reason not to run Git in the quarantine environment and list
the main repository as an alternate via $GIT_DIR/objects/info/alternates
instead of the GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable?

>     4. Execute Git commands that write objects with these environment
>        variables set up. The new objects will end up neatly contained in
>        the temporary directory.
>
>     5. Once done, either discard the temporary object database or
>        migrate objects into the main object daatabase.

Interesting. I'm curious why you don't use the builtin tmp_objdir
mechanism in Git itself. Do you need to run more than one command in the
quarantine environment? If so, that makes sense that you'd want to have
a scratch repository that lasts beyond the lifetime of a single process.

> I wonder whether this would be a viable approach for you, as well.

I think that the main problem that we are trying to solve with this
series is creating a potentially large number of loose objects. I think
that you could do something like what you propose above, with a 'git
repacks -adk' before moving its objects over back to the main repository.

But since we're working in a single process only when doing a merge-tree
operation, I think it is probably more expedient to write the pack's
bytes directly.

> Patrick


Thanks,
Taylor
