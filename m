From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 09 Jun 2009 13:37:10 -0700
Message-ID: <7viqj5kutl.fsf@alter.siamese.dyndns.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	<7vskidcf9s.fsf@alter.siamese.dyndns.org>
	<200906070932.36913.chriscool@tuxfamily.org>
	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	<4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
	<c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
	<c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
	<4A2E7EEC.2050807@zytor.com>
	<c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME84M-0007FM-Ke
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 22:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbZFIUhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbZFIUhJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 16:37:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33945 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbZFIUhI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 16:37:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609203710.DZRS20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jun 2009 16:37:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1wdA1c0064aMwMQ03wdAmr; Tue, 09 Jun 2009 16:37:10 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ZlvubiwuF4QA:10 a=BRJNLUJM0I0A:10
 a=pGLkceISAAAA:8 a=_e_ud7BRRk9EjGqHD7gA:9 a=z5k_0z2m9mUiKoydRuAA:7
 a=0TQKDX80c-Km_rxyDXYCjhlXBzUA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com> (Christian Couder's message of "Tue\, 9 Jun 2009 21\:28\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121219>

Christian Couder <christian.couder@gmail.com> writes:

> My opinion is that we should not penalize all the people working on
> "quite clean" projects and also people working on "not clean" projects
> who are able to recover, on the pretence that there are other people
> on these "not clean" projects who are not.
>
> I think it's the projects maintainers' responsibility to keep their
> projects graphs quite clean (and they have the right to ask git
> developers for the tools to do that).

You seem to be saying that a completely linear history is the only one
that is clean.

In an earlier message, I illustrated a case where two people independently
worked on unrelated topic and ended up merging their branches together, to
illustrate why your "not adjacent in goodness space" algorithm does not
give "away from untestable ones in topology space".

With your definition, that history is _not_ clean.  I do not think any
project wnats that kind of cleanness in their history.  You just made the
word "clean" to describe the history meaningless.

My take on the issue you mentioned above is that we should not penalize
the codepath's simplicity too much, only to cater to pathological
behaviour exhibited on an uninteresting special case of competely linear
history.

Your algorithm is Ok as an initial cut, in that it is an improvement over
the "next in goodness space, not even bother to avoid the pathological
case" algorithm.  But I do not think it is much better than HPA's "try the
best one if it is not skipped, otherwise pick one randomly", and if we
wanted to do better and to claim that we pick ones that are _away_ from
untestable ones, we do need to take topology into account.  That is all I
am saying.
