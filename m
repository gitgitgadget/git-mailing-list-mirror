Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DA220193
	for <e@80x24.org>; Wed,  2 Nov 2016 14:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755413AbcKBOH5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 10:07:57 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:49437 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754544AbcKBOH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 10:07:56 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id uA2E7ncN001865;
        Wed, 2 Nov 2016 17:07:50 +0300
Date:   Wed, 2 Nov 2016 17:07:49 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: RFE: Discard hunks during `git add -p`
Message-Id: <20161102170749.eb04d1892fdf404bb5b2851d@domain007.com>
In-Reply-To: <alpine.LSU.2.20.1611021435280.21207@nerf40.vanv.qr>
References: <alpine.LSU.2.20.1611021435280.21207@nerf40.vanv.qr>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2 Nov 2016 14:46:04 +0100 (CET)
Jan Engelhardt <jengelh@inai.de> wrote:

> Current version: 2.10.2
> Example workflow:
> 
> * I would do a global substitution across a source tree, e.g. `perl
> -i -pe 's{OLD_FOO\(x\)}{NEW_BAR(x, 0)}' *.c`
> * Using `git add -p`, I would verify each of the substitutions that
> they make sense in their respective locations, and, based on that,
>   answer "y" or "n" to the interactive prompting to stage good hunks.
> * When done with add-p, I would commit the so-staged hunks,
>   and then use `git reset --hard` to discard all changes that were 
>   not acknowledged during add-p.
> 
> Being able to discard hunks (reset working copy to index contents) 
> during add-p would alleviate the (quite broad) hard reset.

Couldn't you just do

  git checkout -- .

after staging your approved changes?

To selectively zap uncommitted changes from your working tree, you could
do

  git checkout --patch -- .


I'm not sure overloading `git add` with a "reverse" action is a good
idea.  I'm actually prefer pragmatism over conceptual purity but I'm
not sure the prospective gain here is clear.
