Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6C71FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 18:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbcLISn1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 13:43:27 -0500
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:40423 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752583AbcLISn1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2016 13:43:27 -0500
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-05v.sys.comcast.net with SMTP
        id FQ8EcCcdzGIG7FQ8kc1UNK; Fri, 09 Dec 2016 18:43:26 +0000
Received: from cherryberry.dsgml.com ([IPv6:2601:547:501:184b:22cf:30ff:fe05:22e8])
        by resomta-ch2-19v.sys.comcast.net with SMTP
        id FQ8icxDaqie4VFQ8jcjyxf; Fri, 09 Dec 2016 18:43:26 +0000
Received: from as (helo=localhost)
        by cherryberry.dsgml.com with local-esmtp (Exim 4.84_2)
        (envelope-from <asgit@dsgml.com>)
        id 1cFQ8i-0007Pv-LK; Fri, 09 Dec 2016 13:43:24 -0500
Date:   Fri, 9 Dec 2016 13:43:24 -0500 (EST)
From:   Ariel <asgit@dsgml.com>
X-X-Sender: as@cherryberry.dsgml.com
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: git add -p with new file
In-Reply-To: <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com> <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-CMAE-Envelope: MS4wfIMNlBOsryMx4yR63BVucXxrFV0m7+SUvGCb9a/Klcfx9bYQrDe9j9w9DX3J5hDdujxi4V+6isCWWYDL5AJLu1jpULD1D0JPFxjq9XWS9Go8TcFpPAyf
 GRrrqmy8XoT09h+Um4aA8sXkLJjopNLgLJfsFdT6u5Jo9FdFGW3HIGu0xm1zb9ceADlzt/9bYxkF9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, 9 Dec 2016, Jeff King wrote:

> On Tue, Dec 06, 2016 at 08:18:59PM -0500, Ariel wrote:

>> If you do git add -p new_file it says:

>> No changes.

>> Which is a rather confusing message. I would expect it to show me the
>> content of the file in patch form, in the normal way that -p works, let me
>> edit it, etc.

> What should:
[git add directory with two new files]
> do?

It should do the exact same thing that git add without -p does: Add the 
directory and both files, but because of the -p also show the diff on the 
screen and ask.

> It's contrary to the rest of git-add for specifying pathspecs to 
> actually make things _more_ inclusive rather than less.

Is it? Because git add without -p is happy to add new files.

> Historically "add -p" has been more like "add -u" in updating tracked
> files.

But it doesn't have to be that way. You could make add -p identical to add 
without options, except the -p prompts to review diffs first.

> We have "-A" for "update everything _and_ new files". It doesn't
> seem unreasonable to me to have a variant of "-p" that is similar.

That seems unnecessarily complex because -p asks about each file, so you 
will never find new files added without realizing it.

> I don't think that variant should just be "add -N everything, and then
> run add -p". As Duy points out, the patch for a new file is just one big
> block. But the decision of "do I want to start tracking this untracked
> file" is potentially an interesting one.

What makes sense to me is a two part question: First ask 'Add new path', 
and then if yes, ask to stage the hunk (where the hunk is the entire 
file).

This makes -p useful on new files, without hurting prior expectations of 
how it works.

 	-Ariel
