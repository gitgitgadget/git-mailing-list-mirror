From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-gui: properly check for a bare repo
Date: Wed, 18 Feb 2009 09:16:39 -0800
Message-ID: <20090218171639.GE22848@spearce.org>
References: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com> <1234144850-2903-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZq3m-0001ou-NL
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 18:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbZBRRQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 12:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbZBRRQk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 12:16:40 -0500
Received: from george.spearce.org ([209.20.77.23]:59462 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbZBRRQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 12:16:39 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 34B3C381FF; Wed, 18 Feb 2009 17:16:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234144850-2903-2-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110561>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> When bare repository handling is not enabled, check for a bare
> repository looking at the core.bare config option rather than refusing
> to operate with a git directory ending with .git.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> I know I should have probably used something like
> git rev-parse --is-bare-repository instead, but I didn't feel like
> adding another git call. Is the config approach robust enough?
> 
>  git-gui/git-gui.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index e018e07..658a728 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1071,7 +1071,7 @@ if {$_prefix ne {}} {
>  	}
>  	unset cdup
>  } elseif {![is_enabled bare]} {
> -	if {[lindex [file split $_gitdir] end] ne {.git}} {
> +	if {[is_config_true core.bare]} {

This doesn't work as you expect.  Its a chicken-and-egg problem.
We haven't read the config yet because we aren't sure that the
$_gitdir really is a git directory.  Consequently, core.bare is
always false.

However, yes, in modern versions of git the core.bare setting in
.git/config is *usually* accurate.

The only time it isn't is when its not present (really old repository
which hasn't been re-init'd in a long time), or when the user does
"mv .git ../foo.git" to create a bare repository from a non-bare one.

;-)

-- 
Shawn.
