From: Junio C Hamano <junkio@cox.net>
Subject: Re: What shall we do with the GECOS field again?
Date: Tue, 20 Sep 2005 00:10:02 -0700
Message-ID: <7v8xxs5i5x.fsf@assigned-by-dhcp.cox.net>
References: <20050919134838.GC2903@pasky.or.cz>
	<20050919163219.GA8862@puritan.pnetwork>
	<20050919212113.GB8862@puritan.pnetwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 09:12:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHcGs-0006bJ-TI
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 09:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbVITHKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 03:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbVITHKG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 03:10:06 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26289 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932747AbVITHKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 03:10:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920071002.KHMF3875.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Sep 2005 03:10:02 -0400
To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
In-Reply-To: <20050919212113.GB8862@puritan.pnetwork> (Nikolai Weibull's
	message of "Mon, 19 Sep 2005 23:21:13 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8984>

Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org> writes:

> Perhaps something like the following patch will do?,
>         nikolai

Thanks for the patch.  Some nits and requests.

(1) Proper commit log message here, with your Signed-off-by line.

> +	if (!name && !email && getenv("EMAIL")) {
> +		i = copy(buffer, sizeof(buffer), 0, getenv("EMAIL"));
> +		i = add_raw(buffer, sizeof(buffer), i, " ");

(2) Perhaps have `#define IDENT_ENVIRONMENT "EMAIL"' in cache.h
    and use it, like we do for other environment variables.

(3) Probably you need to validate what is in $EMAIL before
    trusting it, so that we can guard ourselves from EMAIL in a
    format that is suitable for other applications but not for
    us?  If you find that the value does not look good, just
    refuse it with an error message to set more specific
    GIT_{AUTHOR,COMMITTER}_* environment variables.

    Unlike GIT_* environment variables, EMAIL is a convention we
    did not invent ourselves.  We cannot expect it to always be
    formatted to our liking, and more importantly, we should not
    demand the user to set it to the way we like -- the other
    application the user originally set EMAIL for might not like
    what we want.
