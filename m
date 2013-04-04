From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 00:22:37 +0530
Message-ID: <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com> <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:53:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpIA-000350-R1
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763000Ab3DDSxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:53:18 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:42443 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762667Ab3DDSxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:53:17 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so2537973iae.11
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VbMphsG+4zBwznnUY5W32WwC0lpWSdn0h5BrxwIDv3w=;
        b=SLZhN1uuO56Pu/FI+RZz6KalgVnKFeTWgvh/b3HyO9iMR3tG2V8J3yNERA440ELEhC
         pvgSEoz+/Ju5ktFHMkqZEecrgNuaq04sVOqHRB5QdYmVLIqQG4LvCf+xClQYHqaQ2YxY
         aLVKVKFD7/uiTjcwl8Oyfkl/uocSNt/vOmcjI/MbcidBOOExWGJ+5TQVrwEWZzr2XWOa
         rr9qbWPgqNBparzwwDZKu77Yb/EnfNr2ILM8s/ZyxKltga6nkwOXkFaf1QzxnT7LFCqS
         ALwgHnDTFg0T8qBPCSTt/XlbiWB6wDEU/v/1X/T+ENNjpXMcB09E2OZ4m9T6PUaDK4Fn
         YIbw==
X-Received: by 10.50.17.166 with SMTP id p6mr10636057igd.12.1365101597293;
 Thu, 04 Apr 2013 11:53:17 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 4 Apr 2013 11:52:37 -0700 (PDT)
In-Reply-To: <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220061>

Linus Torvalds wrote:
> I don't dispute that a new link object might be a good idea, but
> there's no explanation of the actual format of this thing anywhere,
> and what the real advantages would be. A clearer "this is the design,
> this is the format of the link object, and this is what it buys us"
> would be a good idea.

Yeah, I need help with that.  I've just stuffed in whatever fields
popped into my mind first.  The current ones are:

1. upstream_url: this records the upstream URL.  No need to keep a .gitmodules.

2. checkout_rev: this records the ref to check out the submodule to.
As opposed to a concrete SHA-1, this allows for more flexibility; you
can put refs/heads/master and have truly floating submodules.

3. ref_name: this specifies what name the ref under
refs/modules/<branch>/ should use.

4. floating: this bit specifies whether to record a concrete SHA-1 in
checkout_rev.

5. statthrough: this bit specifies whether git should stat() through
the worktree.  We can turn it off on big repositories for performance
reasons.

> Also, one of the arguments against using link
> objects originally was that the format wasn't stable, and in
> particular the address of the actual submodule repository might differ
> for different people. So when adding a new object type, explaining
> *why* the format of such an object is globally stable (since it will
> be part of the SHA1 of the object) is a big deal.

After some discussion, I hope to be able to finalize a list of fields
that will suffice for (nearly) everything.
