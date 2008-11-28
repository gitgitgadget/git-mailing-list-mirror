From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [RFC PATCH 0/4] Teach git fetch to verify signed tags
	automatically
Date: Thu, 27 Nov 2008 19:09:11 -0500
Message-ID: <20081128000606.GB2759@euler>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu> <7v4p1xohbw.fsf@gitster.siamese.dyndns.org> <7vmyfpn10v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 01:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5qwe-0007pY-M1
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 01:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbYK1AJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 19:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbYK1AJY
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 19:09:24 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:35581 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431AbYK1AJW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 19:09:22 -0500
Received: by an-out-0708.google.com with SMTP id d40so450563and.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 16:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=O1ByT5B1On8UBmeDEQ1gEYhpy05+UL/5YL3GCr6DGEU=;
        b=xEMZ4HyJmiXluqbR4phMKe3NLHAKDlzQfkGrayZ9s6jbnY2JDfTyP3fb6rvlBf+jMW
         1KCqZPnIr+JpPQvhmMVEVK7Cqp9eNX/crcA+3oIIOoiGJzsiSDAjSdy9FJsKjaHYaJ/u
         IuWoJwyPwYHma9WSGENnJsjnRSQ+Rah8rHIqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=qnqga19fN6EEHhipygXL69/IE98dDBbC3jUMgOW1GfYNeWCGXFbjZ9Mpz2VTQ9UiyF
         eYCGz92d9wbLSN5Qc4V3Igk3ozXYDpp2gL2kjUqqIGg/oIXgRssJqHsE86p4qxM8Cvb0
         ShDgJI60qZ1O41qlbcGPZqrMIQ4OBW2a0+n8A=
Received: by 10.65.215.14 with SMTP id s14mr8041295qbq.5.1227830960654;
        Thu, 27 Nov 2008 16:09:20 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id s35sm779974qbs.13.2008.11.27.16.09.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 16:09:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmyfpn10v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101846>

On Sun, Nov 23, 2008 at 09:30:56PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Deskin Miller <deskinm@umich.edu> writes:
> >
> >> It struck me a while back when I fetched a new tagged release from git.git that
> >> if I wanted to verify the tag's signature, I'd have to issue another command to
> >> do so.  Shouldn't git be able to do that for me automatically, when it fetches
> >> signed tags?  Now it does.  Also, 'git remote update' gets this for free.
> >
> > I think this should be done inside your own hook.  Not interested at all
> > in a solution to touch builtin-fetch.c, unless if the patch is about
> > adding a new hook so that people with other needs can use it as well.
> 
> ... or a much stronger case can be made why this shouldn't be done in a
> hook.
> 
> I realize "not interested at all" was a bit too strong, so I am trying to
> rephrase it here.  The cycle that begins with an RFC that leads to
> discussion and review is about clarifying the rationale and design
> incrementally, so please do not get offended by my no, and sorry for using
> unnecessarily strong wording.
> 
> What I meant was more like "The justification as given in the message does
> not interest me in the patch at all as it stands.  I do not understand why
> this has to be done as a patch to git-fetch itself, not in a hook script,
> or why doing it inside git-fetch is a better approach than doing it in a
> hook (if there already is a hook mechanism to do this)".

Let's try this then:

-----
Despite core git's built-in support of cryptographic authentication and
integrity verification through the use of signed tags, git still fails
to provide a good first line of defense against malicious entities
hijacking repositories and disseminating arbitrary code, since git does
not try to verify signed tags at the time they are fetched.  If such a
compromise occurred, the prospect of even one individual who did not
verify the newly-fetched tag prior to use gives this a large potential
value to attackers, and represents a commensurate risk to the git-using
community.

This patch series mitigates this risk by trying to verify each signed
tag when it is first fetched.  Since, however, not everyone is concerned
with the security of signed tags, this feature tries to be conservative
insofar as signatures with public keys which are missing from the user's
keyring do not cause anything to be said about the tag's validity;
furthermore, a configuration variable exists to disable these checks
entirely, if desired.
-----
*the RFC patch series v1 does not include such a configuration variable.

I appreciate that such verification could be accomplished by the
as-yet-nonexistent post-fetch hook, and if that hook existed, I probably
would have done this in that hook.  With that said, I do feel like this
feature merits consideration for inclusion in the builtin fetch code.
First, I very much agree with what Dscho said in his review of patch 1,
that hooks represent a rather more advanced feature of git than most
users are willing to investigate.

So the question, then, is whether this feature is important enough to
include in core git.  I of course think that it is important enough.
Given that we have git-tag installed by default when one builds git,
there is a certain commitment to supporting the use of signed tags; and
I see verifying them when first fetched as a logical continuation of
this support.  As such, a hook seems an unsuitable approach to provide
support for this new use of signed tags.

I'm happy to ask what suggestions you have for someone intending to
implement hooks around fetch; I've not looked at the code in this light,
but someone's got to do it sooner or later.

Deskin Miller
