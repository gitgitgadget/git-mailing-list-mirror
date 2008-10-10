From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Correctly set up locators in case of preset
	URL variable
Date: Fri, 10 Oct 2008 09:42:55 -0700
Message-ID: <20081010164255.GD29829@spearce.org>
References: <20080930195839.GK21310@spearce.org> <1223028826-10306-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Petr Baudis <petr.baudis@novartis.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 10 18:44:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoL60-0005DE-MN
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 18:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323AbYJJQm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 12:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756771AbYJJQm5
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 12:42:57 -0400
Received: from george.spearce.org ([209.20.77.23]:50333 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001AbYJJQm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 12:42:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0A21938360; Fri, 10 Oct 2008 16:42:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223028826-10306-1-git-send-email-pasky@suse.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97948>

Petr Baudis <pasky@suse.cz> wrote:
> This patch fixes locators setup in case the URL variable is already set,
> e.g. in the clone dialog during 'git gui clone'.

Huh.  Better, but Remote->Push... still crashes with your series:

can't read "push_url": no such variable
can't read "push_url": no such variable
    while executing
"set $urlvar"
    (procedure "location_input" line 26)
    invoked from within
"location_input $w.dest.url_t push_url push"
    (procedure "do_push_anywhere" line 53)
    invoked from within
"do_push_anywhere"
    invoked from within
".#mbar.#mbar#remote invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .#mbar.#mbar#remote 1"
    (command bound to event)

 
> diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
> index 277e6b8..02c4eca 100644
> --- a/git-gui/lib/transport.tcl
> +++ b/git-gui/lib/transport.tcl
> @@ -68,8 +68,13 @@ proc location_input {widget urlvar op} {
>  
>  	global _locator_template _locator_input _locator_var
>  	trace remove variable _locator_input write locator_update
> -	set _locator_template $default_locator
> -	set _locator_input {}
> +	if {[set $urlvar] == {}} {
> +		set _locator_template $default_locator
> +		set _locator_input {}
> +	} else {
> +		set _locator_template "URL"
> +		set _locator_input [set $urlvar]
> +	}
>  	set _locator_var $urlvar
>  	trace add variable _locator_input write locator_update
>  
> -- 
> tg: (3c6c738..) t/git-gui/locator-preset (depends on: git-gui/locators t/git-gui/clonecmd)

-- 
Shawn.
