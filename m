From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Initialize notes trees if %N is used and no
 --show-notes given
Date: Tue, 6 Apr 2010 01:32:35 -0400
Message-ID: <20100406053234.GC3901@coredump.intra.peff.net>
References: <20100405115548.GA19971@macbook.lan.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Tue Apr 06 07:33:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz1PH-0005uK-Of
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 07:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab0DFFcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 01:32:54 -0400
Received: from peff.net ([208.65.91.99]:53197 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab0DFFcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 01:32:53 -0400
Received: (qmail 3130 invoked by uid 107); 6 Apr 2010 05:33:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Apr 2010 01:33:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Apr 2010 01:32:35 -0400
Content-Disposition: inline
In-Reply-To: <20100405115548.GA19971@macbook.lan.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144098>

On Mon, Apr 05, 2010 at 01:55:48PM +0200, Johannes Gilger wrote:

> While this patch fixes this behaviour, I'm not sure it's at the right
> place or doesn't impact performance. So this is meant more as a
> bug-report.
> [...]
> --- a/notes.c
> +++ b/notes.c
> @@ -1183,6 +1183,8 @@ void format_display_notes(const unsigned char *object_sha1,
>  			  struct strbuf *sb, const char *output_encoding, int flags)
>  {
>  	int i;
> +	if (!display_notes_trees)
> +		init_display_notes(NULL);
>  	assert(display_notes_trees);
>  	for (i = 0; display_notes_trees[i]; i++)
>  		format_note(display_notes_trees[i], object_sha1, sb,

I'm not sure if it is right to just pass NULL. We shouldn't have any
extra_refs in our display_notes_opt, because we would have had to
pass --show-notes to do so (at least from my brief reading of the code).

But shouldn't "git show --no-standard-notes --format=%N" pass a
display_notes_opt with suppress_default_notes set?

I don't see it as all that likely (since without --show-notes, you
wouldn't have _any_ notes, so why are you using %N?), but it seems to be
the correct behavior, and might be useful for a script that uses '%N' in
combination with user-provided options.

-Peff
