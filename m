From: Geert Bosch <bosch@adacore.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 1 Nov 2007 15:19:50 -0400
Message-ID: <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 20:20:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InfaJ-0004MH-BO
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 20:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbXKATTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753610AbXKATTw
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 15:19:52 -0400
Received: from rock.gnat.com ([205.232.38.15]:46991 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340AbXKATTv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 15:19:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id EA4442AB262;
	Thu,  1 Nov 2007 15:19:50 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8m+KUdlPHIVq; Thu,  1 Nov 2007 15:19:50 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.124])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id D48E32AB003;
	Thu,  1 Nov 2007 15:19:50 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62983>

On Nov 1, 2007, at 14:33, Linus Torvalds wrote:
> I certainly think this should go in, but it does make one deficiency
> painfully clear: the remaining shell scripts end up having all the old
> flags behaviour.
>
> So while you can combine flags for *most* programs, you still won't
> be able to say things like
>
> 	git clean -qdx
>
> just because that's still a shellscript, and doing any fancy argument
> parsing in shell is just painful.
>
> Is somebody still working on doing the shell->C conversion?


This is by far the most dangerous command we have at this stage,
and just too easy to execute by accident. While I now have found
out that it is possible to set clean.requireForce to disarm the
command, that's the wrong way around. Only experienced users set
it, and the mere existence of the config item indicates people
do get hosed (and lose data) as a result of the poor semantics.

I often type "make clean" as well many "git xyz" commands
during development, and so it happens that at times, I type
"git clean" by accident.

So, I propose *not* converting git clean to a C builtin,
but instead adding --untracked and --ignored options to
git-rm.

This fixes two usability issues:
   1. data loss due to command typo
   2. too many git commands

Those who care about "git clean" can setup an alias
to make git clean equal to "git rm --untracked"

   -Geert

PS. No patch yet, but I wanted to prevent others from spending
     time on builtin git-clean.
