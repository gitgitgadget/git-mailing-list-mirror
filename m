From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] bundle: Use OFS_DELTA in bundle files
Date: Sun, 06 Feb 2011 20:28:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102062027300.12104@xanadu.home>
References: <1296953933-8474-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 07 02:28:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmFtp-00031N-IN
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 02:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1BGB2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 20:28:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18719 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab1BGB2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 20:28:06 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG8006KH42U6Y30@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 Feb 2011 20:28:06 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1296953933-8474-1-git-send-email-spearce@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166219>

On Sat, 5 Feb 2011, Shawn O. Pearce wrote:

> git-bundle first appeared in 2e0afafe ("Add git-bundle") in Feb 2007,
> and first shipped in Git 1.5.1.
> 
> However, OFS_DELTA is an even earlier invention, coming about in
> eb32d236 ("introduce delta objects with offset to base") in Sep 2006,
> and first shipped in Git 1.4.4.5.
> 
> OFS_DELTA is smaller, about 3.2%-5% smaller, and is typically faster
> to access than REF_DELTA because the exact location of the delta base
> is available after parsing the object header.  Since all bundle aware
> versions of Git are also OFS_DELTA aware, just make it the default.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  bundle.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/bundle.c b/bundle.c
> index 65ea26b..f48fd7d 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -200,7 +200,7 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	int bundle_fd = -1;
>  	int bundle_to_stdout;
>  	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
> -	const char **argv_pack = xmalloc(5 * sizeof(const char *));
> +	const char **argv_pack = xmalloc(6 * sizeof(const char *));
>  	int i, ref_count = 0;
>  	char buffer[1024];
>  	struct rev_info revs;
> @@ -346,7 +346,8 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	argv_pack[1] = "--all-progress-implied";
>  	argv_pack[2] = "--stdout";
>  	argv_pack[3] = "--thin";
> -	argv_pack[4] = NULL;
> +	argv_pack[4] = "--delta-base-offset";
> +	argv_pack[5] = NULL;
>  	memset(&rls, 0, sizeof(rls));
>  	rls.argv = argv_pack;
>  	rls.in = -1;
> -- 
> 1.7.4.rc3.268.g2af8b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
