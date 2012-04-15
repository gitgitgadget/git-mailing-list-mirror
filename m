From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] prohibit "svn dcommit" on remote-tracking-branches
Date: Sun, 15 Apr 2012 16:23:58 -0500
Message-ID: <20120415212358.GA5813@burratino>
References: <handler.667488.B.133354466019267.ack@bugs.debian.org>
 <20120410211732.GB27555@dcvr.yhbt.net>
 <20120415185535.GA9150@mathe-macht-spass.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Christian Engwer <christian.engwer@wwu.de>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:24:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJWvd-0007QL-Fh
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 23:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab2DOVYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 17:24:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42492 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab2DOVYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 17:24:06 -0400
Received: by iagz16 with SMTP id z16so6582020iag.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BAL/2IVe0/cvcTAKXhj5PeKl4ThkY7nruV/9GnwpyNA=;
        b=pyZNiDbMrzYf9c0SsBelKmIytOOcq68cuYY7IfFKqOaWspBGgDWLJGRYj3QJbZhAix
         bEenX3CQ2sbgKeTjfEa8k4XziiBf26n+QxzosiwfYbXL3HCXp5S0Jpm8RGqiR9m0kxQd
         41L5rB4QHs6mq28ua1O+AQz9BqwWbyMWSmjVXLY1fycW8EiFyyDILKqYPImnjXx5bT5N
         /5ULooe2XZS7RkE6LvzNvU+FCKw2ywKbqe185NxrFOUHiDlOij9+R9nDgz4ITYhqB2i/
         8iUaBIBVbTB+DnJHN1IQocQKiTrvNnaHLE3AqiG3wNplslV2RVp2SiCWJDxvFh6zDIX1
         EZmA==
Received: by 10.50.160.225 with SMTP id xn1mr3756751igb.3.1334525045981;
        Sun, 15 Apr 2012 14:24:05 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ew6sm5847236igc.6.2012.04.15.14.24.05
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 14:24:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120415185535.GA9150@mathe-macht-spass.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195591>

(dropping cc to debian bug)
Hi Christian,

Christian Engwer wrote:

> a) prohibit commit if a remote-tracking branch is used
> b) allow commit if --commit-url is used
> c) allow commit if the allow-dcommit flag is true in .git/config

As I mentioned before, I really do want to be able to dcommit from my
current branch, even if it is not called "master" and is set up,
intentionally or not, to pull from a remote git repository.  I would
be a bit bewildered if git required me to say "yes, please do perform
the action I already requested of you" in order to do that, and I do
not think I am the only one.

On the other hand, I believe it would be useful to be able to prevent
_all_ rebasing on some branches to avoid fat-finger accidents.  It
would be especially useful for new users who do not know how to
recover.  This includes the rebasing performed using "git rebase" or
"git reset" by "git svn rebase".

Therefore I would be much happier to see git svn learn a pre-dcommit
hook (see githooks(5)) that can handle multiple situations than the
check that follows the particular policy you have specified above.

That said.  I am reluctant to make the following comment because
I really would love to have that pre-dcommit hook and I do not want to
take away a use case for it. ;-)

Until some interested person introduces a pre-dcommit hook, would it
make sense in your deployment to add a wrapper around "git svn
dcommit" (let's call it git-commit-to-svn) on the $PATH that performs
the check itself, so the user experience would be as follows?

    $ git commit-to-svn
    fatal: this branch is set up to push to git, not to svn
    hint: switch to a new branch before pushing
    hint: or use "git commit-to-svn --force" to override this check

That already works.  It does not require any change to git.  What do
you think?

Just my two cents,
Jonathan
