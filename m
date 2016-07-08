Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C567206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 23:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbcGHXvH (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 19:51:07 -0400
Received: from imap.thunk.org ([74.207.234.97]:39684 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbcGHXvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 19:51:05 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=eRHQ/ynONGQO7+5/W6DSndfDZ0NCc/7VT24wd/IecLQ=;
	b=LV5QgXCeMYfajETh543FQpoFjmXnVZ50KloKs7MQqDNA9hfWd1QXlWS6/DGjhUQZ0TzJFG12zjsEuujlOv1u8lN0j5VU3VpArz19JFQ3KTlauVlinVoMcpzQGCirO/RVzGW8wtGkQtajcY26Ro9l3IAUJG6gwaUDNJ1e9eVws18=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bLfXr-0000HJ-0L; Fri, 08 Jul 2016 23:50:55 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 7BE0B82030B; Fri,  8 Jul 2016 19:50:53 -0400 (EDT)
Date:	Fri, 8 Jul 2016 19:50:53 -0400
From:	Theodore Ts'o <tytso@mit.edu>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160708235053.GA26097@thunk.org>
References: <20160708025948.GA3226@x>
 <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x>
 <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
 <20160708192504.GL19871@thunk.org>
 <CAPc5daWDi1P-xFaEYf1zzz7m3g9wengQPjRzxhgu6jVM9AKtyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPc5daWDi1P-xFaEYf1zzz7m3g9wengQPjRzxhgu6jVM9AKtyQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 01:30:06PM -0700, Junio C Hamano wrote:
> 
> I can imagine I'd start hacking on a project that I rarely touch, give up
> resolving a "git pull" from an unconfigured place (hence, some stuff is
> only reachable from FETCH_HEAD), and after 2*N days, come back
> to the repository and find that I cannot continue working on it.

Sure, but that's something that could happen today, and no one has
really complained, have they?

> Turning the rule to "*_HEAD we know about, and those we don't that
> are young" would not change the situation, as I may be depending on
> some third-party tool that uses its OWN_HEAD just like we use
> FETCH_HEAD in the above example.
> 
> So I dunno if that is a good solution. If we are going to declare that
> transient stuff will now be kept, i.e. keeping them alive is no longer
> end user's responsibility, then probably we should make it end user's
> responsibility to clean things up.

Well, the question is what does "transient" stuff really mean?  If we
keep them forever, then are they really any different from stuff under
refs/heads?

Maybe pester the user if there is stale *_HEAD files, but don't
actually get rid of the objects?

					- Ted

