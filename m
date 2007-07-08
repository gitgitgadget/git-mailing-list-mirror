From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make fetch-pack a builtin with an internal API
Date: Sun, 08 Jul 2007 15:38:39 -0700
Message-ID: <7vsl7yzfkg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707081551120.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 00:38:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7fOu-0004od-CM
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 00:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106AbXGHWil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbXGHWil
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 18:38:41 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54277 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872AbXGHWil (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 18:38:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708223840.PLFG11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 18:38:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MAef1X00A1kojtg0000000; Sun, 08 Jul 2007 18:38:40 -0400
In-Reply-To: <Pine.LNX.4.64.0707081551120.6977@iabervon.org> (Daniel
	Barkalow's message of "Sun, 8 Jul 2007 15:57:01 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51932>

Daniel Barkalow <barkalow@iabervon.org> writes:

> In addition to making fetch-pack a builtin, this allows it to be called 
> directly from other built-in code without generating and parsing argument 
> lists, which will be useful for builtin-fetch.
>
> Incidently, it makes git-fetch-pack not output lists of what it fetched 
> when it fails.

That sounds sensible.

Hmmm.  incidentally it seems to do a bit more than that.

> @@ -663,15 +659,42 @@ static int fetch_pack_config(const char *var, const char *value)
>  
>  static struct lock_file lock;
>  
> -int main(int argc, char **argv)
> +void setup_fetch_pack(const char *_uploadpack,
> ...
> +#if 0
> +	git_config(fetch_pack_config);
> +
> +	if (0 <= transfer_unpack_limit)
> +		unpack_limit = transfer_unpack_limit;
> +	else if (0 <= fetch_unpack_limit)
> +		unpack_limit = fetch_unpack_limit;
> +#endif
> +}

This has been moved elsewhere?  I do not see how the code now
honors the configuration.
