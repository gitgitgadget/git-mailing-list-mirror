From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCH] Warn the users when more than 3 '-C' given.
Date: Mon, 12 Apr 2010 08:48:47 +0200
Organization: Bertin Technologies
Message-ID: <20100412084847.58ce8b8b@chalon.bertin.fr>
References: <1270900308-20147-1-git-send-email-struggleyb.nku@gmail.com>
 <7vochrw285.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 08:51:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1DUK-0003Rh-Pi
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 08:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab0DLGvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 02:51:10 -0400
Received: from blois.bertin.fr ([212.234.8.70]:57971 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab0DLGvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 02:51:08 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id B8169543CB
	for <git@vger.kernel.org>; Mon, 12 Apr 2010 08:51:06 +0200 (CEST)
Received: from YPORT1 (unknown [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 95082543A5
	for <git@vger.kernel.org>; Mon, 12 Apr 2010 08:51:06 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.3.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0L0R004EW4D5VG10@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 12 Apr 2010 08:51:05 +0200 (CEST)
In-reply-to: <7vochrw285.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.12.12; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8146-6.0.0.1038-17314.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144707>

Le Sat, 10 Apr 2010 12:12:58 -0700,
Junio C Hamano <gitster@pobox.com> a =C3=A9crit :

> Bo Yang <struggleyb.nku@gmail.com> writes:
>=20
> > Output a warning message to users when there are more than
> > 3 '-C' options given. And ignore the numeric argument value
> > provided by the additional '-C' options.
>=20
> How were you bitten by the lack of this warning?  You gave four or
> five to see how output would change, spent sleepless nights but
> couldn't figure out what the differences between third and fourth
> levels are, and wasted too much time?

That sounding a bit harsh, I guess it is my turn to take the blame for
suggesting this in last week's thread :)


> IOW, what does this fix?

One practical advantage of this warning would be, in the very case of
adding meaning to an additional -C, that a user trying to use it on an
older version of git would get a warning that the program might not
indeed to what the user requested.

However, my first feeling was simply that, while it is usually harmless
to let the user specify a flag several time, when it changes nothing,
the situation is different when repetition of the flag is important -
it is closer to an invalid flag combination.

In fact, I even dislike that use of repetitive -C.  One could argue
that it is much like repetition of -v used in various programs to raise
verbosity.  But well, in our case, it is much more than just increasing
the level of details, it makes it use a different mechanism - even if
each time it is a superset of the previous one.

And what if someone comes with an idea of a "level of -C" that indeed
lays between two existing ones ?  Will we shift the meaning of the
existing ones ?  And what about one "level" that would not strictly fit
in the existing "superset" chain ?

What about instead using a more descriptive flag ?  That would be more
verbose typing, but then we can still keep the existing flags for
backward compatibility, and we also have shell command-line completion.

I'd think about something like:
-C -C     -> -Cunmodified (that one also for diff)
-C -C -C  -> -Chistory

I could also argue that "blame -M" could also be better placed as a -C
variant (it is also supposed to detect some copies), and could have as
fullname something like "blame -Csamefile".


> I personally do not see much value in this patch.  It would be just a
> hindrance to remember to remove this hunk when somebody improves the
> algorithm to add fourth level of detail to the inspection logic.

Well, the warning should trigger the 1st time that somebody tests his
fourth -C, right ?

--=20
Yann
