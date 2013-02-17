From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git clone combined with --depth, --branch and --single-branch
Date: Sun, 17 Feb 2013 21:32:55 +0700
Message-ID: <CACsJy8C5G7yy=KDtdsE-9aYTdSEO3v=-25WKtGnLALshXnE+uQ@mail.gmail.com>
References: <CAByu6UWNZLrtwo+FUeq2OELoX3jo1Qng9amko36JGa5pq+y11A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thibault Kruse <tibokruse@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 15:33:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U75JP-0000yw-7g
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 15:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab3BQOd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 09:33:27 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36403 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3BQOd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 09:33:26 -0500
Received: by mail-oa0-f47.google.com with SMTP id o17so5069016oag.20
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=irG/UrS6pQSH5+bPNc1utqE4jdDsBTqaxTTuZogEGb4=;
        b=FLwkln6NnEGj8mPImuRi80r1N00GfB3le2JtgdYoHH0F4943eU4GsIEblg9xGGpVgW
         hXLT+XUW5pCBg5KiYUsHINeso5VuP2bDzc2xWF/sW36UhgKIg4VwtkaIb4DKG+Xqemch
         6xK82lkPd4ilpp+Rjvd8T3Evu8LJMXp/gnnHNjrnbJgBmUCjMyK6LhQVnPvnNR8SYPj0
         M1ytWEBumFJvojN3/cM/haUuYM/hGOjTFW3CEEL9PczSdKOpO4+V2xn2Gm9U5usCDJAJ
         aRm+v8TQ/DPJF1zBxWAY0VAr1Hq0LnRYXxKzxKZ3X/bvxi/MOZkqIDbCBnCp2+4PDPXy
         pJvQ==
X-Received: by 10.182.12.39 with SMTP id v7mr4797820obb.47.1361111605761; Sun,
 17 Feb 2013 06:33:25 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sun, 17 Feb 2013 06:32:55 -0800 (PST)
In-Reply-To: <CAByu6UWNZLrtwo+FUeq2OELoX3jo1Qng9amko36JGa5pq+y11A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216396>

On Sun, Feb 17, 2013 at 7:29 PM, Thibault Kruse
<tibokruse@googlemail.com> wrote:
> git log --pretty=format:'%h-%s %d' --graph --decorate  --all
> * 4565162-5  (foo)
> * 20ce846-4
> * a0615eb-3
> * fa4131d-2
> * f0683bd-1  (bar)
> | * 432b5ec-m1  (HEAD, master)
> |/
> * 39df203-0
>
> git clone repo1 repo2 --depth 1
> cd repo2
> git log --pretty=format:'%h-%s %d' --graph --decorate  --all
> * 432b5ec-m1  (HEAD, origin/master, origin/HEAD, master)
> * 39df203-0
>
> # Why are branches "foo" and "bar" missing?

--depth implies --single-branch. Without explicit --branch,
--single-branch will fetch HEAD. You need --no-single-branch to get
foo and bar.

> cd ..
> git clone repo1 repo3 --depth 1 --branch foo
> git log --pretty=format:'%h-%s %d' --graph --decorate  --all
> * 4565162-5  (HEAD, origin/foo, foo)
> * 20ce846-4
> * a0615eb-3
> * fa4131d-2
> * f0683bd-1
> | * 432b5ec-m1  (origin/master, origin/HEAD)
> |/
> * 39df203-0
>
> # Why is --depth not having effect, and why is branch bar not there,
> yet master is?

I'm not sure, but I can't reproduce it. There's an unreleased fix in
depth calculation (682c7d2 (upload-pack: fix off-by-one depth
calculation in shallow clone - 2013-01-11) that might affect this. You
may want to try again with "master". I got this with the same command

* edbd6cb (grafted, HEAD, origin/foo, foo) 5
-- 
Duy
