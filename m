From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intricacies of submodules
Date: Fri, 11 Apr 2008 22:11:52 -0700
Message-ID: <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <1207859579.13123.306.camel@work.sfbay.sun.com>
 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
 <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Roman Shaposhnik <rvs@sun.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 07:12:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkY2j-0005XW-7M
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 07:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbYDLFMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 01:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbYDLFMG
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 01:12:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYDLFMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 01:12:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CBDD20CD;
	Sat, 12 Apr 2008 01:12:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 60D6420CC; Sat, 12 Apr 2008 01:11:54 -0400 (EDT)
In-Reply-To: <1207970038.10408.8.camel@ginkgo> (Roman Shaposhnik's message of
 "Fri, 11 Apr 2008 20:13:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79331>

Roman Shaposhnik <rvs@sun.com> writes:

> ... Contrast this with .gitconfig where policies get
> enforced right from the minute your clone operation finishes and there's
> much less opportunity for the user to shoot himself in the foot.

Why?  Even if you expect .git/config in a new repository would be vanilla
(which you can't really, as crazy sysadmin can have /etc/gitconfig or
template to override what you do), $HOME/.gitconfig would be in effect the
minute you clone.

As you cannot reasonably expect that your project is the _only_ project
your cloners would use, you cannot dictate what $HOME/.gitconfig has.

A policy issue needs to be addressed at the human level anyway, so I do
not really see major difference either way.  You need to trust your users
to follow the guideline at some point, and all you can do is to make it
easy for them to do so, and (optionally) verify that they are actually
following the guideline.  We need to suggest an easy-to-use and robust
mechanism to allow you to do so as the BCP.

Convenience and robustness need to be considered at the same time.  In
that area, I would say a custom "sane environment setup script" would be
the more flexible, as it rolls the customization and verification into one
step.

Trust goes mutual and your users need to be able to trust you, too.  If
the config mechanism blindly starts reading from in-tree .gitconfig, you
can do nasty things with aliases for example.  So the "sane environment
setup script" would also be a good idea in that sense, too --- the users,
perhaps only the most suspicious and untrusting kind, have a way to verify
it does not mean any harm before running it.

Don't get me wrong.  I am not saying that everybody should start rolling
their own "sane environment setup script" and ship their project with it.
I am only suggesting it as a possible way to do your "policy enforcement"
without having to introduce in-tree .gitconfig, which I unfortunately see
no fundamental upsides but definite downsides (security included).
