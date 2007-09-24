From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: behaviour of git diff, GIT_DIR & checked out tree
Date: Mon, 24 Sep 2007 18:09:20 +0100
Message-ID: <e1dab3980709241009q71f9a40r1f8b551b417f7475@mail.gmail.com>
References: <e1dab3980709240545o32eeefcdkd4bc67abab0e5343@mail.gmail.com>
	 <Pine.LNX.4.64.0709241400410.28395@racer.site>
	 <7v6420au43.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 19:09:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZrRM-00057p-4M
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 19:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758926AbXIXRJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758551AbXIXRJX
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 13:09:23 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:4038 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758592AbXIXRJW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 13:09:22 -0400
Received: by py-out-1112.google.com with SMTP id u77so3023712pyb
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ldvmwLxCjiq4BzT5skNDAwCfGIfwUZMIUjaaxpQZRsQ=;
        b=crQkmki7SNnMBBL6xCLq9K9AVqDefRT+0guJ1KEc7RLE37l4uabTktA0TT1JmQbCcj0y/UCyf3TVkJ8PtajKUDdHYRl8BTmFHGL3ShhzZd2agGzRnHunil37HgHqtJ8DPcof/cEVHQ4vc5x7LlypPple485xKBtrfro21ZtLz1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uKW5b2YvpYcQCiWl8NHxxHr5bXshMY7u6vxR8Do93OEZm+SpPI/fjcKyHiDxuQqTzn2b0EcZtAd1LF/hyF4T/XEnqQuTIZe+SKGRlO1TPSbXymvetimjC+QBJ3+uSJVGKtdm2SiLaeDrZA8ifH85xA2ux5P8LWTicPceaRTRklM=
Received: by 10.65.234.2 with SMTP id l2mr7322806qbr.1190653760687;
        Mon, 24 Sep 2007 10:09:20 -0700 (PDT)
Received: by 10.64.181.10 with HTTP; Mon, 24 Sep 2007 10:09:20 -0700 (PDT)
In-Reply-To: <7v6420au43.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59064>

On 9/24/07, Junio C Hamano <gitster@pobox.com> wrote:
> It would be illustrative if David did the following.
>
>         $ cd $HOME
>         $ cp -a V W
>         $ rm -fr W/.git
>         $ cd W
>         $ GIT_DIR=$HOME/V/.git git diff @{midnight}
>
> Now we are in a random place outside of the work tree
> (i.e. "W"), and we drive "git diff" with GIT_DIR specified,
> telling it to pretend that we are at the top level of the work
> tree.  So ~/W/frotz is compared with "frotz" at the top level of
> the commit (which usually is compared with ~/V/frotz), etc.  But
> the directory we happen to be in very much resembles the work
> tree, so it would give identical results to
>
>         $ cd $HOME/V
>         $ git diff @{midnight}

To separate the two issues, I did all the commands to the diff
above and then removed one directory from the tree in W.

GIT_DIR=$HOME/V/.git git diff master~1
(which ought not need reflogs, right) and it gave a diff between
the contents of W and master~1. I also tried with commit
master@{midnight} and that also gave the difference between
W and the last commit yesterday. So Junio's explanation of what's going on
is right. I'm just asking if there's a way to say
"the `working dir' associated with this git dir" explicitly (in the same
way I can use `HEAD' to refer to the topmost commit on the
current branch) when you're not somewhere within the 'working dir'.
If there's not I can alias around it with
"cd $HOME/V && command && cd -". (As I say, for reasons unrelated
to git usage I don't actually "do work" within the tracked tree.)

Many thanks,

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
