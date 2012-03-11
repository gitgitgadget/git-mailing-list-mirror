From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Sun, 11 Mar 2012 21:26:35 +0100
Message-ID: <1kgsxjq.jf2f02ib96ufM%lists@haller-berlin.de>
References: <7v62ec2mlf.fsf@alter.siamese.dyndns.org>
Cc: marcnarc@xiplink.com (Marc Branchaud),
	cmn@elego.de (=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?=),
	Matthieu.Moy@imag.fr (Matthieu Moy), git@vger.kernel.org
To: gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Sun Mar 11 21:26:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6pLm-00089p-SK
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 21:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab2CKU0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 16:26:38 -0400
Received: from server90.greatnet.de ([83.133.96.186]:40686 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab2CKU0h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 16:26:37 -0400
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 50BF73B065C;
	Sun, 11 Mar 2012 21:26:35 +0100 (CET)
In-Reply-To: <7v62ec2mlf.fsf@alter.siamese.dyndns.org>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192825>

Junio C Hamano <gitster@pobox.com> wrote:

> lists@haller-berlin.de (Stefan Haller) writes:
> 
> > When we say
> >
> >   git checkout -b topic origin/master
> >
> > then it's always a mistake, and what we really meant was
> >
> >   git checkout -b --no-track topic origin/master
> 
> It would have been nice if you explained larger picture of your
> workflow, as almost anything else in life, a blanket statement like
> the above is not a universal truth.

I wasn't saying that "checkout -b topic origin/master" isn't useful for
*anybody*; it's just not useful for us.  But you are right, I should
have explained who "us" is, and what our workflow is, sorry.

We're a closed-source company that uses git more or less like an
old-style, non-distributed VCS. (This is not because "we don't get it",
as someone phrased it elsewhere in this thread, but because it's what
makes most sense for us.)

The central repository has special significance, because it sends an
email for every commit, and it is hooked up to the CI system. For these
reasons, everything that people work on is pushed to the central
repository, on a topic branch with the same name as the local branch.
Also, it is very common for two or more developers to collaborate on a
topic branch, and the central repository is the hub for this (developers
pull topics with "pull --rebase"). There's no direct exchange between
developer's clones, because others on the team wouldn't see a commit
mail.

Topics are never pushed to master; we have a "merge --no-ff" policy for
integration.

Sometimes, we need to branch a topic (let's call it B) off another topic
(say A), because B needs some of A's code before it's integrated (we'll
rebase B onto master once A is merged back, to keep the history clean).
Same thing here: we say "checkout -b B origin/A", but we don't want to
have B's upstream to be set to origin/A. Again, we forgot to say
--no-track.

To sum it up, push.default=current is almost perfect for this kind of
workflow; except that you still need to configure your upstream branches
so that pull works, and status (and the shell prompt) displays the right
information.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
