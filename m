From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 3/3] stash: reject stash name starting with a dash.
Date: Wed, 19 Aug 2009 08:57:05 +0200
Message-ID: <vpq8whg1ebi.fsf@bauges.imag.fr>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
	<1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
	<1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
	<1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
	<1250631523-10524-4-git-send-email-Matthieu.Moy@imag.fr>
	<20090818233535.GB6304@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 19 09:00:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdf9j-0007ha-4a
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 09:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbZHSG7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 02:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbZHSG7q
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 02:59:46 -0400
Received: from imag.imag.fr ([129.88.30.1]:51403 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbZHSG7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 02:59:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7J6v584003147
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Aug 2009 08:57:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mdf6X-0001Cx-S7; Wed, 19 Aug 2009 08:57:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mdf6X-0000Zk-Pj; Wed, 19 Aug 2009 08:57:05 +0200
In-Reply-To: <20090818233535.GB6304@sigill.intra.peff.net> (Jeff King's message of "Tue\, 18 Aug 2009 19\:35\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 19 Aug 2009 08:57:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126508>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 18, 2009 at 11:38:43PM +0200, Matthieu Moy wrote:
>
>> This avoids typos like 'git stash save --invalid-option', particularly
>> nasty since one can omit the 'save' subcommand. The syntax
>> 'git stash save -- "-name starting with dash" still allows such stash name.
>
> Aside from the documentation and usage lines, this one is actually
> independent of the other two, and I think makes sense regardless of what
> happens.

I also do (but I'm not sure this is important enough to be in maint,
especially since it'll introduce silly textual conflicts in docs when
merging).

>> +test_expect_success 'stash --invalid-option' '
>> +       echo bar5 > file &&
>> +       echo bar6 > file2 &&
>> +       git add file2 &&
>> +       ! git stash --invalid-option &&
>> +       test bar5,bar6 = $(cat file),$(cat file2) &&
>> +       git stash -- -message-starting-with-dash &&
>> +       test bar,bar2 = $(cat file),$(cat file2)
>> +'
>
> Should this actually be "git stash save --invalid-option", since it is
> really testing the actual save option parsing, and not the behavior to
> automatically push options to "git stash save"?

It could be, but the most annoying DWIM would be the "implicit save"
case, so that's the one I'm testing. One could test both, but that'd
probably be a bit overkill.

-- 
Matthieu
