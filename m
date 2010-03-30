From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/2] refs.c: Write reflogs for notes just like for branch heads
Date: Tue, 30 Mar 2010 20:00:35 +0200
Message-ID: <201003302000.35616.johan@herland.net>
References: <d6c334ec855bf04d9edb432b9cdc3590ab96d6e9.1269867675.git.git@drmicha.warpmail.net> <201003291625.22977.johan@herland.net> <20100330171932.GE17763@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 20:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwflQ-00079S-Bo
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 20:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab0C3SB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 14:01:57 -0400
Received: from smtp.opera.com ([213.236.208.81]:51335 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754910Ab0C3SB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 14:01:57 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o2UI0Z61009183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Mar 2010 18:00:36 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20100330171932.GE17763@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143585>

On Tuesday 30 March 2010, Jeff King wrote:
> On Mon, Mar 29, 2010 at 04:25:22PM +0200, Johan Herland wrote:
> > > This is actually inspired by Jeff's novel notes use. I think
> > > there are use cases where a notes log makes sense (notes on
> > > commits) and those where it does not (metadata/textconv). In both
> > > cases having a reflog is useful. So, the next step is really to
> > > allow notes trees without history, which also takes care of the
> > > pruning issue. I know how to do this, I just have to decide about
> > > the configuration options.
> >
> > I noticed that Jeff's proof-of-concept wrote notes trees without
> > making notes commits, and although it seemed like a bug at first,
> > it does - as you say - provide a rather nice way to store notes
> > trees without history.
>
> No, it was very much intentional.
>
> However, I think the next iteration will wrap the tree in an actual
> commit, but just keep each commit parentless. That will provide a
> nice spot for metadata like the cache validity information.

Agreed.

> I like the idea of having a reflog, just because you could use it to
> salvage an old cache if you were playing around with your helper's
> options (or debugging your helper :) ). The usual 90-day expiration
> time is perhaps too long, though.

Yes, 90 days as a default might be excessive, but you can always 
override it with a "git gc --prune=now"...

> > Note that I haven't explicitly designed the notes feature with this
> > in mind, so it's wise to add testcases for expected behaviour once
> > we start use history-less notes trees.
> >
> > Thinking about it, the notes code itself (notes.h/.c) only wants a
> > notes _tree_ object, so will probably work fine with history-less
> > notes trees. But builtin/notes.c with its public commit_notes()
> > function may be another story...
>
> I was planning on using my own cache-specific helper instead of
> commit_notes() anyway, so that shouldn't be a problem. By using a
> commit wrapper, I don't think any of the display code should be
> confused (since they need to handle the case of a root note commit
> anyway). Once I have some example trees, I can poke at them with the
> existing notes code and see how they behave (and how we _want_ them
> to behave, since I'm not sure yet what sort of cache introspection,
> if any, would be useful).

Looking forward to your patches. :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
