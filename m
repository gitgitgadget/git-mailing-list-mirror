From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-clone: fix for new unpack_trees() semantics
Date: Sun, 9 Mar 2008 18:35:02 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803091829100.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081803360.19665@iabervon.org> <alpine.LSU.1.00.0803092227230.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 23:35:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYU7M-0005nQ-KI
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 23:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYCIWfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 18:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbYCIWfG
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 18:35:06 -0400
Received: from iabervon.org ([66.92.72.58]:36137 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbYCIWfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 18:35:05 -0400
Received: (qmail 17874 invoked by uid 1000); 9 Mar 2008 22:35:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 22:35:02 -0000
In-Reply-To: <alpine.LSU.1.00.0803092227230.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76676>

On Sun, 9 Mar 2008, Johannes Schindelin wrote:

> In git.git's "next" branch, unpack_trees() must specify source and target 
> index.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	To be squashed into 10/11
> 
>  builtin-clone.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index e4047ed..3890e12 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -534,6 +534,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		opts.verbose_update = !option_quiet;
>  		opts.merge = 1;
>  		opts.fn = twoway_merge;
> +		opts.src_index = &the_index;
> +		opts.dst_index = &the_index;

Actually, I think the sensible thing is to just not do a merge here, since 
we know there's no index beforehand and the two trees are the same.

I think the odd twoway merge of two copies of HEAD is just an artifact of 
clone originally just doing "git checkout HEAD", and that got translated 
various times failing to notice the special cases.

	-Daniel
*This .sig left intentionally blank*
