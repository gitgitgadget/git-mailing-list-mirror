From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Tue, 1 Nov 2011 18:39:17 -0400
Message-ID: <20111101223917.GG32161@thunk.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Tue Nov 01 23:39:25 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RLMzM-0001pr-IG
	for lnx-linux-ide@lo.gmane.org; Tue, 01 Nov 2011 23:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1KAWjX (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Tue, 1 Nov 2011 18:39:23 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:48895 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887Ab1KAWjW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2011 18:39:22 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RLMzF-0003vg-Df; Tue, 01 Nov 2011 22:39:17 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RLMzF-0000F9-Ow; Tue, 01 Nov 2011 18:39:17 -0400
Mail-Followup-To: Ted Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184602>

On Tue, Nov 01, 2011 at 02:21:59PM -0700, Linus Torvalds wrote:
> So I'm wondering if we want to save it at all. it's quite possible
> that realistically speaking "google the mailing list archives" is the
> *right* way to look up the signature if it is ever needed later.

Given the number of trees that you merge in every merge window (never
mind over an entire release), I don't think "google the mailing list
archives" is going to scale.  Finding some way to keep it along with
the merge window seems the right thing.  I agree that it should hidden
normally, but that's a UI display issue.  Heck, we could just hide
after the terminating NULL in the commit description, per a discussion
on the git list 2-3 weeks ago.  :-)

> Because in many ways, "git request-pull" is when you do want to sign
> stuff. A developer might well want to push out his stuff for some
> random internal testing (linux-next, for example), and then only later
> decide "Ok, it was all good, now I want to make it 'official' and ask
> Linus to pull it", and sign it at *that* time, rather than when
> actually pushing it out.

Sure, the signed content should be buried in the commit that it
describes.  Whether we carry it in an emphemeral tag or in the git
request-pull is not really important from a security perspective.  The
tag is nicer simply because the person doing the pull won't need to
cut and paste the signature information.

One approach which might work is if git request-pull sends the e-mail
message with the git shortlog and diffstat, *and* an MIME attachment
that contained all of the necessary information.  The maintainer would
then save the attachment, and feed it to git, which will display the
git shortlog and diffstat, ask for confirmation, and then embed the
digital signature into the merge commit.

The only problem with that is (a) you'd have to get over your hatred
of attachment (but if you're using Gmail hopefully that's relative
convenient :-), and (b) LKML list filter would have to be taught to
tolerate git-generated attachments.

						- Ted
