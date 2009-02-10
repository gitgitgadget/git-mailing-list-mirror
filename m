From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 1/2] code cleanup in sha1_file.c: xmalloc -> xcalloc
Date: Tue, 10 Feb 2009 10:29:14 -0600
Message-ID: <EohcOnsg9EGsisIaM0B0iYUSHt-mz_fzqBCqg27mBU0yXXlkP9baOA@cipher.nrlssc.navy.mil>
References: <1234334612-24907-1-git-send-email-guanqun.lu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guanqun Lu <guanqun.lu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvVb-0000Zk-Ai
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZBJQ3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbZBJQ3W
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:29:22 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58905 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520AbZBJQ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:29:21 -0500
Received: by mail.nrlssc.navy.mil id n1AGTFbZ031808; Tue, 10 Feb 2009 10:29:15 -0600
In-Reply-To: <1234334612-24907-1-git-send-email-guanqun.lu@gmail.com>
X-OriginalArrivalTime: 10 Feb 2009 16:29:15.0215 (UTC) FILETIME=[B6A44DF0:01C98B9C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109265>

Guanqun Lu wrote:
> 'xmalloc' followed immediately by 'memset' is replaced
> with 'xcalloc', and a simple grep in this project seems
> to show that it's the only place.
> 
> Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
> ---
>  sha1_file.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 8868b80..93e5fc0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -858,8 +858,7 @@ unsigned char* use_pack(struct packed_git *p,
>  
>  static struct packed_git *alloc_packed_git(int extra)
>  {
> -	struct packed_git *p = xmalloc(sizeof(*p) + extra);
> -	memset(p, 0, sizeof(*p));
> +	struct packed_git *p = xcalloc(1, sizeof(*p) + extra);
>  	p->pack_fd = -1;
>  	return p;
>  }

I previously scanned through and did this.  I left this one as is
because the extra part is about as large as the sizeof(*p) part.  69 and
72 bytes respectively on 32-bit.  The extra part is always filled in
immediately by callers.  It's only called once for each pack so it's
not performance critical, so maybe your patch is worth it since it is
simpler?

-brandon
