From: Bruce Stephens <bruce.stephens@isode.com>
Subject: alternates, git prune, git-prune(1) bug
Date: Wed, 27 Aug 2008 16:18:31 +0100
Message-ID: <801w0abi60.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 17:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYMoU-0008Sz-R3
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 17:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbYH0PSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 11:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbYH0PSf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 11:18:35 -0400
Received: from rufus.isode.com ([62.3.217.251]:41242 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755144AbYH0PSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 11:18:35 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SLVwRwBNGZqS@rufus.isode.com> for <git@vger.kernel.org>;
          Wed, 27 Aug 2008 16:18:31 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 27 Aug 2008 16:18:31 +0100
X-Hashcash: 1:20:080827:git@vger.kernel.org::dSb5wiSkyt2do05i:0000000000000000000000000000000000000000000hcU
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93894>

The suggested command-line in git-prune(1) makes no sense:

EXAMPLE
       To prune objects not used by your repository nor another that
       borrows from your repository via its
       .git/objects/info/alternates:

           $ git prune $(cd ../another && $(git rev-parse --all))

It surely should have the nested $() removed:

           $ git prune $(cd ../another && git rev-parse --all)

But that doesn't really help if (as must be fairly common) the sharing
repository contains objects not in the repository being pruned.  In
that case I just get "fatal: bad object: ..." for the first such
object.

And now that "git gc" prunes, what's the recommended way to set this
kind of thing up?  I guess just not using alternates is the obvious
one, and that would work OK for me, but for sites that want lots of
sharing repositories (like git hosting sites) that wouldn't be so
good.  Can one set gc.pruneExpire to "never"?  Ah, OK, that looks as
though it'll work.
