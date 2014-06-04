From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [PATCH v2 8/9] fetch doc: add a section on configured remote-tracking
 branches
Date: Wed, 04 Jun 2014 10:55:21 -0400
Message-ID: <538F3359.2050601@xiplink.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com> <1401833792-2486-9-git-send-email-gitster@pobox.com>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 17:02:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsChU-0001o6-NX
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 17:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbaFDPBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 11:01:43 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:50517 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbaFDPBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 11:01:41 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jun 2014 11:01:41 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 8E964200B41;
	Wed,  4 Jun 2014 10:55:16 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2EBEF200902;
	Wed,  4 Jun 2014 10:55:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401833792-2486-9-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250735>

On 14-06-03 06:16 PM, Junio C Hamano wrote:
> To resurrect a misleading mention removed in the previous step,
> add a section to explain how the remote-tracking configuration
> interacts with the refspecs given as the command-line arguments.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-fetch.txt | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index 06106b9..d09736a 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -51,6 +51,49 @@ include::pull-fetch-param.txt[]
>  include::urls-remotes.txt[]
>  
>  
> +CONFIGURED REMOTE-TRACKING BRANCHES
> +-----------------------------------
> +
> +You would often interact with the same remote repository by

s/would//

> +regularly and repeatedly fetching from it.  In order to keep track
> +of the progress of such a remote repository, `git fetch` allows you
> +to configure `remote.<repository>.fetch` configuration variable.

/variable/variables/

> +
> +Typically such a variable may look like this:
> +
> +------------------------------------------------
> +[remote "origin"]
> +	fetch = +refs/heads/*:refs/remotes/origin/*
> +------------------------------------------------
> +
> +This configuration is used in two ways:
> +
> +* When `git fetch` command is run without specifying what branches

s/command//

> +  and/or tags to fetch on the command line, e.g. `git fetch origin`
> +  or `git fetch`, the values configured to this variable are used as

s/values configured to this variable/`remote.<repository>.fetch` values/

> +  the refspecs to be used to fetch.  The example above will fetch

/to be used//

> +  all branches that exist on the `origin` (i.e. any ref that matches

s/on/in/

> +  the left-hand side of the value, `refs/heads/*`) and update the
> +  corresponding remote-tracking branches in `refs/remotes/origin/*`

s/in/in the/

> +  hierarchy.
> +
> +* When `git fetch` command is run with explicit branches and/or tags

s/command//

> +  to fetch on the command line, e.g. `git fetch origin master`, the
> +  <refspec> given on the command line (e.g. `master` in the example,
> +  which is a short-hand for `master:`, which in turn would mean
> +  "fetch the 'master' branch but I do not explicitly say what
> +  remote-tracking branch to update with it from the command line")
> +  determines what are to be fetched, and the example command will

Change "determines what are to be fetched" to "determines what gets fetched"
and move the phrase to before the parenthetical comment.

> +  fetch _only_ the 'master' branch.  The values of the variable are

s/values of the variable/`remote.<repository>.fetch` values/

> +  used to map the branch (i.e. `master`) to determine which

s/used to map the branch (i.e. `master`) to//

> +  remote-tracking branch, if any, is updated.  When used in this
> +  way, the values of the configuration variable do not have any

s/values of the configuration variable/`remote.<repository>.fetch` values/

		M.


> +  effect in deciding _what_ gets fetched (i.e. the values are not
> +  used as refspecs when the command-line lists refspecs); they are
> +  only used to decide _where_ the refs that are fetched are stored
> +  by acting as a mapping.
> +
> +
>  EXAMPLES
>  --------
>  
> 
