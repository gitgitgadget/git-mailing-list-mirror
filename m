Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78ACC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5F365275
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhCIAOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:14:12 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17819 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhCIAOK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:14:10 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1615248843; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QWSNVvZLPt17XzlCRrNnSlMm5Hl/uawAXpiQPTFN4C6qPUTDOL3dOUM4QjmyKwcBjjYUxAlzThCNtDziaEg7IO7RkXMLKCu/r4du/OFJlO78N6HLzGu1/zlBTxqZorLK2+MYXnTk0Sr9fIrmo8EtGHHqB2Vrdx9VAcNqWBiatIw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1615248843; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oXoFfI/JuHnQk0jRRH5EyjNkMFIvzntoJofTBuC+ZBk=; 
        b=PD4P5g34mECnpiDjo01WAUafIwu62bXUy1PlK6AGFwa48e3583av5UV8tJETjIte/FfSjH0ohDwOpt2KEl2NPCT00zDBuYmx58OcgaYBWCER8ABLh1jUlbQOm1kVXOf04p9wY6eAyx8HhFrVon3T6gsrGA/4m+9/rU6a4OvqYck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=monospace.sh;
        spf=pass  smtp.mailfrom=anthony@monospace.sh;
        dmarc=pass header.from=<anthony@monospace.sh> header.from=<anthony@monospace.sh>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=pdk; d=monospace.sh; 
  h=date:from:to:cc:message-id:in-reply-to:references:subject:mime-version:content-type:user-agent; 
  b=f3vubatgmE2ncQoGqxXCUAngNneecHLYs72VhZdO4wvNrsn5+zL2NIrMk/VuMOLk1X2vGbJ68+uK
    LKlZkIZtYdLv2/jvik95uC+5IgAGOYbOg6FRDXdGl61lRRtret/x1zmu1Sw01aRzPn3I5QgIOz51
    G6eraO9RG3B43nwyvb8=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1615248843;
        s=mdk; d=monospace.sh; i=anthony@monospace.sh;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=oXoFfI/JuHnQk0jRRH5EyjNkMFIvzntoJofTBuC+ZBk=;
        b=laqSSt9MzyJocvJSnqy4p2jOXcsWVIt642EED/rKi6a0qDh8n031vgcPGfNbpCQA
        eTK3U2A9YZX+/nETtT52RKyz9vYWfcX3xpxQquGd6dLLMq8igP0fjewm3uHwou4WgdY
        OXgSb+cgTuBh1vapwO2kkLQEt0bkKCKpIhRfEnuc=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1615248841471344.7747092593554; Mon, 8 Mar 2021 16:14:01 -0800 (PST)
Date:   Tue, 09 Mar 2021 00:14:01 +0000
From:   Anthony Muller <anthony@monospace.sh>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Bryan Turner" <bturner@atlassian.com>, "git" <git@vger.kernel.org>
Message-ID: <17814555aec.b8e46da8884253.2263161421793744939@monospace.sh>
In-Reply-To: <YEa5xe0gNDh2wZLB@camp.crustytoothpaste.net>
References: <17813b232e9.e48d03c3862272.7793967418558853913@monospace.sh>
 <CAGyf7-F6jbs-HQeCSMjf_y8Y=5ZfME=CjBagAfKUbnP_0vDXqA@mail.gmail.com> <YEa5xe0gNDh2wZLB@camp.crustytoothpaste.net>
Subject: Re: Performance of "git gc..." is extremely bad in some cases
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Brian and Bryan. You both clarified what was happening and now I know what to look for.

I can use a shallow clone for most repos, but there are some I want to keep history for. I don't need a full copy of this repo, but it was a good repo to show the issue I was facing.

Thanks again!


 ---- On Mon, 08 Mar 2021 23:56:53 +0000 brian m. carlson <sandals@crustytoothpaste.net> wrote ----
 > On 2021-03-08 at 22:29:16, Bryan Turner wrote:
 > > On Mon, Mar 8, 2021 at 1:32 PM Anthony Muller <anthony@monospace.sh> wrote:
 > > >
 > > > What did you do before the bug happened? (Steps to reproduce your issue)
 > > >
 > > > git clone https://github.com/notracking/hosts-blocklists
 > > > cd hosts-blocklists
 > > > git reflog expire --all --expire=now && git gc --prune=now --aggressive
 > > 
 > > --aggressive tells git gc to discard all of its existing delta chains
 > > and go find new ones, and to be fairly aggressive in how it looks for
 > > candidates. This is going to be the primary source of the resource
 > > usage you see, as well as the time.
 > > 
 > > Aggressive GCs are something you do once in a (very great) while. If
 > > you try this without the --aggressive, how does it look?
 > 
 > I should point out that this repository is also rather pathologically
 > structured.  Almost every commit is an automatic commit updating the
 > same five files which are text files ranging from 5 MB to 11 MB.
 > 
 > When you use --aggressive, as Bryan pointed out, you're asking to throw
 > away all the deltas and try really hard to compute all of them fresh.
 > That's going to use a lot of memory because you're loading many large
 > text files into memory.  It's also going to use a lot of CPU because
 > these files do indeed delta extremely well, and since computing deltas
 > on larger files is more expensive, especially when there are many of
 > them.
 > 
 > And that's just the blobs.  The trees and commits are also going to be
 > nearly identically structured and will also delta well with virtually
 > every other similar object of their type.  Normally Git sorts by size
 > which helps pick better candidates, but since these are all going to be
 > identically sized, the performance is going to suffer.
 > 
 > Now, I have the advantage in this case of being a person who's sometimes
 > on call for the maintenance of Git repositories and in that capacity,
 > that this is pathologically structured is obvious to me.  But, yeah, I
 > would definitely not run --aggressive on this repo unless I needed to
 > and I would not expect it to perform well.
 > -- 
 > brian m. carlson (he/him or they/them)
 > Houston, Texas, US
 > 
