From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] builtin-grep: workaround for non GNU grep.
Date: Wed, 17 May 2006 07:24:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605170722590.10823@g5.osdl.org>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
 <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org> <7vejythvkr.fsf@assigned-by-dhcp.cox.net>
 <7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 16:24:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgMwi-00065f-TE
	for gcvg-git@gmane.org; Wed, 17 May 2006 16:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWEQOYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 10:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWEQOYN
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 10:24:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932573AbWEQOYM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 10:24:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HEO5tH023440
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 07:24:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HEO4wY014845;
	Wed, 17 May 2006 07:24:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20200>


No, please don't do it this way.

On Wed, 17 May 2006, Junio C Hamano wrote:
>
> +	 * Some grep implementations do not understand -H nor --
> +	 * but /dev/null can be used as a substitution in most
> +	 * cases.
> +	 *
> +	 * However -L and -c would slightly misbehave (-L would
> +	 * list /dev/null as a hit, and -c would report 0 hits
> +	 * from /dev/null); so do not use the external one on
> +	 * such platforms.
>  	 */
> -	if (!cached) {
> +	if (!cached &&
> +	    (!NO_H_OPTION_IN_GREP ||
> +	     (!opt->count && !opt->unmatch_name_only))) {
>  		hit = external_grep(opt, paths, cached);
>  		if (hit >= 0)
>  			return hit;

That's the ugliest test ever, and at all the wrong levels.

Just make "external_grep()" test for the cases that it cannot handle, and 
return -1. That's how it's designed to work.

		Linus
