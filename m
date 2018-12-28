Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D015C211BB
	for <e@80x24.org>; Fri, 28 Dec 2018 04:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbeL1EsQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 23:48:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52225 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbeL1EsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 23:48:16 -0500
Received: from carbon-x1.hos.anvin.org (c-73-170-200-15.hsd1.ca.comcast.net [73.170.200.15])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wBS4mCth2695608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 27 Dec 2018 20:48:14 -0800
Subject: Re: RFE: version-controlled merge rules
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
References: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com>
 <20181227235526.GF146609@google.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <95ca8579-4e12-1e46-8824-b1d19c6d9289@zytor.com>
Date:   Thu, 27 Dec 2018 20:48:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181227235526.GF146609@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/27/18 3:55 PM, Jonathan Nieder wrote:
> Hi,
> 
> H. Peter Anvin wrote:
> 
>> [merge "version"]
>>         name = Version file merge driver
>>         driver = sort -V -r %O %A %B | head -1 > %A.tmp.1 && mv -f %A.tmp.1 %A
> [...]
>> However, I can't even put this in .gitattributes, because doing so would break
>> any user who *doesn't* have the previous rule defined locally. Even worse, if
>> this rule needs to change, propagating it to all new users has to be done
>> manually... never mind if it needs to vary by branch!
>>
>> The simplest way to address this would presumably be to let the
>> repository/working directory contain a .gitconfig file that can contain rules
>> like that.  (Allowing it to be in the repository proper is probably a
>> requirement for merges to be handled correctly on bare repositories; I'm not
>> sure how .gitattributes is handled for that.)
> 
> The main issue I see is that this would make it a little *too* easy to
> run arbitrary code on the user's machine.  Build systems often already
> lead to that, but users are more familiar with the risks for build
> than for version control.
> 
> See [1] for some related discussion.
> 
> That said, using the include.path feature (see git-config(1)), it's
> possible to do something similar:
> 
> 	[include]
> 		path = ../.gitconfig
> 
> Thanks and hope that helps,
> Jonathan
> 

That would be great, except that it doesn't work if the worktree isn't in
"..".  This is one of many cases where it would be great to have environment
variable interpolation.

	-hpa

