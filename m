From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Sun, 12 Aug 2012 13:10:36 -0700
Message-ID: <20120812201036.GB4065@mannheim-rule.local>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1636924.tANzCnKezB@flobuntu>
 <20120812161258.GA3829@mannheim-rule.local>
 <2007117.uOeClQJdrW@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 22:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0eV3-0007su-RM
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 22:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab2HLUKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 16:10:20 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59465 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab2HLUKT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 16:10:19 -0400
Received: by pbbrr13 with SMTP id rr13so6032698pbb.19
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=USE9VD8+PP3DQb028O6HcUymc9F+a+KMk7GzeLjbTRs=;
        b=0kZGkslib5n0eoZXds2JwCidIFM8wqeAje6FUzQJYqE7cVghktgBgDG55XgH4Gw4mt
         b43ON4tfxoSli8ahIH4I0sRYEqxJSL07CDPQzIVN/nQfLKWdTcFF3OeV+PZxUxOM55bK
         jV/XCdWeFc3+lJNJFe/nFLPCuAXl3tkXoC5kczP9YvAwTZvM7BgGHkaNESyg0Zix/pp4
         SExkU9hRpxK5qoktuXkRwh/KJtwbRl3pz6eFxGNtO4zz9brCmcWAKOydAATKvuFzgBXY
         /W5GVHmnRCo+jJkJWdZxmGPHhksEZNr1HWGkYKycbyhw1MumZVKfdhqGTk3J+8KTPz6x
         2ZaA==
Received: by 10.66.78.196 with SMTP id d4mr13450358pax.76.1344802219192;
        Sun, 12 Aug 2012 13:10:19 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pq1sm3853032pbb.3.2012.08.12.13.10.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Aug 2012 13:10:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2007117.uOeClQJdrW@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203318>

Florian Achleitner wrote:

> This is how I see it, probably it's all wrong:
> I thought the main problem is, that we don't want processes to have *more than
> three pipes attached*, i.e. stdout, stdin, stderr, because existing APIs don't
> allow it.

Oh, that makes sense.  Thanks for explaining, and sorry to have been so
dense.

At the Windows API level, Set/GetStdHandle() is only advertised to
handle stdin, stdout, and stderr, so on Windows there would indeed
need to be some magic to communicate the inherited HANDLE value to
fast-import.

But I am confident in the Windows porters, and if a fast-import
interface change ends up being needed, I think we can deal with it
when the moment comes and it wouldn't necessitate changing the remote
helper interface.

You also mentioned before that passing fast-import responses to the
remote helper stdin means that the remote helper has to slurp up the
whole list of refs to import before starting to talk to fast-import.
That was good practice already anyway, but it is a real pitfall and a
real downside to the single-input approach.  Thanks for bringing it
up.

Jonathan
