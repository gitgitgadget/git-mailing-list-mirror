From: Anders Waldenborg <anders@0x63.nu>
Subject: Re: [PATCH] gitweb: Fix chop_str not to cut in middle of utf8 multibyte
 chars.
Date: Wed, 21 May 2008 09:45:24 +0200
Message-ID: <4833D314.4010904@0x63.nu>
References: <g0vdse$rj6$1@ger.gmane.org> <m3lk244o16.fsf@localhost.localdomain> <7vve185d6s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 10:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyjVL-0007ru-33
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 10:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758482AbYEUIQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 04:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759194AbYEUIQI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 04:16:08 -0400
Received: from phlox.netintact.se ([217.73.97.18]:45749 "EHLO
	phlox.netintact.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758482AbYEUIQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 04:16:06 -0400
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 May 2008 04:16:05 EDT
Received: from localhost (phlox [127.0.0.1])
	by phlox.netintact.se (Postfix) with ESMTP id 6860ADE0145;
	Wed, 21 May 2008 09:45:46 +0200 (CEST)
Received: from phlox.netintact.se ([127.0.0.1])
	by localhost (phlox [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 21875-01-45; Wed, 21 May 2008 09:45:39 +0200 (CEST)
Received: by phlox.netintact.se (Postfix, from userid 56643)
	id 47BC2DE015D; Wed, 21 May 2008 09:45:39 +0200 (CEST)
Received: from hoth.proceranetworks.com (hoth.proceranetworks.com [194.153.91.41])
	by phlox.netintact.se (Postfix) with ESMTP id 1E3CFDE0147;
	Wed, 21 May 2008 09:45:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by hoth.proceranetworks.com (Postfix) with ESMTP id D90AC1AE0068;
	Wed, 21 May 2008 09:45:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from hoth.proceranetworks.com ([127.0.0.1])
	by localhost (hoth.proceranetworks.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZOnI-MluS1k9; Wed, 21 May 2008 09:45:29 +0200 (CEST)
Received: from [192.168.9.174] (static-213-115-101-206.sme.bredbandsbolaget.se [213.115.101.206])
	by hoth.proceranetworks.com (Postfix) with ESMTP id 5C0011AE0065;
	Wed, 21 May 2008 09:45:29 +0200 (CEST)
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
In-Reply-To: <7vve185d6s.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: by Amavis at proceranetworks.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82534>

> I haven't followed the codepath but what do the callers do to the string
> returned from chop_str?  Don't they assume the string hasn't been decoded
> (because the old implementation of chop_str did not do this to_utf8), and
> emit the result directly to the output because it also assumes the
> undecoded format is what the outside world wants?  In other words, don't
> they now need to do different things because returned string has gone
> through the to_utf8() processing already?

The to_utf8() (defined in gitweb.perl, not part of perl it self) is kind 
of sneaky, it checks if the string already is valid utf8. (guess it 
should be called ensure_utf8())

chop_str needs to work on decoded string, otherwise character count goes 
all wrong. But maybe it is better to add the to_utf8() to the callsites?

  anders
