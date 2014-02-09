From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug: relative core.worktree is resolved from symlink and not its
 target
Date: Sun, 9 Feb 2014 16:08:03 +0700
Message-ID: <20140209090803.GA24578@lanh>
References: <52F0BEF7.5020600@thequod.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Hahler <genml+git-2014@thequod.de>
X-From: git-owner@vger.kernel.org Sun Feb 09 10:14:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCQSt-00081o-1D
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 10:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbaBIJOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 04:14:05 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49386 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbaBIJN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 04:13:58 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so4890130pde.14
        for <git@vger.kernel.org>; Sun, 09 Feb 2014 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uphZnr36vmgnlVMvJXZmZH7Vms4I5XFSZN4CY0iKYvg=;
        b=V9+OgfmjavTQLajgPUnPta20M9wUE/gr23vTF4RVhu5x9Vdynay8Z6Zh343wtVI/eq
         p1TQJVJXH47xEiwtEn0ewGuvGUOnHu3HjzgyP5AX2A9t4jybb+M5nq3kZfD4C3rqxhtI
         oY1JD2CP1C2kPUcoCPoG4c00/NCrs7P6HtCTOs4/ta99b1Ir+B0W50P8eO9ZM5yqqtQY
         kS3paSee3fSybBiFqG7z/S8JLZ8136hClT9KD0t0uk0ahSyix8btprk7arnT86IHFFyW
         yCrE7kM7liNwYqRP8dfyBDGMbr+q/BX0EjdgR+NmZGmc+9Ec6Gxrg2iiRqpyoMjmG/Xr
         QDPQ==
X-Received: by 10.66.164.70 with SMTP id yo6mr18867026pab.85.1391936880578;
        Sun, 09 Feb 2014 01:08:00 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id vf7sm30783082pbc.5.2014.02.09.01.07.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Feb 2014 01:07:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Feb 2014 16:08:03 +0700
Content-Disposition: inline
In-Reply-To: <52F0BEF7.5020600@thequod.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241872>

On Tue, Feb 04, 2014 at 11:20:39AM +0100, Daniel Hahler wrote:
> Hi,
> 
> when using a submodule "sm", there is a relative worktree in its config:
> 
>    .git/modules/sm/config:
>    [core]
>     worktree = ../../../smworktree
> 
> git-new-worktree (from contrib) symlinks this config the new worktree.
> 
> From inside the new worktree, git reads the config, but resolves the
> relative worktree setting based on the symlink's location.

Hmm.. core.worktree is relative to $GIT_DIR. Whether "config" is a
symlink should have no effects.

$ pwd
/tmp/abc
$ ls -l .git/config 
lrwxrwxrwx 1 pclouds users 11 Feb  9 15:57 .git/config -> /tmp/config
$ cat /tmp/config 
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        worktree = ../../worktree
$ ls -l /tmp/worktree/
total 4
-rw-r--r-- 1 pclouds users 5 Feb  9 15:59 abc
$ ~/w/git/git ls-files -o
abc

Maybe it's something else. Could you produce a small test case?

> A fix would be to resolve any relative worktree setting based on the
> symlink target's location (the actual config file), and not from the
> symlink.
> 
> This is with git version 1.8.5.3.
--
Duy
