From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] git-symbolic-ref: fix error message when ref doesn't
 exist
Date: Mon, 19 Mar 2007 09:03:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703190857320.25879@beast.quantumfyre.co.uk>
References: <20070318020645.2444.75365.julian@quantumfyre.co.uk>
 <7vslc1iprn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 10:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTDmZ-00057a-3x
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 10:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXCSJDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 05:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbXCSJDy
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 05:03:54 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:35990 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752312AbXCSJDy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2007 05:03:54 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D0A5EC61A6
	for <git@vger.kernel.org>; Mon, 19 Mar 2007 09:03:52 +0000 (GMT)
Received: (qmail 11260 invoked by uid 103); 19 Mar 2007 09:03:52 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2869. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.045631 secs); 19 Mar 2007 09:03:52 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 19 Mar 2007 09:03:52 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vslc1iprn.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42600>

On Mon, 19 Mar 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> When calling resolve_ref from check_symref set reading to 1, since we
>> do want to know if the given ref doesn't exist.  This means that
>> "git symbolic-ref foo" will now print "fatal: No such ref: foo" as
>> expected.
>
> Hmmmm.  That would break:
>
> 	$ rm -fr a; mkdir a; cd a
> 	$ git init-db
>        $ git symbolic-ref HEAD
>        refs/heads/master
>
> wouldn't it?  We do want it not to fail and tell us that the
> commit we are going to create will be on refs/heads/master
> (i.e. "the master branch").

Um .. yes ... as per the comment in refs.c ... :$

>
> And  the command errors out as expected when given a
> non-existent symbolic ref:
>
> 	$ git symbolic-ref no-such; echo $?
> 	fatal: ref no-such is not a symbolic ref
> 	128
>

The thing is, that wasn't what I expected.  From looking at the code for 
symbolic-ref I was expecting:

 	$ git symbolic-ref no-such; echo $?
 	fatal: No such ref: no-such
 	128

In particular, in quiet mode you will get a return of 1 - rather than 
128, which would potentially lead you astray if you belived the man page 
...

-- 
Julian

  ---
"Intelligence without character is a dangerous thing."
-- G. Steinem
