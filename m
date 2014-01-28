From: Johan Herland <johan@herland.net>
Subject: Re: Having Git follow symlinks
Date: Tue, 28 Jan 2014 15:47:14 +0100
Message-ID: <CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com>
References: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jan 28 15:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W89wj-0004L3-R7
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 15:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbaA1OrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 09:47:21 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:59300 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbaA1OrU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 09:47:20 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1W89wc-0000jW-Gs
	for git@vger.kernel.org; Tue, 28 Jan 2014 15:47:18 +0100
Received: from mail-pb0-f43.google.com ([209.85.160.43])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1W89wc-0006Pa-5m
	for git@vger.kernel.org; Tue, 28 Jan 2014 15:47:18 +0100
Received: by mail-pb0-f43.google.com with SMTP id md12so437464pbc.30
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 06:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PNu600+CvVLn/cvX7HYW5ymb2H8wWaiTRA9y1Yo2QqU=;
        b=Add6e1mTtYSstNWmdHZtyxxftQjP+PBmqmK1mP+vS8tAIf1W5yAm3fpo4sxjmPrw73
         n39BQROu4rX80I5WQTDeaTDQuxzxOkjPkRiTluH1+TddsssYQXDE/ErmT6+SKymLFSGR
         XssgzdVntU+A4IpEoK+I8TDr5qrfLLFjStM9gvs0Eg/n7g8xPmoNbR4FWVDN4cB+baCv
         S/j8kv4n8bxJYBy59CjqbVIEScZoPwYjQ+te3jU6H3LDy4XnNcP/Ku8Ry1kkMmlwi6ur
         x4Q3vTI0Xs6o0NVBmnZUfiqgB14r0wA0zit/lN05UlTMPGBV0dDXN6ODHO4ZH0hevNHD
         UeLg==
X-Received: by 10.66.190.198 with SMTP id gs6mr1897074pac.49.1390920434431;
 Tue, 28 Jan 2014 06:47:14 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Tue, 28 Jan 2014 06:47:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241187>

On Tue, Jan 28, 2014 at 2:49 PM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Is there a (per-repo) setting to get Git to follow symlinks in the working
> directory, i.e., to not store the symlinks themselves but rather work on
> what they point to?

Not that I know of.

> Background: I have a repository that stores a number of my dotfiles, shared
> between all my machines (Linux, OSX, Windows/CygWin, Solaris). It is
> currently a CVS repo that I wish to convert to Git since CVS is getting more
> and more scarce. However, I have the repo set up so that I check it out into
> a subdirectory of its own, and have symlinks (junctions on Windows) both
> coming into it (for files that live in ~) and out of it (for subdirectories
> of ~ that cannot be symlinks themselves, such as ~/.ssh, or that live
> elsewhere, such as under AppData on Windows or ~/Library on MacOS). CVS
> handles this by simply not knowing anything about symlinks, and I would like
> to get Git to do the same.

I believe a preferable way to manage dotfiles in Git, is to have a
script that does the necessary setup/installation from the repo (that
lives in some subdirectory of ~) and into ~. This script would be able
to:

 - Set up whatever symlinks or copies are needed
 - Apply permission/mode bits that are not stored by Git
 - Properly handle various platform differences (symlinks vs. junctions, etc.)

As a bonus, you can run the script as a post-checkout hook, to have it
automatically apply any updates you fetch/push into your dotfiles
repo.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
