From: Joachim Schmitz <jojo@schmitz-digital.de>
Subject: Re: t5570 trap use in =?utf-8?b?c3RhcnQvc3RvcF9naXRfZGFlbW9u?=
Date: Fri, 13 Feb 2015 08:57:51 +0000 (UTC)
Message-ID: <loom.20150213T094712-477@post.gmane.org>
References: <013601d04702$d7e721e0$87b565a0$@nexbridge.com> <20150213074403.GB26775@peff.net> <20150213080359.GC26775@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 09:58:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMC4l-0003UV-SP
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 09:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbbBMI6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 03:58:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:34057 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbbBMI6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 03:58:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YMC4e-0003QK-1w
	for git@vger.kernel.org; Fri, 13 Feb 2015 09:58:08 +0100
Received: from dslb-094-221-155-167.094.221.pools.vodafone-ip.de ([94.221.155.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 09:58:08 +0100
Received: from jojo by dslb-094-221-155-167.094.221.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 09:58:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.221.155.167 (Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263801>

Jeff King <peff <at> peff.net> writes:

> 
> On Fri, Feb 13, 2015 at 02:44:03AM -0500, Jeff King wrote:
> 
> > On Thu, Feb 12, 2015 at 03:31:12PM -0500, Randall S. Becker wrote:
> > 
<snip> 
> Hmm, today I learned something new about ksh. Apparently when you use
> the "function" keyword to define a function like:
> 
>   function foo {
>     trap 'echo trapped' EXIT
>   }
>   echo before
>   foo
>   echo after
> 
> then the trap runs when the function exits! If you declare the same
> function as:
> 
>   foo() {
>     trap 'echo trapped' EXIT
>   }
> 
> it behaves differently. POSIX shell does not have the function keyword,
> of course, and we are not using it here. Bash _does_ have the function
> keyword, but seems to behave POSIX-y even when it is present. I.e.,
> running the first script:
> 
>   $ ksh foo.sh
>   before
>   trapped
>   after
> 
>   $ bash foo.sh
>   before
>   after
>   trapped
> 
>   $ dash foo.sh
>   foo.sh: 3: foo.sh: function: not found
>   foo.sh: 5: foo.sh: Syntax error: "}" unexpected
> 
> Switching to the second form, all three produce:
> 
>   before
>   after
>   trapped
> 
> I don't know if that is all helpful to your bug-tracking or analysis,
> but for whatever reason it looks like your ksh is using localized traps
> for both forms of function. But as far as I know, bash has never behaved
> that way (I just grepped its CHANGES file for mentions of trap and found
> nothing likely).
> 
> -Peff
> 

Both versions produce your first output on our platform

$ ksh foo1.sh
before
trapped
after
$ bash foo1.sh
before
after
trapped
$ ksh foo2.sh
before
trapped
after
$ bash foo2.sh
before
after
trapped
$

This might have been one (or even _the_) reason why we picked bash as our 
SHELL_PATH in config.mak.uname (I don't remember, it's more than 2 years 
ago), not sure which shell Randall's test used?

bye, Jojo
