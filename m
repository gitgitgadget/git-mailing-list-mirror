Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0A820248
	for <e@80x24.org>; Fri, 12 Apr 2019 22:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDLWiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 18:38:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34414 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLWiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 18:38:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so5807058pfd.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zjrtflr7D6RvQDPbJdLng37VVu0J/NuN0TjvWM8PSZQ=;
        b=Fk4D36TNYvkFxVB7AN1d0lr4uZkh8T/opRxQ+afYeNoh6SPo2/NceOeduDgiwemIha
         tnjtR4o3Q7Z+fPSdJQcxw1Ijm/lsEkN06CSupLDd9Fteh/HEM4e0GYlm+E+FpVCYztTU
         kmW0cFMsEa5nLqc/EM0SnEKHpgpEcoCT1nkN/WWMbyRQeCfZosiCKqCHATsNUIyvXm/h
         q21Q6KWVjipiCq2jC8HOfVISiUmfDgLqR6LpFWg7PeSlS5aZ4Tnxx9OjfBqw0stfGFGZ
         CLP9oV4rNfTrLul+MKn1lZeEovWQPyk97yRqGugwbLN8d2I/rWIAWBKp7DHFFAMQtdUH
         pvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Zjrtflr7D6RvQDPbJdLng37VVu0J/NuN0TjvWM8PSZQ=;
        b=dFx9/MwxM00dgLCzVDlV9IY3lSfm6USHxqbRj5sCdZXor4PNYyz98mb4Oz/MOHYuEM
         z6yVZYoHi00KPcgvGFpaf9edDdngUOfQBbplbYlwJGUtBzF/Rz8u7LLFkBqdg9j/4vSW
         XwNcRVdeazXqD8azYGkwJvfyOd8EQZML/ppwg4oCPm3WI/oHqPquGPUWdUun5BrxmHL2
         r4tw7jMsmQikII7qnq2/b3rcv3MoZL+6Qnx/OAWQtpzGzhLWySEQqS09lWCxgaMBIHlV
         Kd6eIclBp2RTx5efq3X1iCd3cM9j9PcSIyuPwwdcaLDBNrS8+JaEuA9jH2Yw59mzLSKv
         BoCg==
X-Gm-Message-State: APjAAAWGIfUZ+LTdeKj5ec4URWVdQBNUmhUx9tf1TVZBBUX7pc3POdpD
        fxCXK4qKG7xkjNMrdFU9ZoghUw==
X-Google-Smtp-Source: APXvYqygwWUce4bfccmgX1KflBNxKP8HaXmenpsW8+dUB82/pOTbdpqL/bppxJ+LmK4IXrXPdLq3hA==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr54010383pfo.20.1555108733922;
        Fri, 12 Apr 2019 15:38:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id t9sm7676727pgp.66.2019.04.12.15.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 15:38:52 -0700 (PDT)
Date:   Fri, 12 Apr 2019 15:38:47 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
Message-ID: <20190412223847.GO60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
 <20190409180418.GH8796@szeder.dev>
 <20190409234255.GM60888@google.com>
 <20190411040642.GA8418@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411040642.GA8418@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.11 00:06, Jeff King wrote:
> On Tue, Apr 09, 2019 at 04:42:55PM -0700, Josh Steadmon wrote:
> 
> > >   warning: reflog of 'HEAD' references pruned commits
> > >   warning: reflog of 'refs/heads/master' references pruned commits
> > >   fatal: unable to read 71905dfcd543b7cbb0b4b66fbd20379e67220557
> > >   error: last command exited with $?=128
> > >   not ok 23 - repack -d does not irreversibly delete promisor objects
> > > 
> > 
> > Thank you for catching this. I haven't yet figured out the cause. I will
> > look into this more tomorrow and then send a V4 once I've fixed it.
> 
> I'm concerned that this is a sign that the approach I suggested does not
> actually work everywhere. I.e., could this be a case where we have some
> non-promisor object that points to a sub-object that is reachable from
> the promisor pack, but not a direct tip? Before your patch we'd consider
> that sub-object a promisor (because we enumerate all of the graph that
> we do have and mark each such object), but afterwards we would not.
> 
> And I wonder if that confuses pack-objects. Though I think it would
> confuse it in the _opposite_ direction. I.e., using
> --exclude-promisor-objects would count such an object as not-a-promisor
> and would be more inclined to include it in the new pack.
> 
> It is curious that this only turns up with GIT_TEST_COMMIT_GRAPH=1, too.
> It seems like any such problem ought to be independent of that.
> 
> Puzzling...
> 
> -Peff

Do you think this justifies going back to the V1 approach (only checking
presence of objects pointed to by refs when doing a partial clone)?
