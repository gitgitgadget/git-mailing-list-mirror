From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [RFC v2] submodule: Respect requested branch on all
 clones
Date: Tue, 14 Jan 2014 22:46:08 +0100
Message-ID: <20140114214608.GB838@sandbox-ub>
References: <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
 <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
 <20140109221840.GW29954@odin.tremily.us>
 <20140114102445.GA27915@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 14 22:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3BoV-00075s-JE
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 22:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbaANVqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 16:46:19 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:59829 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbaANVqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 16:46:18 -0500
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W3BoI-00054y-GF; Tue, 14 Jan 2014 22:46:10 +0100
Content-Disposition: inline
In-Reply-To: <20140114102445.GA27915@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240415>

Hi,

On Tue, Jan 14, 2014 at 11:24:45AM +0100, Heiko Voigt wrote:
> I will write another post about how I think we should/can proceed.

and here is my suggestion how we should proceed.

I think there have been many interesting ideas in this thread but IMO
some of them tried to achieve a little bit to much and were not clear
enough. I am a fan of: Keep it as simple as possible, but *no simpler*.
I think some ideas where going in the "make it to simple" direction.

Take my idea for feature branch support from here[1]. After thinking more
thoroughly it still too many corner cases. E.g. it is way to easy to
accidentally merge the feature branch configuration into the stable branch. But
we want to support the user properly so we need to catch stuff like that.

Submodules are separate projects. There is a boundary between
superproject and submodule and IMO its there for a good reason. E.g.
take the typical "shared code" use-case. If A and B are using C
then both want to make sure a change from A does not break B's
expectations and vice versa. Thats were you usually write unit tests in
C for: Ensure that the expectations are met. The more users of the code
the higher the quality and thus the boundary for bad code should be.

I would like to step back a bit and get back to the original problem at hand:
Francescos original use case of an attached head for direct commits on a stable
branch in a submodule. How about we finish discussing the exact solution of
that first. AFAIK that is already solved with the following:

 * Trevor's first patch[2] to create a branch on initial clone of a submodule
 * A possibly a configuration variable for --remote so it can be
   set as the default update method
 * Combined with submodule.<name>.update=merge/rebase

That should be all (and IIRC Francesco agreed) needed for that use-case.

Lets not implement more than currently is needed. We can revisit the ideas once
some other real use-case manifests. Also we (Jens and I) would first like to
proceed with the recursive checkout / fetch (for which the plan is clear) as
the next complicated step.

Once that is done and people gain some experience with it we can still extend
further.

What do you think?

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/240178/
[2] http://article.gmane.org/gmane.comp.version-control.git/239921
