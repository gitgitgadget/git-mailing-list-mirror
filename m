From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long
 format
Date: Tue, 26 Feb 2008 01:19:35 -0800
Message-ID: <7vy7986pnc.fsf@gitster.siamese.dyndns.org>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
 <20080225023634.GK8410@spearce.org>
 <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
 <8aa486160802250034ncdf20b6s13856ca8612bc2ea@mail.gmail.com>
 <7vbq65ju0y.fsf@gitster.siamese.dyndns.org>
 <8aa486160802250105p4f98cb6eu1d6ac4fa700f11fe@mail.gmail.com>
 <7vwsoshk3s.fsf@gitster.siamese.dyndns.org>
 <8aa486160802251251u74a19b93l77ca3930d2387cb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 10:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTvzZ-0002v3-T8
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 10:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbYBZJTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2008 04:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758204AbYBZJTy
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 04:19:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758150AbYBZJTw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2008 04:19:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 18C4821AB;
	Tue, 26 Feb 2008 04:19:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8EC0A21AA; Tue, 26 Feb 2008 04:19:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75112>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

>>  Why can't you solve it?  Your example of two people giving the
>>  same name to different things shows a lack of communication
>>  between developers, and as long as you and the other guy are
>>  talking with each other the problem can be solved, can't it?
>
> But there are times when you can't/don't want to communicate
> (private/testing/forks, whatever).
>
> Anyway, even if this problem is solved I feel more confortable
> with a version in my binary (and output) with a descriptive
> name and a revision id.

As I think about it more, I think that such a lack of communication is
not something "git describe" should even claim to help working around.

But a uniform-looking describe output does have certain
attractiveness:

	$ git describe --long 31e0b2c 6c0f869
        v1.5.4.3-0-g31e0b2c
        v1.5.4.3-1-g6c0f869

So I have quite a big problem with your commit log message, even
though I am starting to like what it does.  Perhaps this would be more
to the point.

    git-describe: --long shows the object name even for a tagged commit
   =20
    This is useful when you want to see parts of the commit object name
    in "describe" output, even when the commit in question happens to b=
e
    a tagged version.  Instead of just emitting the tag name, it will
    describe such a commit as v1.2-0-deadbeef (0th commit since tag v1.=
2
    that points at object deadbeef....).

By the way, I do not think "long" is what it does.  It does not even
show the full object name unless you tell it to with another option
(i.e. --abbrev).  The flag tells the command to use the normal output
format that is used to describe most other commits (untagged ones),
and signal the "taggedness" with the count part being "-0-".

Perhaps --nonexact-format, or even --redundant-output?

Hmmmmm...  "--always-count", as it is about always using the counted
format (which is the "normal" output format)?

I know, I am bad at naming, so I'll park the commit in 'pu',
with option name kept as "--long" as in your patch.
