X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-branch: deleting remote branches in new layout
Date: Sun, 17 Dec 2006 23:08:23 -0800
Message-ID: <7vbqm13cm0.fsf@assigned-by-dhcp.cox.net>
References: <45863044.4040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 07:08:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45863044.4040406@gmail.com> (Quy Tonthat's message of "Mon, 18
	Dec 2006 17:08:04 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34718>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwCc4-0003z8-H0 for gcvg-git@gmane.org; Mon, 18 Dec
 2006 08:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753414AbWLRHIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 02:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbWLRHIZ
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 02:08:25 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60041 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753414AbWLRHIZ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 02:08:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218070824.CLKE18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Mon, 18
 Dec 2006 02:08:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 078c1W0021kojtg0000000; Mon, 18 Dec 2006
 02:08:36 -0500
To: Quy Tonthat <qtonthat@gmail.com>
Sender: git-owner@vger.kernel.org

Quy Tonthat <qtonthat@gmail.com> writes:

> Now that remote branches are in refs/remotes/, branch -D needs to know
> where to find them.
>
> Signed-off-by: Quy Tonthat <qtonthat@gmail.com>

I recognize that giving end users a way to remove a "remote
tracking branch" might be a worthy goal ("update-ref -d" _could_
be used, but "branch -D" feels more natural).

> +	char ** s;
> +	static char * branches_dir[] = {"refs/heads", "refs/remotes", NULL};

But I do not like these two entries in branches_dir[].

(style: lose SP after '*' in these two lines, by the way).

If you had refs/heads/$X and refs/remotes/$X, I do not think
this code allows you to disambiguate.  You cannot remove
"remote" one without first removing the local one, can you?

> +		for (s = branches_dir; *s != NULL; s++) {
> +			name = xstrdup(mkpath("%s/%s", *s, argv[i]));
> +			if (resolve_ref(name, sha1, 1, NULL))
> +				break;
> +		}
> +		if (*s == NULL)
>  			die("Branch '%s' not found.", argv[i]);

(style: we seem to prefer "if (!*s)").
