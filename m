From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 1/7] pull: rename pull.rebase to pull.mode
Date: Fri, 02 May 2014 16:12:06 -0500
Message-ID: <53640a26569a5_135215292ec43@nysa.notmuch>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
 <1398988808-29678-2-git-send-email-felipe.contreras@gmail.com>
 <53640403.30600@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 23:23:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKuw-0005hq-GS
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 23:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbaEBVWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 17:22:46 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:60168 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbaEBVWp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 17:22:45 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so5862483obc.17
        for <git@vger.kernel.org>; Fri, 02 May 2014 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/Y0B3CFUdB0aRWks5GXxarfC7ABGNHZUg+m76vr3sXI=;
        b=f3WJQ+hPCwkSa3lAtt2VnhRekTjD9kV85GxPV0R4Uk8D/E53zVksRAe3KebOAbDbUk
         2GF9GIJQHNmIV8br2/k45/tFnbowi6ftV6kJ1xJ97pwJbjaDTeqvm9nEVOQX8sLkFlBE
         6o6+h+iu0iJSaWdo0oUrqdgICiBeUwUbfJAHy/kF5JfC2H3fBpcFXVmDm/eTMU+djsoO
         NcgOTS8F96ykuuj7ZBzfLQDxsPCOoW0lN+Jv2IM12QtXzpcRDkTXRONknD6KRKckOGGi
         e78v1eHu4s49CuSgSVTg02UJR7DWU90Xt49AxPYl6wyAQU8sSGUMEryyfhvMpjYCZWVM
         rC9Q==
X-Received: by 10.182.181.105 with SMTP id dv9mr4222510obc.59.1399065765019;
        Fri, 02 May 2014 14:22:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e8sm689609oed.7.2014.05.02.14.22.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 14:22:43 -0700 (PDT)
In-Reply-To: <53640403.30600@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247985>

Richard Hansen wrote:
> On 2014-05-01 20:00, Felipe Contreras wrote:
> > Also 'branch.<name>.rebase' to 'branch.<name>.pullmode'.
> > 
> > This way we can add more modes and the default can be something else,
> > namely it can be set to merge-ff-only, so eventually we can reject
> > non-fast-forward merges by default.
> > 
> > The old configurations still work, but get deprecated.
> 
> s/get/are/
> 
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/config.txt   | 39 ++++++++++++++++++++++-----------------
> >  Documentation/git-pull.txt |  2 +-
> >  branch.c                   |  4 ++--
> >  builtin/remote.c           | 14 ++++++++++++--
> >  git-pull.sh                | 31 +++++++++++++++++++++++++++++--
> >  t/t3200-branch.sh          | 40 ++++++++++++++++++++--------------------
> >  t/t5601-clone.sh           |  4 ++--
> >  7 files changed, 88 insertions(+), 46 deletions(-)
> > 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index c26a7c8..c028aeb 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -708,7 +708,7 @@ branch.autosetupmerge::
> >  branch.autosetuprebase::
> >  	When a new branch is created with 'git branch' or 'git checkout'
> >  	that tracks another branch, this variable tells Git to set
> > -	up pull to rebase instead of merge (see "branch.<name>.rebase").
> > +	up pull to rebase instead of merge (see "branch.<name>.pullmode").
> >  	When `never`, rebase is never automatically set to true.
> >  	When `local`, rebase is set to true for tracked branches of
> >  	other local branches.
> 
> Should branch.autosetuprebase be replaced with a new
> branch.autosetupmode setting?

Maybe. But if so, I think that should be done in another series.
Otherwise we'll never have a chance to change anything.

