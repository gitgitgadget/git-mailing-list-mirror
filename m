From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/8] Sequencer Foundations
Date: Thu, 12 May 2011 10:19:34 +0200
Message-ID: <BANLkTi=zXWojMOfe9sECUu-X9euCjr4i3w@mail.gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
	<20110511131356.GI2676@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 10:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKR7X-0008MJ-Am
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 10:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab1ELITh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2011 04:19:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46113 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1ELITf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 04:19:35 -0400
Received: by yxs7 with SMTP id 7so440517yxs.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z7bMJ47I4uJ+CqjG1yzXg6KPTYa6S8rc0wsGxxWDkQk=;
        b=CnAGSw/uS1QnIC2BQHOicrvURHqNseN9/eaZpzKLTyUP/9WHsyvJG2nxMbmtyX8hER
         3V7Nkb7sqmHOzOZ+5kLdGqrDgqCwGKTZmCO+12itac2r9Q38b3EbHGYsLNXcStV5cPxD
         Zz59V4wRkIZnqxeLSbf90UWXAsCx6GutiGXo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SAlb4IPqdKHN7KIQdwPGp60paWrvw+E+I2xluQeoWenykpjuUP1ds1SKBcJmw99QJc
         +Y0dJe9ovxxYBJiYtHoiZs2eYWbDCDSdbOJZya34hb1dygMvIUb057+kxy+tMaxFgTlr
         ZKSiYrkZVMsmiNSgc3Exq+OOsRUMdDWZwc5Pw=
Received: by 10.236.105.140 with SMTP id k12mr11113520yhg.169.1305188374654;
 Thu, 12 May 2011 01:19:34 -0700 (PDT)
Received: by 10.147.167.5 with HTTP; Thu, 12 May 2011 01:19:34 -0700 (PDT)
In-Reply-To: <20110511131356.GI2676@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173448>

Hi,

On Wed, May 11, 2011 at 3:14 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Ramkumar Ramachandra wrote:
>
>> Ramkumar Ramachandra (8):
>> =A0 revert: Improve error handling by cascading errors upwards
>> =A0 revert: Make "commit" and "me" local variables
>> =A0 revert: Introduce a struct to parse command-line options into
>> =A0 revert: Separate cmdline argument handling from the functional c=
ode
>> =A0 revert: Catch incompatible command-line options early
>> =A0 revert: Introduce head, todo, done files to persist state
>> =A0 revert: Implement parsing --continue, --abort and --skip
>> =A0 revert: Implement --abort processing

I had no time to look at this yet but I will try do to so in the coming=
 days.

> The heart is patch 6/8. =A0I have not thought about this deeply yet, =
but
> I wonder if it would be simpler if the behavior of "git cherry-pick
> 1..10" looked like this:
>
> . if there is state in .git/sequencer already, error out
> . lock .git/sequencer/head with the lockfile API to prevent
> =A0concurrent access
> . write current state, including remaining commits to cherry-pick
> . unlock .git/sequencer/head
> . cherry-pick commit #1
> . lock sequencer, check state, update state, unlock
> . cherry-pick commit #2
> =A0...
>
> This way, even if cherry-picking causes git to segfault, the sequence=
r
> state is in good order and we know where to pick up. =A0More
> importantly, massive refactoring of the merge_recursive API would not
> be needed to keep everything in working order. =A0An atexit and sigch=
ain
> handler could be added to print advice for the reader about how to
> resume, but that's just an extra hint and it's okay if it sometimes
> doesn't happen sometimes.
>
> What do you think?

I think that the risk at this point might be to overengineer things
and to lose time, and then we will perhaps find out that we need to do
some refactoring of the merge_recursive API anyway.
If we have cherry-pick with --abort, --continue and --skip that just
works as well or nearly as well (because it's new) as other stuff it
will be already a very good thing. And with enough tests we will
hopefully be able to build and refactor safely after that. Maybe we
will eventually find out that what you suggest is in fact needed even
for cherry-pick with --abort, --continue and --skip, but for now I
would prefer trying to make it work with as few changes and work as
possible.

Thanks,
Christian.
