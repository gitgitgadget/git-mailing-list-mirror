From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Removed unnecessary use of global variables.
Date: Wed, 11 Mar 2009 11:30:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111126280.10279@pacific.mpi-cbg.de>
References: <1236730168-7164-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 11:30:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhLhF-0006LG-AB
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 11:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZCKK2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 06:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbZCKK23
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 06:28:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:46670 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753085AbZCKK22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 06:28:28 -0400
Received: (qmail invoked by alias); 11 Mar 2009 10:28:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 11 Mar 2009 11:28:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hZhlzfDHhgvPnLICfB4N2gbrq8VmrFu1cwsLfOU
	kc6SxxJf4hOAkg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1236730168-7164-1-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112906>

Hi,

On Wed, 11 Mar 2009, Erik Faye-Lund wrote:

> git_config() now takes a third data-parameter that is passed back
> to the callback-function. At the time this code was written, that
> parameter did not exist, so a somewhat nasty (but by all means
> correct) use of global variables was introduced. In commit
> ef90d6d4208a5130185b04f06e5f90a5f9959fe3 Johannes Schindelin
> <Johannes.Schindelin@gmx.de> introduced a parameter for similar
> purposes.

We tend to quote commits in this form: ef90d6d(Provide git_config with a 
callback-data parameter)

> I've changed the code to utilize this parameter to pass the
> string. In addition, I've made the function calculate the string
> length on usage instead, to reduce the parameters needed to what
> the callback-interface supplies.

Usually, commit messages are held in a more imperative form than a 
subjective one:

	Utilize this parameter to pass the string.

> diff --git a/connect.c b/connect.c
> index 2f23ab3..98fbaea 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -371,14 +371,13 @@ static void git_tcp_connect(int fd[2], char *host, int flags)
>  	fd[1] = dup(sockfd);
>  }
>  
> -
>  static char *git_proxy_command;
> -static const char *rhost_name;
> -static int rhost_len;
> -
>  static int git_proxy_command_options(const char *var, const char *value,
> -		void *cb)
> +		void *data)
>  {
> +	const char *rhost_name = data;
> +	const size_t rhost_len = strlen(rhost_name);
> +

git_proxy_command_options is called for each and every config variable.  
The idea of having the length in a local variable was to avoid 
recalculating the length each and every time.  I think I'd actually use a 
strbuf for that.

BTW I would not rename "cb", as it is only distracting the reader of the 
patch.

But I like the idea of your patch (as you can see from me replying ;-)

Thanks,
Dscho
