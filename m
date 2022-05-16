Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CE1C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 07:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiEPHdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 03:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiEPHdw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 03:33:52 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 00:33:50 PDT
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085BB2315E
        for <git@vger.kernel.org>; Mon, 16 May 2022 00:33:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 212D0160122;
        Mon, 16 May 2022 00:28:18 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BzhgLVdxcqj3; Mon, 16 May 2022 00:28:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 5EF5316012F;
        Mon, 16 May 2022 00:28:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CFsyhCDiHoDI; Mon, 16 May 2022 00:28:17 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 2F209160126;
        Mon, 16 May 2022 00:28:17 -0700 (PDT)
Message-ID: <e89577f8-8f52-bf09-15f3-c534bf1a6c64@cs.ucla.edu>
Date:   Mon, 16 May 2022 00:28:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Carlos L." <00xc@protonmail.com>,
        GNU grep developers <grep-devel@gnu.org>
References: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com>
 <xmqqilq658b3.fsf@gitster.g>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: [PATCH] grep: add --max-count command line option
In-Reply-To: <xmqqilq658b3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/22 22:57, Junio C Hamano wrote:

> It indeed is curious why GNU grep chose to immediately exit with 1
> when "-m 0" was given,

As I vaguely recall, if "-m 1" stops before "-m 2" does, then the idea 
was that it's reasonable for "-m 0" to stop before "-m 1" does, and the 
logical place to stop is right at the start, before any matches are 
found (i.e., exit with status 1).

What would be more useful for 'grep -m 0' to do? (Sorry, I came into 
this conversation just now.) Perhaps GNU 'grep -m 0' should change, if 
there's something better for it to do.


> What "git grep -m -1" should do?  IIRC, OPT_INTEGER is for signed
> integer but the new .max_count member, as well as the existing
> "count" that is compared with it, are of "unsigned" type.  Either
> erroring out or treating it as unlimited is probably fine, but
> whatever we do, we should document and have a test for it.

'grep -m -1' treats the count as being unlimited, but this isn't 
documented and (from the code) appears to be accidental. It'd make sense 
for it to be documented.
