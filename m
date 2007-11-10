From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH REPLACEMENT for 2/2] git status: show relative paths when
   run in a subdirectory
Date: Sat, 10 Nov 2007 14:10:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711101401370.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
 <Pine.LNX.4.64.0711072242230.4362@racer.site>
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
 <Pine.LNX.4.64.0711072255420.4362@racer.site>
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
 <Pine.LNX.4.64.0711080011170.4362@racer.site> <7v8x593zyv.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711091529570.4362@racer.site> <fh46vv$ooj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michel Marti <mma@objectxp.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 15:10:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqr2a-0003Nd-Fs
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 15:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbXKJOKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 09:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbXKJOKN
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 09:10:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:60046 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751173AbXKJOKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 09:10:11 -0500
Received: (qmail invoked by alias); 10 Nov 2007 14:10:09 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp041) with SMTP; 10 Nov 2007 15:10:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18g67cVVKMgo1NVZvRVKYeJCqkUVqS7+njmc4iAaO
	mLytLEEubzUuiN
X-X-Sender: gene099@racer.site
In-Reply-To: <fh46vv$ooj$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64351>

Hi,

please, please, please do not cull the Cc list.  I consider it rude to 
reply to _me_, but _address_ the mail to me, either the To: (preferred) or 
the Cc: (not so preferred).

On Sat, 10 Nov 2007, Michel Marti wrote:

> Untracked files in the current dir don't include the relative path 
> to the project-root, but changed/updated files do:
> 
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       new file: ../subdir/hello
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       world
> 
> With the patch below (on top of your changes), the output becomes
> 
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       new file: hello
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       world
> 
> Cheers,
> 
> - Michel
> 
> diff --git a/wt-status.c b/wt-status.c
> index 0d25362..2cdc8ce 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -133,8 +133,8 @@ static void wt_status_print_filepair(struct wt_status *s,
>  
>         strbuf_init(&onebuf, 0);
>         strbuf_init(&twobuf, 0);
> -       one = quote_path(p->one->path, -1, &onebuf, s->prefix);
> -       two = quote_path(p->two->path, -1, &twobuf, s->prefix);
> +       one = quote_path(p->one->path, strlen(p->one->path), &onebuf, s->prefix);
> +       two = quote_path(p->two->path, strlen(p->two->path), &twobuf, s->prefix);
>  
>         color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
>         switch (p->status) {
> @@ -233,7 +233,8 @@ static void wt_status_print_initial(struct wt_status *s)
>         for (i = 0; i < active_nr; i++) {
>                 color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
>                 color_fprintf_ln(s->fp, color(WT_STATUS_UPDATED), "new file: %s",
> -                               quote_path(active_cache[i]->name, -1,
> +                               quote_path(active_cache[i]->name,
> +                                       strlen(active_cache[i]->name),
>                                            &buf, s->prefix));
>         }
>         if (active_nr)
> 

This patch is wrong.

If you want to go that way, move the strlen() call _into_ quote_path(), 
like I had it earlier.

But then we will have a double traversal of the strings again.  That's 
what I tried to avoid, but I missed one place:

In line 94, it says "... && off < len && ...".  This should read something 
like "((len < 0 && !in[off]) || off < len)" instead.  Or maybe even "(len 
< 0 || off < len)" and have an "} else if (in[off]) off++; else break;" in 
the loop block.

Besides, you completely ignored the nice examples how other people 
contribute their patches, with mail bodies that double as a commit 
message, a diffstat, and with a test case.

Hth,
Dscho
