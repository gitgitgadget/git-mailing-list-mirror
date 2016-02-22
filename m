From: Jeff King <peff@peff.net>
Subject: whither merge-tree? (was: What's cooking in git.git (Feb 2016, #05;
 Wed, 17))
Date: Mon, 22 Feb 2016 17:12:10 -0500
Message-ID: <20160222221209.GA18522@sigill.intra.peff.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:12:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyiG-00053K-W1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbcBVWMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:12:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:46991 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755461AbcBVWMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:12:12 -0500
Received: (qmail 20135 invoked by uid 102); 22 Feb 2016 22:12:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:12:12 -0500
Received: (qmail 22565 invoked by uid 107); 22 Feb 2016 22:12:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:12:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:12:10 -0500
Content-Disposition: inline
In-Reply-To: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286958>

On Wed, Feb 17, 2016 at 02:34:08PM -0800, Junio C Hamano wrote:

> * jk/merge-tree-merge-blobs (2016-02-16) 1 commit
>  - merge_blobs: use strbuf instead of manually-sized mmfile_t
> 
>  "git merge-tree" (a throw-away demonstration) did not work very
>  well when merging "both sides added a new file at the same path"
>  case.
> 
>  Undecided; we might be better off deleting it altogether.

What do we want to do with this? I think there are basically three
options:

  1. Take the patch you queued above. That's the minimal fix with no
     user-visible changes.

  2. Rip out the weird add/add conflict resolution. This gets rid of the
     buggy code, makes merge-tree more like the rest of git, and I think
     lets us even drop the EMIT_COMMON stuff from xdiff).

     That lets people keep using merge-tree if they have found it useful
     over the years.

  3. Drop merge-tree completely. This deletes even more code, and helps
     the people in (2) realize that it is utterly unmaintained. :)

I think at this point I am waffling between (2) and (3). I did (1) in a
hope that I could avoid looking deeper into the code at all, but now
that I have, I do not think (2) would be so bad. I'm happy to work up a
patch, but won't bother if we think that (3) is viable.

-Peff
