From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] packed_git: convert pack_local flag into generic
	bit mask
Date: Mon, 3 Nov 2008 08:12:02 -0800
Message-ID: <20081103161202.GJ15463@spearce.org>
References: <14536526.1225596838300.JavaMail.teamon@b301.teamon.com> <6141358.1225643400587.JavaMail.teamon@b303.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, nico@cam.org
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 03 17:13:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx23O-0005ko-EH
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbYKCQMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 11:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755785AbYKCQMF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:12:05 -0500
Received: from george.spearce.org ([209.20.77.23]:38810 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbYKCQME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 11:12:04 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 978293835F; Mon,  3 Nov 2008 16:12:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <6141358.1225643400587.JavaMail.teamon@b303.teamon.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99957>

drafnel@gmail.com wrote:
> This is in preparation for adding a flag indicating whether a .keep file is
> present.

Good idea.
 
> diff --git a/cache.h b/cache.h
> index b0edbf9..0cb9350 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -679,12 +679,15 @@ extern struct packed_git {
>  	int index_version;
>  	time_t mtime;
>  	int pack_fd;
> -	int pack_local;
> +	unsigned int flags;

Hmm, isn't this a smaller change to make?

-	int pack_local;
+	unsigned pack_local:1;

Then later you can do:

-	unsigned pack_local:1;
+	unsigned pack_local:1,
+		pack_keep:1;

and the compiler handles all the bitmask stuff for you?

In general in git.git we like to use the struct bitmask stuff when
possible as the code is easier to follow.  We only use explicit
mask constants and mask operations when the data is being stored
on disk or written over the network and we need to ensure it is
consistent across compilers.  But for in-core only stuff, struct
bitmasks are easier.

-- 
Shawn.