> > @@ -764,15 +764,17 @@ branch.<name>.mergeoptions::
> >  	option values containing whitespace characters are currently not
> >  	supported.
> >  
> > -branch.<name>.rebase::
> > -	When true, rebase the branch <name> on top of the fetched branch,
> > -	instead of merging the default branch from the default remote when
> > -	"git pull" is run. See "pull.rebase" for doing this in a non
> > -	branch-specific manner.
> > +branch.<name>.pullmode::
> > +	When "git pull" is run, this determines if it would either merge or
> > +	rebase the fetched branch.
> 
> To me this sentence implies that 'rebase' would rebase the fetched
> branch onto HEAD, when it's actually the other way around.

Right.

This actually interesting mode of thinking:

a) git pull --rebase

We want to rebase HEAD onto @{upstream}.

b) git pull --merge

We want to merge HEAD into @{upstream}. (Why are we doing the opposite?)

c) git pull --rebase github john

We weant to rebase github/john onto HEAD. (We are doing the opposite?)

d) git pull --merge github john

We want to merge github/john into HEAD.

> >                                  The possible values are 'merge',
> > +	'rebase', and 'rebase-preserve'.
> 
> While the name 'merge' is mostly self-explanatory, I think it needs
> further clarification:  Does 'merge' imply --no-ff?  Or --ff?  Or the
> value of merge.ff?

'pull.mode=merge' will do the same as `git merge`, I don't see where or
how it can be explained more clearly.

> Which side will be the first parent?

The same as things currently are: the pulled branch into the current
branch (current branch is first parent).

We should probably change this, but that's out of scope of this series,
and hasn't been decided yet.

> >                                        See "pull.mode" for doing this in a
> > +	non branch-specific manner.
> 
> I find this sentence to be a bit unclear and would prefer something
> like:  "Defaults to the value of pull.mode."

Hmm, might make sense.

> >  +
> > -	When preserve, also pass `--preserve-merges` along to 'git rebase'
> > -	so that locally committed merge commits will not be flattened
> > -	by running 'git pull'.
> > +	When 'rebase-preserve', also pass `--preserve-merges` along to
> > +	'git rebase' so that locally committed merge commits will not be
> > +	flattened by running 'git pull'.
> > ++
> > +	It was named 'branch.<name>.rebase' but that is deprecated now.
> 
> To me this sentence implies that .rebase was simply renamed to .pullmode
> with no other changes.  I'd prefer something like this:
> 
> branch.<name>.rebase::
>     Deprecated in favor of branch.<name>.pullmode.
> 
> (Same goes for pull.rebase.)

Right.

> >  +
> >  *NOTE*: this is a possibly dangerous operation; do *not* use
> >  it unless you understand the implications (see linkgit:git-rebase[1]
> > @@ -1881,15 +1883,18 @@ pretty.<name>::
> >  	Note that an alias with the same name as a built-in format
> >  	will be silently ignored.
> >  
> > -pull.rebase::
> > -	When true, rebase branches on top of the fetched branch, instead
> > -	of merging the default branch from the default remote when "git
> > -	pull" is run. See "branch.<name>.rebase" for setting this on a
> > -	per-branch basis.
> > +pull.mode::
> > +	When "git pull" is run, this determines if it would either merge or
> > +	rebase the fetched branch. The possible values are 'merge',
> > +	'rebase', and 'rebase-preserve'. See "branch.<name>.pullmode" for doing
> > +	this in a non branch-specific manner.
> > ++
> > +	When 'rebase-preserve', also pass `--preserve-merges` along to
> > +	'git rebase' so that locally committed merge commits will not be
> > +	flattened by running 'git pull'.
> > ++
> >  +
> > -	When preserve, also pass `--preserve-merges` along to 'git rebase'
> > -	so that locally committed merge commits will not be flattened
> > -	by running 'git pull'.
> 
> The default value should be documented.  Also, rather than copy+paste
> the description from branch.<name>.pullmode, I'd prefer a brief
> reference.  For example:
> 
> pull.mode::
>     See branch.<name>.pullmode.  Defaults to 'merge'.

I'd say pull.mode is the important one.

-- 
Felipe Contreras
