Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4C01F576
	for <e@80x24.org>; Mon, 22 Jan 2018 05:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbeAVFkf (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 00:40:35 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39290 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbeAVFke (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 00:40:34 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 784401F576;
        Mon, 22 Jan 2018 05:40:34 +0000 (UTC)
Date:   Mon, 22 Jan 2018 05:40:34 +0000
From:   Eric Wong <e@80x24.org>
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     git@vger.kernel.org
Subject: Re: git svn clone - Malformed network data: The XML response
 contains invalid XML: Malformed XML: no element found at
 /usr/share/perl5/vendor_perl/5.26/Git/SVN/Ra.pm line 312
Message-ID: <20180122054034.GA9759@starla>
References: <042F7DAF79EF4C29B85958BD75AE019F@blackfat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <042F7DAF79EF4C29B85958BD75AE019F@blackfat>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Pyeron <jpyeron@pdinc.us> wrote:
> 
> I am asuming that this is an issue caused by codeplex's svn
> from tfs implementation. Does anyone here have any insight?

Seems like it, even using svn(1) fails (see below)

> r27599 = 9e769d8327767a155d7b96b7cc28579cf0ed4c93 (refs/remotes/git-svn)
> Malformed network data: The XML response contains invalid XML: Malformed XML: no element found at /usr/share/perl5/vendor_perl/5.26/Git/SVN/Ra.pm line 312.

OK, so lets find out what the next commit is after r27599:

  svn log -v -r 27599:HEAD https://smtp4dev.svn.codeplex.com/svn

  # which tells me r27864

  svn diff -r 27599:27864 https://smtp4dev.svn.codeplex.com/svn
  # which tells me:
  svn: E130003: The XML response contains invalid XML

strace only shows encrypted data, so maybe there's a flag or
debug option you can enable in SVN itself to see what was in the
bad XML or maybe contact the admin to see if it can be fixed.
