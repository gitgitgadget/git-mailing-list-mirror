From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/3] Re: git config --get-urlmatch does not set exit code 1 when no match is found
Date: Sun, 28 Feb 2016 11:54:34 +0000
Message-ID: <cover.1456660027.git.john@keeping.me.uk>
References: <20160228104557.GT1766@serenity.lan>
Cc: John Keeping <john@keeping.me.uk>, Guilherme <guibufolo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 12:54:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZzwA-0006Ik-34
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 12:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261AbcB1Lyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 06:54:54 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:36413 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975AbcB1Lyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 06:54:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 81E1ACDA62D;
	Sun, 28 Feb 2016 11:54:52 +0000 (GMT)
X-Quarantine-ID: <zT0b40QHOW0Z>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zT0b40QHOW0Z; Sun, 28 Feb 2016 11:54:51 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 54686CDA54E;
	Sun, 28 Feb 2016 11:54:43 +0000 (GMT)
X-Mailer: git-send-email 2.7.1.503.g3cfa3ac
In-Reply-To: <20160228104557.GT1766@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287769>

On Sun, Feb 28, 2016 at 10:45:57AM +0000, John Keeping wrote:
> It looks to me like a simple bug that --get-urlmatch doesn't return 1 if
> the key isn't found, but git-config(1) isn't entirely clear.  The
> overall documentation on exit codes at the end of DESCRIPTION says that
> exit code 1 means:
> 
>       the section or key is invalid (ret=1)
> 
> Then the documentation for the --get option says:
> 
>       Returns error code 1 if the key was not found.
> 
> and --get-all says:
> 
>       Like get, but does not fail if the number of values for the key
>       is not exactly one.
> 
> although it does return 1 if there are zero values.  --get-regexp
> behaves in the same way.
> 
> Overall I think that the fact that --get-urlmatch is the outlier here
> means that it should change to match the other --get* options (ignoring
> --get-color and --get-colorbool which are very different).  Although I
> wonder if anyone is relying on the current behaviour and will find their
> workflow broken if we change this.
> 
> The documentation could also use some clarification since most of the
> return codes only apply for the "set" options and in some cases this
> isn't clear from the existing descriptions.

Here's a series that changes the behaviour of "git config --get-urlmatch"
when no appropriate key is found as well as a couple of improvements to
the documentation while we're here.

The second two patches are independent of the first and I think they
should be picked up even if we decide the change to --get-urlmatch's
exit code is not desirable.

John Keeping (3):
  config: fail if --get-urlmatch finds no value
  Documentation/git-config: use bulleted list for exit codes
  Documentation/git-config: fix --get-all description

 Documentation/git-config.txt | 19 +++++++++----------
 builtin/config.c             |  5 ++++-
 t/t1300-repo-config.sh       |  3 +++
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.7.1.503.g3cfa3ac
