From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 4/4] implement automatic fast-forward merge for
	submodules
Date: Wed, 7 Jul 2010 19:11:09 +0200
Message-ID: <20100707171059.GA44073@book.hvoigt.net>
References: <cover.1278508352.git.hvoigt@hvoigt.net> <cover.1278508352.git.hvoigt@hvoigt.net> <3cff3f0b6b859180556ab5ef5345179e603609a9.1278508352.git.hvoigt@hvoigt.net> <7vwrt7w7qq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 19:11:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWY9U-0000vc-L5
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 19:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab0GGRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 13:11:12 -0400
Received: from darksea.de ([83.133.111.250]:50319 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751746Ab0GGRLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 13:11:11 -0400
Received: (qmail 18051 invoked from network); 7 Jul 2010 19:11:09 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Jul 2010 19:11:09 +0200
Content-Disposition: inline
In-Reply-To: <7vwrt7w7qq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150484>

On Wed, Jul 07, 2010 at 09:56:45AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > diff --git a/submodule.c b/submodule.c
> > index 61cb6e2..9bc4b80 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -6,6 +6,7 @@
> >  #include "revision.h"
> >  #include "run-command.h"
> >  #include "diffcore.h"
> > +#include "refs.h"
> >  
> >  static int add_submodule_odb(const char *path)
> >  {
> > @@ -218,3 +219,164 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
> > ...
> > +	while ((commit = get_revision(&revs)) != NULL) {
> > +		struct object *o = &(commit->object);
> > +		if (in_merge_bases(b, &commit, 1)) {
> > +			add_object_array(o, NULL, &merges);
> > +		}
> 
> Unnecessary braces around a single statement.  I've fixed some other style
> violations to this file while replacing the topic branch.

True, that must be a leftover from development. I will check that out
once you pushed the new pu.

> > ...
> > +static void print_commit(struct commit *commit)
> > +{
> > +	struct strbuf sb = STRBUF_INIT;
> > +	struct pretty_print_context ctx = {0};
> > +	ctx.date_mode = DATE_NORMAL;
> > +	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
> > +	fprintf(stderr, "%s\n", sb.buf);
> > +}
> 
> strbuf_release(&sb)???

Definitely, thanks for catching that.

cheers Heiko
