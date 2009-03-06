From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
 configured
Date: Fri, 06 Mar 2009 09:17:43 -0800
Message-ID: <7vr61ash8o.fsf@gitster.siamese.dyndns.org>
References: <20090305221529.GA25871@pvv.org>
 <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>
 <200903052322.02098.markus.heidelberg@web.de>
 <200903052325.44648.markus.heidelberg@web.de>
 <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
 <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de>
 <7v4oy7szze.fsf@gitster.siamese.dyndns.org> <20090306114812.GA19534@pvv.org>
 <alpine.DEB.1.00.0903061306450.10279@pacific.mpi-cbg.de>
 <m3r61aisdo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 18:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfdhr-0001Vk-AH
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 18:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbZCFRSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 12:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbZCFRSA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 12:18:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbZCFRSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 12:18:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BB9A53152;
	Fri,  6 Mar 2009 12:17:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7C7C53151; Fri, 
 6 Mar 2009 12:17:45 -0500 (EST)
In-Reply-To: <m3r61aisdo.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 06 Mar 2009 07:25:26 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCC9DF7E-0A72-11DE-A80E-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112470>

Jakub Narebski <jnareb@gmail.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> ...
>> Speaking of which, Steffen (who cannot reply right now, since he is AFK 
>> for a while) had a patch to install "remote.<branch>.push = HEAD" with 
>> clone and remote.  Would that be better?
>
> Errr... I thought that "remote.<remotename>.push = HEAD" works?
>
> But note that "remote.<name>.push = HEAD" (push current branch only)
> and "remote.<name>.push = :" (push matching branches, i.e. curent
> behavior) works only if you have remote configured... "git push <URL>"
> won't be affected, and people (probably) would want to either have
> 'nothing' as default, or/and be able to configure it to nothing,
> current, or matching (at least).

When you and Dscho contradict with each other, I seem to end up agreeing
with Dscho most of the time, but for this particular one, I completely
agree with you.

I personally think Finn's suggested list is overengineered, and we should
start with only three: "nothing", "current" (aka HEAD), and "matching".
It is Ok to have a separate discussion to figure out what other default
behaviours are desireable, but I think that should come after the dust
settled from the transition, and more importantly, I think the other kinds
of fine-tuned behaviour needs to be per-remote, and is not something the
repository (or user) wide default push.default can cover.

In addition to your counterargument, clone to set up remote.*.push is
introducing an inconsistency between existing and new repositories until
the default is changed for everybody, and the recent trend is to avoid
that kind of inconsistency.  Steffen's patch _could_ use push.default to
infer what kind of remote.*.push to set up when adding a remote (or when
cloning, if you take push.default from $HOME/.gitconfig), but at that
point it becomes a redundant information.
