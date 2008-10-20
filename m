From: Maciej Pasternacki <maciej@pasternacki.net>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Mon, 20 Oct 2008 09:28:03 +0200
Message-ID: <2C311251-D0C3-4962-9EDE-02383C6B9A1C@pasternacki.net>
References: <DDFCD680-C477-4BE5-AB71-3F26048E26D1@pasternacki.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 16:41:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrpCf-0000fh-GM
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 09:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYJTH2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 03:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbYJTH2M
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 03:28:12 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:53593 "EHLO
	jankymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750878AbYJTH2L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2008 03:28:11 -0400
Received: from [192.168.11.248] (vide-sat.pl [213.192.64.46])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jankymail-a1.g.dreamhost.com (Postfix) with ESMTP id 660F0986A8
	for <git@vger.kernel.org>; Mon, 20 Oct 2008 00:28:09 -0700 (PDT)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98670>

On 2008-10-20, at 06:55, Junio C Hamano wrote:

>>> As for -C being superfluous: --git-dir and --work-tree seem to  
>>> support
>>> weird usage patterns (like work tree separate from git-dir), but  
>>> it seems
>>
>> Hmm. Yeah, thinking about it more, -C is not really superfluous with
>> respect to those options. You don't want to say "here is the work- 
>> tree,
>> and here is the git-dir". You want to say "find the work-tree and
>> git-dir for me using the usual rules, as if I were in this  
>> directory."
>
> I think that interpretation of -C, if the option existed, makes  
> sense, but
> I do not understand why the tool that drives git refuses to chdir to  
> the
> repository for itself in the first place.

The tool (a) manages many repositories, and I don't want to chdir()  
back and forth, (b) should be able to manage those repositories not  
disturbing anything other.  It comes as a Common Lisp library, which  
will usually be called by end user, but can also be called  
programmatically, and I wouldn't want any library to change my cwd; it  
could chdir() back, of course, but this would still be a race  
condition if other threads were running at the same time.

And there is the Lisp-specific thing, that the language comes from  
before Unix domination, and things as simple as changing the process'  
cwd are actually nontrivial to do portably (there is equivalent of cwd  
inside Lisp world, which is used by Lisp-level file access routines,  
but chdir() is not in ANSI standard, is done differently by every  
implementation, and would require some kind of compatibility layer).

For me, -C would make life much easier, and I gave other arguments for  
it before.  It would suffice if --work-tree worked with "git pull", if  
-C doesn't pass, but it seems to me that -C has some merits.

Regards,
Maciej.

-- 
-><- Maciej Pasternacki -><- http://www.pasternacki.net/ -><-
