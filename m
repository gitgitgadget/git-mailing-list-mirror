From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] RFC - Say goodbye to the rodent
Date: Wed, 5 Aug 2009 15:02:56 -0400
Message-ID: <20090805190256.GA9004@coredump.intra.peff.net>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:03:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYllb-00062C-5R
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 21:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbZHETDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 15:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbZHETDD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 15:03:03 -0400
Received: from peff.net ([208.65.91.99]:41626 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351AbZHETDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 15:03:01 -0400
Received: (qmail 11757 invoked by uid 107); 5 Aug 2009 19:05:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 Aug 2009 15:05:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2009 15:02:56 -0400
Content-Disposition: inline
In-Reply-To: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124952>

On Wed, Aug 05, 2009 at 05:51:40PM +0800, Nazri Ramliy wrote:

> The idea is that "git status --id" shows a unique id for each file in
> its output (modified/staged/unknown/etc). The ids and the
> corresponding filenames are stored in .git/FILE_IDS. This file gets
> overwritten everytime you run "git status --id"

But files _already_ have a unique id: the filename. You never say why
those unique ids must be cut-and-pasted using the mouse when your unique
ids would be suitable for typing, but I'll assume it's because your
unique ids are much shorter than your filenames.

There are already two classes of solutions to this problem:

  1. Make typing the filenames easier. Generally, this is accomplished
     by tab completion. Even stock bash (and other shells) should
     complete filenames easily, but you can also complete much more
     using the programmable bash completion included with git.

     The main advantage of this approach is that it is totally
     generalizable. Anytime you have to input a filename, you can use
     it.

  2. Structure your workflow to iterate over the list of items to be
     acted on, and then select actions for each item. This is what "git
     add -i" does, as well as "git mergetool" and "git difftool".

     This can save a lot of typing over (1), but requires a new script
     for every such workflow (e.g., the scripts above cover only adding,
     resolving merges, and diffing; you would need a new script to
     iterate over files, doing "git checkout" on each one, for example).

I think your solution is a third class, which is to assign a mapping of
shorter ids to items that persists over multiple commands. But it's not
clear to me where it has an advantage over the existing two solutions.
It is actually less general than (1), because you have to have assigned
the mappings beforehand. But it is not nearly as convenient as (2).

In addition, it's more complicated to implement and use, because you
have to care about the persistence of the mapping (i.e., how long does
it last, which commands reset it, etc).

So while it is somewhat clever, I don't think it is worth merging to
mainline git; it introduces complexity to solve a problem that already
has overlapping solutions.

-Peff
