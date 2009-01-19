From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] parsecvs: produce tagger fields acceptable to newer git versions
Date: Mon, 19 Jan 2009 13:44:06 +0100
Message-ID: <87ab9nbh49.fsf@meyering.net>
References: <20090119120217.GD4390@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: keithp@keithp.com, git@vger.kernel.org, jay@gnu.org,
	kedars@marvell.com
To: Lennert Buytenhek <buytenh@wantstofly.org>
X-From: git-owner@vger.kernel.org Mon Jan 19 13:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOtfv-0003sv-N3
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 13:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759527AbZASMyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 07:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759200AbZASMyz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 07:54:55 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:43352 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758917AbZASMyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 07:54:54 -0500
X-Greylist: delayed 638 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2009 07:54:52 EST
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 1D2A778000F
	for <git@vger.kernel.org>; Mon, 19 Jan 2009 13:45:23 +0100 (CET)
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0265C818068;
	Mon, 19 Jan 2009 13:44:09 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1FEB181816C;
	Mon, 19 Jan 2009 13:44:07 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id F21F05010B; Mon, 19 Jan 2009 13:44:06 +0100 (CET)
In-Reply-To: <20090119120217.GD4390@xi.wantstofly.org> (Lennert Buytenhek's
	message of "Mon, 19 Jan 2009 13:02:17 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106353>

Lennert Buytenhek <buytenh@wantstofly.org> wrote:

> Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
>
> diff --git a/git.c b/git.c
> index da320d1..8f94d1b 100644
> --- a/git.c
> +++ b/git.c
> @@ -371,11 +371,13 @@ git_mktag (rev_commit *commit, char *name)
>  		"object %s\n"
>  		"type commit\n"
>  		"tag %s\n"
> -		"tagger %s\n"
> +		"tagger %s <%s> %lu +0000\n"
>  		"\n",
>  		commit->sha1,
>  		name,
> -		author ? author->full : commit->author);
> +		author ? author->full : commit->author,
> +		author ? author->email : commit->author,
> +		commit->date);
>      if (rv < 1) {
>  	fprintf (stderr, "%s: %s\n", filename, strerror (errno));
>  	fclose (f);

Hi Lennert,

I posted the same patch a while back.

    http://markmail.org/message/cebh7suc7ejpayos

However, I never heard back.
You'll also need the patch below, if you're building
against a newer version of git.


>From 93bc277dff113f1133ef25b8bb985af80f1fbe0e Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Thu, 6 Nov 2008 11:35:09 +0100
Subject: [PATCH 2/2] * tree.c (init_tree): Adapt to new git_config API.

---
 tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tree.c b/tree.c
index a76f27c..e2a041c 100644
--- a/tree.c
+++ b/tree.c
@@ -177,7 +177,7 @@ rev_commit *create_tree(rev_commit *leader)

 void init_tree(int n)
 {
-	git_config(git_default_config);
+	git_config(git_default_config, NULL);
 	strip = n;
 }

--
1.6.1.331.g9c367
