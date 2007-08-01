From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Add functions get_relative_cwd() and is_inside_dir()
Date: Tue, 31 Jul 2007 21:22:44 -0700
Message-ID: <7vy7gvdgtn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
	<Pine.LNX.4.64.0708010058130.14781@racer.site>
	<Pine.LNX.4.64.0708010129090.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 01 06:22:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG5jY-0002Oe-DR
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 06:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbXHAEWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 00:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbXHAEWq
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 00:22:46 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56502 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbXHAEWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 00:22:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801042245.JOHO11888.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 00:22:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WUNj1X00Q1kojtg0000000; Wed, 01 Aug 2007 00:22:44 -0400
In-Reply-To: <Pine.LNX.4.64.0708010129090.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 1 Aug 2007 01:29:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54405>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The function get_relative_cwd() works just as getcwd(), only that it
> takes an absolute path as additional parameter, returning the prefix
> of the current working directory relative to the given path.  If the
> cwd is no subdirectory of the given path, it returns NULL.
> ...
> +/*
> + * get_relative_cwd() gets the prefix of the current working directory
> + * relative to 'dir'.  If we are not inside 'dir', it returns NULL.
> + * As a convenience, it also returns NULL if 'dir' is already NULL.
> + */
> +char *get_relative_cwd(char *buffer, int size, const char *dir)
> +{
> +	char *cwd = buffer;
> +
> +	if (!dir || !getcwd(buffer, size))
> +		return NULL;

When is it not a fatal error if get_relative_cwd() is called
with a NULL dir parameter, or getcwd() fails?

If there is no valid such cases, I would rather have this
die(), former with "BUG" and the latter with strerror(errno).
