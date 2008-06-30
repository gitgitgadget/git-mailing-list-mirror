From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v8] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 30 Jun 2008 02:30:44 +0200
Message-ID: <48682934.6090406@gmail.com>
References: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com> <200806300047.12224.jnareb@gmail.com> <48681D21.1040302@gmail.com> <200806300156.28908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 02:32:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD7Jh-0007I2-16
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 02:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbYF3Aav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 20:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYF3Aav
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 20:30:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:30561 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbYF3Aau (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 20:30:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so653764fgg.17
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=522ma4oAJRy3Vrm32t0e8R78vn9KNTIssZhyZPf9CR8=;
        b=QlgZkYeEvz3QiNu84fswhQAr3xI9rcpBNU0FFkcKO+QOAAVSCQI4G2pKMuTUnt9d+p
         uUyKJ+sHf5ThZ9GKUTGDw2+Tw325mqUwp13t/volYMPAber/5zUZerDvmA1cZ5eTCZNi
         EElQzWPbIutdxC+MfrJKgaKX2AQK5iiNPZ3Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=x6itDs37PtRvu6+imVnzyJfWSlSsWSo/Wo8k1QXBNCYB1wYMHttALPwtjZh8T2cl9H
         li0o/BapDrVHjdXNr5tIUp8VdFyH88IKR2CFcMz6tZpn829U25zMNjjmiTmv/MoFUGZp
         tyO3uhPYVJp/x/otBbHdJ/avAXKmF2Z4wk+OQ=
Received: by 10.86.27.9 with SMTP id a9mr5343091fga.57.1214785848640;
        Sun, 29 Jun 2008 17:30:48 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.203.119])
        by mx.google.com with ESMTPS id 4sm7810679fge.5.2008.06.29.17.30.45
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 17:30:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806300156.28908.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86850>

Jakub Narebski wrote:
> some time ago I have send a patch which converted support for
> links with hash and without action to use redirect instead of
> silently filling correct action based on type of object [...]
> IMHO it is better as it should prevent bookmarking "expensive" URL.

Haha, I'd actually suggest the opposite. ;-)  Figuring out the right
action is almost free since you have to fetch the object anyways, so I
doubt it'll make any difference performance-wise (though it'd be
interesting to benchmark this).  However, gitweb's URLs are
prohibitively long -- so that nobody uses them in email --, and
(automatically?) dropping the action parameter where possible would be a
good first step to shortening them.  Another idea would be to shorten
the hashes.

>> there are links to line numbers that don't exist
> 
> I wonder if those are intentional (or at least known) breaking, to form
> approximate blame file history browsing;

*nods*  I wasn't following this in detail; if it turns out to be
unfixable, we could also remove the fragment checks for line numbers
(rather than running them as "TODO:" tests).

> [Git::Commit:] you should not error out on unknown header in commit object,

Unless this can actually happen in practice, I'd rather die aggressively
-- it prevents errors (like cache hiccups) slipping through unnoticed.
