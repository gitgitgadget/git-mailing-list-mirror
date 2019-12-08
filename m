Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E4C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7FF206F4
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 14:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLHO0Z convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 8 Dec 2019 09:26:25 -0500
Received: from mail.computer-surgery.co.uk ([82.69.253.61]:48329 "EHLO
        nicole.computer-surgery.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbfLHO0Z (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Dec 2019 09:26:25 -0500
X-Greylist: delayed 1138 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 09:26:25 EST
Received: from [192.168.131.253] (helo=bath.backslashat.org)
        by nicole.computer-surgery.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <rgammans@gammascience.co.uk>)
        id 1idxDa-00010b-Px; Sun, 08 Dec 2019 14:07:26 +0000
Received: from roger by bath.backslashat.org with local (Exim 4.92)
        (envelope-from <rgammans@gammascience.co.uk>)
        id 1idxDP-0004Wh-Nj; Sun, 08 Dec 2019 14:07:15 +0000
Message-ID: <0a578dce37e8802b2022df80c336f61a264a33e3.camel@gammascience.co.uk>
Subject: Re: How to determine age of HEAD commit
From:   Roger Gammans <rgammans@gammascience.co.uk>
To:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>
Date:   Sun, 08 Dec 2019 14:07:15 +0000
In-Reply-To: <956e2efe-3426-f61e-7686-5416b51931b9@iee.email>
References: <956e2efe-3426-f61e-7686-5416b51931b9@iee.email>
Organization: Gamma Science Ltd. (GB Nr. 07356014 )
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2019-12-08 at 12:09 +0000, Philip Oakley wrote:
> Is there a command that does return the numeric agedness of a commit 
> (e.g. now - commit_date, in seconds)?

Hi

I don't know a specific command for the age. But `git cat-file commit
HEAD`, will give you the commit's timestamps in seconds from the the
epoch. (Plus some timezone info).

I can construct a bash script, shown below (warning: only had the most 
rudimentary testing), which turns that into an age. For your use case
you might be better getting yesterdays unix-timestamp from date, if GNU
date is available, and directly comparing it to the commit timestamp.

------
#!/bin/bash

now=$(date +"%s")
commit=$(git cat-file commit HEAD | grep committer)
commit=${commit##*>}
commit=${commit%%+*}
echo $(( $now-$commit ))
#--------------

-- 
Roger Gammans <rgammans@gammascience.co.uk>

