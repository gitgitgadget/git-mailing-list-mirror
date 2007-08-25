From: David Kastrup <dak@gnu.org>
Subject: Re: Problem with git-gui and relative directories
Date: Sat, 25 Aug 2007 09:26:20 +0200
Message-ID: <85veb4dqhv.fsf@lola.goethe.zz>
References: <868x81vynk.fsf@lola.quinscape.zz>
	<20070825031834.GW27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 09:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOq2c-0005z4-VC
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 09:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558AbXHYH0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 03:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbXHYH0j
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 03:26:39 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:55809 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189AbXHYH0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 03:26:22 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IOq2F-000230-4N; Sat, 25 Aug 2007 03:26:19 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D42DE1C39500; Sat, 25 Aug 2007 09:26:20 +0200 (CEST)
In-Reply-To: <20070825031834.GW27913@spearce.org> (Shawn O. Pearce's message of "Fri\, 24 Aug 2007 23\:18\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56625>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  git-gui.sh |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 743b7d4..fa30ccc 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -703,7 +703,15 @@ if {![file isdirectory $_gitdir]} {
>  	error_popup "Git directory not found:\n\n$_gitdir"
>  	exit 1
>  }
> -if {![is_enabled bare]} {
> +if {$_prefix ne {}} {
> +	regsub -all {[^/]+/} $_prefix ../ cdup

I don't like this approach.  It assumes too much about the file system
and cleanliness of paths.  It does all of the following:

/somedir/ -> /../
/somedir -> /somedir
//server/somedir -> //../somedir
/somedir//someother -> /..//someother

and so on.  It can't deal with directory symlinks properly.  And the
approach does not scale to Windows and other systems with diverging
path syntaxes at all.

Isn't it possible to move to the workdir root for the purpose of
interpreting workdir root relative filenames?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
