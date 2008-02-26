From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Build in clone
Date: Tue, 26 Feb 2008 11:14:19 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261111460.17164@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-649740166-1204024462=:17164"
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 12:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTxmQ-0005MB-9Q
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 12:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbYBZLOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 06:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbYBZLOt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 06:14:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:36114 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751820AbYBZLOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 06:14:49 -0500
Received: (qmail invoked by alias); 26 Feb 2008 11:14:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 26 Feb 2008 12:14:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FVUAy8sXFQV8nIJLgOe/QKKR2a+35/T86erfyKM
	8SW9k4qX6bzZ4J
X-X-Sender: gene099@racer.site
In-Reply-To: <200802260321.14038.johan@herland.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75119>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-649740166-1204024462=:17164
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 26 Feb 2008, Johan Herland wrote:

> On Monday 25 February 2008, Daniel Barkalow wrote:
> > This version is still a mess, but it passes all of the tests.
> 
> Not for me:
> *** t5700-clone-reference.sh ***
> *   ok 1: preparing first repository
> *   ok 2: preparing second repository
> * FAIL 3: cloning with reference (-l -s)
>         git clone -l -s --reference B A C

Which machine?  What is your base (next or master)?  What does the verbose 
output look like?

> diff --git a/builtin-clone.c b/builtin-clone.c
> index 5aa75e1..7eed340 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -1,7 +1,7 @@
>  /*
>   * Builtin "git clone"
>   *
> - * Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
> + * Copyright (c) 2007 Kristian HÃ¸gsberg <krh@redhat.com>

This is almost certainly wrong.

> @@ -79,7 +79,7 @@ static char *get_repo_path(const char *repo)
>  
>  	if (!stat(repo, &buf) && S_ISDIR(buf.st_mode))
>  		return xstrdup(make_absolute_path(repo));
> -	
> +

Trailing whitespace.  Okay.

> @@ -347,6 +347,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	char *path, *dir, *head, *ref_temp;
>  	struct ref *refs, *r, *remote_head, *head_points_at, *remote_master;
>  	char branch_top[256], key[256], refname[256], value[256];
> +	struct strbuf reflog_msg;
> +
> +	git_config(git_default_config);

Good catch.

> @@ -495,7 +501,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (!remote_head) {
>  		/* If there isn't one, oh well. */
>  	} else if (remote_master && !hashcmp(remote_master->old_sha1,
> -				      remote_head->old_sha1)) {
> +					     remote_head->old_sha1)) {

I am not so sure about this change.  It is unneeded, and distracts from 
the rest.

Thanks,
Dscho

---1463811741-649740166-1204024462=:17164--
