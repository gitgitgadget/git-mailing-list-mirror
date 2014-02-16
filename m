From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] Wider exposure for index-v4
Date: Sun, 16 Feb 2014 08:16:41 +0700
Message-ID: <CACsJy8BDerqeua6zjGhniy_kxruDk9WuTJY-2zi6m4EpE9=CBg@mail.gmail.com>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 02:17:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEqMU-00030C-CV
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 02:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbaBPBRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 20:17:13 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:33795 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaBPBRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 20:17:12 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so22276049qcq.32
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JBh3Y+fQB651/7xol0OOrtDLNpQxMFAggt0NTVqI6vw=;
        b=l9s3SsJmTkAeU8dW+1jPJz1PA+qX6k9xVzTyXn5sLe6TiXpQqg0HSv4Gyy+41TuxvC
         asRL/aNKd7BmL/vz/Nn4MvPTdXWLOquVsreOAc8oiwGpe7cDvvCasMX7D80PKNm2q+Se
         HZwExYgmTCJEU0bEqhz4S4w7CkqsncFAdZhkPfU/EaC3mRdXeSW3BG20J5AYzb4+Ubqk
         XpZfkAr2wzz8M1VNw7yyIIfWElvntc5bV5WhSY4JFv7d+KzKvOA/BDrtM5aRSKi3R8jR
         W9yCGbu9ykwnPRQMJYIctwpsSR2fIYVBbrhADcqb32WZeVIOxjIJX+cO49/mnNf6EfI5
         9xtQ==
X-Received: by 10.140.51.170 with SMTP id u39mr23732902qga.69.1392513431751;
 Sat, 15 Feb 2014 17:17:11 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 15 Feb 2014 17:16:41 -0800 (PST)
In-Reply-To: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242203>

On Sun, Feb 16, 2014 at 2:23 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Hi,
>
> since index-v5 didn't seem to generate enough interest to be merged, I

I thought there were some comments last time that you were going to
address and resubmit?

> have a few patches that give users users easier access to index-v4.
> Until now users have to go into the source code and compile git
> themselves to use index-v4 by default, or use git-update-index to
> change the index file to the new version.

Not objecting this, but I think something like [1] would give v4 more
exposure. Reading the patch again, I think putting that detection code
in unpack_trees() or git-merge may make more sense because people will
be advised about upgrading to v4 at the next fast-forward.

[1] http://article.gmane.org/gmane.comp.version-control.git/216307

> With this patches it's possible to set the default index file format
> either in gitconfig or in an environment variable.  It also simplifies
> testing index-v4 by adding a Makefile knob to use it for running the
> test suite.  For safety, existing repositories are not changed when
> the environment or the config variables are set.
>
> I'm not sure about the precedence in patch 3, right now the environment
> variable has precedence, but it should be easy to give the config
> option precedence over that.
>
> Thomas Gummerer (3):
> introduce GIT_INDEX_VERSION environment variable
> test-lib: allow setting the index format version
> read-cache: add index.version config variable
>
> Documentation/config.txt              |  4 +++
> Documentation/git.txt                 |  5 ++++
> Makefile                              |  7 +++++
> read-cache.c                          | 36 +++++++++++++++++++++++-
> t/t1600-index.sh                      | 52 +++++++++++++++++++++++++++++++++++
> t/t2104-update-index-skip-worktree.sh |  2 ++
> t/test-lib-functions.sh               |  5 ++++
> t/test-lib.sh                         |  3 ++
> 8 files changed, 113 insertions(+), 1 deletion(-)
> create mode 100755 t/t1600-index.sh
>
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
