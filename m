From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working
 directory
Date: Thu, 4 Sep 2014 23:26:34 -0400
Message-ID: <20140905032633.GB25339@odin.ulthar.us>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1409387642-24492-23-git-send-email-pclouds@gmail.com>
 <70985AC885404243A2B95F534083A0E9@PhilipOakley>
 <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
 <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com>
 <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley>
 <CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com>
 <5405D983.3050707@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 05:26:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPkAk-0000Dl-0M
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 05:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbaIED0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 23:26:39 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:45512
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999AbaIED0i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 23:26:38 -0400
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id nFLj1o0020mv7h055FSd43; Fri, 05 Sep 2014 03:26:37 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id nFSc1o00F2Ekl483XFSckJ; Fri, 05 Sep 2014 03:26:37 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.7/8.14.5) with ESMTP id s853QZch029638;
	Thu, 4 Sep 2014 23:26:35 -0400
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.7/8.14.7/Submit) id s853QY6i029637;
	Thu, 4 Sep 2014 23:26:34 -0400
Content-Disposition: inline
In-Reply-To: <5405D983.3050707@xiplink.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1409887597;
	bh=eP0y6zMOCKdlISS/+wJWRVM8as8Ww0Y85hiZW9NQc5Q=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=lHx8Cgttux9VObkGsJOSU2vMXyfR6SDOaF9Pq961+G90LQBd8jk3bil3Y45VhyXnM
	 1KUPj1MypOlYpcyfDiBxG+IBeOtiJo0am6AIMFPUAUTWKAjMc0RvFk1/xrmo0hcspP
	 mHgNckr/zBtM3tjM5T+tQOSTPvxde4CycWc9mM7elHM8lHAI7NypGlCadG0+KKznYH
	 IM2bu/v4wwveUPGM996Iz/7oJec/4d+32WFggM7jIG8I613LFQwlL+RvaSjg3VQjNl
	 Y+muuK9MD0tDYJYOE96PwPR6TaOs3WaAV0/W0UevVEUMBG+wc0KLK89F2ACWUGTO/Z
	 NdFEOl0T47Y5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256498>

On Tue, Sep 02, 2014 at 10:51:47AM -0400, Marc Branchaud wrote:
> MULTIPLE WORKING TREES
> ----------------------
> 
> A git repository can support multiple working trees, allowing you to check
> out more than one branch at a time.  With `git checkout --to` a new working
> tree is associated with the repository.  This new working tree is called a
> "linked working tree" as opposed to the "main working tree" prepared by "git
> init" or "git clone".  A repository has one main working tree (if it's not a
> bare repository) and zero or more linked working trees.
> 
> Each linked working tree has a private sub-directory in the repository's
> $GIT_DIR/worktrees directory.  The private sub-directory's name is usually
> the base name of the linked working tree's path, possibly appended with a
> number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
> command `git checkout --to /path/other/test-next next` creates the linked
> working tree in `/path/other/test-next` and also creates a
> `$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
> if `test-next` is already taken).

As a user, this leaves me with one other question -- what happens when
I'm done with the test-next working tree and want to delete/rename it?
Is that cleaned up automatically, or do I need to register that I'm
getting rid of/renaming it?  (Another use case is if I put the working
tree on removable media for some reason.)
