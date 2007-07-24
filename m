From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Tue, 24 Jul 2007 20:01:49 +0800
Message-ID: <46A5EA2D.1030707@midwinter.com>
References: <20070723041741.GA22461@midwinter.com>	<Pine.LNX.4.64.0707231059490.14781@racer.site>	<46A481B4.7000502@midwinter.com>	<Pine.LNX.4.64.0707231136530.14781@racer.site>	<46A48949.1020501@midwinter.com> <7vfy3fkpr8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:02:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDJ5T-0006Vx-Ez
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 14:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758585AbXGXMB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 08:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763769AbXGXMB4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 08:01:56 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:43311
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S936137AbXGXMBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 08:01:55 -0400
Received: (qmail 19140 invoked from network); 24 Jul 2007 12:01:53 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=XPospjx+d47BzvH3sOq7v0O0jxmXsJbAmSoQgQ35tWXsltisQEg0HbDrkFEZ6a1V  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 24 Jul 2007 12:01:52 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <7vfy3fkpr8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53576>

Junio C Hamano wrote:
> Offhand, an "interesting" side effect of the above I can see is
> that you will cry "wolf" if the only thing the user did is to
> add his own Signed-off-by: line ;-)  But that is sane in the
> context of coming up with totally new commit log message.
>   

Yes, that is intentional -- the existing git-commit code wasn't treating 
Signed-off-by: as content when it checked for a commit message, so I 
wanted to preserve that behavior.

> I am more worried about how this should interact with cases
> where you usually do not start the log message from scratch.
> For example, are there cases / policies where being able to use
> templates to leave comments on merge commits are needed?
> Squash-commits?  Perhaps "apply this template but only when you
> have hand resolved a conflicting merges"?
>   

Those are all valid cases. They also happen to be ones that are not 
personally useful to me; none of the stuff in my company's commit 
template would really apply to merges. I'm happy to do it if you think 
those cases need to be handled before this can go in, but given there's 
at least one user out there who doesn't need those things, I wonder if 
this makes more sense to hold off on until someone actually asks for it.

> Or even the case of amending a commit made by somebody else,
> without changing the tree contents, in order to make the commit
> log message to conform to the company standard?
>   

It's not clear to me that I can do anything useful in that case, given 
that there's no way to tell in what way the commit message needs to be 
fixed up. If it's a case of, "This engineer committed without using the 
template at all," then I can see an argument for loading the template 
above / below the existing comment, but IMO a more common case will be 
something like, "The format is right, but the bug ID isn't filled in or 
is incorrect," in which case any template I supply would be useless and 
annoying.

Is your hunch about the common case different than mine? Again, I can go 
address this if it'll actually be useful. Maybe by always including the 
template if the command-line option is used, but skipping it in these 
cases if the config option is used? Or something like that? (On the 
other hand, if you have to specify the template on the command line, 
maybe it's easier to just load it into the editor as needed.)

-Steve
