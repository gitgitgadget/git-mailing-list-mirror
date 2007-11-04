From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC PATCH] Make gitk use --early-output
Date: Sun, 4 Nov 2007 12:57:36 +0100
Message-ID: <e5bfff550711040357w77e85ecfl3f840502a8f2ec38@mail.gmail.com>
References: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
	 <e5bfff550711040237s250bcec0iddf1ebdc616e0bbf@mail.gmail.com>
	 <18221.42793.38389.359621@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioe75-0003Kw-QI
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbXKDL5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbXKDL5q
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:57:46 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:2353 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbXKDL5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 06:57:45 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1242024rvb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 03:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Izjrmi0vxwYN3DSVoNKvquo51iCnmVFh542lLMoegX8=;
        b=I8SEiWkU731g9aESGCmjhkNq/CA70nMWIyBOyeP9ErqmFiJzGvTpmI/lTWISnzsqU/0pP2xozQAKt5yelu5uSKBdcGR+SEbU8rLIMaAn+NI0doqwlcTjM/dw7H5AuCV62knT09Gc6WiB2eZ+Cc/9jqretXXPBY8h2RleI7jd574=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iSto5wvoLQpPYoXuGoyvSLTjHNFPwprHpaOzYy1XfUUs+meYovMQOnAAvifBanbXEAdO7eYo2CWLIz4YY7/YA8zLJc3+0CU5c8jWyj0YIhflIcGasG+bd+6Ru39xGPIBBOk5dalc5ihxYiQoYmBLCS3l1VM5+GHoeGaYVK9lCPQ=
Received: by 10.141.162.16 with SMTP id p16mr1831467rvo.1194177456958;
        Sun, 04 Nov 2007 03:57:36 -0800 (PST)
Received: by 10.141.203.3 with HTTP; Sun, 4 Nov 2007 03:57:36 -0800 (PST)
In-Reply-To: <18221.42793.38389.359621@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63394>

On 11/4/07, Paul Mackerras <paulus@samba.org> wrote:
>
> So yes, --early-output does imply --topo-order.
>

Thanks, I should have checked myself.

> > P.S: Why did you choose not let git log (i.e. Linus) to handle the
> > default number of commits?
> >
> > "--early-output=50" instead of just "--early-output"
>
> Because I was thinking of adding a control in the edit/preferences
> window for it later on.
>

I see. Perhaps this default number could become obsolete very quickly
if Linus implements what he has suggested in a similar thread:

"One other thing I was thinking of was also to perhaps allow multiple
partial early-output things, in case we get just 5 commits in the first
0.1 seconds, then 50 in the first second, and 200 after 2 seconds.. I can
well imagine getting the full list taking a long time over a network
filesystem (somebody mentioned samba), and maybe having just a single
trigger is too inflexible."


One thing I see playing with this new --early-output feature in qgit
is that for small /warm cache repos the list of revisions is already
the final one, i.e. the line

"Final output"

appears as the first (and useless in this case) line of the git-log
output stream.

If my proposal to teach git-log to check the final output revisions
against the already outputted one is accepted then the handling of the
above case would come free.

The proposal is that in case early-output has already streamed out 'n'
revisions, when the final ones are ready git-log checks the firsts 'n'
final output revisions and if they exactly match with the already
outputted ones then "Final output" line is skipped and final output
stream starts directly from revisions 'n+1'.

Given the statistically very low number of out of order revisions in
big repos the above could end up being the common case.

Marco
