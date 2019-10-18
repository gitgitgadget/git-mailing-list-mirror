Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323111F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 19:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505765AbfJRTPd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 15:15:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57928 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394833AbfJRTPd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 15:15:33 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9IJEu32003509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 15:14:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1F67B420458; Fri, 18 Oct 2019 15:14:56 -0400 (EDT)
Date:   Fri, 18 Oct 2019 15:14:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018191456.GI21137@mit.edu>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018161547.GG21137@mit.edu>
 <de49fe5e-85cb-9fb0-f9f4-c294d72e356c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de49fe5e-85cb-9fb0-f9f4-c294d72e356c@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 06:50:51PM +0200, Vegard Nossum wrote:
> I started out using this approach, but I changed it because the
> implementation was a bit annoying: 'git am' runs 'git mailsplit',
> which just splits the email into two parts:
> 
> 1) headers, changelog, and diffstat;
> 2) diff and signature.
> 
> One of my PoC patches changes mailsplit to split the extra metadata into
> a third file.
> 
> The problem I ran into with putting the metadata at the end was
> detecting where the diff ends. A comment in 'git apply' suggested that
> detecting the difference between "--" as a diff/signature separator and
> as part of the diff is nontrivial in the sense that you need to actually
> do some parsing and keep track of hunk sizes.

Could we cheat by having "git format-patch" add a "Diff-size" in the
header which gives the number of lines in the diff so git am can just
count lines to find the Trailer section?

Thanks,

					- Ted
