From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Improve documentation for git-remote-helpers
Date: Sun, 21 Mar 2010 19:29:50 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003211907390.14365@iabervon.org>
References: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com> <f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-291763999-1269214190=:14365"
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 00:29:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtUai-0002YY-Tu
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 00:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0CUX3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 19:29:52 -0400
Received: from iabervon.org ([66.92.72.58]:56195 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887Ab0CUX3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 19:29:51 -0400
Received: (qmail 11793 invoked by uid 1000); 21 Mar 2010 23:29:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Mar 2010 23:29:50 -0000
In-Reply-To: <f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142873>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-291763999-1269214190=:14365
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

I'd like to start by saying that it's good to see patches early, and also 
that I think the best documentation comes from people who are new to 
something going back and forth with people who know it too well to know 
what needs to be said about it.

On Sun, 21 Mar 2010, Ramkumar Ramachandra wrote:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-remote-helpers.txt |   22 ++++++++++++++++------
>  1 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-remote-helpers.txt
> b/Documentation/git-remote-helpers.txt
> index 1b5f61a..54b36c8 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -3,7 +3,8 @@ git-remote-helpers(1)
> 
>  NAME
>  ----
> -git-remote-helpers - Helper programs for interoperation with remote git
> +git-remote-helpers - Helper programs for interacting with main git
> +programs without linking to them

I think the name is supposed to fit on a single line. Adding more 
explanation is good, but probably more appropriate below.

>  SYNOPSIS
>  --------
> @@ -13,10 +14,19 @@ DESCRIPTION
>  -----------
> 
>  These programs are normally not used directly by end users, but are
> -invoked by various git programs that interact with remote repositories
> -when the repository they would operate on will be accessed using
> -transport code not linked into the main git binary. Various particular
> -helper programs will behave as documented here.
> +invoked by various git programs that interact with remote
> +repositories.  For a program to qualify as a remote helper, it must
> +implement a subset of the capabilities documented here, and conform to
> +the remote helper protocol. Remote helpers interact with the main git
> +programs via text streams, and do not link to them.
> +
> +The curl helper is one such program. It is invoked via
> +'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
> +'git-remote-ftps', and implments the capabilities 'fetch', 'option',
> +and 'push'.
> +
> +Remote helpers are often useful when native interoperability with a
> +foreign versioning system is desired.

You should probably make clear that a helper can provide a fast-import 
stream (a format which has been adopted by other version control systems) 
instead of native git objects, if the helper is not exchanging git objects 
from the remote repository and trying to preserve their identities. The 
curl helper is unusual in that it just moves git pbjects from place to 
place. (That is, the curl helper uses 'fetch' and 'push', but other 
helpers will mostly use 'import' and 'export'; the curl helper does need 
the ability to use the git object database, but other helpers mostly 
won't.)

>  COMMANDS
>  --------
> @@ -122,7 +132,7 @@ CAPABILITIES
>        This helper supports the 'fetch' command.
> 
>  'option'::
> -       This helper supports the option command.
> +       This helper supports the 'option' command.

Yup. Or maybe these should be documented as a list of capabilities which 
mean that the helper supports the command with the same name, since that's 
a common pattern, and documenting it as a pattern makes it obvious that, 
if we have a new 'export' command, and it needs a capability, it'll fit 
the pattern.

>  'push'::
>        This helper supports the 'push' command.
> --
> 1.7.0
> 

	-Daniel
*This .sig left intentionally blank*
--1547844168-291763999-1269214190=:14365--
