From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 08:40:03 +0200
Message-ID: <m2sjgde7cs.fsf@linux-m68k.org>
References: <1333935414-10389-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Apr 09 08:40:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SH8H0-0002ke-Fd
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 08:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab2DIGkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 02:40:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52536 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab2DIGkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 02:40:11 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VR21z00Bxz3hhVs;
	Mon,  9 Apr 2012 08:40:05 +0200 (CEST)
Received: from linux.local (ppp-93-104-153-14.dynamic.mnet-online.de [93.104.153.14])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VR21x5HLlz4KK3T;
	Mon,  9 Apr 2012 08:40:05 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 3D2F71E52F0; Mon,  9 Apr 2012 08:40:03 +0200 (CEST)
X-Yow: All I can think of is a platter of organic PRUNE CRISPS being trampled
 by an army of swarthy, Italian LOUNGE SINGERS...
In-Reply-To: <1333935414-10389-1-git-send-email-bwalton@artsci.utoronto.ca>
	(Ben Walton's message of "Sun, 8 Apr 2012 21:36:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195011>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> The sed provided by Solaris in /usr/xpg4/bin has a bug whereby an
> unanchored regex using * for zero or more repetitions sees two
> separate matches fed to the substitution engine in some cases.
>
> This is evidenced by:
>
> $ for sed in /usr/xpg4/bin/sed /usr/bin/sed /opt/csw/gnu/sed; do \
> echo 'ab' | $sed -e 's|[a]*|X|g'; \
> done
> XXbX
> XbX
> XbX
>
> This bug was triggered during a git submodule clone operation as
> exercised in the setup stage of t5526-fetch-submodules when using the
> default SANE_TOOL_PATH for Solaris.  It led to paths such as
> ..../.. being used in the submodule .git gitdir reference.
>
> Using the expression 's|\([^/]*\(/*\)\)|..\2|g' provides the desired

How about using 's|[^/][^/]*|..|g' instead, which should avoid the bug
as well.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
