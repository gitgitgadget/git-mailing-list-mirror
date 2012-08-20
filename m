From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/5] GSOC: prepare svndump for branch detection
Date: Mon, 20 Aug 2012 19:43:53 +0200
Message-ID: <3221500.GV11OifKyt@flomedio>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1701463.olu8UUX9CV@flomedio> <20120820164530.GD168@mannheim-rule.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 19:44:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3W1H-0004rE-6E
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 19:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab2HTRoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 13:44:01 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35220 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab2HTRn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 13:43:59 -0400
Received: by bkwj10 with SMTP id j10so1942934bkw.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=VSSggq8ZI2J1CQ+wHXBTRpOIOtPhNI5XTTgHn7fMg7I=;
        b=zXYRISmya8mLnGKaGCRk/rhLvsPNnHzsWMr5TPovKBmObmPSTZpDIPdj2uEfC2vXSr
         TU3+Nkw+ZVLKyPx+Fb65LycARydcMpTgtEspHtF1eQW7WRuAhbsQGa9EsTLolbEaZ1QC
         37AgsAWEKj7bONDi0sy2BoQi9wtjyblCi9otPy60FLVuoSvDkOr9Gy8NzsSSilzXMbt2
         io1INSk/2y3lSVNi5TFrsfGlvjc7sspCQSRbyuUIYb84aDRfqfacWQh81hWgWknEX69f
         nRhGU4+eWM4EsjJ7Fk1e5Lexzjyt+RTA6rrvn9GllKmLhfg1LyPGBHXrj5y13RO3pMZG
         FsiQ==
Received: by 10.204.130.209 with SMTP id u17mr4619436bks.35.1345484638006;
        Mon, 20 Aug 2012 10:43:58 -0700 (PDT)
Received: from flomedio.localnet (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id fu8sm6585471bkc.5.2012.08.20.10.43.55
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 10:43:56 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120820164530.GD168@mannheim-rule.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203863>

On Monday 20 August 2012 09:45:30 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> > Currently, the mark number is equal to the svn revision number the commit
> > corresponds to. I didn't want to break that, but not mandatory. We could
> > also split the mark namespace by reserving one or more of the most
> > significant bits as a type specifier.
> > I'll develop a marks-based version ..
> 
> Have we already exhausted possibilities that don't involve changing
> vcs-svn/ code quite so much?  One possibility mentioned before was to
> post-process the stream that svn-fe produces, which seemed appealing
> from a debuggability point of view.
> 

Do you mean like another program in the pipe, that translates the fast-import 
stream produced by svn-fe into another fast-import stream?
svnrdump | svn-fe | svnbranchdetect | git-fast-import ?

My two previous ideas were meant like this:
1. Import everything into git and detect branches on the stuff in git, or
2. detect branches as it imports.

Both require to create commits for their work. So the idea behind these 
patches is to split the creation of commits from the creation of data. So that 
the data can be sent immediatly as it is coming in from svnrdump, and 
therefore save memory by not buffering it. 

And create the commits later. Either all linear and splitting it into branches 
later which requires creating commits but not data, or creating branched 
commits immediatly. This requires to inspect all  node data before starting a 
commit.

Anyways it's just an idea..

> Curious,
> Jonathan

Hope that helps,
Florian
