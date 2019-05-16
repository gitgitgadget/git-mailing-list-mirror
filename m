Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2760F1F461
	for <e@80x24.org>; Thu, 16 May 2019 22:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfEPWCQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 18:02:16 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41862 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfEPWCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 18:02:16 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hROS2-0002ba-6O; Fri, 17 May 2019 07:02:10 +0900
Date:   Fri, 17 May 2019 07:02:10 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Closing fds twice when using remote helpers
Message-ID: <20190516220210.6abbye45p6yt5dol@glandium.org>
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
 <87bm04vt81.fsf@evledraar.gmail.com>
 <b6ff2486-a1c2-4e89-4338-9e4e56d528bc@kdbg.org>
 <20190515220834.svurujspjt3bmath@glandium.org>
 <20190515235339.GA3579@sigill.intra.peff.net>
 <20190516004802.fmtdz52xxcplkgcf@glandium.org>
 <20190516032802.GB4596@sigill.intra.peff.net>
 <20190516083519.5n6qmdw2aaqhjudd@glandium.org>
 <20190516214752.GE10787@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516214752.GE10787@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 05:47:52PM -0400, Jeff King wrote:
> On Thu, May 16, 2019 at 05:35:19PM +0900, Mike Hommey wrote:
> 
> > On Wed, May 15, 2019 at 11:28:02PM -0400, Jeff King wrote:
> > > Totally orthogonal, but I think we might also want to introduce a helper
> > > capability so that import helpers can say "I always send 'done' to
> > > fast-import". And then we can pass "--done" to fast-import, which means
> > > it would detect a truncated stream.
> > 
> > Doubly orthogonal, but I wouldn't mind a helper capability that allows
> > import helpers to deal with creating git objects on their own rather
> > than having a fast-import spawned (git-cinnabar actually doesn't use the
> > fast-import stream it's offered to use, but can't be a fetch helper
> > either)
> 
> Yeah, while writing that I definitely thought "Gee, wouldn't it be
> easier if the importer was just responsible for running fast-import
> itself?".
> 
> What makes it impossible to run as a normal fetch-helper? Is it that we
> expect the helper to then report back the refs for us to update?
> 
> So I take it your strategy is to just run your own fast-import, and then
> you just pass along EOF with no input to the one that Git runs, to
> signal that you're done importing? So maybe the right capability is to
> let the helper say "by the way, I don't need you to run fast-import for
> me". But it's probably not that big a deal, since it's just wasting an
> extra process startup.

When it received the "import" command, git-cinnabar does its stuff,
creates the namespaced refs it advertized in its response to
"capabilities", and writes "done". That's all. So in fact, the current
setup, without --done passed to fast-import, just works.

Mike
