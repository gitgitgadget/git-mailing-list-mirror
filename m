From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Wed, 5 Dec 2007 14:14:17 -0800
Message-ID: <5920F34B-A94B-4C24-A95B-D35F35A4F0C0@midwinter.com>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com> <20071203021333.GC8322@coredump.intra.peff.net> <7vlk8csetl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 23:14:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J02Vr-0005xk-Vp
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 23:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbXLEWOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 17:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbXLEWOS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 17:14:18 -0500
Received: from tater.midwinter.com ([216.32.86.90]:52811 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751909AbXLEWOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 17:14:18 -0500
Received: (qmail 19055 invoked from network); 5 Dec 2007 22:14:17 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Ou6B2LWru3Cjjh8+ZuJVz8HYFKNEIwKyKCufDI6s0nZS9oenQQih+od1J/chTrvW  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 5 Dec 2007 22:14:17 -0000
In-Reply-To: <7vlk8csetl.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67204>

On Dec 2, 2007, at 6:16 PM, Junio C Hamano wrote:
>> ..., but an
>> "ok, but btw I changed your commit" status from receive-pack seems  
>> like
>> it would be useful, for two reasons:
> Sensible argument.  I stand corrected.

If we want that status in principle, I'd argue that sending down the  
updated commit SHA1 is actually the right way to indicate it, because  
it gives the client all the information it needs to make an  
intelligent choice about what to do next. If you don't transmit the  
modified SHA1, the client will have to do another fetch to find out  
what rewriting was done by the server, and if another push happened in  
the meantime, the client will have to basically guess about which  
commits correspond to the ones it pushed.

I'm going to have to modify the "ok" line for this either way, and  
it's not like the extra 39 bytes (for sending a hex SHA1 instead of a  
one-character status indicator) is going to hurt in any but the  
narrowest corner cases.

But if people really object to that, I will add a simple flag to the  
"ok" line.

-Steve
