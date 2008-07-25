From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Fri, 25 Jul 2008 14:30:16 +0200
Message-ID: <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no>
References: <alpine.DEB.1.00.0807222255450.8986@racer>  <7vy73tihl6.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807230203350.8986@racer>  <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807231817460.8986@racer>  <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 14:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMMSA-0000L5-EM
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 14:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYGYMaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 08:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbYGYMaU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 08:30:20 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:63313 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYGYMaT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 08:30:19 -0400
Received: from [192.168.0.147] (062016241070.customer.alfanett.no [62.16.241.70])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id A33EE1B0F6B;
	Fri, 25 Jul 2008 14:30:17 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90043>

On 25. juli. 2008, at 02.01, Johannes Schindelin wrote:

>> Um, what?  This discussion is about figuring out when Git should mess
>> with the line endings a user is trying to commit.
>
> This discusion is about when Git should mess with _content_ at all.
>
> It is not limited to line endings.

Fair enough.  Did you read the rest of my email to see when I think  
Git should mess with content?  I've thought about it, and being able  
to do stuff like this in .gitattributes would work for me:

* eol=auto
*.bat eol=crlf
Makefile eol=lf
bin/magic-binary eol=none

I.e. "detect line endings and do CRLF->LF conversion on all files  
except *.bat (*->CRLF), Makefile (*->LF) and bin/magic-binary (do  
nothing)".

The closest you can get today is by setting core.autocrlf to "input"  
and having this in .gitattributes:

*.bat -crlf
bin/magic-binary -crlf

...but "core.autocrlf" is not versioned and applies to _all_  
repositories, and anyone who doesn't have the correct setting can mess  
the repository up.  There's also no way of saying "this file should  
have LF line endings, even with autocrlf=true".

One problem is that the autocrlf setting mixes "I want LF only in my  
repositories" and "I like to have CRLFs in my working directory" into  
one config variable.  Instead, I'd like to have a config setting that  
specifies which line ending form I prefer: "when a text file is marked  
eol=auto, convert LFs to CRLFs on checkout".

Does this make sense to anyone but me?

> Ciao,
> Dscho "who personally could not care less about CR if it was not for  
> M$'
> stupidity"

Well, we agree on that.
-- 
Eyvind Bernhardsen
