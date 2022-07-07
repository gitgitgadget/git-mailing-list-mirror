Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D51C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 19:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiGGT7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiGGT7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 15:59:24 -0400
Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD41D0DA
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 12:59:22 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 9Xego0UB6OC4k9Xehojfwp; Thu, 07 Jul 2022 20:59:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657223960; bh=I52nVs3Q6r7fjVqqe6q4sg2y5WBuY/PkwYok+vgiKoQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=q+039vCRbJ/GmP96UAY7md95Fm+Vx4ZXx9Dq1NWOT2ngMTBTFddS70TqdfXXETmJp
         NldhnPk8Wnij3ALVUbiiJBvAsjkau8Wjxya2GR4QLJtXLFH0d/MIz8Olwu7M844izX
         MW2bxC33yp15nL2G32KMIipagEyJ/otwFbIn+hU+xrzCTvCifhHocmHUX398ozJ3GW
         EEzxePDAX2lHuDKGfj/l22ibcUFfXN+uOH4zKUdeYTU/pGp8lKw125B2FJu3wJ8uJn
         u03LSCTfCT8Sd0o/DHA2V4N2RHLunFI6ZduGBEn+4lyv46OOzLhcy3QuphdHkJm4k6
         forZ34GINjjSA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FsUWQknq c=1 sm=1 tr=0 ts=62c73b18
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=PKzvZo6CAAAA:8 a=qC85YyIROwbKi9NBaBwA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Message-ID: <ee1aa051-1c01-f525-e925-a21e63682531@ramsayjones.plus.com>
Date:   Thu, 7 Jul 2022 20:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: t0301-credential-cache test failure on cygwin
Content-Language: en-GB
To:     Jeff King <peff@peff.net>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <YsciDznU2TqzCXP4@coredump.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <YsciDznU2TqzCXP4@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAmbq6L6jLlJNn+TFPW7FByJofxMehhg5vcZ1k3F3asPYeeHcx+udTGeI4rlfLR9lY5fD15fqc5vwPR+TkYKbKRMStT+xzT1hIJNPsgrjqPJ9eNUvsJD
 p/mhdFMdSUqJX4slzDCeLMVlXso47rGE7PcywU0pFDNr4lk5B4xMxFEResghSis+X9FjXEYDFlGE6fE+HLe3lw5UCsBtT8YliyU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/07/2022 19:12, Jeff King wrote:
> On Thu, Jul 07, 2022 at 02:50:21AM +0100, Ramsay Jones wrote:
> 
>> Having deleted the above patch, I now had a look at the server side. Tracing
>> out the server execution showed no surprises - everything progressed as one
>> would expect and it 'exit(0)'-ed correctly! The relevant part of the code to
>> process a client request (in the serve_one_client() function, lines 132-142
>> in builtin/credential-cache--daemon.c) looks like:
>>
>> 	else if (!strcmp(action.buf, "exit")) {
>> 		/*
>> 		 * It's important that we clean up our socket first, and then
>> 		 * signal the client only once we have finished the cleanup.
>> 		 * Calling exit() directly does this, because we clean up in
>> 		 * our atexit() handler, and then signal the client when our
>> 		 * process actually ends, which closes the socket and gives
>> 		 * them EOF.
>> 		 */
>> 		exit(0);
>> 	}
>>
>> Now, the comment doesn't make clear to me why "it's important that we clean
>> up our socket first" and, indeed, whether 'socket' refers to the socket
>> descriptor or the socket file. In the past, all of my unix-stream-socket
>> servers have closed the socket descriptor and then unlink()-ed the socket
>> file before exit(), with no 'atexit' calls in sight (lightly cribbed from a
>> 30+ years old Unix Network programming book by Stevens - or was it the Comer
>> book - or maybe the Comer and Stevens book - I forget!).
> 
> That comment refers to the socket file. If we close the handle to the
> client before we clean up the socket file, then the client may finish
> while the socket file is still there. So anybody expecting that:
> 
>   git credential-cache exit
> 
> is a sequencing operation will be fooled. One obvious thing is:
> 
>   git credential-cache exit
>   git credential-cache store <some-cred
> 
> which is now racy; the second command may try to contact the socket for
> the exiting daemon. It might actually handle that gracefully (because
> the server wouldn't actually accept()) but I didn't check. But another
> example, and the one that motivated that comment is:
> 
>   git credential-cache exit
>   test_path_is_missing $HOME/.git-credential-cache/socket
> 
> which is exactly what our tests do. ;) See the discussion around here:
> 
>   https://lore.kernel.org/git/20160318061201.GA28102@sigill.intra.peff.net/

I have now read (much) of that thread and it makes sense now. (Yes, I probably
should have postponed sending the email until after researching some more today;
lesson learned).

[snip]
>> So, we now have three patches which 'fix' the issue. What does this tell us?
>> Well, not an awful lot! ;-)
> 
> Of the three, I actually like the client-side one to check errno the
> best. The client is mostly "best effort". If it can't talk to the daemon
> for whatever reason, then it becomes a noop (there is nothing it can
> retrieve from the cache, and if it's trying to write, then oh well, the
> cached value was immediately expired!).
> 
> So one could argue that _every_ read error should be silently ignored.
> Calling die_errno() is mostly a nicety for debugging a broken setup, but
> in normal use, the outcome is the same either way (and Git will
> certainly ignore the exit code credential-cache anyway). I prefer the
> "ignore known harmless errors" approach, possibly because I am often the
> one debugging. ;) If ECONNABORTED is a harmless error we see in
> practice, I don't mind adding it to the list (under the same rationale
> as the current ECONNRESET that is there).

Yes, I was going to ask about ECONNRESET ... heh, no I'm kidding! :)

Yeah, if we can't determine the reason for cygwin changing behaviour
here (and fix it in cygwin), then this is probably the simplest solution.

ATB,
Ramsay Jones


