Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986392021E
	for <e@80x24.org>; Tue, 15 Nov 2016 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932333AbcKOS1W (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 13:27:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55604 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753793AbcKOS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 13:27:18 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 02BF12021E;
        Tue, 15 Nov 2016 18:27:17 +0000 (UTC)
Date:   Tue, 15 Nov 2016 18:27:17 +0000
From:   Eric Wong <e@80x24.org>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
Message-ID: <20161115182717.GA5162@starla>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
 <20161115010356.GA29602@starla>
 <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:
> > On 15 Nov 2016, at 02:03, Eric Wong <e@80x24.org> wrote:
> 
> > Anyways, I'll plan on doing something similar (in Perl) with the
> > synchronous parts of public-inbox which relies on "cat-file --batch"
> > at some point... (my rotational disks are sloooooooow :<)
> 
> That sounds interesting! What changes to you have in mind for 
> "cat-file --batch"? We are thinking about performance improvements
> in that area, too. I would be happy to help reviewing your patches!

I'm not touching "cat-file --batch" itself, just the Perl code
that uses it.  (still trying my best to avoid working on C or
any compiled languages);

There'll probably be a Perl queue mechanism so there's still
only one cat-file process running per-inbox to avoid overloading
on seeks; but the Perl daemons should be able to handle network
duties and other in-memory operations while it waits for
cat-file.
