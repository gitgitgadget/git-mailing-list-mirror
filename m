From: Jeff King <peff@peff.net>
Subject: Re: Giving command line parameter to textconv command?
Date: Wed, 30 Dec 2009 04:56:34 -0500
Message-ID: <20091230095634.GA16349@coredump.intra.peff.net>
References: <20091215071735.6117@nanako3.lavabit.com>
 <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
 <20091230121325.6117@nanako3.lavabit.com>
 <7vr5qc51kv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 10:56:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPvIM-0006Tl-NI
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 10:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZL3J4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 04:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbZL3J4h
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 04:56:37 -0500
Received: from peff.net ([208.65.91.99]:59959 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbZL3J4g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 04:56:36 -0500
Received: (qmail 4857 invoked by uid 107); 30 Dec 2009 10:01:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 05:01:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 04:56:34 -0500
Content-Disposition: inline
In-Reply-To: <7vr5qc51kv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135876>

On Wed, Dec 30, 2009 at 12:05:20AM -0800, Junio C Hamano wrote:

> I stopped promoting the patch after Peff mentioned he was planning a
> rework of textconv, but now I re-read it, I think his rework would be
> orthogonal to the patch.

Actually, I thought I volunteered to produce a patch series converting
textconv and diff.

> Also Peff gives a good hint about borrowing how launch_editor() calls out
> to the shell.  I think the codepath we fork&exec user-defined commands
> (not hooks, but filters like smudge/clean/textconv and EDITOR/PAGER that
> take a command line) need to be first enumerated, then we need to see if
> we can refactor what launch_editor() does into a common helper function.

I think the helper function is not too hard. Whereas the patch you
posted earlier actually runs { "sh", "-c", "%s %s" } for textconv, it is
a bit simpler to do { "sh", "-c", "%s \"$@\"", ... } as launch_editor
does. And then we don't have to worry about quoting the arguments (which
your patch gets wrong).

> I felt it was unclear what we would want to do with GIT_EXTERNAL_DIFF,
> diff.external, and diff.<driver>.command trio, but I tend to agree that we
> should run things the same way, honoring $IFS and shell everywhere.

I thought it was left at "maybe for 1.7.0", but perhaps we don't have
time now to issue sufficient warning.

Anyway, I'm working on a series which will hopefully be done in a few
minutes.

-Peff
