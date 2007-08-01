From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow git_author|committer_info be called in the same expression
Date: Wed, 01 Aug 2007 02:24:34 -0700
Message-ID: <7vhcnj7gkt.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0707310957x62ac9d28j60104bffb46a80b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Kristian_H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 11:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGARd-000053-39
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 11:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759415AbXHAJYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 05:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758987AbXHAJYh
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 05:24:37 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47005 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629AbXHAJYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 05:24:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801092436.MKPF14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 05:24:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WZQb1X0081kojtg0000000; Wed, 01 Aug 2007 05:24:36 -0400
In-Reply-To: <81b0412b0707310957x62ac9d28j60104bffb46a80b7@mail.gmail.com>
	(Alex Riesen's message of "Tue, 31 Jul 2007 18:57:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54422>

"Alex Riesen" <raa.lkml@gmail.com> writes:

>  const char *git_committer_info(int error_on_no_name)
>  {
> -	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
> -			 getenv("GIT_COMMITTER_EMAIL"),
> -			 getenv("GIT_COMMITTER_DATE"),
> -			 error_on_no_name);
> +	static char *buffer;
> +	if (!buffer)
> +		buffer = xmalloc(FMT_IDENT_BUFSIZE);

It is not like we are aiming to run on embedded devices, I think
trying to save static memory when the function is not called
by doing things like this is not worth it.  Why not just:

	static char buffer[FMT_IDENT_BUFSIZE];

instead?

In any case, I'd really like to slow things down and ask
everybody to concentrate on finding and fixing bugs in what are
scheduled for 1.5.3 for a week or so.

That means the current "master".

I did not merge Johannes's work tree rationalization patch to
"master" yet (it is now part of "next"), but I would like to
have it in, as it makes the code much easier to read compared to
the work-tree changes currently in "master".  Even though the
one currently in "master" does not seem to regress the normal
usage of not using GIT_WORK_TREE environment, we would be better
off if a new feature is released in a shape that is maintainable.

Other than that topic, everything on "next" will be post 1.5.3.

Please.

I'd like to do -rc4 this weekend, and then 1.5.3 final by mid
August at the latest, but hopefully sooner.

As to parts of the system that other people are primarily in
charge of, git-gui 0.8.0 is already in as promised, updates to
gitk were merged, and we've had a nice set of improvements from
Jakub on gitweb already.  Bruce seems to have a beginning of the
user manual reorganization, but I am getting the feeling it is
not ready yet.
