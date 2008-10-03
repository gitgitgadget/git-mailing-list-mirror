From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Use "git_config_string" to simplify "remote.c" code in
 "handle_config"
Date: Fri, 03 Oct 2008 07:28:42 +0200
Message-ID: <48E5AD8A.4070301@op5.se>
References: <20081003033937.GA11594@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 07:30:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KldEl-000719-FN
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 07:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbYJCF2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 01:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbYJCF2t
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 01:28:49 -0400
Received: from mail.op5.se ([193.201.96.20]:50748 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbYJCF2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 01:28:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7802324B0006;
	Fri,  3 Oct 2008 07:20:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C7kFaNIZUkTV; Fri,  3 Oct 2008 07:20:19 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 1B1D324B004E;
	Fri,  3 Oct 2008 07:20:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081003033937.GA11594@eratosthenes.cryptobackpack.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97395>

David Bryson wrote:
> Signed-off-by: David Bryson <david@statichacks.org>
> 
> I tried to keep with the naming/coding conventions that I found in
> remote.c.  Feedback welcome.
> 
> ---
>  remote.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index 3f3c789..893a739 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -305,6 +305,7 @@ static int handle_config(const char *key, const char *value, void *cb)
>  {
>  	const char *name;
>  	const char *subkey;
> +	const char *v;


Not very mnemonic. I'm sure you can think up a better name, even if it's
a long one. Git is notoriously sparse when it comes to comments. We rely
instead on self-explanatory code.


>  	struct remote *remote;
>  	struct branch *branch;
>  	if (!prefixcmp(key, "branch.")) {
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
>  			if (branch == current_branch)
>  				default_remote_name = branch->remote_name;
>  		} else if (!strcmp(subkey, ".merge")) {
> -			if (!value)
> -				return config_error_nonbool(key);
> -			add_merge(branch, xstrdup(value));
> +			if (git_config_string(&v, key, value )) 
> +				return 	-1;
> +			add_merge(branch, v);
>  		}
>  		return 0;
>  	}
> @@ -334,9 +335,9 @@ static int handle_config(const char *key, const char *value, void *cb)
>  			return 0;
>  		rewrite = make_rewrite(name, subkey - name);
>  		if (!strcmp(subkey, ".insteadof")) {
> -			if (!value)
> -				return config_error_nonbool(key);
> -			add_instead_of(rewrite, xstrdup(value));
> +			if (git_config_string(&v, key, value )) 
> +				return 	-1;
> +			add_instead_of(rewrite, v);
>  		}
>  	}
>  	if (prefixcmp(key,  "remote."))


Other than that, the patch looks good.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
