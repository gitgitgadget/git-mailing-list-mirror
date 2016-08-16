Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D3B1FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 10:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbcHPKGr (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 06:06:47 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:55008 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928AbcHPKGq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2016 06:06:46 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 77F10232CC;
	Tue, 16 Aug 2016 11:06:44 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id 7007433D7;
	Tue, 16 Aug 2016 11:06:44 +0100 (BST)
X-Quarantine-ID: <2RcOHHc-n3_G>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2RcOHHc-n3_G; Tue, 16 Aug 2016 11:06:40 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.10])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id EC42F33E5;
	Tue, 16 Aug 2016 11:06:33 +0100 (BST)
Date:	Tue, 16 Aug 2016 11:06:33 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org,
	larsxschneider@gmail.com, me@jnm2.com
Subject: Re: [PATCH v2] help: make option --help open man pages only for Git
 commands
Message-ID: <20160816100633.be55qsbnlmlm37dr@john.keeping.me.uk>
References: <20160812201011.20233-1-ralf.thielow@gmail.com>
 <20160815053628.3793-1-ralf.thielow@gmail.com>
 <D954CB3E6C3445AF9358C6941362B69D@PhilipOakley>
 <xmqqr39phq3c.fsf@gitster.mtv.corp.google.com>
 <C8DDA334A45E4B558FD1EFB191E047C9@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8DDA334A45E4B558FD1EFB191E047C9@PhilipOakley>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 09:40:54PM +0100, Philip Oakley wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
> > "Philip Oakley" <philipoakley@iee.org> writes:
> >
> >> I'm still not sure this is enough. One of the problems back when I
> >> introduced the --guides option (65f9835 (builtin/help.c: add --guide
> >> option, 2013-04-02)) was that we had no easy way of determining what
> >> guides were available, especially given the *nix/Windows split where
> >> the help defaults are different (--man/--html).
> >>
> >> At the time[1] we (I) punted on trying to determine which guides were
> >> actually installed, and just created a short list of the important
> >> guides, which I believe you now check. However the less common guides
> >> are still there (gitcvs-migration?), and others may be added locally.
> >
> > I think we should do both; "git help cvs-migration" should keep the
> > same codeflow and behaviour as we have today (so that it would still
> > work), while "git cvs-migration --help" should say "'cvs-migration'
> > is not a git command".  That would be a good clean-up anyway.
> >
> > It obviously cannot be done if git.c::handle_builtin() does the same
> > "swap <word> --help to help <word>" hack, but we could improve that
> > part (e.g. rewrite it to "help --swapped <word>" to allow cmd_help()
> > to notice).  When the user said "<word> --help", we don't do guides,
> > when we swapped the word order, we check with guides, too.
> >
> The other option is to simply build a guide-list in exactly the same format 
> as the command list (which if it works can be merged later). Re-use the 
> existing code, etc.

One nice thing at the moment is that third-party Git commands can
install documentation and have "git help" work correctly (shameless plug
for git-integration[1] which does this).  I think Junio's suggestion
above keeps that working whereas having a hardcoded list of guides will
break this.

[1] https://github.com/johnkeeping/git-integration
