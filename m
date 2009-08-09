From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v4 0/5] Re: {checkout,reset,stash} --patch
Date: Sun, 9 Aug 2009 23:28:31 +0200
Message-ID: <20090809212831.GA12932@vidovic>
References: <200907271210.40001.trast@student.ethz.ch> <200908091117.19167.trast@student.ethz.ch> <20090809163233.GA12911@vidovic> <200908091844.43107.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Aug 09 23:28:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaFwb-0008KI-NT
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 23:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZHIV2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 17:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbZHIV2i
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 17:28:38 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37504 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbZHIV2h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 17:28:37 -0400
Received: by ewy10 with SMTP id 10so2647544ewy.37
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=PaauUopJ7h47KJNVvGk4ZFfp5xXJf69SOU/iQ0wc+/Q=;
        b=K0LnDnohFBplk0rmrMKB6IdPJPLSe3MTq6hnbx6tJO60ak2pXPSPhc+tZlXjCVGC3j
         +UfMAboZMgqLiTg9muY6wOnpU9v3cDyMOY/6SDwY5Tdf0BTuhoD8FZC0rqGWYHWxI9jJ
         EzCtwjYAz13OpLsqDK607vyYsc/Z1sVyEgIN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ul+8FaFpX0dYcxO2f8mrNwEg0CtstIxRabSVZ1GPqVFXdGmZYUS5IQPn70+NgeksbW
         NWI/V1lj/wsU65/05h4XK9NlNV1l0rXtjdM58eBXNhwn/2MQkHVslhEGKj8z2JFfSbGm
         3T/04yUSXHTG4XQsUHEfiC5HrzwH4UiM6CUUk=
Received: by 10.210.89.7 with SMTP id m7mr4282333ebb.77.1249853317703;
        Sun, 09 Aug 2009 14:28:37 -0700 (PDT)
Received: from @ (91-165-128-55.rev.libertysurf.net [91.165.128.55])
        by mx.google.com with ESMTPS id 10sm9400743eyz.31.2009.08.09.14.28.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Aug 2009 14:28:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200908091844.43107.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125385>

The 09/08/09, Thomas Rast wrote:
> Nicolas Sebrecht wrote:
> > 
> > Also, I'd expect to have 'git reset --hard -p' discarding hunks from
> > both the index and the WT (which is not possible for now unless I missed
> > something).
> 
> Well, the unfortunate overlap between 'git reset --hard' and 'git
> checkout HEAD -- .' strikes again :-)
> 
> Since you can't say 'git reset --hard -- file', you have to do 'git
> checkout HEAD -- file' to achieve this effect.  So this usage is
> covered by 'git checkout -p HEAD'.

Not exactly:

  Current branch: my_branch (clean)
  nicolas@vidovic git % echo 'hi' > file
  Current branch: my_branch (dirty: untracked:1)
  nicolas@vidovic git % git add file
  Current branch: my_branch (dirty: index)
  nicolas@vidovic git % git checkout -p
  No changes.


Same example with an already tracked file:

  Current branch: my_branch (clean)
  nicolas@vidovic git % echo 'hi Thomas' >> Documentation/SubmittingPatches
  Current branch: my_branch (dirty: working_tree)
  nicolas@vidovic git % git add Documentation/SubmittingPatches
  Current branch: my_branch (dirty: index)
  nicolas@vidovic git % git checkout -p
  No changes.


So, we can discard a hunk from the index with 'git reset -p' without
touching the WT. And we can discard a hunk from the WT with 'git
checkout -p' without touching the index. But we can't discard a hunk
from both the index and the WT.


IOW, we have (from the user POV):

  .git --- (reset -p) ---> index
                           index --- (checkout -p) ---> WT

What's missing:

  .git ------------------ ( ??? ) --------------------> WT

-- 
Nicolas Sebrecht
