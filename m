From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 0/3] git-cvsserver: Add support for some binary files
Date: Mon, 19 May 2008 22:53:34 +1200
Message-ID: <46a038f90805190353o42fe59f2lfee9b6befdd588db@mail.gmail.com>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net>
	 <7v7idteqzn.fsf@gitster.siamese.dyndns.org>
	 <46a038f90805181538v56aee5b8y33d68b226a62494f@mail.gmail.com>
	 <20080519073535.GA2885@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junio@pobox.com>, git@vger.kernel.org,
	"Martin Langhoff" <martin@catalyst.net.nz>,
	"Frank Lichtenheld" <djpig@debian.org>
To: "Matthew Ogilvie" <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Mon May 19 12:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy30e-0002sZ-8E
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 12:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbYESKxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 06:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755086AbYESKxi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 06:53:38 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:44766 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbYESKxg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 06:53:36 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1295084wfd.4
        for <git@vger.kernel.org>; Mon, 19 May 2008 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9G5Ab6q2R/hTSua8l1riTaHacHTZAXFXXi01MwC/w1U=;
        b=Dd9mVRcmrwGcLYAIf0a1MeNY4MSs9qIHTZQbelHk0GYFPf6F/GJLv/QFmxmwEhQJ3U38ZT5QnNVW5bemiqALsDsaAo7x2kCSb9z3pvhThWYJ223nb0IIb2pPzpynnQgL9ouqi3hLf05C8SaRjp3gjXORSROATBO9LAbfG6yVhtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=u1IB4NOrDvRg0bnWv9bsGfqqojo99qI2xv/mxTChWLDedvrUDuEuO6FQgJVkIyuM1GspB8im+DhQiQ/vSt2EbNVXrWHjVuluNPt+G6KySrmwrQ30Et4zzmSip7g235yVvkXyOjwNsihgdDLXlWz5ad6w3yff/2jRNwx1iWVamYw=
Received: by 10.142.217.17 with SMTP id p17mr2785806wfg.139.1211194414353;
        Mon, 19 May 2008 03:53:34 -0700 (PDT)
Received: by 10.142.128.16 with HTTP; Mon, 19 May 2008 03:53:34 -0700 (PDT)
In-Reply-To: <20080519073535.GA2885@comcast.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82426>

On Mon, May 19, 2008 at 7:35 PM, Matthew Ogilvie
<mmogilvi_git@miniinfo.net> wrote:
> I've heard the most finicky CVS client is probably the
> one embedded in the Eclipse plugin.  Apparently it has had trouble
> with minor tweaks in new versions of official CVS, let alone
> an emulation.  But given that I have never even tried Eclipse, I
> probably am not a good choice for testing it, and probably wont.

Indeed. We've had endless trouble with Eclipse :-(

> Generally my motivation here is to make it easier for
> an organization like my day job to transition to git.  I generally
> don't intend to use git-cvsserver myself much, especially not from
> platforms that need the newline-munging.

That's exactly the reason why interest in cvsserver is always fleeting
-- people hack on it during their team's transition. Perhaps you can
get some help from an Eclipse-wielding member of your team ;-)

> I perceive one remaining big issue for git-cvsserver to be
> a good replacement for real CVS: The ability to properly
> support "cvs update -r VERSION", where VERSION could

That would be good, and is not too hard. You can mostly simulate that
extending the sqlite DB.

With that in place, a _very_ cool thing would be to add a special
"initial run" script, intended for projects that have just been
imported from a real CVS repo. The initial run script would look at
the CVS repo and add the needed version skew to make the revision
numbers of each file in sqlite match the cvs repo. For sane imports
this would work pretty well, and there's an amount of safe "skew" you
can add for slightly not-sane imports.

The end result is that a project can switch from CVS to git +
git-cvsserver and end users would not need to change their CVS
checkouts at all. Covert cvs->git migration, and users switch to git
on their own schedule.

WRT to your other notes, I agree that cvs update -j -j support isn't
interesting -- users that do merge will want to be on the git side of
things -- but it isn't hard. Submodules is probable not worth the
hassle - at least not yet :-) and a nested CVS checkout works
transparently - in some cases moreso than git submodules!

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
