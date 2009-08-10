From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Limited git-gui to displaying 5000 new files
Date: Mon, 10 Aug 2009 08:38:59 -0700
Message-ID: <20090810153859.GT1033@spearce.org>
References: <4A4A77A6.1020905@lawrence.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, raa.lkml@gmail.com
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:39:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWxo-0002zS-V2
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbZHJPi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbZHJPi6
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:38:58 -0400
Received: from george.spearce.org ([209.20.77.23]:60982 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbZHJPi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:38:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6787E381FD; Mon, 10 Aug 2009 15:38:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A4A77A6.1020905@lawrence.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125465>

Dan Zwell <dzwell@gmail.com> wrote:
> When there is a large number of new or modified files,
> "display_all_files" takes a long time, and git-gui appears to
> hang. Limit the display to 5000 files, by default. This number
> is configurable as gui.maxfilesdisplayed.
>
> Show a warning if the list of files is truncated.

> @@ -1713,7 +1717,18 @@ proc display_all_files {} {
> 	set file_lists($ui_index) [list]
> 	set file_lists($ui_workdir) [list]
>
> -	foreach path [lsort [array names file_states]] {
> +	set to_display [lsort [array names file_states]]
> +	set display_limit $default_config(gui.maxfilesdisplayed)

This should use [get_config gui.maxfilesdisplayed] so that the
user can actually set this property in a configuration file and
have git-gui honor it.  Reading from $default_config means you are
only looking at the hardcoded value you set in git-gui.sh.

> +	if {[llength $to_display] > $display_limit} {
> +		if {![info exists files_warning] || !$files_warning} {

Wouldn't it be easier to just set files_warning to 0 at the start
of the script, so that you don't need to do this info exists test?

> +			set warning "Displaying only $display_limit of "
> +			append warning "[llength $to_display] files."
> +			info_popup [mc $warning]

This needs to be in the translated strings.

-- 
Shawn.
