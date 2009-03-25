From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: Avoid dropping files from commits
Date: Wed, 25 Mar 2009 23:13:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302>
References: <1238014519-11683-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 23:15:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmbNF-0001r9-NK
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 23:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbZCYWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZCYWN3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 18:13:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:46951 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752261AbZCYWN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 18:13:28 -0400
Received: (qmail invoked by alias); 25 Mar 2009 22:13:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 25 Mar 2009 23:13:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wRwIYnYpw5+fzwOBYakVJ/7kwsWGYT5VWkhpsEK
	88sBCSInXM2u5G
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1238014519-11683-1-git-send-email-newren@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114686>

Hi,

On Wed, 25 Mar 2009, newren@gmail.com wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> When exporting a subset of commits on a branch that do not go back to a
> root commit (e.g. master~2..master), we still want each exported commit to
> have the same files in the exported tree as in the original tree.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Makes sense.

>  builtin-fast-export.c  |    3 ++-
>  t/t9301-fast-export.sh |    7 +++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index fdf4ae9..34a419c 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -221,7 +221,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>  	if (message)
>  		message += 2;
>  
> -	if (commit->parents) {
> +	if (commit->parents &&
> +	    get_object_mark(&commit->parents->item->object) != 0) {
>  		parse_commit(commit->parents->item);
>  		diff_tree_sha1(commit->parents->item->tree->object.sha1,
>  			       commit->tree->object.sha1, "", &rev->diffopt);

I do not understand that change.

A good explanation in the commit message might help this stupid developer.

Ciao,
Dscho
