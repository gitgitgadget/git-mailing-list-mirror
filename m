From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [bash-completion] syntax error near unexpected token '<' on line
 123 in bash_completion.d/git
Date: Mon, 26 Jul 2010 22:39:58 +0100
Message-ID: <4C4E00AE.7010904@pileofstuff.org>
References: <1280056320.7883.9.camel@soho.example.org>	 <4C4C982C.20904@pileofstuff.org> <1280096368.7211.2.camel@soho.example.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: solsTiCe d'Hiver <solstice.dhiver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 23:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdVQM-00069S-Mw
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 23:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab0GZVlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 17:41:02 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:7917 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755088Ab0GZVkG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 17:40:06 -0400
X-Greylist: delayed 92287 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2010 17:40:06 EDT
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100726214004.PBPR3075.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Mon, 26 Jul 2010 22:40:04 +0100
Received: from [192.168.1.6] (really [80.6.134.127])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100726214004.HEQH1593.aamtaout04-winn.ispmail.ntl.com@[192.168.1.6]>;
          Mon, 26 Jul 2010 22:40:04 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <1280096368.7211.2.camel@soho.example.org>
X-Cloudmark-Analysis: v=1.1 cv=DhNl2YeytwJssBBGe49HJX82LNDFEEVkpVB34RXKaPo= c=1 sm=0 a=1U7auHjJ3WkA:10 a=IkcTkHD0fZMA:10 a=KDOwrr1Pt8ZdlByPpjMA:9 a=zbALYNx63po2oTSqKrkA:7 a=N0KweNuqVUpZrg4zPjMlvxT_pFUA:4 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151897>

On 25/07/10 23:19, solsTiCe d'Hiver wrote:
<snip>
> When I add the above command at line 98, it shows it is really bash
> running:
> 4.1.7(2)-release
> cmdhist:expand_aliases:extglob:extquote:force_fignore:interactive_comments:progcomp:promptvars:sourcepath 

Hmm, that's interesting.  It's certainly bash, but I don't see
"login_shell" in the list, which suggests that something is loading bash
completion stuff in a non-interactive shell that has no need for it.
That might increase your your boot time a bit, so you may want to take
it up with Arch Linux when we've got to the bottom of this.

One way I've found to replicate your behaviour is to call bash as sh:

$ ln -s /bin/bash sh
$ ./sh -c 'echo $BASH_VERSION'
4.1.5(1)-release
$ ./sh contrib/completion/git-completion.bash
contrib/completion/git-completion.bash: line 123: ...

Again, this fits with the theory that some non-interactive shell is
wrongly loading this stuff.

This time, could you tell me what the following debug messages print:

echo $BASHOPTS -- $SHELLOPTS -- $POSIXLY_CORRECT
tr '\0' ' ' < /proc/$$/cmdline ; echo

Could you also have a look at /bin/sh and any other files that might be
(incorrectly?) symlinked to bash?

On a wider point, I consider the bash/sh behaviour above to be a bug,
whether or not it's the cause of this specific problem.  Unless someone
wants to tell me about git's long-standing policy against it, I'll try
and find some time to send in a patch warning usefully in this case.

	- Andrew
