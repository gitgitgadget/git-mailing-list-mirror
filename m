From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rerere: Usage question
Date: Fri, 23 May 2008 17:02:11 -0700
Message-ID: <7vwslkpo1o.fsf@gitster.siamese.dyndns.org>
References: <4836D46A.7070807@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat May 24 02:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhEM-0001MO-4u
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760108AbYEXACY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2008 20:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759740AbYEXACY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:02:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759467AbYEXACX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 20:02:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D4D13698;
	Fri, 23 May 2008 20:02:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 849513697; Fri, 23 May 2008 20:02:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF075996-2924-11DD-80CB-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82780>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> I recently read the docs for 'git-rerere'. Seems a cool feature.
> But I'm not quite sure whether I understood it right. I think
> I understood what it does but I didn't understand when to call
> it.
>
> Is it true that it's not neccessary to issue that command manually
> when I configured "rerere.enabled true"? The docs say that I *can*
> call it but it also says that git-merge and git-rebase call it
> automatically whenever needed.
>
> Thus it seems to be one of the plumbing tools to me, which
> I only call in case of emergency. Am I right?

It started as an independent, opt-in feature, that people _could_ use
manually.  In that mode:

 (1) when you see "git merge" stop at a conflict, you say "git rerere",
     expecting one of two benefits:

     (1-a) If the conflict is something you have used rerere on
     previously, this may apply the previous resolution.

     (1-b) Otherwise, the conflict is recorded, so that you can record =
the
     corresponding resolution after manually resolving it.

 (2) after having to manually resolve the conflict, if you did "git
     rerere" in step (1), you can say "git rerere" again to record it.

These days, rerere is pretty much automatic in that rerere is called
automatically from places that generate conflicts (e.g. "git merge") fo=
r
purpose of (1), and from places that the user tells git that the confli=
cts
are now resolved (e.g. "git commit") for purpose of (2).

So it is not even for "emergency" anymore.

The only time you still might want to call it yourself is when you are =
not
comfortable with the conflict resolution you just did (iow, if it later
turns out to be a bad resolution, you may regret recording that incorre=
ct
resolution).  In such a case, you would say "git rerere clear" before
committing the result (in which time, "rerere" automatically try to rec=
ord
but because of earlier "rerere clear" it does not find anything to
record).
