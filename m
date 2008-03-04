From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] git-submodule - Allow adding a submodule in-place
Date: Tue, 4 Mar 2008 12:22:59 +0100
Message-ID: <20080304112259.GM4703MdfPADPa@greensroom.kotnet.org>
References: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pkufranky@gmail.com
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVFY-0000JO-VT
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbYCDLXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756003AbYCDLXY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:23:24 -0500
Received: from cavuit02.kulnet.kuleuven.be ([134.58.240.44]:59266 "EHLO
	cavuit02.kulnet.kuleuven.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755089AbYCDLXX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2008 06:23:23 -0500
Received: from smtps01.kuleuven.be (smtpshost01.kulnet.kuleuven.be [134.58.240.74])
	by cavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id 700B275B85E
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 12:23:04 +0100 (CET)
Received: from greensroom.kotnet.org (10-92-86-131.kotnet.org [10.92.86.131])
	by smtps01.kuleuven.be (Postfix) with SMTP id E271531E704
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 12:23:03 +0100 (CET)
Received: (qmail 29251 invoked by uid 500); 4 Mar 2008 11:23:00 -0000
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
Content-Disposition: inline
In-Reply-To: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Mutt/1.5.10i
X-KULeuven-Information: Katholieke Universiteit Leuven
X-KULeuven-Scanned: Found to be clean
X-Spam-Status: not spam, SpamAssassin (not cached, score=-49.9, required 5,
	autolearn=disabled, KUL_SMTPS -50.00, RDNS_DYNAMIC 0.10)
X-KULeuven-Envelope-From: skimo@kotnet.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76066>

On Mon, Mar 03, 2008 at 09:06:23PM -0500, Mark Levedahl wrote:
> @@ -9,17 +9,18 @@ git-submodule - Initialize, update or inspect submodules
>  SYNOPSIS
>  --------
>  [verse]
> -'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
> +'git-submodule' [--quiet] add [-b branch] [-r <remote>] [--] <repository> [<path>]
>  'git-submodule' [--quiet] status [--cached] [--] [<path>...]
> -'git-submodule' [--quiet] [init|update] [--] [<path>...]
> +'git-submodule' [--quiet] [init|update] [-r <remote>] [--] [<path>...]
>  
> @@ -55,6 +56,18 @@ OPTIONS
>  -b, --branch::
>  	Branch of repository to add as submodule.
>  
> +-r remote::
> +	Name of remote to use or define when working with relative submodules
> +	(i.e., submodules whose url is given relative to the top-level
> +	project). If this value is undefined, the top-level project's
> +	branch.<name>.remote is used, and if that is undefined the default
> +	"origin" is used. The remote will be defined in each relative
> +	submodule as needed by appending the relative url to the top level
> +	project's url. This option has no effect upon submodules defined
> +	using an absolute url: such project's are cloned using the default
> +	"origin," and are updated using the submodule's branch.<name>.remote
> +	machinery and defaulting to "origin."
> +

As has been noted by others, these changes don't belong in this commit.

As to the functionality actually provided by this patch,
I'm somewhat concerned with encouraging this kind of setup,
where the main (and only) copy of your subproject repo
is stored inside the working tree.

Ideally (for some at least), switching back to a commit
of the superproject from before the subproject was added
should remove the subproject from the working tree.
This means that the GIT_DIR of the subproject should be
stored somewhere under the GIT_DIR of the superproject.
There was some talk about doing this about a year ago,
but AFAIK, it hasn't gotten implemented yet.
It's easier to handle this when adding a subproject that
does not already exist in the tree.

Of course, if this feature would ever get implemented, then
it would also have to provide an upgrade path from the
current setup and that upgrade path would also handle your
case.  So this is not really an objection, but just a concern.

skimo
