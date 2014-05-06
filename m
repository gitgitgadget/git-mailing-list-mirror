From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Tue, 6 May 2014 07:26:26 +0700
Message-ID: <CACsJy8DWK9ysCJobh4oQZe2hxdTaE=n7hH=Nm6bfWzx+yJ=KZg@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com> <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 06 19:39:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiFe-0007Xo-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410AbaEFA05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 20:26:57 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:58813 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbaEFA05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 20:26:57 -0400
Received: by mail-qc0-f169.google.com with SMTP id e16so6195871qcx.28
        for <git@vger.kernel.org>; Mon, 05 May 2014 17:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=xxctNuGUGHclrZXeEGKzmOzF9c9KXbAGHjzMzP9Nqeg=;
        b=JtcpEP5zDkdpG0vtmtNn1K3p6kuJZvuxiP/Es+uq+YpbRWM3i8B1kDJzXn/yNe5/dj
         pevcoIBBA/rI4w/XXiwGNujUyA5y0cekOqhnOnoXNQZ81N9AoR6wN6CYaJVDuN+gQOpy
         VoQ0rU8VgYoscCxNQl62yy0maek/VylkNdeG+Ii7grA64w4usmISuEJBxwMOZ0DqboSI
         IGKIKWbFJDVwp7s0EmDe93pLyu1m0oisgmFchlrql3WMIPNmLP+WFtev2o8sWgaOMFni
         7lh23i1QZ2szWwkmTVHo8fLQJ4IyyBKNeM6iz4sfU7g6iwrP6r1p/9jyqkmUCbhIYhRj
         Iz7A==
X-Received: by 10.224.97.69 with SMTP id k5mr50687826qan.8.1399336016316; Mon,
 05 May 2014 17:26:56 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 5 May 2014 17:26:26 -0700 (PDT)
In-Reply-To: <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248189>

On Sat, May 3, 2014 at 7:52 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> wt_status_collect_changes_index() depends on how damaged cache-tree is
> (in this case, totally scraped). watchman does not help this either.
> We need to try to "heal" cache-tree as much as possible to reduce the
> number.

On the topic of cache-tree, I notice that unpack_trees() will call
discard_index() in the end (or even discard_index() on a merge
failure). That destroys cache-tree. unpack_trees() is the core of
branch switching, or reset/merge, which I consider frequent
operations. Cache-tree destruction is bad for "git diff --cached",
"git commit" and maybe more. This discard_index() code was added
recently in e28f764 (unpack-trees: plug a memory leak - 2013-08-13).
As a workaround, perhaps we only do so when the sequencer is running.
-- 
Duy
