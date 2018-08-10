Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40ED61F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeHJVqI (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:46:08 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:34863 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeHJVqI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:46:08 -0400
Received: from [192.168.2.240] ([92.22.20.54])
        by smtp.talktalk.net with SMTP
        id oCsAfo0xXoI6LoCsBf2Uar; Fri, 10 Aug 2018 20:14:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533928496;
        bh=XNTyLVGvriFa9OYJnxSFLCFQvdi2MKzS5VWrw2P9Ohw=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LbXMdkAKfTDr7Wu9wKbn9DzXu91Ohw4x2Fb5ceBKwhzD4g0OLfVtrkXpMZWelJ0TE
         VdWM8T1rSos6Ucs66c0obUyaiNfUPbiPoh/4PeC6wp+byz8KytRTJLqVL5mC0Y8PXv
         QSzgs1zk12lCQjm/3ca/hHbZ6BaYPBzTtpgGS7a4=
X-Originating-IP: [92.22.20.54]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=cBkcwERnQO8ecD6kvs3Zjw==:117
 a=cBkcwERnQO8ecD6kvs3Zjw==:17 a=IkcTkHD0fZMA:10 a=anyJmfQTAAAA:8
 a=NEAV23lmAAAA:8 a=5rxgeBVgAAAA:8 a=nN7BH9HXAAAA:8 a=CpZgjnYw6D_ypJeXXAgA:9
 a=QEXdDO2ut3YA:10 a=YJ_ntbLOlx1v6PCnmBeL:22 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug? Git won't apply a split hunk that went through a text editor
To:     Jeff King <peff@peff.net>, Philip White <philip@mailworks.org>
Cc:     git@vger.kernel.org
References: <43C90F94-C9B8-49E4-A9E9-C1D652B52E2F@mailworks.org>
 <20180810182745.GA8876@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b487318b-0746-e00b-f088-bfc5bd086ed5@talktalk.net>
Date:   Fri, 10 Aug 2018 20:14:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180810182745.GA8876@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEbTmMtZZYXAYyZkfKsYTvc1KoXS/bWEgUwmf9zQ29EAzOnoAxb/K4Ev+R6dxcdPraupEnkHCnyfdU7ICOgjQzRxAhsaiqR5H4XPncjEDlJbvQz94L+f
 bhXaVP2dO0XTUi7H9OnXBmQLUIdDOF3WuHcnMW5b47h6WvlEYJGn7tlvIGMb2bTVW2Va+/THPeJQluxPGo38eP+z/q/OpANHd6sWVLb3WpiAsrP1ACEmH865
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip

Thanks for CC'ing me Peff.

On 10/08/18 19:27, Jeff King wrote:
> On Thu, Aug 09, 2018 at 08:17:36PM -0700, Philip White wrote:
> 
>> I’d like to report what I suspect is a bug in Git, tested in 2.18 and
>> 2.14. (I’d be delighted to be corrected if it is my own
>> misunderstanding.) I’m reporting it here based on guidance from
>> https://git-scm.com/community.
>>
>> I created a minimal testcase with a detailed README here:
>> https://github.com/philipmw/git-bugreport-2018-hunk-fail
>>
>> Overview of the bug:
>>
>> When interactively selecting hunks to apply, using `git checkout -p
>> <tree> <file>`, git will correctly apply an unmodified hunk, but will
>> refuse to apply a hunk that went through a text editor ("e" command),
>> even when I made no changes in the text editor.
>>
>> Thanks for any advice or attention you can give to this matter.
> 
> This sounds like the bug discussed in:
> 
>    https://public-inbox.org/git/be321106-2f10-e678-8237-449d2dd30fee@talktalk.net/

Looking at the bug report Philip linked to I think this is a long 
standing bug where splitting a patch and then editing one of the 
subhunks can fail because git-add--interactive.perl doesn't know how to 
stitch the subhunks back together when one of them has been edited. 
There's a failing test in t3701-add-interactive.sh to document this. It 
is on my radar to fix this (at least in simple cases) but I haven't got 
round to it yet.

Thanks Philip for the detailed report

Best Wishes

Phillip


> (that message and the surrounding thread).
> 
> The fix is in f4d35a6b49 (add -p: fix counting empty context lines in
> edited patches, 2018-06-11), which is in the current tip of 'master',
> but not yet any released version.
> 
> -Peff
> 

