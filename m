From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: the pager
Date: Wed, 28 Aug 2013 14:19:48 -0400
Message-ID: <201308281819.r7SIJmnh025977@freeze.ariadne.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com> <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 20:19:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEkLU-000099-2N
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 20:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab3H1STw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 14:19:52 -0400
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:59798
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752980Ab3H1STv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 14:19:51 -0400
Received: from omta24.westchester.pa.mail.comcast.net ([76.96.62.76])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id JAQh1m0031ei1Bg59JKq8d; Wed, 28 Aug 2013 18:19:50 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta24.westchester.pa.mail.comcast.net with comcast
	id JJKq1m00A1KKtkw3kJKq7H; Wed, 28 Aug 2013 18:19:50 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r7SIJnEQ025978;
	Wed, 28 Aug 2013 14:19:49 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r7SIJmnh025977;
	Wed, 28 Aug 2013 14:19:48 -0400
In-reply-to: <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1377713990;
	bh=Us2zX+vSFmQcdOfWUc3qquhWB3RRs18Rmvl71K2ItzM=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=Nb8qdQG/vENbOjCFa12ZZyyqWD2BENS2zJaUjaCSdyiCAq8DJkN3d4xi5yG2Gw1Hh
	 YcNXUxG4ilB/ghRU6jk3DNXsuF3FQ5Nhd5Sm9u8nP+r4q2KJsyaztbeA1xR3NgkGo1
	 oOlr/DRzO4lVqLugBMrNyfqZq3R6lkwTbqczg5lJW/xd+gcrNsuSvabIkYzw2eXLmW
	 3cPkBrVtmnbO7eG7sEdK9Dt+GULOsY6+3PsTIyVqZEmqPuIWGwv+x3iOBemfaqLvQm
	 QWxZUO0eipWArfhPjtfms7PJAIZipYyRnJI19QMD87g5f39Kz7XHSfziDkMG8zWN31
	 SUMpaMOvfnITQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233192>

> From: Junio C Hamano <gitster@pobox.com>
> 
> > I've noticed that Git by default puts long output through "less" as a
> > pager.  I don't like that, but this is not the time to change
> > established behavior.  But while tracking that down, I noticed that
> > the paging behavior is controlled by at least 5 things:
> >
> > the -p/--paginate/--no-pager options
> > the GIT_PAGER environment variable
> > the PAGER environment variable
> > the core.pager Git configuration variable
> > the build-in default (which seems to usually be "less")
> > ...
> > What is the (intended) order of precedence of specifiers of paging
> > behavior?  My guess is that it should be the order I've given above.
> 
> I think that sounds about right (I didn't check the code, though).
> The most specific to the command line invocation (i.e. option)
> trumps the environment, which trumps the configured default, and the
> hard wired stuff is used as the fallback default.
> 
> I am not sure about PAGER environment and core.pager, though.
> People want Git specific pager that applies only to Git process
> specified to core.pager, and still want to use their own generic
> PAGER to other programs, so my gut feeling is that it would make
> sense to consider core.pager a way to specify GIT_PAGER without
> contaminating the environment, and use both to override the generic
> PAGER (in other words, core.pager should take precedence over PAGER
> as far as Git is concerned).

I've just discovered this bit of documentation.  Within the git-var
manual page is this entry:

       GIT_PAGER
           Text viewer for use by git commands (e.g., less). The value is
           meant to be interpreted by the shell. The order of preference is
           the $GIT_PAGER environment variable, then core.pager configuration,
           then $PAGER, and then finally less.

This suggests that the ordering is GIT_PAGER > core.pager > PAGER >
default.

Dale
