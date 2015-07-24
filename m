From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/9] refs:  Introduce pseudoref and per-worktree ref
 concepts
Date: Fri, 24 Jul 2015 16:14:41 -0400
Organization: Twitter
Message-ID: <1437768881.1141.15.camel@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
	 <1437713129-19373-2-git-send-email-dturner@twopensource.com>
	 <344748CA1CA54D55A9F245FE2DBD23DC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jul 24 22:14:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIjMm-000150-Na
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 22:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbbGXUOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 16:14:45 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33107 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbbGXUOo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 16:14:44 -0400
Received: by qkdl129 with SMTP id l129so21255665qkd.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 13:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=uMSyFGqyVvis9BxXZLJzu0mSkgNJMN8qobW3gyHErr4=;
        b=bP7xoDQZkCIdaNWCNC2BcQN8wKjsdG/77u4Ljm4ONY88Bocc9pe/vqJSnac63i6H6L
         rln/+31VuZ+EK3eUl1uLAfLZjAGvGHh0g9Kcsffl/5L9cVfMkMUhUDAiM1IL94JaGms5
         YDEzaJ9Z0gRzlkwMbXdXAdWGFKxmhgPuVuWZEQlg1ZS8uMPbpA0Mp6FtwOX12vWJ/S8b
         vbHtCIdVyUrd4DohVWRJOmLZydzlmfa0XBHWnzTYWN9SyFCJA8sQnkzmprGClxhvCz3E
         tEGBghfw3nzlhQnlXn3hGyMGfTO59qGIC6FIgdcQItPEejRVroBCm7Discz74f9GzpcY
         yRug==
X-Gm-Message-State: ALoCoQlWNK/0R+2d6Jvu+oGOmmZPofjlz5C9vjSSZWgbtdluEWSuaiAX3GE5gwMRs9NznxwHKaJM
X-Received: by 10.140.150.211 with SMTP id 202mr24233464qhw.42.1437768883831;
        Fri, 24 Jul 2015 13:14:43 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f82sm4609328qkf.7.2015.07.24.13.14.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2015 13:14:43 -0700 (PDT)
In-Reply-To: <344748CA1CA54D55A9F245FE2DBD23DC@PhilipOakley>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274597>

On Fri, 2015-07-24 at 20:52 +0100, Philip Oakley wrote:
> From: "David Turner" <dturner@twopensource.com>
> > Add glossary entries for both concepts.
> >
> > Pseudorefs and per-worktree refs do not yet have special handling,
> > because the files refs backend already handles them correctly.  Later,
> > we will make the LMDB backend call out to the files backend to handle
> > per-worktree refs.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> > Documentation/glossary-content.txt | 17 +++++++++++++++++
> > refs.c                             | 23 +++++++++++++++++++++++
> > refs.h                             |  2 ++
> > 3 files changed, 42 insertions(+)
> >
> > diff --git a/Documentation/glossary-content.txt 
> > b/Documentation/glossary-content.txt
> > index ab18f4b..d04819e 100644
> > --- a/Documentation/glossary-content.txt
> > +++ b/Documentation/glossary-content.txt
> > @@ -411,6 +411,23 @@ exclude;;
> >  core Git. Porcelains expose more of a <<def_SCM,SCM>>
> >  interface than the <<def_plumbing,plumbing>>.
> >
> > +[[def_per_worktree_ref]]per-worktree ref::
> > + Refs that are per-<<def_worktree,worktree>>, rather than
> > + global.  This is presently only <<def_HEAD,HEAD>>, but might
> > + later include other unsuual refs.
> s/unsuual/unusual/

Thanks.

> > +
> > +[[def_pseudoref]]pseudoref::
> > + Files under `$GIT_DIR` whose names are all-caps, and that
> 
> s/and that/excluding 'HEAD', which is special./ ?
> 
> > + contain a line consisting of a <<def_sha1,SHA-1>> followed by
> 
> s/contain/Pseudorefs typically contain/ perhaps?

See my reply to Junio on these; that "contain a line" thing was intended
to be an additional condition on what constitutes a pseudoref.
