From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] Client side of user-relative paths, take two.
Date: Tue, 01 Nov 2005 16:14:36 -0800
Message-ID: <7vpspj6h3n.fsf@assigned-by-dhcp.cox.net>
References: <20051101225921.245595BF70@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:15:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6H3-0007kF-Cn
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbVKBAOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVKBAOi
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:14:38 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38896 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751468AbVKBAOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:14:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102001415.JUKJ4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 19:14:15 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10978>

Andreas Ericsson <ae@op5.se> writes:

> +	if (protocol == PROTO_SSH && colon && (!path || colon < path)) {
> +		*colon = 0;
> +		path = colon + 1;
> +	}

I think "colon < path" is to cover "git://host.xz/foo/bar:baz"
case (i.e. funny directory name with an embedded colon); I think
you should reset colon to NULL if you do things differently
later depending on colon is set or not, like this part:

> +	/* null-terminate host part and point path to ~ for URL's like this:
> +	 *    ssh://host.xz/~user/repo
> +	 */
> +	if(!colon && *(path + 1) == '~')
> +		*path++ = '\0';
> +	else {
> +		colon = path;
> +		path = strdup(path);
> +		*colon = '\0';
