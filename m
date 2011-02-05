From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [idea] separate .git dir and the working tree
Date: Sat, 5 Feb 2011 12:04:25 -0600
Message-ID: <20110205180425.GA18961@elie>
References: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
 <20110205032339.GA15303@mg1>
 <20110205132708.GA18391@elie>
 <AANLkTinYMuXSvKjgtpSCbJPuo=PHDGR_OgOkwtV4Azmz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Gant <mike@gantsfort.com>
To: redstun <redstun@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 19:04:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlmUx-0003t3-Cc
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab1BESEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 13:04:34 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61435 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab1BESEd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 13:04:33 -0500
Received: by qwa26 with SMTP id 26so2576450qwa.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 10:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uBT0Au1kc0ToAP9XpuXYghtJ2RJVcQLhyVXWmdzl7Nw=;
        b=ZzcpU8vWiluhksL/H3UyKnvUWYEa6bjt/F2Jvoohes77vNRldnid7Z8jkAG2UIuQqL
         H3e1eRK3izaEEPBuUi7LLOmNFyh8fGIiEwZ9sPhNbmxV0MWL1NU3vp6fcNiKpY+V0S/b
         ifrxEKCZMk7Ds2RyJcJMw2KMom97DFDRk58sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N7uoYZCVHXsJJeSk0ofXksUaFVAqdNs9xo3SoCopyN4jEdNBB08Ux2s1KO+QI03a1d
         3MDuuKgZd3MnDRawBVEmix7Qe8lXYTL2a/kpCEM9ZrCR0xgG4aamHeD7nmKGi/HQVU/h
         wrwBhMzgA650oi7rZogvgalwwNFbo8sw3N5/U=
Received: by 10.229.212.3 with SMTP id gq3mr9063263qcb.169.1296929070992;
        Sat, 05 Feb 2011 10:04:30 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id l12sm1430321qcu.19.2011.02.05.10.04.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 10:04:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinYMuXSvKjgtpSCbJPuo=PHDGR_OgOkwtV4Azmz@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166104>

redstun wrote:

> what I wanted is, I may have multiple git working tree in my $HOME, like:
> $HOME/proj1
> $HOME/proj2,
> 
> I then wanted their .git directories respectively located at
> /safe/disk/.git_proj1
> /safe/disk/.git_proj2
> 
> How can I get this? I tried to read the doc but didn't have much luck.

By making .git in $HOME/proj1 a symlink to /safe/disk/.git_proj1 and
making $HOME/proj2/.git a symlink to /safe/disk/.git_proj2.
GIT_DIR should be left unset for this to work.

The GIT_DIR variable is for more complicated use cases in which you
do not want a .git directory, file, or symlink in the worktree at all.

One uses it as follows:

	GIT_DIR=/somewhere/else/.git git <command> ...

The top level of the work tree is inferred to be the current working
directory and git metadata is taken from somewhere else.

Sometimes a person does not only want to work in the top level of the
working tree.  To tell git where the top level is, use the
GIT_WORK_TREE variable:

	(
		GIT_DIR=/somewhere/else/.git; export GIT_DIR
		GIT_WORK_TREE=$(pwd); export GIT_WORK_TREE

		cd sub/directory
		git <command>...

		cd ../other/directory
		git <other command>...
	)

These are not variables for your .profile, since as you mentioned, a
person typically will work with one git repo and worktree sometimes,
another git repo and work tree another time.

Hope that helps,
Jonathan

Side note: I don't think you mentioned wanting it, but for reference,
there is a nice tool for sharing objects between multiple worktrees in
contrib/worktree.  It comes with some sharp edges, as described in [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/150559
