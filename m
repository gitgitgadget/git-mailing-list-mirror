From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: A little mystery - crash caused by empty commit message.
Date: Tue, 10 Feb 2009 13:58:43 +0100
Message-ID: <1a6be5fa0902100458w246f2bfeu5c0c303d18d17a3b@mail.gmail.com>
References: <1a6be5fa0902100315q554dc457j8c8476d3f59a314f@mail.gmail.com>
	 <20090210113234.GE12089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsE6-00035h-AC
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbZBJM6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZBJM6q
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:58:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:41749 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbZBJM6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:58:45 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1306516fgg.17
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O6bZhXQC3e1B6rxIciaRtWPDHLRhGfNvrcI7crDAGa8=;
        b=A1isBmi1Fp6Sv1gwFFQvpnJdKkD/Yo6y20/7DzCccw/T1rsFy+FZbIDuMVYBP5GSP1
         WsBCELBHgODce0scVBRA6sRv5oskJkOmcHTfruC1SAgBN2ESC23nfnTDKpzzzfQDr0+7
         VIvr7DYMDkNojcEkMKENXL8ZLhdy0XsMPKGaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oqw++QOrsAi0oEkIgWEwW3wj0NVg51x24V8UvbBI0F/SNgLGiL6PRc5te/u3JG5PT1
         bhYF7KmcL04l9FzV9wgEbGTCC5oZ3O2hOQZKehGFkC4/b4Ljyj8rV6e1S81ufKOkRiam
         qGB8hyptIyMDqc1h6yeMwF40I9R4wfma7ZPzA=
Received: by 10.103.222.1 with SMTP id z1mr1230549muq.100.1234270723287; Tue, 
	10 Feb 2009 04:58:43 -0800 (PST)
In-Reply-To: <20090210113234.GE12089@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109230>

On Tue, Feb 10, 2009 at 12:32 PM, Jeff King <peff@peff.net> wrote:
> Are you sure it's truly an _empty_ commit message? Can you try
>
>  git cat-file commit f67f77edf06bbcebabf430735c751245a4b70f14
>
> and look at the result with xxd, hd, or similar.

Cool. You are correct. It is not empty after all. I ran git cat-file
on that commit, and on the "same" commit on the branch where I did not
see the problem. The correct one looks like:

<start>
tree c5d2063a9b21de1f84240e4b9c0e40a44f0357b6
parent 6d109492008c68d28af821b96b82f807f338caf6
author Tor Arvid Lund <toral@qsystems.no> 1233852429 +0100
committer Tor Arvid Lund <toral@qsystems.no> 1233852429 +0100

[HIA] Log exception when serializing fails.

[git-p4: depot-paths = "//Heads/Dev/MarkII/Main/": change = 19233]
<stop>

So - after the "+0100" on the committer line, hd tells me (as
expected) that I have 0a 0a before "[HIA]". On the "faulty" commit I,
for some reason, have 0a 00 instead. I do not understand why, but I
guess strchr will return NULL when "\0[HIA]....." is passed to it, and
segfault on the next iteration.

So - I am no closer to understanding what got me to this state, but
your reply was helpful anyway, thanks :-)

-Tor Arvid-
