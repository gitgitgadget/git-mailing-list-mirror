From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/14] shortlog: allow grouping by committer ident
Date: Mon, 4 Jan 2016 05:23:00 -0500
Message-ID: <20160104102300.GB32086@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
 <20151229073515.GK8842@sigill.intra.peff.net>
 <CAPig+cT1pNXt2U1bd-KVapiUD=-6TQ8KRBNC8y+0wLAtuqUhQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 11:23:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG2IE-00024n-Tg
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 11:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbcADKXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 05:23:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:48211 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752658AbcADKXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 05:23:04 -0500
Received: (qmail 6617 invoked by uid 102); 4 Jan 2016 10:23:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 05:23:03 -0500
Received: (qmail 1131 invoked by uid 107); 4 Jan 2016 10:23:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 05:23:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2016 05:23:00 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cT1pNXt2U1bd-KVapiUD=-6TQ8KRBNC8y+0wLAtuqUhQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283295>

On Mon, Jan 04, 2016 at 04:44:00AM -0500, Eric Sunshine wrote:

> > diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> > @@ -47,6 +47,14 @@ OPTIONS
> > +--ident=<type>::
> 
> Should this be called --group-by?

Yeah, that may be a more sensible name. For committer/author, I think
--ident is accurate. But for a trailer, we technically do not know what
is in it. I expect people would use this primarily with ident-based
trailers (like "reviewed-by" or whatever), but there's no reason you
could not collate references to a bug id, or something.

> > +       By default, `shortlog` collects and collates author identities;
> > +       using `--ident` will collect other types of identity. If
> > +       `<type>` is:
> > ++
> > + - `author`, commits are grouped by author (this is the default)
> > + - `committer`, commits are grouped by committer
> 
> There is a bit of redundancy here. I wonder if it could be described
> more succinctly. For instance, instead of all the above, perhaps:
> 
>     Group commits by `<type>`, which can be one of:
> 
>     - `author` (default)
>     - `committer`

I avoided that kind of parallel structure because I knew that later in
the series I would be adding a new bullet that would need more
explanation. I'm still pondering `trailer:<key>` as the syntax, which
would involve reworking this text. I'll keep it in mind when I do.

> > +       case SHORTLOG_IDENT_COMMITTER:
> > +               format_commit_message(commit, "%cn <%ce>", &ident, &ctx);
> > +               if (ident.len <= 3) {
> > +                       warning(_("Missing committer: %s"),
> > +                               oid_to_hex(&commit->object.oid));
> > +                       return;
> 
> Is this leaking strbuf 'ident'?
> 
> (Ditto for the "author" case as mentioned already in the patch 6/14 review.)

Yep. :) I think these can become "goto out" per my previous fixup.

-Peff
