From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 23:10:44 +0800
Message-ID: <46B1F3F4.5030504@midwinter.com>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:10:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcKG-00063g-8s
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbXHBPKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbXHBPKt
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:10:49 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:55475 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755219AbXHBPKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:10:48 -0400
Received: (qmail 17821 invoked from network); 2 Aug 2007 15:10:48 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=cg417oj2H1OpOFOVPScl1nAsQXl40QB+5NwILkn6pvv2J2gbdwrbYmjWRYgxNOhv  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 2 Aug 2007 15:10:47 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <Pine.LNX.4.64.0708021541520.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54559>

Johannes Schindelin wrote:
> This use case has not much to do with new users.  A new user _has_ to know 
> that updating all files, even if their content does not change, is not 
> right.
>   

Someone who has used, say, Subversion might have a perfectly reasonable 
expectation that "git diff" will show differences in content, and when 
there are no differences in content, will not mention a file at all. 
Other version control systems have "diff" commands that ignore touched 
files.

I admit I also thought the empty diffs were a bug (albeit a minor one 
not worth making noise about) until this thread. Now I understand why it 
happens, though I still think we'd be better off just not displaying the 
filename in git-diff until we know there's an actual diff to display.

I certainly don't think the "it's a feature: it reminds you when you've 
edited a file without changing it" argument holds any water at all. If 
that were truly the intent, if we truly considered that to be useful 
information a developer would want to get at after the fact, then why 
would git-status throw away that information? If I check to see what 
files I've modified/added (for which I run git-status) why does that 
automatically imply I am no longer interested in being reminded that I 
have saved a file without making changes, especially given that such 
files *don't* show up in the git-status output? git-status is silently 
losing information here; it gives you no indication that it has 
refreshed the index for those touched-but-not-edited files.

Now, I happen to think throwing away that information is just fine, 
because I don't think I have ever once cared to know that I touched a 
file but didn't change it. But fundamentally it's either a piece of 
information we care about (in which case we shouldn't go silently 
discarding it) or not (in which case it is just clutter in git-diff).

In the meantime, though, it's trivial enough to put a wrapper around 
git-diff to filter out the diffless files. I haven't cared enough to 
bother, but if I did it'd be just a few lines of Perl, no big deal.

-Steve
