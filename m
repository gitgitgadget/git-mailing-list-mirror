From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Thu, 4 Mar 2010 07:55:23 +0100
Message-ID: <201003040755.23485.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org> <201003040306.16580.chriscool@tuxfamily.org> <7vhbowoj8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 07:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn4yn-00072F-Fb
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 07:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab0CDG4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 01:56:12 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53906 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab0CDG4K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 01:56:10 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 596CA818064;
	Thu,  4 Mar 2010 07:55:59 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E70E68180EC;
	Thu,  4 Mar 2010 07:55:56 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vhbowoj8y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141514>

On Thursday 04 March 2010 04:31:25 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > I tried to use the checkout_fast_forward() function from builtin/merge.c
> > but unfortunately it doesn't work. It gives an error like that in the
> > tests :
> >
> > error: Your local changes to 'file1' would be overwritten by merge. 
> > Aborting. Please, commit your changes or stash them before you can merge.
> >
> > and I don't really understand why. (Though I didn't spend a lot of time
> > on this.)
> 
> Shouldn't it be something like this?  The patch is still unnecessarily
> large because I wanted to share options between revert and cherry-pick
> while giving --ff only to cherry-pick, but I don't understand why it needs
> a nine patch series worth of code churn.

Please have another look at the patch series and realize that only the first 4 
patches are (trivial) refactoring (that you call "code churn"), so I think 
it's not fair at all to say that it's "a nine patch series worth of code 
churn".

And it used to be accepted to do some refactoring, and IMHO some reasonable 
amount of refactoring is good, as long as it is well done of course. So there 
is no problem if you criticize the amount in term of line of codes or if you 
criticize the quality of refactoring. But I don't think the patch count is 
right metric (especially when applied to the whole series).

> +static int fast_forward_to(const unsigned char *to, const unsigned char
>  *from) +{
> +	struct ref_lock *ref_lock;
> +
> +	read_cache();
> +	if (checkout_fast_forward(from, to))
> +		exit(1); /* the callee should have complained already */
> +	ref_lock = lock_any_ref_for_update("HEAD", from, 0);
> +	return write_ref_sha1(ref_lock, to, "cherry-pick");
> +}

Ok, so your patch adds new code to do the job, while my refactoring patches 
only move existing code into new functions. So I think the net result is that 
your patch in fact increases the complexity of the code base and duplicates 
existing functionality, while my patches reuse and increase readability of 
existing code.

Now it's true that your patch adds a very small amount of new code and maybe I 
am missing many things and your patch is much better for many reasons that I 
can't see. If that is the case I am sorry to be so stupid.

I also agree that it might not be the right time for refactoring, and that 
it's more work for reviewers, especially yourself, and you (and other 
reviewers) probably just need less work and not more, but in the long run I 
think that reusing existing code is better as that means less maintenance 
work.

Best regards,
Christian.
