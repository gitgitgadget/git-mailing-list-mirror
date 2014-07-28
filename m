From: Jeff King <peff@peff.net>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 06:35:04 -0400
Message-ID: <20140728103504.GB10737@peff.net>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiGv-0008Tt-78
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbaG1KfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:35:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:41631 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752134AbaG1KfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:35:07 -0400
Received: (qmail 29740 invoked by uid 102); 28 Jul 2014 10:35:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 05:35:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 06:35:04 -0400
Content-Disposition: inline
In-Reply-To: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254297>

On Mon, Jul 28, 2014 at 07:42:16PM +1000, Bryan Turner wrote:

> Running a git bisect between v2.0.1, which does not manifest this
> issue, and v2.0.2 fingers the following commit:
> bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
> c1b3c71f4b4571abb2b2a457122fd100dc9f7eb0 is the first bad commit
> commit c1b3c71f4b4571abb2b2a457122fd100dc9f7eb0
> Author: Jeff King <peff@peff.net>
> Date:   Tue Jun 10 17:43:02 2014 -0400
> 
>     commit: convert commit->buffer to a slab

I haven't reproduced here yet, but this is almost certainly the bug
where lookup_unknown_object causes a bogus commit->index field (and
prior to the commit you found, diff-tree did not use commit->index).

The series that Junio has in jk/alloc-commit-id should fix the problem
(it's in master already, and slated for v2.1.0).

Junio, we should consider a v2.0.4 with that series, I think. This is a
pretty serious regression in diff-tree (I didn't even realize that the
buffer-slab work went into the maint series; that may have been a little
ambitious).

-Peff
