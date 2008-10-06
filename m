From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use "git_config_string" to simplify "remote.c" code in
 "handle_config"
Date: Mon, 6 Oct 2008 16:13:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810061610400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081003033937.GA11594@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 16:08:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmqko-0007Vd-Hb
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYJFOGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbYJFOGz
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:06:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:58673 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751552AbYJFOGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:06:54 -0400
Received: (qmail invoked by alias); 06 Oct 2008 14:06:52 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 06 Oct 2008 16:06:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EhFNfi6ZEjCY1xiAqZn+W44rwJ8mZccG2NdAyB5
	ZM/nbvF6spgz1P
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081003033937.GA11594@eratosthenes.cryptobackpack.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97582>

Hi,

On Thu, 2 Oct 2008, David Bryson wrote:

> 
> Signed-off-by: David Bryson <david@statichacks.org>
> 
> I tried to keep with the naming/coding conventions that I found in
> remote.c.  Feedback welcome.
> 
> ---

Usually this comment goes after the --- but other than that, the form is 
as perfect as you can wish for.

> @@ -314,15 +315,15 @@ static int handle_config(const char *key, const char *value, void *cb)
>  			return 0;
>  		branch = make_branch(name, subkey - name);
>  		if (!strcmp(subkey, ".remote")) {
> -			if (!value)
> -				return config_error_nonbool(key);
> -			branch->remote_name = xstrdup(value);
> +			if (git_config_string(&v, key, value) ) 
> +				return -1;
> +			branch->remote_name = v;

What is the reason not to write

			if (git_config_string(&branch->remote_name, key, value))
				return -1;

?  (Also note that we do not like the space between the two closing 
parentheses.)

Ciao,
Dscho
