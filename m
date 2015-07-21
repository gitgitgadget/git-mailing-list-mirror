From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4] gitk: Add a "Copy commit summary" command
Date: Tue, 21 Jul 2015 12:19:23 +0200
Message-ID: <55AE1CAB.9040404@drbeat.li>
References: <1437218139-7031-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 12:19:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHUeB-0003QW-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 12:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbbGUKTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 06:19:34 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:39384 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbbGUKTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 06:19:33 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 4C56FC3447;
	Tue, 21 Jul 2015 12:19:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 271B7C343D;
	Tue, 21 Jul 2015 12:19:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1437218139-7031-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274371>

Guys,

can I get a Yea or Nay for this patch?

Does it go in via Paul's gitk repo or directly through Junio?


Thanks,
Beat

On 18.07.15 13:15, Beat Bolli wrote:
> When referring to earlier commits in commit messages or other text, one
> of the established formats is
> 
>     <abbrev-sha> ("<summary>", <author-date>)
> 
> Add a "Copy commit summary" command to the context menu that puts this
> text for the currently selected commit on the clipboard. This makes it
> easy for our users to create well-formatted commit references.
> 
> The <abbrev-sha> is produced with the %h format specifier to make it
> unique. Its length can be controlled with the gitk preference
> "Auto-select SHA1 (length)", or, if this preference is set to its
> default value (40), with the Git config setting core.abbrev.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
> Changes since v3:
> - consider $autosellen for the --abbrev value
> 
> Changes since v2:
> - call git show to produce a unique <abbrev-sha>
> - use the short date format
> 
> Changes since v1:
> - drop the "commit " literal in front of the <abbrev-sha>
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  gitk-git/gitk | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 9a2daf3..d05169a 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2617,6 +2617,7 @@ proc makewindow {} {
>  	{mc "Diff selected -> this" command {diffvssel 1}}
>  	{mc "Make patch" command mkpatch}
>  	{mc "Create tag" command mktag}
> +	{mc "Copy commit summary" command copysummary}
>  	{mc "Write commit to file" command writecommit}
>  	{mc "Create new branch" command mkbranch}
>  	{mc "Cherry-pick this commit" command cherrypick}
> @@ -9341,6 +9342,20 @@ proc mktaggo {} {
>      mktagcan
>  }
>  
> +proc copysummary {} {
> +    global rowmenuid autosellen
> +
> +    set format "%h (\"%s\", %ad)"
> +    set cmd [list git show -s --pretty=format:$format --date=short]
> +    if {$autosellen < 40} {
> +        lappend cmd --abbrev=$autosellen
> +    }
> +    set summary [eval exec $cmd $rowmenuid]
> +
> +    clipboard clear
> +    clipboard append $summary
> +}
> +
>  proc writecommit {} {
>      global rowmenuid wrcomtop commitinfo wrcomcmd NS
>  
> 
