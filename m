From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 6 Feb 2013 11:55:15 -0800
Message-ID: <20130206195515.GC21003@google.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu>
 <7v8v72u0vw.fsf@alter.siamese.dyndns.org>
 <51122D9D.9040100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3B61-0003v2-4r
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 20:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758392Ab3BFTzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 14:55:23 -0500
Received: from mail-ia0-f178.google.com ([209.85.210.178]:50911 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758298Ab3BFTzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 14:55:20 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so2033789iab.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 11:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mNV4eidHAvta+GWSvPla2Wi1O7IjQi5ltqNQ95WpEj8=;
        b=z1RfJCDyCbXFaKd0eUGbboq3s3ZaggkuuUAJPqk9b9SMIfxXEjKXxvPVam8a7jufDR
         0RohB2Ir9+K8Hv08cywvLPpokpl1JUkbKqWVE7hPX3MkDB/Da+sVOtmeyrjvYnIjSWIA
         Y4svsxDXGqFRW4zzIlTQVWBIAcydmnBp0qrJ6c50j5ZyvNxjNybTqgdZu4s+8HvleoIW
         /+tb/YDDqwcobn8UQvqzDf2J1b0GFqlpWtiHKL7yLt0xpnbgNXTIF+TEDaSqocoRlFZk
         ABjRAXphwQFkuYiv+EJTngWfYDUDZ4SepOc2zk8GffF9BcAXxoVdW/z2WOVEt2W1M9Xr
         VHCg==
X-Received: by 10.50.46.228 with SMTP id y4mr8714076igm.40.1360180519983;
        Wed, 06 Feb 2013 11:55:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id k7sm26692999paz.13.2013.02.06.11.55.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 11:55:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <51122D9D.9040100@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215629>

Michael Haggerty wrote:

> Scenario 1: Some providers junk up their users' repositories with
> content that is not created by the repository's owner and that the owner
> doesn't want to appear to vouch for (e.g., GitHub pull requests).  These
> references might sometimes be useful to fetch, singly or in bulk.
>
> Scenario 2: Some systems junk up their users' repositories with
> additional references that are not interesting to most pullers (e.g.,
> Gerrit activity markers) though they don't add questionable content.

Actually Gerrit's refs/changes refs are pretty similar to Github's
refs/pull.  Both are requests for code review.

[...]
> But now every time I do a "gitk --all" or "git log --decorate", the
> output is cluttered with all of his references (most of which are just
> old versions of references from the upstream repository that we both
> use).  I would like to be able to hide his references most of the time
> but turn them back on when I need them.
>
> Scenario 5: Our upstream repository has gazillions of release tags under
> "refs/tags/releases/...", sometimes including customer-specific
> releases.  In my daily life these are just clutter.

For both of these use cases, putting the refs somewhere other than
refs/heads, refs/tags, and refs/remotes should be enough to avoid
clutter.

I agree that a --decorate-glob along the lines of "git rev-parse"'s
--glob would be nice.

[...]
> * Some small improvements (e.g. allowing *multiple* views to be
>   defined) would provide much more benefit for about the same effort,
>   and would be a better base for building other features in the future
>   (e.g., local views).

Would advertising GIT_CONFIG_PARAMETERS and giving examples for server
admins to set it in inetd et al to provide different kinds of access
to a same repository through different URLs work?

> Thanks for listening.
> Michael
>
> [1] Theoretically one could support multiple views of a single
> repository by using something like "GIT_CONFIG=view_1_config git
> upload-pack ..." or "git -c transfer.hiderefs=... git upload-pack ...",
> but this would be awkward.

Ah, I missed this comment before.  What's awkward about that?  I
think it's a clean way to make many aspects of how a repository is
presented (including hook actions) configurable.

Thanks for your help clarifying this feature.  Hopefully some of the
discussion will filter into the documentation.

Jonathan
