From: Brian Ericson <bme@visi.com>
Subject: Re: teach git diff -v/--invert-match?
Date: Fri, 22 Aug 2008 16:29:31 -0500
Message-ID: <48AF2FBB.2080401@visi.com>
References: <48AED264.60600@visi.com> <20080822193947.GA31322@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:30:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWeDQ-0004XB-TF
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbYHVV3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbYHVV3g
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:29:36 -0400
Received: from mailfront2.g2host.com ([208.42.176.213]:48553 "EHLO g2host.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753295AbYHVV3f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:29:35 -0400
Received: from [209.98.56.25] (account bme@visi.com [209.98.56.25] verified)
  by mailfront2.g2host.com (CommuniGate Pro SMTP 5.1.16)
  with ESMTPA id 62156663; Fri, 22 Aug 2008 16:29:34 -0500
User-Agent: Thunderbird 2.0.0.16 (X11/20080805)
In-Reply-To: <20080822193947.GA31322@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93375>

I was just working on a reply to my own email as I realized it was only 
dumb-luck that
converted 1200 noisy changes into a couple of dozen.  "-S" matches only 
the string
itself, not the line the string resides on.  So, -Sxyz will match if 
"xyz" itself was
added or deleted in the diff (if "xyz" is on a line that's changed but 
did not itself change,
it won't match).  Funny that I actually knew this -- I use it to look for
System.out.println additions among other things.

Interestingly, if I wanted to know if an import changed (on top of 
knowing if imports were
added or deleted), eg:
-import foo;
+import bar;

I couldn't tell you how to do it.  The string "import" didn't change.  
I'd've guessed that
"-S'import.*;' --pickaxe-regex" would have been sufficient, but that 
doesn't work.

Jeff King wrote:
> On Fri, Aug 22, 2008 at 09:51:16AM -0500, Brian Ericson wrote:
>
>   
>> I'm wondering what it would take to teach git diff to invert the -S  
>> string (like git grep).
>>     
>
> I think you would have to figure out the desired semantics first.
>   
I think mostly what I want is a happy marriage between git diff & git 
grep so that if the
changed lines matched (or didn't match) the file would show up (or 
not).  I'd like to grep
added and removed lines (the diff itself) for a pattern and either 
include or exclude the file
based on matches.
>   
>> I'm finding git diff -S<string> [--pickaxe-regex] to be really useful,  
>> but find I have cases where I want to ignore differences.  For example, I 
>> might not care if the only changes to a Java file, for example, are  
>> related to import statements.  I'd like to be able to do something like  
>> "git diff -S'^import' --pickaxe-regex -v".  I'll admit I can get by with  
>> something like "git diff -S'^[^i]' --pickaxe-regex", but am pining for  
>> -v/--invert-match.
>>     
>
> I would have thought "-v" meant "match any changes which do not have
> this pattern". But you want "match any changes that have any line which
> does not have this pattern."
>   
Right.  Good summary!  It's probably not accurate to use "-S" for my 
interpretation unless
--pickaxe-regex behaved more as I outlined above.  It's probably a 
subtle enough difference
> IOW, mine would not match any changes which used an import statement,
> whereas yours would not match any changes which are _only_ import
> statements.
>   
The current behavior seems to work well to answer questions like "has 
somebody added
a System.out.println", I'd like it to be able to ignore or consider 
files based on line changes
that contain a string where the string itself did not change.

> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   
