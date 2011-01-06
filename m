From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: False positives in git diff-index
Date: Thu, 6 Jan 2011 12:12:34 +0000
Message-ID: <AANLkTikJY2u2XKDpqwBYLcTwXz1Je6nW1-cffyaw=-fR@mail.gmail.com>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
 <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
 <20110105054825.GC5884@sigill.intra.peff.net> <AANLkTimQCMr+emw=rXdBKKnD_W9G981zCkboKgiDWxPF@mail.gmail.com>
 <20110105061515.GA12163@sigill.intra.peff.net> <AANLkTimFbodDe=DMj5kkR749sG8bDTxyjDCtOEvmDkRd@mail.gmail.com>
 <20110105080802.GA15997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 06 13:13:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaoiD-00080M-Dv
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 13:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab1AFMM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jan 2011 07:12:56 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45973 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab1AFMMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 07:12:55 -0500
Received: by qwa26 with SMTP id 26so16665800qwa.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rAr3hYFP0ma1dPB5ZFlFUEUAWbc0woN1aONY/lXCzOA=;
        b=wruUNI2MEF8iCYEuDRqOH7uCJsySv4oHdWNr/f9mejV1C+PYpeDUoqeHTpQL9GGr/N
         z3Qec7Nwq8+VYvtNrLRWPucu9JqV+XyW3UWDcN3GSGo9iykZ5uyCgO0fK59+1y7dounv
         m+Na161aCzlzJNJzrBgvN+Vi4aVs1ppSZBCOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=D440TKbpqrh1jvO1qxxTy6stf5AFF+1aqSAHuhx6qmYwouSXZs0ChnfGW0gZl2UUHi
         gRHeSGBko1uGi8EKvp41SL3mrOlSOdoA+A7ymLFFs8opmaXrkqoLJFs8S3ssUcbm03gI
         AnzMxCe66kf+sjMa2L9yEd25h43XtET6i5JdI=
Received: by 10.229.182.11 with SMTP id ca11mr13697254qcb.15.1294315974578;
 Thu, 06 Jan 2011 04:12:54 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Thu, 6 Jan 2011 04:12:34 -0800 (PST)
In-Reply-To: <20110105080802.GA15997@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164629>

Hi, Jeff,

Apologies for delay. Apparently, after all, the problem does not
reproduce each time (like 33% of the time, or there is some another
factor that I did not realized yet). And the build process is quite
lengthy, so I was not able to gather stats fast enough. But here they
are, below:

On Wed, Jan 5, 2011 at 08:08, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 05, 2011 at 07:46:19AM +0000, Alexander Gladysh wrote:

>> ----> Rebuilding manifest...
>> Making manifest for .
>> Generating index.html for .
>> :100644 100644 483a7292436daecc9bea0ab265ee19d587b14298
>> 0000000000000000000000000000000000000000
>> M =C2=A0 =C2=A0 cluster/localhost-ag/rocks/index.html
>> :100644 100644 fcb9ff896fd1a1bd15663fa9be19b250789d4a25
>> 0000000000000000000000000000000000000000
>> M =C2=A0 =C2=A0 cluster/localhost-ag/rocks/manifest

>> So, does that mean that HGFS violates consistency guarantees?
>
> Hmm. That could be the problem. =C2=A0It may not violate traditional
> consistency guarantees, but I wonder if it is returning slightly
> different stat information between the program runs. That would mean
> "git status" does an index refresh and puts some stat information in =
the
> index, but the followup "git diff-index" might see different stat
> information.
>
> That's just a theory, though. You might try the patch below:

<...>


----> Rebuilding manifest...
Making manifest for .
Generating index.html for .
changed (3): cluster/localhost-ag/rocks/index.html
changed (3): cluster/localhost-ag/rocks/manifest
changed (3): cluster/localhost-ag/rocks/index.html
changed (3): cluster/localhost-ag/rocks/manifest
changed (115): cluster/localhost-ag/versions/versions-current.lua
changed (115): cluster/localhost-ag/versions/versions-current.lua
changed (3): cluster/localhost-ag/rocks/index.html
changed (3): cluster/localhost-ag/rocks/manifest
:100644 100644 483a7292436daecc9bea0ab265ee19d587b14298
0000000000000000000000000000000000000000
M	cluster/localhost-ag/rocks/index.html
:100644 100644 fcb9ff896fd1a1bd15663fa9be19b250789d4a25
0000000000000000000000000000000000000000
M	cluster/localhost-ag/rocks/manifest
----> Comitting changed manifest...
changed (3): cluster/localhost-ag/rocks/index.html
changed (3): cluster/localhost-ag/rocks/index.html
changed (3): cluster/localhost-ag/rocks/manifest
changed (3): cluster/localhost-ag/rocks/manifest
changed (115): cluster/localhost-ag/versions/versions-current.lua
changed (115): cluster/localhost-ag/versions/versions-current.lua
9760438c65f7b0293459e622153f235434436ad6
changed (115): cluster/localhost-ag/versions/versions-current.lua
# On branch ag/git-debugging
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#	typechange: cluster/localhost-ag/versions/versions-current.lua
#
no changes added to commit (use "git add" and/or "git commit -a")

Hope this makes some sense,
Alexander.
