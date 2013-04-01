From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] checkout: add --no-widen for restoring files in
 sparse checkout mode
Date: Sun, 31 Mar 2013 23:18:13 -0700
Message-ID: <20130401061813.GJ11704@elie.Belkin>
References: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
 <1364637753-18785-1-git-send-email-pclouds@gmail.com>
 <20130401044816.GI11704@elie.Belkin>
 <CACsJy8BVcu2VwxgQ9URViHMx2+6436npcYSHyZ5Mj0aVhVFtug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kirill =?utf-8?Q?M=C3=BCller?= <kirill.mueller@ivt.baug.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 08:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMY4x-0000Jb-73
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 08:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642Ab3DAGSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 02:18:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62903 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757634Ab3DAGSW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 02:18:22 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so1067108pdj.27
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=95KU/3zKLFhj4oVRtns8Q3uwIgQ5wjR2X+HqH0oaJbs=;
        b=Ykrzc3weWJuwDr6YHbhEpemx4WGF+6uF9W17hUo1WG9zD2+zwwspWdbBK9zIku28XX
         hBWqGpR7wF8xaW/wONKgyDxi93cL3mbc+En0Oi+v8vKgZWlHoRbMdrY+pO1BwTVNj30P
         6IMXW/441vb+suWpmdKZpBljbR85z7chrEkkDcMYkH3LXeEIsd1J2QkqQ+V00XFdui1N
         +GnnDz4qVgJ262uwANX/3v/gYVnhH5SXF00h5ECC5q/aAK+wazldfdi3SJx1tJG7VKot
         m4/qrXZVliMVcR1gjwpcS/9bHhKrR1+BeLYCcvQfx+R92vHhbFGzYEw455Bp9/GAcCsB
         ZgHw==
X-Received: by 10.68.95.69 with SMTP id di5mr1692578pbb.204.1364797101323;
        Sun, 31 Mar 2013 23:18:21 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id eh5sm12541124pbc.44.2013.03.31.23.18.18
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 23:18:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8BVcu2VwxgQ9URViHMx2+6436npcYSHyZ5Mj0aVhVFtug@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219673>

Duy Nguyen wrote:
> On Mon, Apr 1, 2013 at 11:48 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I'm afraid I can't imagine when --no-respect-skip-worktree would be
>> useful.  That can easily be a failure of my imagination, though.
>
> There may be scripts that expect "git checkout -- foo" to reset
> everything in "foo". Or maybe you just want to check out a single file
> and do not bother to edit sparse patterns as you won't need it for
> long.

Those scripts are bringing suffering on themselves by using porcelain
instead of "git checkout-index".  The usual way to look at a single
file from the index is "git show :git.c >git.c".

So you've convinced me.  I think --respect-skip-worktree can be just
the normal behavior (and that there's no need for a --no-respect
option).  That would let me do:

	git clone --no-checkout git://repo.or.cz/git.git
	cd git
	echo '/Documentation/' >.git/info/sparse-checkout
	git config core.sparsecheckout true
	git checkout

	printf '%s\n' /README /INSTALL /COPYING >>.git/info/sparse-checkout
	git checkout

	... hack hack hack ...

	# return to what the index has
	git checkout .

without having to see any pesky actual source (*.c) files.
