From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: gitk performance questions/issues
Date: Mon, 13 Aug 2007 18:18:24 +0100
Message-ID: <e1dab3980708131018h495c5cf2m76cb8f6ffc4df6dc@mail.gmail.com>
References: <e1dab3980708130248g1cbab0cej18e260c8bfa2b315@mail.gmail.com>
	 <alpine.LFD.0.999.0708130945420.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKdYs-0002hf-2t
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 19:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S973497AbXHMRSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 13:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032251AbXHMRSc
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 13:18:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10315 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031877AbXHMRS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 13:18:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so602816ugf
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 10:18:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QlesE5IJ+9xAoyKk/+XXIzUezMFP5DT1dbvT9QDLAOLM3DRZb22qPEsh47xBSIbQ8zuDUl3KvC01bLUh5oTo7wOxHy+zf2WquxrYNI+yMQRrVfAVmsBd2cL2KAfR6PpUnV2oa7a3yM5Psm6hmzqzcb8ldfW7fH35+zwfKuDBVCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HnUtmz1GCT7/tgNspzZ6xcyuPlZSNE35Or//yOnGMSQzrOYbQHQBf6AgzMyLbP9+x8HEUSbXWvJzuQUkmuK6FDUGTAuajoxH+d5ZF36p+rWAoAaxOLTZr93CManA1nZSL7jCB1vub0l2yv6esmOvi1m8y0MhSCO899zB5JBWKiQ=
Received: by 10.70.129.6 with SMTP id b6mr9847084wxd.1187025504341;
        Mon, 13 Aug 2007 10:18:24 -0700 (PDT)
Received: by 10.70.26.12 with HTTP; Mon, 13 Aug 2007 10:18:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708130945420.30176@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55773>

On 8/13/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Alternatively, maybe your repo has some odd structure (do you have tons
> and tons of branches or tags?) and "gitk" ends up having some problem with
> that. What does
>
>         git rev-parse --all | wc -l
>
> say? Various git tools have had performance problems with thousands of
> branches or tags in the past.

Ah, that's it: I've got
$ wc .git/packed-refs
  1915   3832 130178 .git/packed-refs
and 35 currently unpacked tags and temporarily moving that
file away, gitk now starts up virtually instantly. My usage generates
a tag per commit which is probably excessive. For completeness,
$ git rev-parse --all | wc -l
1957

Thinking about it, I suppose even if you're only looking at the last
256 commits you've got to look through all the tags to see whether
or not they refer to something within that window, so it's not
unreasonable for it to affect startup time.

The bit that is a quite surprising to me is that once the window has
finished initialising, clicking on one of the blue dots now (ie
without .git/packed-refs file) now generates the diffs instantly
as well. It's not obvious to me why the existence/non-existence
of tags should affect displaying-diff performance.

Anyway, now I know I can rearrange things not to need anything
like as many tags.

Many thanks for the help,

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
