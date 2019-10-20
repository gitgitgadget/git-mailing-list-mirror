Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418B01F4C3
	for <e@80x24.org>; Sun, 20 Oct 2019 03:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfJTDRd (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 23:17:33 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:64605 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJTDRd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 23:17:33 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x9K3HGFR017485;
        Sun, 20 Oct 2019 05:17:16 +0200
Date:   Sun, 20 Oct 2019 05:17:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Santiago Torres Arias <santiago@nyu.edu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191020031716.GA17475@1wt.eu>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018161547.GG21137@mit.edu>
 <de49fe5e-85cb-9fb0-f9f4-c294d72e356c@oracle.com>
 <20191018191456.GI21137@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018191456.GI21137@mit.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 03:14:56PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Oct 18, 2019 at 06:50:51PM +0200, Vegard Nossum wrote:
> > The problem I ran into with putting the metadata at the end was
> > detecting where the diff ends. A comment in 'git apply' suggested that
> > detecting the difference between "--" as a diff/signature separator and
> > as part of the diff is nontrivial in the sense that you need to actually
> > do some parsing and keep track of hunk sizes.
> 
> Could we cheat by having "git format-patch" add a "Diff-size" in the
> header which gives the number of lines in the diff so git am can just
> count lines to find the Trailer section?

Be careful with this, it starts like this and ends up with non-editable
patches. I'd rather have git-am use best-effort detection of the end.
Also when dealing with stable backports, I've done a lot of
"cat foo.diff >> bar.patch" to fixup some patches in which I just had
to move some parts around. Having to count lines and edit a counter
somewhere is going to become really painful.

Just my two cents,
Willy
