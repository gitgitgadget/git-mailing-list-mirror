From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Fri, 15 May 2009 10:40:43 -0700
Message-ID: <7v3ab6uuw4.fsf@alter.siamese.dyndns.org>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
	<op.utwdsutn1e62zd@merlin.emma.line.org>
	<7v8wl01iev.fsf@alter.siamese.dyndns.org>
	<op.utwyczlf1e62zd@merlin.emma.line.org>
	<20090514182249.GA11919@sigill.intra.peff.net>
	<op.utxydvnu1e62zd@merlin.emma.line.org>
	<20090515020206.GA12451@coredump.intra.peff.net>
	<op.uty0pjb51e62zd@balu> <m34ovmlcve.fsf@localhost.localdomain>
	<4A0D8211.5010806@viscovery.net>
	<81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>
	<4A0D9696.1040805@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri May 15 19:41:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M51P5-0004rA-8n
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 19:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbZEORky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 13:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbZEORky
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 13:40:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58535 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbZEORkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 13:40:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515174053.WHZG2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 May 2009 13:40:53 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id rtgj1b00L4aMwMQ04tguJs; Fri, 15 May 2009 13:40:54 -0400
X-Authority-Analysis: v=1.0 c=1 a=lQuyK5o2kcMA:10 a=f4ZrQ2YIIQcA:10
 a=UXqJC3FAQZbhPenqoScA:9 a=F-7gL-Wif_KivU9vagIA:7
 a=CXQgHz-SHOCXq-BjPOfySU3gr10A:4
X-CM-Score: 0.00
In-Reply-To: <4A0D9696.1040805@op5.se> (Andreas Ericsson's message of "Fri\, 15 May 2009 18\:21\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119266>

Andreas Ericsson <ae@op5.se> writes:

> Is it? Does it really make sense to have a tag named "foo" point to a tag object
> that in turn points to a tag object without a tag ref? I mean, if you're signing
> a tag, it makes sense to want to keep the original tag around so people can
> reference it. If you want to *replace* a tag, it doesn't make sense to create
> this chain which, iiuc, goes something like this:
>
>   tag ref -> tag object -> tag object without ref -> something
>
> Honestly, I can see how this turned out to be confusing, as you end up with a
> tag object without a tag, but a new tag in its place. Not to mention that the
> new tag won't be push-able without --force in case the old tag was pushed earlier.

Suppose the gpg key used to sign v1.6.3 somehow gets compromised, and I
come up with a new gpg key.  I could reassure people that the commit the
old v1.6.3 tagged is genuine if I re-tag with the new key like this:

	git tag -f v1.6.3 v1.6.3^{commit}

But what should I do if I would want to reassure people that both the old
v1.6.3 was tagged by _me_ (with the old key that later was compromised)
and that the commit that old tag tags is genuine?
