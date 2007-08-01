From: "Denis Bueno" <denbuen@sandia.gov>
Subject: Re: Git clone error
Date: Wed, 01 Aug 2007 08:24:18 -0600
Message-ID: <C2D5F3B2.2B00%denbuen@sandia.gov>
References: <alpine.LFD.0.999.0707311924590.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 16:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGF81-0006bK-0y
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 16:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbXHAOYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 10:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbXHAOYk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 10:24:40 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:4442 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbXHAOYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 10:24:39 -0400
Received: from [134.253.164.156] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Wed, 01 Aug 2007 08:24:19 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from ES21SNLNT.srn.sandia.gov ([134.253.164.104]) by
 ES23SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Wed, 1
 Aug 2007 08:24:19 -0600
Received: from 134.253.202.158 ([134.253.202.158]) by
 ES21SNLNT.srn.sandia.gov ([134.253.164.116]) with Microsoft Exchange
 Server HTTP-DAV ; Wed, 1 Aug 2007 14:24:18 +0000
User-Agent: Microsoft-Entourage/11.3.3.061214
Thread-Topic: Git clone error
Thread-Index: AcfUR6UJ46PqvkA6EdyCnwAX8tQlcQ==
In-Reply-To: <alpine.LFD.0.999.0707311924590.4161@woody.linux-foundation.org>
X-OriginalArrivalTime: 01 Aug 2007 14:24:19.0503 (UTC)
 FILETIME=[A5EF2BF0:01C7D447]
X-TMWD-Spam-Summary: TS=20070801142420; SEV=2.2.2; DFV=B2007080112;
 IFV=2.0.4,4.0-9; AIF=B2007080112; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230322E34364230393739342E303039342C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007080112_5.02.0125_4.0-9
X-WSS-ID: 6AAE48194Q42446279-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54440>

On 07/31/2007 20:38, "Linus Torvalds" <torvalds@linux-foundation.org> wrote:
> Please do
> 
> cd /Volumes/work/scripts
> git fsck --full
> 
> which I would guess will almost certainly talk about some kind of problems
> with that object "b28b949a1a3c8eb37ca6eefd024508fa8b253429". And possibly
> more.

Indeed:

    scripts[10] > git fsck --full
    error: b28b949a1a3c8eb37ca6eefd024508fa8b253429: object corrupt or
missing
    missing blob b28b949a1a3c8eb37ca6eefd024508fa8b253429

Fortunately, it's the only one.

> There are certainly ways to figure out what that object _should_ be,
> though. For example, if that object is the only corrupted entry, and it's
> a blob (ie pure data object), what you can generally do is still use the
> repo (as long as you avoid that particular blob), and do things like
> 
> git log --raw -r --no-abbrev

    scripts[11] > git log --raw -r --no-abbrev | grep
b28b949a1a3c8eb37ca6eefd024508fa8b253429
    :100755 100755 b28b949a1a3c8eb37ca6eefd024508fa8b253429
9dbd5bb59198ab59e1850f838f2ed27c77364cde M      condor/condor-uninstall.sh
    :000000 100755 0000000000000000000000000000000000000000
b28b949a1a3c8eb37ca6eefd024508fa8b253429 A      condor/condor-uninstall.sh

> and you'll see the git history with all blobs named with their SHA1's.
> Then you can just search for that b28b949.. name, and you'll see exactly
> which file (in which version) it was, and if you can just find a backup of
> that file (or re-create it *exactly* from previous versions and your
> memory of it), you can re-generate the git object and thus save your
> repository.

When you say "re-generate", do you mean `git add <file> ; git commit
<file>`?  Or something a bit more clever?  I suspect you actually meant the
latter, since you suggest recreating it *exactly*.

If I just recreate a version I'm happy with, can I add that to the repo and
go from there?

> Of course, a much easier option tends to be to just have a backup
> repository that has that object in it, and then you can literally just
> copy that b28b949 object over.

No such luck, but I'll back up my repos in the future.  Any hint on what
might have caused this kind of corruption?  That repo was created on my
laptop and only edited there; it's not a clone from some other machine.
It's possible that I have Ctrl-C'd some git operation in the past -- could
that have caused it?

Is there anything (e.g. trapping signals if a blob is being written until
it's done, or backing out of the current blob on SIG{INT,HUP}) that could
make this kind of corruption less easy to encounter?  I ask because I have
used VC systems (i.e. CVS, SVN, darcs, and now git) for 4+ years (not long
by any means, but long enough) and the only repository corruption I had ever
encountered was after I went mucking about in a CVS repo's internal
representation -- and I deserved that.


                      Denis
--
"Dealing with failure is easy: Work hard to improve. Success is also easy to
handle: You've solved the wrong problem. Work hard to improve." -- Perlis
