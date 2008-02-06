From: Jonas Fonseca <fonseca@diku.dk>
Subject: [TIG RFC] Cleaning up tig's option handling
Date: Thu, 7 Feb 2008 00:57:34 +0100
Message-ID: <20080206235734.GA9969@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 00:58:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMuAB-00042k-I3
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 00:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764893AbYBFX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764886AbYBFX5k
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 18:57:40 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:54497 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764876AbYBFX5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 18:57:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 97A1C19BB76
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 00:57:36 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13939-10 for <git@vger.kernel.org>; Thu,  7 Feb 2008 00:57:34 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id D948419BAFC
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 00:57:34 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 9901A6DFBF1
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 00:56:05 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id BD0195B8001; Thu,  7 Feb 2008 00:57:34 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72879>

Hello,

In my own usage of tig, I increasingly use git-log options like -S and
--all and rarely use any of the "native" tig options or subcommands.
The only exception is the option for entering the status view, which I
have even configured a hotkey for in my editor (reducing most commit
preparations to a simple combination of pressing 't', 'u', '.' with the
help of tig's yet unreleased command aliases :). Anyway, the above usage
pattern leads to weird looking command lines when multiple "--"s are
needed, e.g.:

	$ tig -- --all ^release -- tig.c

I would like to ask tig users out there on how to best proceed with
cleaning up the option handling so that tig will act more like gitk.
Besides making command lines more visually appealing, out-sourcing the
option handling to git-rev-parse will also make it easier to add
refreshing of the main view (similar to F5 in gitk) in the future.

My plan is to obsolete most of the options over the course of the next
(few) release(s) keeping only the options for help and version
information. This should be fairly harmless I hope. Remaining is the
question of what to do with the subcommands and the option for the
status view. Having optional subcommands for tig has the problem that it
may ending up conflicting with local branch or file names causing
dreadful ambiguity. On the other hand, given git-log's and git-diff's
vast amount of options, it won't conflict with any and it might be more
natural to say `tig show <rev>` and `tig status` than `tig --show` and
`tig --status`.

Below is the list of subcommands and options:
---------------------------------------------
tig 0.9.1-19-gc509eed (Dec 13 2007)

Usage: tig [options]
   or: tig [options] [--] [git log options]
   or: tig [options] log  [git log options]
   or: tig [options] diff [git diff options]
   or: tig [options] show [git show options]
   or: tig [options] <    [git command output]

Options:
  -l                          Start up in log view
  -d                          Start up in diff view
  -S                          Start up in status view
  -n[I], --line-number[=I]    Show line numbers with given interval
  -b[N], --tab-size[=N]       Set number of spaces for tab expansion
  --                          Mark end of tig options
  -v, --version               Show version and exit
  -h, --help                  Show help message and exit

-- 
Jonas Fonseca
