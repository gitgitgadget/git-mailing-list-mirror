From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH v2] revert: Implement --abort processing
Date: Sun, 12 Jun 2011 17:39:05 +0530
Message-ID: <BANLkTi=T0wCg1bKzmtQEQ-J-5ogqRZaqRg@mail.gmail.com>
References: <1307774186-14207-1-git-send-email-artagnon@gmail.com> <20110611112213.GA25268@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 14:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVjTw-0002GO-Av
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 14:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab1FLMJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2011 08:09:27 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39441 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1FLMJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2011 08:09:26 -0400
Received: by wwa36 with SMTP id 36so4050522wwa.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=OzFDQteTosDslXZhKgna5sn2Dh84KMz8yioqmRPsLAU=;
        b=tyjhRiEELivN8cQh8UPetw3iei57Illbw2euW+LtjWW2SQeZnCap3S2mtpbh5oVuOB
         tZOWszTDeg0UVbNXBCXv4F6mh8ONI2B/Yy+lnuoroI9zIK6GKgR+ruhrk5HZ9BamY1Ix
         Zu67qcF9BMdF27B3lyYm9hETWb06rNgYeKf4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GC1oHz3wgpB98b4bKKtysS6xMF2hOU21SgS8lODllbWLyYqQECQ5Xy+rK9gcSRSXlp
         znuL8yhNzjM9ztgJizHfOtsPgwJ/VcXCYjl7wrwvNSpKdzLXy3QkmZYrZbX5pCgAgtPg
         ggQNmzr7//5m0OsZ3SkXZluMRn4734/MKWwAQ=
Received: by 10.216.232.13 with SMTP id m13mr1490223weq.110.1307880565127;
 Sun, 12 Jun 2011 05:09:25 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Sun, 12 Jun 2011 05:09:05 -0700 (PDT)
In-Reply-To: <20110611112213.GA25268@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175655>

Hi Jonathan,

Jonathan Nieder writes:
> The documentation could say:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0To wipe out everything and get back to whe=
re you started, use:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --ha=
rd PRE_CHERRY_PICK_HEAD

My notion of --abort has changed: I simply want to remove the state
files for the cherry-pick so that the user can execute more
cherry-pick/ revert commands.  I didn't think a soft reset would be
intrusive.  Hm, you're suggesting using a ref -- I was wondering what
to do with CHERY_PICK_HEAD.  I'm not entirely convinced, but I'll wait
for the others to comment and think about this for some time.

> What if instead of --abort something else were simpler to think about=
?
> As a random example, I can imagine a "git sequencer --edit" command
> that would present the sequence in an editor and let me revise the
> plan --- would that do the trick?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A01
> =C2=A0 =C2=A0 =C2=A0 =C2=A02
> =C2=A0 =C2=A0 =C2=A0 =C2=A03
> =C2=A0 =C2=A0 =C2=A0 =C2=A04
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* YOU ARE HERE
> =C2=A0 =C2=A0 =C2=A0 =C2=A05
> =C2=A0 =C2=A0 =C2=A0 =C2=A06
> =C2=A0 =C2=A0 =C2=A0 =C2=A07
> =C2=A0 =C2=A0 =C2=A0 =C2=A08
>
> =C2=A0- Remove lines 5-8: removes sequencer state, leaves HEAD as is
> =C2=A0- Remove everything: rewinds to abort sequence
> =C2=A0- Add a line 2.5 between 2 and 3: rewind to 2, cherry-pick 2.5,
> =C2=A0 continue.

Interesting perspective.  I essentially have to keep two TODO files
and run a diff until I find the first different line.  Then, I have to
reset to that SHA-1 and replay the rest of the user-edited TODO.  Can
be complicated to get right, but it seems like quite an elegant
interactive solution.  It takes care of all three: --abort and --skip.
 We'd still need a --continue to non-interactively continue after a
conflict resolution though, no?

> Which is to say: if you have a story about what --abort will be used
> for, the life of others evaluating the thing becomes better and the
> upsides and downsides can be seen in perspective. =C2=A0A story like =
"am
> and rebase have --abort, so cherry-pick should have one, too" is
> harder to think about.

I agree.  There's little point in being stuck with historical
conventions -- we should try something new and see how it works out :)

Thanks.

-- Ram
