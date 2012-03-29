From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Thu, 29 Mar 2012 18:00:43 -0500
Message-ID: <20120329230043.GB27829@burratino>
References: <20120328042215.GB30251@sigill.intra.peff.net>
 <1332977191-29069-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, j.sixt@viscovery.net, gitster@pobox.com,
	git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Mar 30 01:00:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDOKw-0004ni-58
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 01:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760316Ab2C2XAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 19:00:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60249 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760288Ab2C2XAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 19:00:52 -0400
Received: by obbeh20 with SMTP id eh20so84412obb.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0mFFzUjYSQkPf4FaNpSXuYaiOmuL3Tf/wZHmlZMoykE=;
        b=TpdlPGejQxj8q3sJ/u0EwflZ361eSkDkEUQ3bvUES7ZMFRmY1Dc7sRZMcq3mp5qq1j
         kS8Z7vn6abR0t3yGKGLds8+b251aiKg82XJoa6Y277GHH88RF8/YgY5h/bJbkRZuJig5
         2VnQ2NmSi9qV/JdlQo9a6lppzyEAqtexr7fnIzwTOmpzsAw5Y2cT8y+Rl9rqe9jHJiZh
         R/mUnh8Z+yZCdR0pbde6GKc1wR3ptFtD7YyzOyWL8rtNuJ/mLn/99WUvAAojb9PEEObI
         u5Sa6vF9WlyKNjJoc+8f7gjqeLULGkw16zltAVcy3JLbrLkIm1Wy3LOEaJTktcmY+NRl
         RPEA==
Received: by 10.182.134.97 with SMTP id pj1mr24169obb.2.1333062051929;
        Thu, 29 Mar 2012 16:00:51 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o9sm7488191obd.21.2012.03.29.16.00.49
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 16:00:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332977191-29069-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194302>

Ben Walton wrote:

[...]
> 2. The git wrapper could prepend SANE_TOOL_PATH to PATH for
>    consistency with builtin commands.

The phrase "builtin commands" left me confused for a moment ---
busybox-style builtins and standalone commands in C both don't get the
PATH fixup.

I think you meant scripted commands (i.e., commands that get the PATH
fixup by sourcing git-sh-setup).

> 3. The run_command.c:prepare_shell_command() could use the same
>    SHELL_PATH that is in the #! line of all all scripts.
>
> Option 1 would preclude opening a bidirectional pipe to a filter
> script and would also break git for Windows as cmd.exe is spawned from
> system() (cf. v1.7.5-rc0~144^2, "alias: use run_command api to execute
> aliases, 2011-01-07).
>
> Option 2 is voided by the same example that turned up this issue.
> SANE_TOOL_PATH might also include 'insane' tools.

As Junio mentioned, the only insane tool that SANE_TOOL_PATH is
allowed to point to is sh.  I guess the note on insane tools was meant
as a wistful observation, but it didn't come through clearly.

Maybe a reference to v1.5.5-rc0~5^2~3 (filter-branch: use $SHELL_PATH
instead of 'sh', 2008-03-12) would make the motivation behind the
"don't trust sh" principle clearer.

> Option 3 is the best choice

Makes sense to me and the patch looks good.  Thanks for your
perseverance.

Ciao,
Jonathan
