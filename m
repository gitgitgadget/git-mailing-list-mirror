From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 18:28:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711301828050.27959@racer.site>
References: <7veje8twt2.fsf@gitster.siamese.dyndns.org>
 <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
 <20071130005852.GA12224@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
 <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de> <20071130151223.GB22095@coredump.intra.peff.net>
 <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com>
 <20071130152942.GA22489@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org>
 <20071130162257.GA22882@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi B?jar <sbejar@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 19:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyAcF-0003U3-7Y
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 19:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759521AbXK3S3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759436AbXK3S3K
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 13:29:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:35594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758813AbXK3S3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 13:29:08 -0500
Received: (qmail invoked by alias); 30 Nov 2007 18:29:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 30 Nov 2007 19:29:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195RxU/xEF5x3m3Nm7e6frQstvzhcX3YLMqGAc5G/
	nQusJq8VoHLp/j
X-X-Sender: gene099@racer.site
In-Reply-To: <20071130162257.GA22882@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66654>

Hi,

On Fri, 30 Nov 2007, Jeff King wrote:

> Support builtin aliases
> 
> Builtin aliases are "default" alias values that can be
> overridden by user-configured aliases.
> 
> For example, the first such alias is "view", an alias for
> gitk. A user with no further configuration can run
> "git view" to use gitk. However, they can also set the
> config option "alias.view" to "!tig" to run tig.
> ---
>  git.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/git.c b/git.c
> index f220284..95296aa 100644
> --- a/git.c
> +++ b/git.c
> @@ -151,6 +151,13 @@ static int split_cmdline(char *cmdline, const char ***argv)
>  	return count;
>  }
>  
> +static char *builtin_alias(const char *cmd)
> +{
> +	if (!strcmp(cmd, "view"))
> +		return xstrdup("!gitk");
> +	return NULL;
> +}
> +
>  static int handle_alias(int *argcp, const char ***argv)
>  {
>  	int nongit = 0, envchanged = 0, ret = 0, saved_errno = errno;
> @@ -162,6 +169,8 @@ static int handle_alias(int *argcp, const char ***argv)
>  
>  	alias_command = (*argv)[0];
>  	git_config(git_alias_config);
> +	if (!alias_string)
> +		alias_string = builtin_alias(alias_command);
>  	if (alias_string) {
>  		if (alias_string[0] == '!') {
>  			if (*argcp > 1) {

Didn't you mean to put this _before_ the git_config() call?  As you wrote 
it, the "soft" alias overrides the user-specified one.

Ciao,
Dscho
