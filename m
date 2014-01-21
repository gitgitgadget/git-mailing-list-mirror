From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Comply with XDG base directory specification
Date: Tue, 21 Jan 2014 22:10:41 +1100
Message-ID: <20140121111041.GC8265@iris.ozlabs.ibm.com>
References: <1386963996-5481-1-git-send-email-astrilhayato@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Astril Hayato <astrilhayato@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 12:19:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5ZMl-00085f-MZ
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 12:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbaAULTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 06:19:19 -0500
Received: from ozlabs.org ([203.10.76.45]:51638 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021AbaAULTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 06:19:19 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 54DB42C0089; Tue, 21 Jan 2014 22:19:18 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1386963996-5481-1-git-send-email-astrilhayato@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240750>

On Fri, Dec 13, 2013 at 07:46:36PM +0000, Astril Hayato wrote:
> Write the gitk config data to $XDG_CONFIG_HOME/git/gitk ($HOME/.config/git/gitk
> by default) in line with the XDG specification. This makes it consistent with
> git which also follows the spec.
> 
> If $HOME/.gitk already exists use that for backward compatibility, so only new
> installations are affected.

Sounds reasonable...

> @@ -12058,7 +12061,27 @@ namespace import ::msgcat::mc
>  ## And eventually load the actual message catalog
>  ::msgcat::mcload $gitk_msgsdir
>  
> -catch {source ~/.gitk}
> +catch {
> +    # follow the XDG base directory specification by default. See
> +    # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
> +    if {[info exists env(XDG_CONFIG_HOME)] && $env(XDG_CONFIG_HOME) ne ""} {
> +	# XDG_CONFIG_HOME environment variable is set
> +	set config_file [file join $env(XDG_CONFIG_HOME) git gitk]
> +	set config_file_tmp [file join $env(XDG_CONFIG_HOME) git gitk-tmp]
> +    } else {
> +	# default XDG_CONFIG_HOME
> +	set config_file "~/.config/git/gitk"
> +	set config_file_tmp "~/.config/git/gitk-tmp"
> +    }
> +    if {![file exists $config_file]} {
> +	if {![file exists [file dirname $config_file]]} {
> +	    file mkdir [file dirname $config_file]
> +	}
> +	# for backward compatability use the old config file if it exists
> +	if {[file exists "~/.gitk"]} {set config_file "~/.gitk"}

Don't we need to set config_file_tmp here too?

And, do we really want to create the ~/.config/git directory if we are
using the old-style ~/.gitk as the config file?

Paul.
