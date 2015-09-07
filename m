From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v1 0/2] contrib/subtree: make it respect spaces in a
 repository path
Date: Mon, 7 Sep 2015 14:05:54 +0300
Message-ID: <20150907110554.GA482@dell-note>
References: <cover.1441404851.git.Alex.Crezoff@gmail.com>
 <xmqqoahheqax.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 13:06:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYuFO-0004tu-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 13:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbbIGLF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 07:05:59 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33463 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbIGLF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 07:05:57 -0400
Received: by lamp12 with SMTP id p12so48798192lam.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9xGGO8DWuoqU99mzU6w2WDVsfQNcYO4K7qRiqHkgJ+M=;
        b=0PnKpwqGkZ0FLgRu+l1itTMWaFAI8D7xPKbnGg9UfZf2IgHUAxYC7etuDU/9PJiBLS
         iT+G8hW/I3UbkAROuiBoB38CwH2RAWSFwHn9ueyw6wqYj/NRiOhNBHo/fyl2HENuuSmF
         bDpOoLZ7tJjGaETuUV5Yq0yccd1Bbjqo8jXZB/tZYilSRmCxgvkdhQ2EN2r80XHNvkzm
         np3kMG2sUO+vOMvFIo/s1e8l6PTTO9yzuAswG6URzvMTFv7ALDsBqhUX2MPeuQoXZU6/
         x7gcfDsKJpfRdsFPseqbnhdTXF0zRuvRH839uofSYQd6j2WsIqH08PhC2+CSloIU6rh/
         wAUQ==
X-Received: by 10.112.55.105 with SMTP id r9mr16555129lbp.89.1441623956439;
        Mon, 07 Sep 2015 04:05:56 -0700 (PDT)
Received: from localhost ([213.108.22.197])
        by smtp.gmail.com with ESMTPSA id j1sm2976086lbc.15.2015.09.07.04.05.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2015 04:05:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqoahheqax.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277448>

On Fri, Sep 04, 2015 at 04:08:06PM -0700, Junio C Hamano wrote:
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> > Some repositories may have spaces in their paths. Currently `git-subtree`
> > raises an error in such cases.
> > Also, `git-subtree` currently does not have tests for its 'push' command.
> > Following patches are to fix these statements.
> >
> > Alexey Shumkin (2):
> >   t7900-subtree: test the "space in a subdirectory name" case
> >   contrib/subtree: respect spaces in a repository path
> 
> Doesn't this order break bisection?  It seems that you turn "subdir"
> to "sub dir" in existing tests, and I understand that the whole
> point of this series is that such a change will expose that the tool
> is broken, making tests fail.
It seems I have to reword commit messages to avoid such an interpretation.
Because, the first commit does not break anything. It is to change the
tests for `git-subtree` "to show" that `git-subtree`s already tested
commands (almost) work correctly if there are spaces in paths (except
--rejoin-msg issue).
And the second commit adds missing tests and the fix.
Should I add/commit the breaking test first and then commit the fix?
> 
> Also, if you feel up to it, it might be a good idea to clean t7900
> test up to the current best practice before doing any other changes
> as a pure preparatory clean-up patch.
> 
> Namely, using cd outside a subshell of the tests to move around is a
> bad thing to do, and you are adding more instance of it in this
> series.  If one test with such a cd to go down fails before it has a
> chance to come back up (or go up and then fail to come back down),
> the later tests will be left in an unexpected place.
I understand this issue with "cd" (I've just followed the existing t7900
tests "code style").
> 
> >  contrib/subtree/git-subtree.sh     |   4 +-
> >  contrib/subtree/t/t7900-subtree.sh | 194 +++++++++++++++++++++++--------------
> >  2 files changed, 124 insertions(+), 74 deletions(-)
> 
> Thanks.

-- 
Alexey Shumkin
E-mail: Alex.Crezoff@gmail.com
ICQ: 118001447
Jabber (GoogleTalk): Alex.Crezoff@gmail.com
Skype: crezoff
