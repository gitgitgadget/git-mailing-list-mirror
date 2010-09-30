From: Nate Parsons <parsons.nate@gmail.com>
Subject: Re: git .lock file error
Date: Thu, 30 Sep 2010 17:10:52 -0400
Message-ID: <AANLkTinFJ5rSA7Om0ZxhuqzQiqEDvJ+JoEQFpz=NDvxE@mail.gmail.com>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
 <AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
 <AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
 <AANLkTik364t7WEHOsZcB7FE4Y2gJQNxkXsRvW5guUWCi@mail.gmail.com> <7vbp7fhtt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 23:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1QPU-0004z1-FP
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 23:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab0I3VLP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 17:11:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39543 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab0I3VLO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 17:11:14 -0400
Received: by iwn5 with SMTP id 5so2900773iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g0Gs8eE2f8hdpsCgElItW4grTx5t3MqIJTfCTB1NvQs=;
        b=CxCjSei7muNsPP3YDQU0DUFEa50PAeFJuDyiZB0uAP/wc/dt89kTWuJndP4KIjpTdi
         cSKpB3ldM68MKKnDe7Mrt4CFbPVFnJn0nMFk2HpfLHLmL8JZY8ajyQ6mR4gn1/dAMQ4I
         7v/J5xH9mnJXwEDydAKvoehPDmZL5R5i3fMc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MwJ5oT+B48Va537hz6yp4WqPl2VNi6jIc3RH+zPjaud/pgLLeC/ZkyVzK0IkVU3Rwn
         zOkyjAbZA0jEOpXgVd/BpO/YW81+M7QVwiWQS8XKMm39H0nCtdNN+aALIVb9xmHdi8Fm
         jKD7R8lUGKNlCC4va3BbnnH6Zt4EF+A0L37kg=
Received: by 10.231.191.136 with SMTP id dm8mr4438972ibb.75.1285881073250;
 Thu, 30 Sep 2010 14:11:13 -0700 (PDT)
Received: by 10.231.155.210 with HTTP; Thu, 30 Sep 2010 14:10:52 -0700 (PDT)
In-Reply-To: <7vbp7fhtt0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157713>

On Thu, Sep 30, 2010 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
> > FWIW I think this is more readable, but maybe we want to retry on a=
ll
> > platforms:
> >
> > =A0 =A0 my $fh;
> > =A0 =A0 if ($^O eq 'MSWin32' or $^O eq 'cygwin') {
> > =A0 =A0 =A0 =A0 # Try 10 times to open our lock file, in case Windo=
ws is lagging
> > =A0 =A0 =A0 =A0 for my $try (1..10) {
> > =A0 =A0 =A0 =A0 =A0 =A0 sysopen($fh, $db_lock, O_RDWR | O_CREAT);
> > =A0 =A0 =A0 =A0 =A0 =A0 last if $fh;
> > =A0 =A0 =A0 =A0 }
> > =A0 =A0 } else {
> > =A0 =A0 =A0 =A0 sysopen($fh, $db_lock, O_RDWR | O_CREAT);
> > =A0 =A0 }
> >
> >     warn "Couldnt open $db_lock: $!\n" unless $fh;'

I agree that this is more readable, although I don't think there needs
to be separate code sections for each OS. If it's a good OS, it will
only loop once. You would want to die or croak instead of warn,
though. It needs the lock to continue, right?

> What exactly does "Windows is lagging" mean in the above?
>
> Why does sysopen() randomly fail and why does it succeed (sometimes) =
when
> it immediately gets retried with the same argument? =A0Is this a shar=
ed lock
> and is used by some other processes that drive git? =A0Why does the i=
ssue
> manifest only on Windows? =A0If there are competing processes, wouldn=
't it
> exacerbate the situation to run a tight loop to try grabbing the lock
> without waiting, like the above patch does?

All very good questions, and I don't know most of the answers. I know
that sysopen() is just a thin wrapper around the 'open' system call,
so the problem has to be with Windows somehow. It probably doesn't
happen with other OSes because they're better at files :P

I have verified (to the best of my ability) that this problem happens
even when TortoiseGit is not running, and I don't have cheetah
installed, and there are no other 'git.exe's running. I considered
putting some sort of sleep() in there, but since it worked so well
without the sleep (it only retried once at most). Fetching multiple
revisions is slow anyways, so I don't think a 2-second wait would
hurt, though.

-Nate
