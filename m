From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] notes: handle multiple worktrees
Date: Fri, 31 Jul 2015 17:44:46 -0400
Organization: Twitter
Message-ID: <1438379086.4735.25.camel@twopensource.com>
References: <1438364697-6647-1-git-send-email-dturner@twopensource.com>
	 <xmqq8u9w5fnd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 23:44:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLI6n-00050Y-Mb
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 23:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbbGaVov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 17:44:51 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36672 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbGaVot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 17:44:49 -0400
Received: by qgeh16 with SMTP id h16so54871008qge.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 14:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=dLo7Frvf2Lr54rup1VSzs1pYYzru24U3YdQku4lrUbg=;
        b=kBY1FrCy70rIUyRJDkKSNlFg3G6NAXhW3jkHiaD8YBF4CNkbnYhTMAXnUoXSHLNSBg
         R4YP/JxuaufowAFPetg95ZXM61HWCHm1poX2sO1+80ndnKWzAIdd/jLdTj2l6ZjXFfzy
         PMvdqDni89WuDPnhx5D2dGplHH4KxPCuHCbdJ5p9AncqvzuNZKnlX72zG9IS7/9QSZSf
         scZjgwZybCVKz4ndK1jC0jrZT6brUrRVUOHXGNM3NzOmhyt+mjoRlrANvTWWP+xr0TJM
         W+nXdms3oWHO+k0CLziuMa82rbR5DtMqe5bHNXviwT7792xpinv4JvkiSjS9U/57Uil+
         /bdA==
X-Gm-Message-State: ALoCoQk0s0gJ1oTKv+2FI4zcSKYUfoWSSQvaCW26XavpazEzfdnHdjQ3Tbe403bFVuFSAOT/zwAT
X-Received: by 10.140.164.136 with SMTP id k130mr8631170qhk.40.1438379089201;
        Fri, 31 Jul 2015 14:44:49 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id f27sm2882399qkh.23.2015.07.31.14.44.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2015 14:44:48 -0700 (PDT)
In-Reply-To: <xmqq8u9w5fnd.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275082>

On Fri, 2015-07-31 at 11:46 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
> > die_if_shared_symref.  This prevents simultaneous merges to the same
> > notes branch from different worktrees.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >
> > This version addresses Eric Sunshine's critiques of v1.  It breaks out
> > the symref-checking functionality into die_if_shared_symref, leaving
> > die_if_checked_out to handle HEAD.
> 
> >
> > ---
> >  builtin/notes.c                  |  2 ++
> >  t/t3320-notes-merge-worktrees.sh | 71 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 73 insertions(+)
> >  create mode 100755 t/t3320-notes-merge-worktrees.sh
> 
> Hmm, is this the whole thing?
> 
> Or is a prerequisite patch to add that "symref check" infrastructure
> missing on the receiving end?

Oops, resent with first patch included -- I forgot I had split it.

> This is a tangent, but there is a bigger spanner in "bisect".  It
> uses refs/bisect/* to keep track of the current bisection state, but
> that state is tied to a particular worktree, and it should not be
> shared across other worktrees.

Good point.  

> We need to reserve a part of refs/* hierarchy (e.g. refs/private/*)
> for per worktree private stuff and handle them just like we do
> per-worktree pseudorefs, or something like that.

In the pseudorefs series, is_per_worktree_ref is a separate function
precisely so that we can make this sort of change.  To bikeshed a bit, I
propose worktree_refs/*, since:

(a) "private" can have many meanings, and
(b) common_list in path.c doesn't do exceptions ("refs/ except
refs/worktree/").  We could of course do a manual exception, but that's
not pretty.

I further propose to add some patches (to go on top of the pseudorefs
series):

(a) include worktree-refs/ in per_worktree_refs and include
worktree-refs/ in per_worktree_refs in common_list, and
(b) include changes to bisect which switches it over to use
worktree_refs/*.  To make this change compatible with bisections started
with old git versions, we should just unconditionally rename refs/bisect
to worktree-refs/bisect, and, in the event of EISDIR (meaning that both
refs/bisect and worktree-refs/bisect exist), die with a message
explaining the situation.
