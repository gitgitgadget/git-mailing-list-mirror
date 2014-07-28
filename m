From: Jeff King <peff@peff.net>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 06:44:09 -0400
Message-ID: <20140728104409.GC10737@peff.net>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
 <20140728103504.GB10737@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:44:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiPg-0003EV-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbaG1KoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:44:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:41640 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751664AbaG1KoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:44:12 -0400
Received: (qmail 30186 invoked by uid 102); 28 Jul 2014 10:44:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 05:44:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 06:44:09 -0400
Content-Disposition: inline
In-Reply-To: <20140728103504.GB10737@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254300>

On Mon, Jul 28, 2014 at 06:35:04AM -0400, Jeff King wrote:

> I haven't reproduced here yet, but this is almost certainly the bug
> where lookup_unknown_object causes a bogus commit->index field (and
> prior to the commit you found, diff-tree did not use commit->index).
> 
> The series that Junio has in jk/alloc-commit-id should fix the problem
> (it's in master already, and slated for v2.1.0).

Yep, that's definitely it. Here's the minimum reproduction:

  git init
  git commit --allow-empty -m one
  git commit --allow-empty -m two
  git rev-list HEAD | git diff-tree --stdin --always --format=%s

That yields:

  one
  one

on v2.0.3, but merging in jk/alloc-commit-id yields:

  two
  one

-Peff
