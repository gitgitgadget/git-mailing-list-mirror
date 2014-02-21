From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/6] find_pack_entry(): document last_found_pack
Date: Fri, 21 Feb 2014 12:15:08 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1402211214290.17677@knanqh.ubzr>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
 <1393000327-11402-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 21 18:15:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGth0-0006ow-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 18:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbaBURPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 12:15:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18781 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923AbaBURPK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 12:15:10 -0500
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N1C00FMHVX9ULD0@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 21 Feb 2014 12:15:09 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 17A1F2DA070D; Fri, 21 Feb 2014 12:15:09 -0500 (EST)
In-reply-to: <1393000327-11402-4-git-send-email-mhagger@alum.mit.edu>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242476>

On Fri, 21 Feb 2014, Michael Haggerty wrote:

> Add a comment at the declaration of last_found_pack and where it is
> used in find_pack_entry().  In the latter, separate the cases (1) to
> make a place for the new comment and (2) to turn the success case into
> affirmative logic.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

REviewed-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  sha1_file.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 6e8c05d..0910939 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -60,6 +60,12 @@ static struct cached_object empty_tree = {
>  	0
>  };
>  
> +/*
> + * A pointer to the last packed_git in which an object was found.
> + * When an object is sought, we look in this packfile first, because
> + * objects that are looked up at similar times are often in the same
> + * packfile as one another.
> + */
>  static struct packed_git *last_found_pack;
>  
>  static struct cached_object *find_cached_object(const unsigned char *sha1)
> @@ -2460,11 +2466,13 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>  		return 1;
>  
>  	for (p = packed_git; p; p = p->next) {
> -		if (p == last_found_pack || !fill_pack_entry(sha1, e, p))
> -			continue;
> +		if (p == last_found_pack)
> +			continue; /* we already checked this one */
>  
> -		last_found_pack = p;
> -		return 1;
> +		if (fill_pack_entry(sha1, e, p)) {
> +			last_found_pack = p;
> +			return 1;
> +		}
>  	}
>  	return 0;
>  }
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
