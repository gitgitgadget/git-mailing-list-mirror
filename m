From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Thu, 16 Jul 2015 22:48:49 +0200
Message-ID: <55A818B1.4000205@kdbg.org>
References: <1437060565-4716-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFq5T-00023y-NN
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 22:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbbGPUsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 16:48:55 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:63851 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751166AbbGPUsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 16:48:54 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mXSNg2nhvz5tlD;
	Thu, 16 Jul 2015 22:48:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id EB1025148;
	Thu, 16 Jul 2015 22:48:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1437060565-4716-1-git-send-email-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274044>

Am 16.07.2015 um 17:29 schrieb Beat Bolli:
> When referring to earlier commits in commit messages or other text, one
> of the established formats is
>
>      <abbrev-sha> ("<summary>", <author-date>)
>
> Add a "Copy commit summary" command to the context menu that puts this
> text for the currently selected commit on the clipboard. This makes it
> easy for our users to create well-formatted commit references.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
>   gitk-git/gitk | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 9a2daf3..72a2756 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2617,6 +2617,7 @@ proc makewindow {} {
>   	{mc "Diff selected -> this" command {diffvssel 1}}
>   	{mc "Make patch" command mkpatch}
>   	{mc "Create tag" command mktag}
> +	{mc "Copy commit summary" command copysummary}
>   	{mc "Write commit to file" command writecommit}
>   	{mc "Create new branch" command mkbranch}
>   	{mc "Cherry-pick this commit" command cherrypick}
> @@ -9341,6 +9342,19 @@ proc mktaggo {} {
>       mktagcan
>   }
>
> +proc copysummary {} {
> +    global rowmenuid commitinfo
> +
> +    set id [string range $rowmenuid 0 7]

You abbreviate the commit name to 7 characters. This is too short for 
certain repositories to remain unique. In my group, it is customary to 
abbreviate to 8 charaters. This reduces the usefulness for my use. If 
you don't want to make this a configuration I would suggest to aim for a 
longer commit name as it is simpler to delete excess letters after 
pasting than to add back the missing ones.

Except for this, I like the idea.

> +    set info $commitinfo($rowmenuid)
> +    set commit [lindex $info 0]
> +    set date [formatdate [lindex $info 2]]
> +    set summary "$id (\"$commit\", $date)"
> +
> +    clipboard clear
> +    clipboard append $summary
> +}
> +
>   proc writecommit {} {
>       global rowmenuid wrcomtop commitinfo wrcomcmd NS
>
>

-- Hannes
