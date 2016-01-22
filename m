From: Jeff King <peff@peff.net>
Subject: Re: Minor bug, git ls-files -o aborts because of broken submodules
Date: Fri, 22 Jan 2016 17:26:50 -0500
Message-ID: <20160122222650.GA14772@sigill.intra.peff.net>
References: <CACsJy8BpCc6sNKUs3TsMnA_8dk+uFvZy1T_UmfQMxcm2bpg2uw@mail.gmail.com>
 <20160122211803.GA17071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:26:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkAU-0007vP-3z
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbcAVW0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:26:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:58948 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753686AbcAVW0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:26:53 -0500
Received: (qmail 17599 invoked by uid 102); 22 Jan 2016 22:26:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:26:53 -0500
Received: (qmail 6555 invoked by uid 107); 22 Jan 2016 22:27:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:27:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 17:26:50 -0500
Content-Disposition: inline
In-Reply-To: <20160122211803.GA17071@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284594>

On Fri, Jan 22, 2016 at 04:18:03PM -0500, Jeff King wrote:

> But I think this is another case of
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/265560/focus=281253
> 
> There the question was about performance (lots of these clog up the
> linear ref_cache list), but I think the root cause is the same: going
> too far into ref resolution without realizing we don't have a real
> submodule.
> 
> Andreas posted some patches, but they didn't make it to the list. Here
> are my replies, which did:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/282028
> 
>   http://article.gmane.org/gmane.comp.version-control.git/282029
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/282030
> 
> However, from going over them, I think there was a problem in the series;
> we really do need to know the sha1 in some of these cases. So I think
> maybe the simplest thing would be to catch this case in
> resolve_gitlink_ref(), before we go deeper. Let me see if I can come up
> with something.

Here it is. I think this is the right fix, based on the previous attempt
by Andreas and my comments. Sorry for stealing your topic, but I hope
the perf numbers in the second patch will brighten your day. :)

  [1/2]: clean: make is_git_repository a public function
  [2/2]: resolve_gitlink_ref: ignore non-repository paths

-Peff
