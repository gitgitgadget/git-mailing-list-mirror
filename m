From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/9] refs:  Introduce pseudoref and per-worktree ref
 concepts
Date: Fri, 24 Jul 2015 16:13:38 -0400
Organization: Twitter
Message-ID: <1437768818.1141.14.camel@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
	 <1437713129-19373-2-git-send-email-dturner@twopensource.com>
	 <xmqqio99mkfp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 22:13:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIjLl-0000BX-I5
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 22:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbbGXUNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 16:13:41 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36359 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbbGXUNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 16:13:40 -0400
Received: by qgy5 with SMTP id 5so15796712qgy.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 13:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=vR0r3k9oauQlr/T4szTcKt1w5vgJqfCNr3OncHLcOXw=;
        b=HrwH/B8S5Uni2xP5QBvKYwkDaPy1CaOf43dsfP+f3inBF1MCwWOVk3EF1wjElHqc5e
         nT8jShDM9ETTU5x8yhvrlaZnum7A6xTh92TFmZ8o1k5iZQhTxW2d5ruvbpaatglbiYyU
         4oMyVaMpxWZyGlzMpum5ApjywKcCepLNE1aXAoX7KyQYvXTAgfRxOn6dgUAk1R8W9ISq
         CTTOswZPJGhZ9foeYC2MJdPMpH9AfOIDDwxDxlcVTjhcuqejgKY4CzgDi8VxlHuutTK6
         FVVW2Oh+T3NPe2Ddo0wTFjLWzDQcZ+peujiqDpPbVf9O6zzOVUx+3kk7C/Kiu7jfFcHl
         v/YQ==
X-Gm-Message-State: ALoCoQlDP39XqgEopkDEQgVO5zwx9nasoJtcDd9K2Mib4qWg9M+sDoPxVcfiw2n0dbflUoOR48c6
X-Received: by 10.140.239.129 with SMTP id k123mr24264557qhc.66.1437768820091;
        Fri, 24 Jul 2015 13:13:40 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 65sm4597914qks.30.2015.07.24.13.13.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2015 13:13:39 -0700 (PDT)
In-Reply-To: <xmqqio99mkfp.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274596>

On Fri, 2015-07-24 at 12:20 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > +[[def_pseudoref]]pseudoref::
> > +	Files under `$GIT_DIR` whose names are all-caps, and that
> > +	contain a line consisting of a <<def_sha1,SHA-1>> followed by
> > +	a newline, and optionally some additional data.  `MERGE_HEAD`
> > +	and `CHERRY_PICK_HEAD` are examples.  Unlike...
> 
> I wonder if you meant to include FETCH_HEAD in this category (I am
> not complaining about not having it listed as an example).  If you
> did mean to include FETCH_HEAD, then "followed-by a newline" must
> be rethought.

I guess "followed by whitespace"?

> Documentation pedant might say that the above definition would throw
> HEAD into this category.  s/all-caps,/all-caps (except "HEAD"),/ or
> something like that may be needed to prevent them from making useless
> noise.

I meant "and that contain a line consisting of a SHA" to exclude HEAD,
but I need to add a "always" in there, since detached HEAD would
otherwise apply.  That is, it is an additional condition on what a
pseudoref is.

Something like the following?

	Pseudorefs are a class of files under `$GIT_DIR` which behave
	like refs for the purposes of rev-parse, but which are treated
	specially by git.  Psuedorefs both have names are all-caps,
	and always start with a line consisting of a
	<<def_sha1,SHA-1>> followed by whitespace.  So, HEAD is not a
	pseudoref, because it is sometimes a symbolic ref.  They might
	optionally some additional data.  `MERGE_HEAD` and
	`CHERRY_PICK_HEAD` are examples.  Unlike
	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
	be symbolic refs, and never have reflogs.  They also cannot be
	updated through the normal ref update machinery.  Instead,
	they are updated by directly writing to the files.  However,
	they can be read as if they were refs, so `git rev-parse
	MERGE_HEAD` will work.
