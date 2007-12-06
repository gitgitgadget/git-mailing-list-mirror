From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Color support for "git-add -i"
Date: Thu, 06 Dec 2007 12:18:47 -0800
Message-ID: <7vejdzd1aw.fsf@gitster.siamese.dyndns.org>
References: <475697BC.2090701@viscovery.net>
	<1196906706-11170-1-git-send-email-gitster@pobox.com>
	<1196906706-11170-2-git-send-email-gitster@pobox.com>
	<1196906706-11170-3-git-send-email-gitster@pobox.com>
	<5055E3DF-E01D-41B5-9F59-DAD69885CAE8@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 21:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0NBk-0000gB-UM
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 21:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbXLFUSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 15:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbXLFUSz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 15:18:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57118 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXLFUSy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 15:18:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 847022F2;
	Thu,  6 Dec 2007 15:19:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 162C19D9D6;
	Thu,  6 Dec 2007 15:19:12 -0500 (EST)
In-Reply-To: <5055E3DF-E01D-41B5-9F59-DAD69885CAE8@wincent.com> (Wincent
	Colaiuta's message of "Thu, 6 Dec 2007 20:59:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67333>

Wincent Colaiuta <win@wincent.com> writes:

> What are the other options?
>
> - Make git-add--interactive part of builtin-add so as to be able to  
> use the core.whitespace code directly? (ideally yes and at some point  
> in the future it seems inevitable that this will happen, but it will  
> require a fair bit of work)
>
> - Fork a second "git diff-files" process to capture the colorized  
> version of the output? (may set off the "kludge" alarm)
>
> - Something else?

 - Realize that whitespace clean-up can be risky and change semantics
   depending on the material you are editing.  Do not do the clean-up
   during "add -i", but before.  IOW, add an alias that does an
   equivalent of:

	git diff HEAD >tmp
        git apply -R <tmp
        git apply --whitespace=fix <tmp

   then encourage users to clean-up their whitespace gotchas early (and
   test the result!), before even attempting to run "git add -i".
