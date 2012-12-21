From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Fwd: [RFC/FR] Should "git checkout (-B|-b) branch
 master...branch" work?
Date: Fri, 21 Dec 2012 13:31:00 -0800
Message-ID: <CANiSa6hcDHTpZnAXR3zxdv-H4r-yRjuSx_kgE5V1rSFk_pNhOA@mail.gmail.com>
References: <7v8v8r2y8s.fsf@alter.siamese.dyndns.org>
	<CANiSa6jP_JN+DpDgYpWA9Aky9REJvFq3aR3Yj0vF3+axWvtmsw@mail.gmail.com>
	<CANiSa6ibS7ORY=QMS3WQzXYJQQH4ZYvPO75qgLgv-oWGMSBBrw@mail.gmail.com>
	<7vr4mj1g8j.fsf@alter.siamese.dyndns.org>
	<50D4BBDC.6030700@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmABd-0006Xm-SL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 22:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab2LUVbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 16:31:04 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:57583 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2LUVbB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 16:31:01 -0500
Received: by mail-ie0-f180.google.com with SMTP id c10so6810323ieb.25
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 13:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xbuk6NnJzuMrE59QYOXfoeobaAxvLovpffa8XDVG5r4=;
        b=r9oBu6U3ctByeWSFXp3j90U82fDrdRzBKyQhAif3iiQyvjGlkThU0v9fjdqN7whkvc
         NOeIBtLdHAKamt8ZaUV+NpkfWo6eTKGAD/tW5b0Y0DejAO2gwun9x9gWEXvVdTPrUQWO
         atYVBzunNaxRDCD5nejUyOp2Lc6Jm2Swi7L0eGKvWaYrtmN6YrYdLGgateP84D8SUJxN
         NDjfGRDZobRAKFdy91Zh78pzNv2xw+7HOQMzdwCQDsSAUyN4CRMVfhvw3gTfYYPVIFJX
         /Ujm+5jbSX28AnkU+MtZ+ZVMUZPZp9KcGp3O+19Hr2qr774W5lHxmknAkv6HBUQDPNkt
         5ueg==
Received: by 10.50.42.169 with SMTP id p9mr14474623igl.17.1356125460347; Fri,
 21 Dec 2012 13:31:00 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Fri, 21 Dec 2012 13:31:00 -0800 (PST)
In-Reply-To: <50D4BBDC.6030700@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212010>

On Fri, Dec 21, 2012 at 11:43 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/21/2012 06:12 PM, Junio C Hamano wrote:
>> "diff" is always about two endpoints, not the path that connects
>> these two endpoints (aka "range"), and when you want to "diff"
>> between two commits, you say "diff A B".  "A..B" happens to be
>> accepted as such only by accident (e.g. the old command line parser
>> did not have a reliable way to tell "^A B" and "A..B" apart), not by
>> design.

Off topic: I also find it hard to wrap my head around what diffing
against a negative revision would mean. Looking at the result of
running it, it seems to be the same as diffing against a positive one.

>>
>>     side note: incidentally, now we have rev_cmdline_info support,
>>     we could start deprecating "diff A..B" syntax.
>
> I often find myself using "git diff A..B" syntax when using the command
> line history because the previous command used "A..B"; e.g.,
>
>     git log A..B
>     git diff A..B

The problem with this, to me, if it wasn't clear, is that "git log
A..B" shows you is new _since B branched off from A_, while "git diff
A..B" shows you what has changed _between A and B_.

>> Actually, in many places where the command line parser knows it
>> wants a single point, and never a range, we should be able to apply
>> the "A...B as a notation to specify a single point" rule.
>>
>> Of course you could come up with a symbol other than "..." for that
>> purpose, and migrate the current "git checkout A...B" special case
>> to use that other symbol, but that would be more work and also you
>> would need to retrain existing users.
>
> OTOH making A...B sometimes mean a range and sometimes a merge-base
> (depending on context) adds a confusing non-uniformity, and also has the
> disadvantage of making merge-base shorthand unavailable in contexts that
> allow a range.

And making it unavailable in contexts where the command was not
specifically implemented to support it. I'm sure there are many
scripts out there that use "git ... $(git merge-base A B) ..." that
could be simplified if rev-parse could resolve a merge base.

> OTOOH git already has so many notations that can be used on the command
> line; inventing yet another one would make it that much more overwhelming.

Agreed.
