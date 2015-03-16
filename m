From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Mon, 16 Mar 2015 17:33:06 +0100
Message-ID: <20150316163306.GB11832@vps892.directvps.nl>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
 <1425934575-19581-1-git-send-email-me@ikke.info>
 <xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
 <20150310225509.GA5442@vps892.directvps.nl>
 <xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
 <20150311184512.GB5442@vps892.directvps.nl>
 <xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:33:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXXx4-0002aX-8i
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 17:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbbCPQdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 12:33:09 -0400
Received: from ikke.info ([178.21.113.177]:46201 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755821AbbCPQdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 12:33:08 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 207971DCF6D; Mon, 16 Mar 2015 17:33:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265574>

On Wed, Mar 11, 2015 at 01:13:48PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > On Tue, Mar 10, 2015 at 04:12:18PM -0700, Junio C Hamano wrote:
> >
> 
> Step back and think why "git bisect --first-parent" is sometimes
> desired in the first place.
> 
> It is because in the regular bisection, you will almost always end
> up on a commit that is _not_ on the first-parent chain and asked to
> check that commit at a random place on a side branch in the first
> place. And you mark such a commit as "bad".
> 
> The thing is, traversing from that "bad" commit that is almost
> always is on a side branch, following the first-parent chain, will
> not be a useful history that "leaves out any merged in branches".
> 
> When "git bisect --first-parent" feature gets implemented, "do not
> use --first-parent with --bisect" limitation has to be lifted
> anyway, but until then, not allowing "--first-parent --bisect" for
> "rev-list" but allowing it for "log" does not buy our users much.
> The output does not give us a nice "show me which merges on the
> trunk may have caused the breakage to be examined with the remainder
> of this bisect session".
> 
> So, yes, there is a use case for "log --bisect --first-parent", once
> there is a working "bisect --first-parent", but not until then, the
> command is not useful, I would think.

Thank you for you explanation. My confusion came from incorrectly
assuming refs/bisect/bad and refs/bisect/good-* were pointing to the
initially specified good and bad commits, in which case the combination
does make sense.

I was looking in the manpages for the meaning of the bisect refs, but
could only find something about refs/bisect/bad:

git-bisect(1):
> Eventually there will be no more revisions left to bisect, and you
> will have been left with the first bad kernel revision in
> "refs/bisect/bad

So this ref changes to the bad commit.

For refs/bisect/good-*, I could only find an example snippet:

> GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*)

But it's not really clear what * might be expanded to, nor what they
mean. I guess this could use some clarrification in the documentation.

Knowing this, I agree that the combination log --bisect --first-parent
doesn't make sense either.

I will send in a new patch.

Kevin
