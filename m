From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/9] refs: Introduce pseudoref and per-worktree ref concepts
Date: Fri, 24 Jul 2015 03:34:46 -0400
Message-ID: <CAPig+cRkY3uQJ4MyjwHRFb3WtN5JKiO5HHF6B8T=nWfmUSW3ng@mail.gmail.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
	<1437713129-19373-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 09:34:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIXVL-0004j0-T8
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 09:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbbGXHes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 03:34:48 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33115 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbbGXHer (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 03:34:47 -0400
Received: by ykfw194 with SMTP id w194so13562925ykf.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 00:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=429K/d+bEHeEsLcyreVzT5M6LUEJT4Xav8YDGRf32A8=;
        b=hyyvIPIRy2ojf5P4PUfJ7WffcWo7bF/Llx+H6dckG+7fHb5fI0E70QHa+fZE2qbj8S
         Aaq+V9dUwPcA+a3Ccia1GIRZFYmJNFaJkQcCFydMDDZ6DI66CMCYC798WutuKS0gAxL2
         lLTEBkDVSakVUhIl0pJ3mr38mRCt6fnOcIyWjZiESFTiCPQUdwb0cvzd2NL5zkTUKl0q
         qGYt+SEJgVrSJ7UhgfgANZkDQoLaW5DK6uABfIxDOIid6ngPvORwhQK8lImHIIu6jCgw
         Q4xrOI6NHD4n26ElbMNQvGzzfWgW8KLSsa6XYB2vSPPNSgg6RTLnLLWyl9dVWhRI0xe7
         XK1w==
X-Received: by 10.13.207.1 with SMTP id r1mr13654961ywd.166.1437723286472;
 Fri, 24 Jul 2015 00:34:46 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 24 Jul 2015 00:34:46 -0700 (PDT)
In-Reply-To: <1437713129-19373-2-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: RgSuPxDPStQ-CwJ83t-Kp2gckqc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274559>

On Fri, Jul 24, 2015 at 12:45 AM, David Turner <dturner@twopensource.com> wrote:
> Add glossary entries for both concepts.
>
> Pseudorefs and per-worktree refs do not yet have special handling,
> because the files refs backend already handles them correctly.  Later,
> we will make the LMDB backend call out to the files backend to handle
> per-worktree refs.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index ab18f4b..d04819e 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -411,6 +411,23 @@ exclude;;
>         core Git. Porcelains expose more of a <<def_SCM,SCM>>
>         interface than the <<def_plumbing,plumbing>>.
>
> +[[def_per_worktree_ref]]per-worktree ref::
> +       Refs that are per-<<def_worktree,worktree>>, rather than
> +       global.  This is presently only <<def_HEAD,HEAD>>, but might
> +       later include other unsuual refs.
> +
> +[[def_pseudoref]]pseudoref::
> +       Files under `$GIT_DIR` whose names are all-caps, and that
> +       contain a line consisting of a <<def_sha1,SHA-1>> followed by
> +       a newline, and optionally some additional data.  `MERGE_HEAD`
> +       and `CHERRY_PICK_HEAD` are examples.  Unlike
> +       <<def_per_worktree_ref,per-worktree refs>>, these files cannot
> +       be symbolic refs, and never not have reflogs.  They also

s/never not/never/

> +       cannot be updated through the normal ref update machinery.
> +       Instead, they are updated by directly writing to the files.
> +       However, they can be read as if they were refs, so `git
> +       rev-parse MERGE_HEAD` will work.
> +
>  [[def_pull]]pull::
>         Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
>         <<def_merge,merge>> it.  See also linkgit:git-pull[1].
