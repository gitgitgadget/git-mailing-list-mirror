From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 13:50:49 -0500
Message-ID: <20150202185049.GA27399@peff.net>
References: <4727F1DC-2FC3-49BE-8C6D-0C4D7D8B107C@jonathonmah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathon Mah <me@jonathonmah.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:50:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIM5I-0004LD-Vh
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbbBBSuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:50:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:44161 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752822AbbBBSuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 13:50:52 -0500
Received: (qmail 13396 invoked by uid 102); 2 Feb 2015 18:50:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 12:50:51 -0600
Received: (qmail 10697 invoked by uid 107); 2 Feb 2015 18:51:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 13:51:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 13:50:49 -0500
Content-Disposition: inline
In-Reply-To: <4727F1DC-2FC3-49BE-8C6D-0C4D7D8B107C@jonathonmah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263276>

On Mon, Feb 02, 2015 at 10:48:12AM -0800, Jonathon Mah wrote:

> The string in 'base' contains a path suffix to a specific object; when
> its value is used, the suffix must either be filled (as in
> stat_sha1_file, open_sha1_file, check_and_freshen_nonlocal) or cleared
> (as in prepare_packed_git) to avoid junk at the end.  loose_from_alt_odb
> (introduced in 660c889e46d185dc98ba78963528826728b0a55d) did neither and
> treated 'base' as a complete path to the "base" object directory,
> instead of a pointer to the "base" of the full path string.
> 
> The trailing path after 'base' is still initialized to NUL, hiding the
> bug in some common cases.  Additionally the descendent
> for_each_file_in_obj_subdir function swallows ENOENT, so an error only
> shows if the alternate's path was last filled with a valid object
> (where statting /path/to/existing/00/0bjectfile/00 fails).
> 
> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---
> Squashed test and fix.

Thanks, this version looks good to me.

-Peff
