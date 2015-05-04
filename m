From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv2] gitk: Show the current view's name in the window title.
Date: Mon, 04 May 2015 10:26:29 -0400
Message-ID: <55478195.4070301@xiplink.com>
References: <20150406043711.GC31463@iris.ozlabs.ibm.com> <1428421911-20393-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 16:26:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpHKN-00045F-O8
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 16:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbbEDO0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 10:26:31 -0400
Received: from smtp90.ord1c.emailsrvr.com ([108.166.43.90]:43278 "EHLO
	smtp90.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707AbbEDO0a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2015 10:26:30 -0400
Received: from smtp12.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp12.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id C1DE8380237;
	Mon,  4 May 2015 10:26:29 -0400 (EDT)
Received: by smtp12.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 716B3380722;
	Mon,  4 May 2015 10:26:29 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Mon, 04 May 2015 14:26:29 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1428421911-20393-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268328>

On 15-04-07 11:51 AM, Marc Branchaud wrote:
> If the current view is the "Command line" view, show the command line
> arguments instead of the view name.
> 
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> This is v2 of my previous "Show the command-line revs in the window title" RFC
> patch.  (I'm having trouble accessing gmane, or I'd include a link here.)
> 
> This version incorporates Paul's feedback (thanks!) and handles view properly.

Ping?

		M.


> 		M.
> 
>  gitk | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/gitk b/gitk
> index b859879..90419e3 100755
> --- a/gitk
> +++ b/gitk
> @@ -4034,6 +4034,19 @@ proc shellsplit {str} {
>      return $l
>  }
>  
> +proc set_window_title {} {
> +    global appname curview viewname vrevs
> +    set rev [mc "All files"]
> +    if {$curview ne 0} {
> +	if {$viewname($curview) eq [mc "Command line"]} {
> +	    set rev [string map {"--gitk-symmetric-diff-marker" "--merge"} $vrevs($curview)]
> +	} else {
> +	    set rev $viewname($curview)
> +	}
> +    }
> +    wm title . "[reponame]: $rev - $appname"
> +}
> +
>  # Code to implement multiple views
>  
>  proc newview {ishighlight} {
> @@ -4510,6 +4523,7 @@ proc showview {n} {
>      } elseif {$numcommits == 0} {
>  	show_status [mc "No commits selected"]
>      }
> +    set_window_title
>  }
>  
>  # Stuff relating to the highlighting facility
> @@ -6650,6 +6664,7 @@ proc show_status {msg} {
>      global canv fgcolor
>  
>      clear_display
> +    set_window_title
>      $canv create text 3 3 -anchor nw -text $msg -font mainfont \
>  	-tags text -fill $fgcolor
>  }
> @@ -12393,7 +12408,7 @@ catch {
>  }
>  # wait for the window to become visible
>  tkwait visibility .
> -wm title . "[reponame] - $appname"
> +set_window_title
>  update
>  readrefs
>  
> 
