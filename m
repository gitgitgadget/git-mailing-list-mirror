From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 11/11] vcs-svn,svn-fe: add an option to write svnrev
 notes
Date: Mon, 25 Jul 2011 23:39:23 +0200
Message-ID: <20110725213923.GC8708@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-12-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 23:39:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlSsB-00064r-21
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 23:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024Ab1GYVjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 17:39:31 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55615 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab1GYVja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 17:39:30 -0400
Received: by ewy4 with SMTP id 4so2718528ewy.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H/g9zVifUCG1wN2JgsUr3dljGxEj0Ib+2RcZEG/zDMM=;
        b=uaMoMWWOc2nQVvgr7fJJ78PZSFmqB0KzWhPAlBLw2mnysI9NOQ796BcbS3RLN0+/3U
         27Rz6ksRIQtdLg4WcrO1iwofpI8z4glgNrIwAFLCHtwWbotERO6PUKU3AxeMDYdPrh0q
         7jtJBAFJvbkQ52HSEPIJLLXwaK50VQtbpt+fY=
Received: by 10.213.29.79 with SMTP id p15mr361125ebc.8.1311629968841;
        Mon, 25 Jul 2011 14:39:28 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id e48sm3017879eeb.37.2011.07.25.14.39.25
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 14:39:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-12-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177822>

Hi,

Dmitry Ivankov wrote:

> There are already a few options to determine svn revision from which
> a git commit imported with svn-fe came from. One is to make svn-fe
> write a git-svn-id: line to commit messages. Another one is to calc
> distance to the root commit. The former includes a "url" and is for
> git-svn compatibility, the latter is obviously slow and a bit fragile.
>
> $ svn-fe --notes_ref=notes_tree --ref=branch...
> will write annotations for branch commits to the notes_tree, each
> annotation is a simple "rN" string. Then these annotations can be
> viewed manually or used in incremental import to detect the last
> imported revision or to (re)create the import marks for further
> imports.

Wouldn't another way be to look at the mark numbers?

I am not sure I like this.  svn-fe is supposed to be a generally
useful tool, and this patch hard-codes the particular note format rN.
If it is needed, maybe it would be possible to do something like

	--notes-ref=refs/notes/svn-rev --note='project foo, r%N'

As a bonus, that would allow including more information using
different flag characters in the note in the future.
