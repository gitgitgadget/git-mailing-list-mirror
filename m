From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: give a hint when a commit message has been
 abandoned
Date: Mon, 23 Jul 2012 17:43:39 -0400
Message-ID: <20120723214339.GA13931@sigill.intra.peff.net>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185218.GC27588@sigill.intra.peff.net>
 <7vzk6qjj7w.fsf@alter.siamese.dyndns.org>
 <20120723205209.GA6745@sigill.intra.peff.net>
 <7vr4s2jiqk.fsf@alter.siamese.dyndns.org>
 <20120723211312.GA12533@sigill.intra.peff.net>
 <7veho2jh4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQPq-00038s-6X
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab2GWVnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:43:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59251 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab2GWVnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:43:41 -0400
Received: (qmail 9296 invoked by uid 107); 23 Jul 2012 21:43:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jul 2012 17:43:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2012 17:43:39 -0400
Content-Disposition: inline
In-Reply-To: <7veho2jh4q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201992>

On Mon, Jul 23, 2012 at 02:35:01PM -0700, Junio C Hamano wrote:

> > +FILES
> > +-----
> > +
> > +`$GIT_DIR/COMMIT_EDITMSG`::
> > +	This file contains the commit message of a commit in progress.
> > +	If `git-commit` exits due to an error before creating a commit,
> > +	any commit message that has been provided by the user (e.g., in
> > +	an editor session) will be available in this file, but will be
> > +	overwritten by the next invocation of `git-commit`.
> >  
> >  SEE ALSO
> >  --------
> 
> Very sensible, modulo s/git-commit/git commit/ and lack of S-o-b.

Yeah, I'm used to using the dashed form in documentation, but it's
probably reasonable to use the normal spaced form here. I assume you can
forge my S-o-b?

> I also wondered if something like the following might be useful, but
> it probably falls into the "water under the bridge" category.
> 
>  builtin/commit.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 149e07d..83bcee4 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -768,6 +768,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				"with '#' will be kept; you may remove them"
>  				" yourself if you want to.\n"
>  				"An empty message aborts the commit.\n"));
> +		status_printf(s, GIT_COLOR_NORMAL,
> +			      _("The file '%s' keeps a copy of the log message\n"
> +				"you edited, if you wish to inspect it later.\n"
> +				"It will be wiped by the next invocation of 'git commit'.\n"),
> +			      git_path("COMMIT_EDITMSG"));

That seems excessive, as it is inside the file itself. Unless your
editor is terrible, it already shows you that information.

-Peff
