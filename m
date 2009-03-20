From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: Re: [PATCH 2/2] Make Git respect changes to .gitattributes during checkout.
Date: Fri, 20 Mar 2009 09:11:29 +0100
Message-ID: <49C34FB1.4040100@nokia.com>
References: <49B8DD1D.3060908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: ext Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 09:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkZqo-0007mH-OY
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 09:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZCTILm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 04:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbZCTILl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 04:11:41 -0400
Received: from hoat.troll.no ([62.70.27.150]:54398 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbZCTILj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 04:11:39 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id A36A020C0F;
	Fri, 20 Mar 2009 09:11:32 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 9749A20B67;
	Fri, 20 Mar 2009 09:11:32 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2K8BURa012657;
	Fri, 20 Mar 2009 09:11:30 +0100
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Fri, 20 Mar 2009 09:11:29 +0100 (CET)
In-Reply-To: <7v8wn18bo2.fsf@gitster.siamese.dyndns.org>
References: <49C267E3.1020205@nokia.com>
References: <7v8wn18bo2.fsf@gitster.siamese.dyndns.org>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.19 (X11/20090122)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113913>

ext Junio C Hamano wrote:
> Kristian Amlie <kristian.amlie@nokia.com> writes:
> 
>> ext Junio C Hamano wrote:
>> ...
>>> For example, you may notice that, after making a clean checkout, one path
>>> has a wrong attribute assigned to it, and may try to correct it.  But how?
>>>
>>>  $ edit .gitattributes ;# mark foo.dat as binary
>>>  $ rm foo.dat
>>>  $ git checkout foo.dat ;# make sure the new settings is correct???
>> As far as I can see, this works without any modifications to the patch.
>> Is that maybe because git_attr_set_direction() is not called if you use
>> that form of checkout?
> 
> But that in itself can be seen as a bug, right?  In another use case,
> suppose you botched your .gitattributes in HEAD version and noticed that
> foo.dat is checked out with a wrong attribute.  You try to fix it like
> this:
> 
>     $ git reset HEAD^ .gitattributes
>     $ rm foo.dat
>     $ git checkout foo.dat
> 
> If you do not flip the direction, the one from the work tree is used which
> is not what you want.  If you do, then you break the other use case.

Right, I didn't even think about that case. My idea of gitattributes was
that the working tree copy is always the master version, and takes
precedence. The only reason that the index takes precedence in the "git
checkout <branch>" case is that there is no other way to get it checked
out correctly, so I see this as an implementation detail. I'm sure some
people would disagree though.

But you're right, there is no way to make both cases correct. From my
standpoint I'd say that the behavior of your patch is the most intuitive.

I'll follow up with the test case.

--
Kristian
