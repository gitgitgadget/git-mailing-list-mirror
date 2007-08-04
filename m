From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 04 Aug 2007 14:11:54 +0800
Message-ID: <46B418AA.4070701@midwinter.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>	<200708040341.36147.ismail@pardus.org.tr>	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>	<46B3F762.1050306@midwinter.com> <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 08:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHCrz-0003md-Dj
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 08:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbXHDGL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 02:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbXHDGL5
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 02:11:57 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:50899 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752022AbXHDGL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 02:11:57 -0400
Received: (qmail 22781 invoked from network); 4 Aug 2007 06:11:56 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=kGAlS0iSfQCiD5ch+8Rg2JcqZ9/G8dVVs+CWrGP86sdW55MBsgxzycQUx2MNbhvk  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 4 Aug 2007 06:11:56 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54798>

Junio C Hamano wrote:
> If I read you correctly, what you are proposing to offer is a
> clone of asciidoc, perhaps AsciiDoc 7, with only xhtml11 and man
> backends.  It is a subset in the sense that you will do only two
> backends, but otherwise is a clone in the sense that you are
> going to implement the input language we use (one thing I
> personally care about while probably other people do not is the
> conditional compilation "ifdef::stalenotes[]" in git.txt).
>   

Yes and no. I am not offering to clone *all* of AsciiDoc, just whatever 
subset is necessary to format the git documentation. (Of course, having 
looked at this very little so far, perhaps that really is all of 
AsciiDoc -- but it's certainly not all of xmlto.)

>  * You would need to duplicate the AsciiDoc 7 manual and
>    maintain it as well; otherwise, when later versions of
>    AsciiDoc comes, people who update our documentation will
>    refer to asciidoc website to learn the syntax, and find out
>    that your dialect does not match what is described there.
>   

Actually, I disagree with this. If we were to fork our own document 
formatter (or rather "implement" -- "fork" implies starting with the 
existing code base) we would explicitly say its input was expected to be 
in the "git documentation human-readable text format" rather than "git's 
implementation of the AsciiDoc format." Then we could freely tweak 
whatever parts of AsciiDoc we're not happy with, and precise 
compatibility would be a total non-issue.

>  * How much can we really rely on your fork to be kept
>    maintained?  When we need newer mark-up that is not offered
>    by AsciiDoc 7 clone, is it our plan to model that after
>    AsciiDoc X (X > 7), or we just come up with an extension of
>    our own?
>   

My thought would be to come up with our own syntax; that's a logical 
result of me not considering this anything but "a formatter whose input 
looks suspiciously like AsciiDoc".

While I agree that that's extra work, it also seems to be the case that 
(a) git hasn't actually needed new markup very often, and (b) we've 
spent far more time dealing with AsciiDoc version-to-version 
incompatibilities than it would likely take to implement whatever new 
markup we needed.

>  * What would happen when xhtml11 goes out of fashion and we
>    would want to switch to newer formats?
>   

If I do this I'll try to structure the code in such a way that new 
formats could be added without huge pain. Will it be as flexible and 
configurable as xmlto? Absolutely not, which is kind of the point of the 
exercise. Adding a substantially different output format might require 
logic changes to the formatter depending on the details, given that the 
optimization here will be for speed rather than extreme flexibility.

On the other hand, I don't think that's a short-term enough concern to 
be worth worrying too much about; it'll be a long, long time before 
XHTML is completely replaced by anything else, just because of its 
gargantuan installed base of existing documents. And it's not like we 
can't decide to switch to another formatter down the road if we want to. 
(Once we all have 64-core machines on our desktops, "make -j64" will 
cause AsciiDoc/xmlto to be sufficiently fast!)

>  * What to do with the user manual, which formats to docbook
>    "book" output?
>   

Ah, that's a sticking point, and an answer to my "are there other output 
formats?" question. I never pay attention to that file when I'm doing 
builds -- forgot it even existed. I'll ask one question first: is that 
Docbook output actually necessary, or would people be happy enough just 
having the user manual in XHTML?

Assuming we really need a Docbook manual, it's tempting to say, "keep 
using AsciiDoc" but then my assertion that we aren't really using 
AsciiDoc's input format kind of flies out the window. I wonder if it's 
possible to go from one of my proposed script's *output* formats to 
Docbook format -- is there software to take well-formed XHTML and turn 
it into that format? (Possibly that software is called "xmlto"...) I 
think the transformation from .txt to .html is likely to be pretty 
lossless, so it should be theoretically possible, anyway.

> It might be more worthwhile to research what other "Text-ish
> lightweight mark-up" systems are availble, and if there is one
> that is more efficient and can go to at least html and man,
> one-time convert our documentation source to that format using
> your Perl magic.  The minimum requirements are:
>
>  * The source is readable without too much mark-up distraction;
>
>  * Can go to roff -man;
>
>  * Can go to html.
>   

I will look around and see what I can find. You're quite right, better 
to use already-existing code than reinvent the wheel.

-Steve
