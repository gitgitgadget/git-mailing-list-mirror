From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 11:46:34 -0500
Message-ID: <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil> <20080612041847.GB24868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 19:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6qLo-0003HB-Ef
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 19:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbYFLRLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 13:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbYFLRLq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 13:11:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46491 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbYFLRLp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 13:11:45 -0400
X-Greylist: delayed 1436 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2008 13:11:44 EDT
Received: by mail.nrlssc.navy.mil id m5CGkYuM006709; Thu, 12 Jun 2008 11:46:34 -0500
In-Reply-To: <20080612041847.GB24868@sigill.intra.peff.net>
X-OriginalArrivalTime: 12 Jun 2008 16:46:34.0513 (UTC) FILETIME=[DFBB5810:01C8CCAB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84767>

Jeff King wrote:
> On Wed, Jun 11, 2008 at 06:25:23PM -0500, Brandon Casey wrote:
> 
>> Yes, I think usually stashes are used for very short term storage. At the
>> same time, I don't expect a stash (however old) to disappear without me
>> explicitly deleting it.
>>
>> In particular, I don't want to experience this:
>>
>> $ git stash list
>> stash@{0}: WIP on master: 8c372fb... git-cvsimport: do not fail when CVS is /
>> $ git pull
>> $ git stash apply
>> fatal: Needed a single revision
>> : no valid stashed state found
> 
> Did that actually happen to you?

It has happened and that is what brought it to my attention. But I don't
remember whether I was testing reflog or gc, or whether they had reached
the expiration date naturally or not. The stashes that were lost were
not important, so the incident was enough to put the idea in the back of
my mind, but not enough for me to yell and scream. Maybe that's proof that
persistent stashes are unnecessary?, I don't know.

> Because it seems kind of unlikely to me
> that you would perform this exact sequence of events, _exactly_ 90 days
> after stashing (i.e., the 90 day period expires sometime between "git
> stash list" and "git pull"). Not to mention that you actually _care_
> about the stash 90 days later.

Wouldn't it usually be 30 days? Wouldn't stash objects generally be unreachable?

Also, the sequence above would not have to be performed _exactly_ at the
expiration date. The listing of the stashes i.e. git-log, does not perform
reflog expiration AFAIK. So the initial 'stash list' and the 'git pull' do
not have to straddle the expiration date, they can all be performed any time
after the expiration point to produce the above behavior.

> So yes, I would hate for that to happen, too. However, I think there is
> a real benefit to garbage collecting stashes, and the scenario you
> describe seems implausibly unlikely.

I really hate special cases, so special casing stashes is something I was
reluctant to do. At the same time I see stashes as something very different
from reflogs even though stashes are implemented using reflogs. The big
difference is that reflogs are created automatically and stashes are created
by explicit user action. Automatically deleting something that git creates
automatically is ok and desirable, doing so for something the user explicitly
created is not necessarily so.

Now that I have read some of my email, I see that this conversation has been
continued without me and this same point has already been made much more
elikwintlee by Wincent Colaiuta.

-brandon
