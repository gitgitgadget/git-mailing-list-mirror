From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] fetch: try mirrors if selected
Date: Wed, 25 Nov 2009 17:20:22 -0800
Message-ID: <20091126012022.GP11919@spearce.org>
References: <1259143617-26580-1-git-send-email-sam@vilain.net> <1259143617-26580-2-git-send-email-sam@vilain.net> <1259143617-26580-3-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 02:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDT26-0003nl-GZ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 02:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758934AbZKZBUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 20:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758918AbZKZBUR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 20:20:17 -0500
Received: from george.spearce.org ([209.20.77.23]:33075 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758915AbZKZBUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 20:20:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C91223842F; Thu, 26 Nov 2009 01:20:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1259143617-26580-3-git-send-email-sam@vilain.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133751>

Sam Vilain <sam@vilain.net> wrote:
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 209f502..b3b8766 100644
> @@ -109,6 +109,109 @@ static void find_non_local_tags(struct transport *transport,
>  			struct ref **head,
>  			struct ref ***tail);
>  
> +char* get_url_hostname(const char *url)

Minor nit, but we mark any function not used outside of the module
as static.  Especially in a builtin-*.c since they all link into
the same namespace.  If this is meant to be reused, it belongs in
connect.c most likely, that's where we already have code like this
to get the SSH hostname out of a URL for SSH connections.

I don't have time right now to read the rest of this series, but
the general approach of fetching to a temporary mirror space before
checking if you really are current is a good one.

I'm not sure that storing the list of mirrors inside of the remote
makes much sense, I would think the user would want to store only
a handful of "fast" URLs.

And even then I wonder why this can't just be the url[1]..url[n-1]
entries in the configuration file.  push pushes to all of the
URLs at once, "seeding the mirrors".  Why can't fetch use the same
configuration?

-- 
Shawn.
