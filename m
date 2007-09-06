From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/9] Introduce entry point for launching add--interactive.
Date: Thu, 6 Sep 2007 17:31:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061729270.28586@racer.site>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com> <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-442831545-1189096299=:28586"
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:32:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKGu-0003jS-7n
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbXIFQbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbXIFQby
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:31:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:47552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752182AbXIFQby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:31:54 -0400
Received: (qmail invoked by alias); 06 Sep 2007 16:31:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 06 Sep 2007 18:31:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HkRcYtwMHnY09cRwJt3FdXNa0hewBB7RlUdp4jp
	QffU5KcqSHVOjx
X-X-Sender: gene099@racer.site
In-Reply-To: <11890382253220-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57900>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-442831545-1189096299=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 5 Sep 2007, Kristian Høgsberg wrote:

> diff --git a/builtin-add.c b/builtin-add.c
> index 3dd4ded..e79e8f7 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -153,6 +154,13 @@ static int git_add_config(const char *var, const char *value)
>  	return git_default_config(var, value);
>  }
>  
> +int interactive_add(void)
> +{
> +	const char *argv[2] = { "add--interactive", NULL };
> +
> +	return run_command_v_opt(argv, RUN_GIT_CMD);
> +}

I'd rather have this in builtin-commit.c, since it is quite funny if 
builtin-add.c has code to fork() and exec() itself (eventually, that 
is) ;-)

> diff --git a/commit.h b/commit.h
> index 467872e..64e1d4b 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -122,4 +122,13 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
>  		int depth, int shallow_flag, int not_shallow_flag);
>  
>  int in_merge_bases(struct commit *, struct commit **, int);
> +
> +extern const unsigned char *
> +create_commit(const unsigned char *tree_sha1,
> +	      unsigned char parent_sha1[][20], int parents,
> +	      const char *author_info, const char *committer_info,
> +	      const char *message, int length);
> +
> +extern int interactive_add(void);
> +

Just a guess: you did not want create_commit() to creep in here, right?

Ciao,
Dscho

--8323584-442831545-1189096299=:28586--
