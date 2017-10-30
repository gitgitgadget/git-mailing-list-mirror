Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB26202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbdJ3Cvh (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 22:51:37 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51322 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdJ3Cvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:51:36 -0400
Received: by mail-wm0-f53.google.com with SMTP id b9so13456230wmh.0
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 19:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KstTmCA9TSvYIxhGWn95RQ5XI9pBtSN1I+33UPRcWrk=;
        b=M4LO3YM/aSyRdGnk0BrbRF9tG/s15K61kiIV0VAVOiv6iIlFHJ5MSIc88XWprcoCjV
         IcaIJWDipVuptYE6MWlgWOYZH4p714JAocQAT7DQtT1zJQal25F+zQ9dQ6nYa2Sb++Hh
         lPXn0LhMtkKfMe1uMoOExQ59T43lJ9QcYlyeCETG2osvM0F2kNADcbMPg9nU9u1OCWRo
         /viRtBSptDvlT/lE4/9IPz8gpWOpdNV73+DMmeTzU+G1bG2TfBKmPDcUp+COUCQjrujF
         W1NoCI0pX7d+oOPzahd9r/eBHULDNQCDlHEMqPjCDA3NOPffOwejvuq+QtPRIj8yvxkK
         cNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KstTmCA9TSvYIxhGWn95RQ5XI9pBtSN1I+33UPRcWrk=;
        b=mo1t9+gOT3XrBZGAy7mZdCq3d3Vls/yCrILaAEAzmBlE6Ense9GifwkaqWW2oBNUx5
         DXmN5/ZCeb9W+bFFpZY13F3iJsIL9b4YpqR2oQjbKdNJzrEhtvhfHWzDbdjkjUA4klJ2
         7E2IP0RlkW8fXwWLoRqhgM8lLIyjUI2vD7/9k+x8vb2xBrbLqM1A2DPBjtnM39p9Lf0/
         QDgdgudUDIywOhJoA96JE7p+BFid9OETRhHepHHQwb27FPUNCLmX9oNMxXKVOnUI3cBe
         Ohm4IdMF9ryxrCFLNcYmuD8/r+3zGDbKZHwXkOYKZLFCOg2FD3y5i3Z4HrRWfLRittcy
         21DQ==
X-Gm-Message-State: AMCzsaVoDxTulDMKpU86exu9Evs3MfgwEEs8D+/YKIDbe3tEApK4wgP0
        v0q2AUOCNmmocEPsfc+1hCZ+cJ+065aXweg5iP8=
X-Google-Smtp-Source: ABhQp+Qey2qsBv7oR2Qe+ThWgqAe7nXqm8ff8cCETofJfCsp58S0N8H5//mC4ZcVMFlhrI63MWAAIOR8KVE+7R4j0YA=
X-Received: by 10.80.172.122 with SMTP id w55mr9820697edc.293.1509331895271;
 Sun, 29 Oct 2017 19:51:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Sun, 29 Oct 2017 19:51:14 -0700 (PDT)
In-Reply-To: <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net>
References: <20171028000152.2760-1-jacob.e.keller@intel.com>
 <alpine.DEB.2.21.1.1710281740070.6482@virtualbox> <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 29 Oct 2017 19:51:14 -0700
Message-ID: <CA+P7+xrUeM-TsXrbOxscqaqCJB+wq2NP-TdnxzvA7n4vQXvOxQ@mail.gmail.com>
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 11:34 AM, Phillip Wood
<phillip.wood@talktalk.net> wrote:
>
> Just clearing GIT_DIR does not match the behavior of the shell version
> (tested by passing -p to avoid rebase--helper) as that passes GIT_DIR to
> exec commands if it has been explicitly set. I think that users that set
> GIT_DIR on the command line would expect it to be propagated to exec
> commands.
>
> $ git rebase -px'echo $GIT_DIR' @
>
>                                                             Merge commit
> '7c2f1abd64' into phil
> Executing: echo $GIT_DIR
>
> Successfully rebased and updated refs/heads/phil.
>
> $ env GIT_DIR=.git git rebase -px'echo $GIT_DIR' @
>
>                                                             Merge commit
> '7c2f1abd64' into phil
> Executing: echo $GIT_DIR
> /home/phil/Documents/src/git/.git/worktrees/git-next
> Successfully rebased and updated refs/heads/phil.
>

I'm not really sure what the exact fix is, since we do want to pass in
GIT_DIR if it was passed to us, but maybe it needs to be an absolute
path?

Thanks,
Jake
