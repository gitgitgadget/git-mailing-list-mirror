Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251DE1F406
	for <e@80x24.org>; Sun, 13 May 2018 21:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeEMVCf (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 17:02:35 -0400
Received: from ikke.info ([178.21.113.177]:57540 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbeEMVCf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 17:02:35 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A80C14400D0; Sun, 13 May 2018 23:02:33 +0200 (CEST)
Date:   Sun, 13 May 2018 23:02:33 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Dannier Castro L <danniercl@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Matthieu.Moy@imag.fr,
        jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
Message-ID: <20180513210233.GA18892@alpha>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 08:23:32PM -0600, Dannier Castro L wrote:
> Currently, <checkout> is a complex command able to handle both
> branches and files without any distintion other than their names,
> taking into account that depending on the type (branch or file),
> the functionality is completely different, the easier example:
> 
> $ git checkout <branch>  # Switch from current branch to <branch>.
> $ git checkout <file>    # Restore <file> from HEAD, discarding
>                          # changes if it's necessary.
> $ git checkout -- <file> # The same as the last one, only with an
>                          # useless '--'.
> 
> For GIT new users, this complicated versatility of <checkout> could
> be very confused, also considering that actually the flag '--' is
> completely useless (added or not, there is not any difference for
> this command), when the same program messages promote the use of
> this flag.
> 
> Regarding the <checkout>'s power to overwrite any file, discarding
> changes if they exist without some way of recovering them, the
> solution propuses that the usage of '--' is strict before to
> specify the file(s) path(s) for any <checkout> command (including
> all types of flags), as a "defense barrier" to make sure about
> user's knowledge and intension running <checkout>.
> 
> The solution consists in detect '--' into command args, allowing
> the discard of changes and considering the following names as
> file paths, otherwise, they are branch names.
> 
> Signed-off-by: Dannier Castro L <danniercl@gmail.com>

One data point indicating this is giving issues is that today on IRC a
user was confused why `git checkout pt` did not show any message and did
not checkout a remote branch called 'pt' as they expected. It turned out
they also had a local file/dir called 'pt', which caused git to checkout
that file/dir rather than creating a local branch based on the remote
branch.

Kevin
