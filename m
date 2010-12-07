From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Improved error messages when temporary file creation fails
Date: Wed, 08 Dec 2010 00:56:39 +0100
Organization: At home
Message-ID: <idmhjl$n1j$1@dough.gmane.org>
References: <20101207181633.GF25767@bzzt.net> <7v62v5paj2.fsf@alter.siamese.dyndns.org> <20101207212041.GG25767@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 00:57:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ7P2-0002Ms-Fl
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 00:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab0LGX44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 18:56:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:50921 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab0LGX4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 18:56:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PQ7Ot-0002JA-Ro
	for git@vger.kernel.org; Wed, 08 Dec 2010 00:56:51 +0100
Received: from abws249.neoplus.adsl.tpnet.pl ([83.8.242.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 00:56:51 +0100
Received: from jnareb by abws249.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 00:56:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: abws249.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163150>

Arnout Engelen wrote:
> On Tue, Dec 07, 2010 at 12:56:17PM -0800, Junio C Hamano wrote:

>>> +   char origtemplate[255];
>>> +   strlcpy(origtemplate, template, 255);
>> 
>> Why "255"?
> 
> Random - 'i had to choose something'.
> 
>> It may happen to be sufficiently large for the current callers, but what
>> provisions if any are made to help the compiler or the runtime protect us
>> from new and broken callers?  Use of strlcpy() there hides the issue from
>> the runtime by avoiding segfault, but it actively harms us by making the
>> code silently behave incorrectly without segfaulting, no?
> 
> Only in a small way: when a bigger template is encountered and the mkstemp 
> call succeeds, there is no problem. Only when xmkstemp fails *and* clears the
> template, the diagnostic error message shows a truncated version of the 
> original.
> 
> I *could* dynamically allocate space for the original template string, but that
> would mean I'd need to do a malloc() instead of putting the buffer on the stack
> like this, and free() it afterwards. I'm not too concerned about the 
> performance hit here (presumably the I/O that comes with creating and using 
> the temporary file here is orders of magnitude slower than that malloc() 
> anyway), but it would also make the code a bit less easy to read.
> 
> What do you think would be preferable here, a simple fixed-length buffer on the
> stack that might cause a truncated error message or a dynamically-allocated 
> one that makes the code somewhat more complicated?

Why not use PATH_MAX instead of 255?

P.S. I'm sory for cutting up CC list...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
