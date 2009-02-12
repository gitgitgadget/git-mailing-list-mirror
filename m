From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clean up use of ANSI color sequences
Date: Thu, 12 Feb 2009 15:03:21 -0800
Message-ID: <7vy6wbi7gm.fsf@gitster.siamese.dyndns.org>
References: <1234471059-53625-1-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXkc3-0002Ow-UO
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbZBLXD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbZBLXD2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:03:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbZBLXD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:03:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 63015999CA;
	Thu, 12 Feb 2009 18:03:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CF750999C8; Thu,
 12 Feb 2009 18:03:22 -0500 (EST)
In-Reply-To: <1234471059-53625-1-git-send-email-arjen@yaph.org> (Arjen
 Laarhoven's message of "Thu, 12 Feb 2009 21:37:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5AEC33A8-F959-11DD-857C-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109676>

Arjen Laarhoven <arjen@yaph.org> writes:

> diff --git a/color.h b/color.h
> index 5019df8..c4d2e53 100644
> --- a/color.h
> +++ b/color.h
> @@ -4,6 +4,16 @@
>  /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
>  #define COLOR_MAXLEN 24
>  
> +#define COLOR_NORMAL	""
> +#define COLOR_RESET	"\033[m"
> +#define COLOR_BOLD	"\033[1m"
> +#define COLOR_RED	"\033[31m"
> +#define COLOR_GREEN	"\033[32m"
> +#define COLOR_YELLOW	"\033[33m"
> +#define COLOR_BLUE	"\033[34m"
> +#define COLOR_CYAN	"\033[36m"
> +#define COLOR_BG_RED	"\033[41m"

Sounds like a very sane thing to do in principle, but the choice of
constant names are problematic.

 (1) There are COLOR_BRANCH_$category constants, that look very similar
     (they probably should be renamed to BRANCH_COLOR_$category). 

 (2) These are ANSI constants so it might be better to call them
     ANSI_COLOR_$physical_attributes, or GIT_COLOR_$physical_attributes.

     I actually prefer the latter because then later we can potentially
     redefine these macros with something like:

	#define GIT_COLOR_RED ti_setf(COLOR_RED)
	#define GIT_COLOR_BG_RED ti_setb(COLOR_RED)

     and write a set of small wrappers to terminfo to support non ANSI
     terminals without changing the rest of the code.  It is nicer to use
     GIT_COLOR_RED instead of COLOR_RED, because the latter are defined in
     ncurses.h like this:

        /* colors */
        #define COLOR_BLACK	0
        #define COLOR_RED	1
        #define COLOR_GREEN	2
        #define COLOR_YELLOW	3
        #define COLOR_BLUE	4
        #define COLOR_MAGENTA	5
        #define COLOR_CYAN	6
        #define COLOR_WHITE	7
