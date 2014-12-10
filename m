From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: filter-branch performance
Date: Wed, 10 Dec 2014 23:44:58 +0000
Message-ID: <CAFY1eda-utVReuQnotSUDPV4-=hiMupbNdLZrYnEiaDryXQboQ@mail.gmail.com>
References: <548744F1.9000902@gmx.de>
	<20141209185933.GC31158@peff.net>
	<CAFY1edYYC9TZmLE6b3=QAoTB1zQHi_Y97rHL-5wk5Pbpa_oj_w@mail.gmail.com>
	<xmqqfvcnjxry.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Henning Moll <newsScott@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:45:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyqwM-0006x4-5u
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758314AbaLJXpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:45:00 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:57457 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758097AbaLJXo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 18:44:59 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so8620357igi.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 15:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wljZYp0/u/rg9DN3w7pEouI2ylWYYXkgwvkrVIfgC8E=;
        b=OF7R7flu8tmRs4jwW/kC7B10cdd+lLWANLldWtXwrEHA38rYoCo6QCubzH4O8Rwkii
         V0voz+2VHzzz2nhYNBGBbdmZV3cavSXc5/xhoety1fIcLm6/R9Po8WgB2WTdW0iFHhcm
         cpKLpdvqk1TZyVtJ4YzLLZyMoUwHjOUNYSYynKfyhd6abj6EXmOskYF2YvflbRSN8yuj
         xhIsDdsGUpVYcWLkPc0ZnMzZtFo0jjvaf3mN2HBD8hqXHn7PRw9O/fo0YE0vMDT3GzSd
         XQ8aC/FSqzjaf7grdy890ahs5XBg2Or+JzH6DV9xTkiQCsJTioSuhYSQRDr2F29Age5h
         DETQ==
X-Received: by 10.107.138.131 with SMTP id c3mr7107222ioj.0.1418255098572;
 Wed, 10 Dec 2014 15:44:58 -0800 (PST)
Received: by 10.64.240.171 with HTTP; Wed, 10 Dec 2014 15:44:58 -0800 (PST)
In-Reply-To: <xmqqfvcnjxry.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261259>

On 10 December 2014 at 16:05, Junio C Hamano <gitster@pobox.com> wrote:
> Roberto Tyley <roberto.tyley@gmail.com> writes:
>
>> The BFG is generally faster than filter-branch for 3 reasons:
>>
>> 1. No forking - everything stays in the JVM process
>> 2. Embarrassingly parallel algorithm makes good use of multi-core machines
>> 3. Memoization means no Git object (file or folder) is cleaned more than once
>>
>> In the case of your problem, only the first factor will be noticeably
>> helpful. Unfortunately commits do need to be cleaned sequentially, as
>> their hashes depend on the hashes of their parents, and filter-branch
>> doesn't clean /commits/ more than once, the way it does with files or
>> folders - so the last 2 reasons in the list won't be significant.
>
> Just this part.  If your history is bushy, you should be able to
> rewrite histories of merged branches in parallel up to the point
> they are merged---rewriting of the merge commit of course has to
> wait until all the branches have been rewritten, though.

That's true, and the bfg does take advantage of that parallelism, so
as well as point 1, point 2 will provide some benefit if history is
bushy enough :)
