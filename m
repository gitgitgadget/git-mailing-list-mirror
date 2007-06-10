From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/4] Introduce optional "keywords" on tag objects
Date: Mon, 11 Jun 2007 01:16:15 +0200
Message-ID: <200706110116.15673.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706102104.48440.johan@herland.net>
 <7vabv77ael.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:16:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWe0-0003EA-KK
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbXFJXQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756618AbXFJXQT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:16:19 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34616 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756219AbXFJXQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:16:18 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJG00A010N5GJ00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Jun 2007 01:16:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJG00EZE0N4L130@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Jun 2007 01:16:16 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJG00C2J0N3GPB0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Jun 2007 01:16:16 +0200 (CEST)
In-reply-to: <7vabv77ael.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49788>

On Sunday 10 June 2007, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > For now, I couldn't find a good reason why the set of allowed characters
> > for keywords should be smaller than for the tag name.
> 
> The set of allowed tag names excludes shell metacharacters,
> primarily to help scripting.  

It already does? Or are you proposing this? Right now the code doesn't 
enforce anything like this, AFAICS...

> I think keywords can share the same reasoning to exclude them.
> 
> It also excludes '^', '~' and ':', because tag names can be used 
> in revision range expressions (i.e. prefix '^' is the "exclude
> from the resulting set" operation, postfix "~<number>" is the
> "Nth generation ancestor" operation) and general SHA-1
> expression (i.e. infix ':' is the "find in the tree-ish the
> object at path" operation).  These reasons would not apply to 
> keywords.

I have nothing against limiting keywords to fairly small set, say
alphanumerics plus a couple of "safe" symbols. It just didn't make
sense to do this when I made the patch without doing it to the
tag name at the same time, and I'm not sure what that restricted
set should be, so I held off on it. Feel free to fix.

> Having said all of that, I suspect it is premature to talk about
> keywords, as it is unclear what their intended use is.  What
> kind of operations are useful on them?  
> 
> It does not count that "git cat-file tag" would show "keywords
> blah" on the header instead of in body.  It is not a compelling
> enough reason to introduce a new header type. grep would work
> just fine for such a use.
> 
> On the other hand, for example, if (the syntax is totally made
> up) we make '::keywords=foo::' expand to set of all tags that
> have the specified keyword 'foo', and it turns out to be useful
> to be able to say "git show ::keywords=foo::" instead of listing
> individual tags, that kind of use case may make it a good reason
> to add such a new header type.

Yes, this is what I'm thinking; using keywords to filter tag objects in 
various settings. Haven't thought much about the syntax yet, but as it 
would have to work on the command-line (possibly together with the other 
weird characters git uses for specifying revisions), I imagine a character 
set similar to the one for tag names should be good.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
