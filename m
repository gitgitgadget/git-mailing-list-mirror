From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Fri, 30 Mar 2012 01:32:16 -0500
Message-ID: <20120330063216.GC7220@burratino>
References: <20120328042215.GB30251@sigill.intra.peff.net>
 <1332977191-29069-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v8vikrr5l.fsf@alter.siamese.dyndns.org>
 <1333073831-sup-5734@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, peff <peff@peff.net>,
	"j.sixt" <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Mar 30 08:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDVNz-0005na-LK
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 08:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab2C3Gca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 02:32:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52304 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab2C3Gc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 02:32:26 -0400
Received: by iagz16 with SMTP id z16so557029iag.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 23:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QrQNWSPfCqrq1AxkvTOIVRJl+tIjQZo7BElEd+BkH+0=;
        b=JnMZ//Bl0tF0Ml28BB0AmntEOll0blu7hRlXFAY83PfkiKiuxTzfryFyfua3RCLUYe
         BvEwjX9kFk2pAI8vkxMZ3KhjxLCNpoQvWrhQJE7Jdli25Tg2IfMb0XhZ/vnrJq7UtCx8
         RuGL/jxcCadVv0kYCTcZwsfch7S2MdmSrh1Y/m5QfNX9Tb35LRl0sV/RkvYP6HtjF4+2
         K2KWHary4fEix+i+kpfzqn8F3LvNaL/Hqxa6YPbcgZHIO3UZMCu4dXnwwYax2HVof/V7
         VtxRNEzmw+qHKShaiU0RHtF7c2FrvwtoKDL/7f7SI4Da67dbvyFT+XuFAopcVuRs2lJx
         4nQA==
Received: by 10.50.217.137 with SMTP id oy9mr556180igc.31.1333089146423;
        Thu, 29 Mar 2012 23:32:26 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vr4sm7465300igb.1.2012.03.29.23.32.24
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 23:32:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333073831-sup-5734@pinkfloyd.chass.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194330>

Ben Walton wrote:

> The issue really comes down to the fact the current code allows a
> user's environment at runtime to negatively affect the ability to run
> commands that would otherwise be fine.
[...]
> The way that SANE_TOOL_PATH is injected into PATH for shell scripts
> only sees it given priority over /bin and /usr/bin (and things
> following them).  If this were mimicked for consistency in the
> non-script parts of git, users would still be able to have paths with
> 'insane' tools given precedence.

Oh, that's what you meant.

Git could unconditionally override or prefix the PATH with some value
determined at build time, but we deliberately gave users more control
than that.  git-rebase.sh et al make use of various tools from the
usual Unix toolset, expecting to find them on the PATH.  If the user
sets the PATH to point to the Plan 9 tools, say, then these scripts
will break.  Is that a problem?

More importantly: is it the same problem your patch fixes?

If "yes", then that is problematic.  If the SANE_TOOL_PATH facility is
broken, we should be fixing or eliminating it, not piling workarounds
on top.  If we want to say 'sh' is special, we should mean it.

[My personal answers are "no, give them rope" and "no, they are
different problems", so I'm not too worried. ;-)]

Thanks for some food for thought.
Jonathan
