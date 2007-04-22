From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [RFR] gitattributes(5) documentation
Date: Sun, 22 Apr 2007 02:33:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704220221160.5946@qynat.qvtvafvgr.pbz>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> 
 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>  <7v647tcjr6.fsf@assigned-by-dhcp.cox.net><7vslav4yv6.fsf_
  -_@assigned-by-dhcp.cox.net><alpine.LFD.0.98.0704191835290.9964@woody.linux
  -foundation.org><7virbr4p0v.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.63.07
 04211749300.5655@qynat.qvtvafvgr.pbz> <7vmz10q4cx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 12:07:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfYya-0003UJ-DC
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 12:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965620AbXDVKHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 06:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbXDVKHV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 06:07:21 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:61386 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754167AbXDVKHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 06:07:20 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 22 Apr 2007 03:07:19 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 22 Apr 2007 03:07:14 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vmz10q4cx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45234>

On Sun, 22 Apr 2007, Junio C Hamano wrote:

> David Lang <david.lang@digitalinsight.com> writes:
>
>> in the long run this would let you phase out the core.autocrlf option
>> entirely, letting the bahavior be specified in gitattributes.
>
> You _could_, but that is quite against what we want.  These
> should stay separate, and the gitattributes mechanism is
> designed specifically to allow them cleanly separated.
>
> The configuration "core.autcrlf" describes a particular
> repository.  If the platform the repository is on expects text
> files to be line-terminated with CRLF, you would have
> core.autocrlf set; otherwise you don't.
>
> On the other hand, gitattributes' 'crlf' describes if the path
> is text, and that is the reason it can and should be "in-tree",
> i.e. not just $GIT_DIR/info/attributes (which is private to the
> repository) but in .gitattributes (and subdirectories'), which
> is given to everybody who has a copy of the project.

I was thinking that it should be in $GIT_DIR/info/gitattributes along with the 
rest of the crlf defintitions.

> How text files are handled is a local matter, and stays in the
> config.  Which ones are text is the same for everybody who has a
> copy of the project, and is in-tree information.

I understand what you are aiming for, but you are depending on people doing the 
defining of what files are text in the .gitattributes files instead of 
$GIT_DIR/info/gitattributes, which is also valid to do with things as currently 
defined (at least if I'm understanding them correctly)

what you really do want for crlf is one variable that, if set, uses the value of 
another variable.

i wonder if this is useful enough to define formally. something along the lines 
of
[default] crlf=input
in the $GIT_DIR/info/gitattributes file

at the moment we have crlf (set by core.autocrlf) and merge (set by the 
environment variable), I think I saw that it may also be possible to define a 
different diff to use by default as well (possibly by useing a third method to 
define the default, possibly by an environment variable, I don't remember)

if you could set the defaults in the $GIT_DIR/info/gitattributes file and then 
have the flag set/unset/set-to-value in the whatever gitattributes file(s) are 
appropriate, it would consolodate the configurations into one related place 
rather then spreading them around with different ways to set the defaults for 
different things.

David Lang
