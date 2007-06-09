From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/21] Make parse_tag_buffer_internal() handle item == NULL
Date: Sat, 09 Jun 2007 11:01:53 -0700
Message-ID: <7vlketf1m6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	<200706090210.36270.johan@herland.net>
	<200706090214.39337.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 20:02:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5GA-0001Z0-Ty
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598AbXFISB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757558AbXFISB4
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:01:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60518 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757476AbXFISBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:01:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609180154.UVKN7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 Jun 2007 14:01:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9W1t1X00d1kojtg0000000; Sat, 09 Jun 2007 14:01:54 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49590>

Johan Herland <johan@herland.net> writes:

> This is in preparation for unifying verify_tag() and
> parse_tag_buffer_internal().
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  tag.c |   54 +++++++++++++++++++++++++++++-------------------------
>  1 files changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/tag.c b/tag.c
> index 19c66cd..b134967 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -46,9 +46,11 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
>  	const char *type_line, *tag_line, *tagger_line;
>  	unsigned long type_len, tag_len;
>  
> -	if (item->object.parsed)
> -		return 0;
> -	item->object.parsed = 1;
> +	if (item) {
> +		if (item->object.parsed)
> +			return 0;
> +		item->object.parsed = 1;
> +	}
>  
>  	if (size < 64)
>  		return error("failed preliminary size check");

Passing both item and data does not feel right.  If you are
trying to make the factored out function to do the verification
of data, then perhaps the caller should do the "don't handle the
same data twice" optimization using item?
