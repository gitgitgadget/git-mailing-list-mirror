From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/17] sequencer: Announce sequencer state location
Date: Sun, 17 Jul 2011 21:53:26 +0530
Message-ID: <CALkWK0k1pX6rjGh8U6ZdDFk3qFcbj-UjU-Q-Z76hn6HV46pncg@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-11-git-send-email-artagnon@gmail.com> <20110712185638.GA14909@elie>
 <CAGdFq_ijTh-m7+zRFAyqvhN5k_BrC1TPdc3y47h=tBUiz6QF2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 18:23:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiU8H-0004Hp-87
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 18:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab1GQQXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 12:23:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36211 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab1GQQXr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 12:23:47 -0400
Received: by wyg8 with SMTP id 8so1652758wyg.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QLFWuwMsDecpeCSBl8jwleYrNtIqv5I5P8SrrJLP1Ac=;
        b=JT41MUI7xJ/uXb+9s7T3cc/SYgJ4i1WdX+gGazzodIK092Fk2EZTwTcVcm6wofAo0X
         1I0Ic49wilL5sst5kFRBTrKCVHCbfPlMq5ws8FD+nqgizWb2DOyxd2l/rm9Z9rj3bLRP
         vlatTi+NMlCf4qcapTuo6gK2exY04x/NQKL+I=
Received: by 10.216.155.134 with SMTP id j6mr4943553wek.81.1310919826327; Sun,
 17 Jul 2011 09:23:46 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Sun, 17 Jul 2011 09:23:26 -0700 (PDT)
In-Reply-To: <CAGdFq_ijTh-m7+zRFAyqvhN5k_BrC1TPdc3y47h=tBUiz6QF2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177303>

Hi Jonathan and Sverre,

Jonathan Nieder writes:
> Wait, so what is the actual impact of this patch?
>
> As far as I can tell, it is to introduce a remove_sequencer_state()
> function whose eventual purpose would be to remove the .git/sequencer
> directory used by "git cherry-pick" to record its progress. =C2=A0Par=
aphrased,
> the function does this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -fr "$GIT_DIR/sequencer-old"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mv "$GIT_DIR/sequencer" "$GIT_DIR/sequence=
r-old"
>
> This way, a person has one level of "undo" possible, assuming git
> commands and scripts use the function carefully enough not to call it
> twice.
>
> Is the "undo" feature advertised anywhere? =C2=A0Should this function=
 write
> a message to stderr to inform the operator about how to get back the
> precious cherry-pick state?

I don't think we should advertise it on stdout or stderr.  I think of
a safeguard that only very few people will use.  Ofcourse, documenting
it somewhere like Documentation/technical will make sense once we have
something usable.

> If I were doing it, I'd squash this with the patch that introduces
> "git cherry-pick --quit", to give an example of how the new function =
is
> meant to be used (and tests!).

I would have done that too, except that the "reset: Make hard reset
remove the sequencer state" patch depends on this.  So, I don't think
it's fair to squash it into either patch.
I can definitely write a better commit message though (wait for the
next iteration to see it).

Sverre Rabbelier writes:
> I think we can learn from hg here and just use a datetime stamp. So
> instead of moving to sequencer-old move to sequencer-20110713-141022
> or such. That way there's as many undo as you need.

That's a great example in general, but I'm wondering if it would
really be useful for this particular usecase.  Are sequencer states so
valuable that we want to allow so many levels of undo?

-- Ram
