From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 0/3] fast-import: add option command
Date: Sun, 2 Aug 2009 17:15:22 -0700
Message-ID: <20090803001522.GE1033@spearce.org>
References: <fabb9a1e0908011829j3843c132ka5081d994aad973f@mail.gmail.com> <1249189570-26576-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 02:15:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXlDB-0008NS-8X
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 02:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbZHCAPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 20:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbZHCAPW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 20:15:22 -0400
Received: from george.spearce.org ([209.20.77.23]:59444 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbZHCAPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 20:15:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 87A90381FD; Mon,  3 Aug 2009 00:15:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1249189570-26576-1-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124679>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
>     This allows the frontend to specify any of the supported options as
>     long as no non-option command has been given. This way the
>     user does not have to include any frontend-specific options, but
>     instead she can rely on the frontend to tell fast-import what it
>     needs.
...
>  fast-import.c          |  137 ++++++++++++++++++++++++++++++++++++-----------
>  t/t9300-fast-import.sh |   33 ++++++++++++
>  2 files changed, 138 insertions(+), 32 deletions(-)

Some comments:

Since you are changing the language format, please also update the
documentation of the language.

It might be cleaner to say "option foo=value\n" because then the
if block to parse the command line and the if block to parse the
input stream are the same.  When parsing argv just skip the "--"
and pass the rest of the argv value into the function, when parsing
the stream, just skip the "option " and pass the rest of the line
into the function.

This has come up before on the list.  We had somewhat decided against
setting options in the stream header.  The only option class that
really impacts the data itself is the date format, all others
are about local file paths or how noisy the command should be.
Thus we decided that the frontend should invoke `git fast-import`
itself if it cared about these options, and that's what any typical
frontend does.

-- 
Shawn.
