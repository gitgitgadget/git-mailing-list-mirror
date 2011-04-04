From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How to split a big commit
Date: Mon, 4 Apr 2011 18:30:20 +0530
Message-ID: <20110404130016.GA16975@kytes>
References: <BANLkTikFXzut7fY5Tr0u-abu5Q0rMUOCmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 15:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6jPO-0004KK-Hj
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 15:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab1DDNBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 09:01:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37744 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab1DDNBY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 09:01:24 -0400
Received: by iyb14 with SMTP id 14so5860675iyb.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=b6C0uInUplrAMuDT5Rqsw/W6cCLCxhEFh8x4Znn7c28=;
        b=LQ48ec/yT/IzmivIAdB6bMqHkOzJtPu8Ton5AUQPgviaPDFIcFLNNVCAX35ETRsy4l
         YNa0XAOYtSfmwY+q5kt+GtlvueTOWEIntVym86zLZeoQQ983BMSfgVzMSGxCGJXoxaeT
         QGr+VTbvHF1ZxpldG9CCeohY7kysaG7+UdP9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VfPPVuN8Og2WVfqIv848HByfdEkML7oDbuItHIbmKZNLpUst5pC7jTew8RUHHUazpW
         JNfUj0qZ1Zrdx184qbZ7J63ClgJTt92ZKUBraSWr2KmsPUxakcp39dOl6kStgmMYxnvI
         JteYscwVSNiKRiEOAu5npNCcjCBIHhf4Z0KtY=
Received: by 10.42.176.74 with SMTP id bd10mr10567710icb.256.1301922084312;
        Mon, 04 Apr 2011 06:01:24 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i26sm3754556iby.7.2011.04.04.06.01.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 06:01:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikFXzut7fY5Tr0u-abu5Q0rMUOCmA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170811>

Hi Nguyen,

Nguyen Thai Ngoc Duy writes:
> After a lot of small commits and a few mixed up large commits, it was
> too messy that I merged them all into one big commit then started
> spliting it into smaller, reasonable patches. Just wonder if anybody
> else faces the same thing and how they deal with it. I used "git reset
> --soft <big commit>^" and "git add -N" because there were new files,
> but it was clumsy.

To split a big commit, I simply reverse-diff-apply the changes that I
don't want in the big commit, and I stage all changes.  Then, I again
reverse-diff-apply all the staged changes, and keep that in the
unstaged portion.  Your repository should look like this now:

commit bigcommit
diff --git a/bigfile b/bigfile
+Desirable change
+Undesirable change

Staged changes:
diff --git a/bigfile b/bigfile
-Undesirable change

Unstaged changes:
diff --git a/bigfile b/bigfile
+Undesirable change

Now simply 'commit --amend' to remove the undesirable change from the
bigcommit, and commit the unstaged changes to produce a new
commit. Final result:

commit bigcommit
diff --git a/bigfile b/bigfile
+Desirable change

commit newcommit
diff --git a/bigfile b/bigfile
+Undesirable change

I can afford to do this kind of jugglery very easily because I use
Magit with Emacs.  After highlighting the relevant portions,
reverse-diff-apply is one keystroke :) But yes, you're probably right-
there should be an easier way to do this.  Maybe a 'git split' that
allows you to interactively select the portions of an existing commit
that you'd like to exclude from the commit and turn into a new commit?

Hope that helps.

-- Ram
