From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Mon, 22 Dec 2014 23:25:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:25:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BPk-0006Mj-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbaLVWZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:25:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:49920 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853AbaLVWZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:25:12 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MMXVC-1XyD4U3QaM-008JQR;
 Mon, 22 Dec 2014 23:25:08 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:0DSoQtRvJksfGW12vp9ntnCQOed3RpvOtBVHNKfGtaXEaA1/uiI
 L2MOwUcg/moJxpuv3qhtIxyjSV4D0M14uDuH7ngg+gjVG8UpNfmYpdEKYpJ2/JxtcXTMii2
 PMMWdpQ+kqve8r/P/aRJJkW/N9iIe5MaHyH39222WruicVP0hZtN+srlgOqK9uW9gYL63u8
 yT/K9qIcAQBN43lROVkMg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261684>

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > We already have support in `git receive-pack` to deal with some legacy
> > repositories which have non-fatal issues.
> >
> > Let's make `git fsck` itself useful with such repositories, too, by
> > allowing users to ignore known issues, or at least demote those issues
> > to mere warnings.
> >
> > Example: `git -c fsck.missing-email=ignore fsck` would hide problems with
> > missing emails in author, committer and tagger lines.
> 
> Hopefully I do not have to repeat myself, but please do not have
> punctuations in the first and the last level of configuration variable
> names, i.e. fsck.missingEmail, not mising-email.

I vetted the complete patch series and think I caught them all.

Or do you want the error messages to also use camelCased IDs, i.e.

	warning in tag $tag: missingTaggerEntry: invalid format ...

instead of

	warning in tag $tag: missing-tagger-entry: invalid format ...

? It is easy to do, but looks slightly uglier to this developer's eyes...

> Should these be tied to receive-pack ones in any way?  E.g. if you
> set fsck.missingEmail to ignore, you do not have to do the same for
> receive and accept a push with the specific error turned off?
> 
> Not a rhetorical question.  I can see it argued both ways.  The
> justification to defend the position of not tying these two I would
> have is so that I can be more strict to newer breakages (i.e. not
> accepting a push that introduce a new breakage by not ignoring with
> receive.fsck.*) while allowing breakages that are already present.
> The justification for the opposite position is to make it more
> convenient to write a consistent policy.  Whichever way is chosen,
> we would want to see the reason left in the log message so that
> people do not have to wonder what the original motivation was when
> they decide if it is a good idea to change this part of the code.

Hmm. I really tried very hard to separate the fsck.* from the receive.*
settings because the two code paths already behave differently: many
warnings reported (and ignored) by fsck are fatal errors when pushing with
receive.fsckObjects=true. My understanding was that these differences are
deliberate, and my interpretation was that the fsck and the receive
settings were considered to be fundamentally different, even if the same
fsck machinery performs the validation.

If you agree, I would rephrase this line of argument and add it to the
commit message. Do you agree?

Ciao,
Dscho
