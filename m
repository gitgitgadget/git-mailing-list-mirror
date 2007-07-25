From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] resolve symlinks when creating lockfiles
Date: Wed, 25 Jul 2007 16:35:45 -0700
Message-ID: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
References: <7vps2s2chy.fsf@assigned-by-dhcp.cox.net>
	<11853821932079-git-send-email-bradford.carl.smith@gmail.com>
	<11853821951367-git-send-email-bradford.carl.smith@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:35:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDqOV-0004Nr-2c
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 01:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbXGYXft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 19:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbXGYXft
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 19:35:49 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50639 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbXGYXfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 19:35:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725233545.VCWD1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 25 Jul 2007 19:35:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Tzbm1X0031kojtg0000000; Wed, 25 Jul 2007 19:35:46 -0400
In-Reply-To: <11853821951367-git-send-email-bradford.carl.smith@gmail.com>
	(Bradford C. Smith's message of "Wed, 25 Jul 2007 12:49:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53738>

This probably is going in the right direction, but the code is
too densely formatted and unreviewable.  Please imitate the
layout convention of the other parts of the code.

> +/**
> + * p = absolute or relative path name
> + *
> + * Return a pointer into p showing the beginning of the last path name
> + * element.  If p is empty or the root directory ("/"), just return p.
> + */

	/*
         * multi-line comments look like this without the extra
         * asterisk at the beginning of the first line.
         */

> +static char * last_path_elm(char * p)

char *last_path_elem(char *p)

> +{
> +	int	p_len = strlen(p);
> +	char *	r;
> +
> +	if (p_len < 1) return p;

        char *r;
	int p_len = strlen(p);

        if (p_len < 1)
                return p;

Aren't p and r of type "const char *", I wonder...

> +	/* r points to last non-null character in p */
> +	r = p + p_len - 1;
> +	/* first skip any trailing slashes */
> +	while (*r == '/' && r > p) r--;

That is

	r = strrchr(p, '/');

isn't it?

> +/**
> + * p = char array containing path to existing file or symlink
> + * s = size of p
> + *
> + * If p indicates a valid symlink to an existing file, overwrite p with
> + * the path to the real file.  Otherwise, leave p unmodified.

I suspect some callers use lockfile interface to create a new
file.  There will be a symlink to not-yet-created real file,
that is.
