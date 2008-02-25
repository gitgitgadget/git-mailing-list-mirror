From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long
 format
Date: Mon, 25 Feb 2008 12:11:35 -0800
Message-ID: <7vwsoshk3s.fsf@gitster.siamese.dyndns.org>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
 <20080225023634.GK8410@spearce.org>
 <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
 <8aa486160802250034ncdf20b6s13856ca8612bc2ea@mail.gmail.com>
 <7vbq65ju0y.fsf@gitster.siamese.dyndns.org>
 <8aa486160802250105p4f98cb6eu1d6ac4fa700f11fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:12:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjgh-0004Bo-9G
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566AbYBYULy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 15:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756451AbYBYULy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:11:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbYBYULx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 15:11:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3F2C216E;
	Mon, 25 Feb 2008 15:11:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BB34D2168; Mon, 25 Feb 2008 15:11:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75061>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

>>  That's backwards.  If you want reliable unique identifier, you
>>  would use 40-hexdigit.  If you want human readable, you would
>>  use tags, and if you allow different people to distribute tags
>>  with the same name that point at different things, _you_ have a
>>  problem at higher level.
>
> Yes, I have a "problem" at a higher level, but I cannot "solve" it.
> This patch "workaround" this "problem", we want all to be able to tag
> and have descriptive and uniqe names. I think git should allows us to
> work this way.

Why can't you solve it?  Your example of two people giving the
same name to different things shows a lack of communication
between developers, and as long as you and the other guy are
talking with each other the problem can be solved, can't it?

SCM or any other tools may facilitate developer communication,
but it is not a replacement for communication.

Inside a local repository, git already allows you to:

 * prevent such a problem by not overwriting an existing tag
   unless you ask with -f; and

 * verify that the object a tag refers to is really the object
   you expect the tag to point at with "cat-file tag".

"git describe" output can be unique only within a local
repository, as it cannot read your mind and inspect random
repositories other people own.  In one repository, abbreviating
an object name to 4 hexdigits may be enough to make it unique,
but in another it may need 6 hexdigits.

If you are trying to guarantee uniqueness of something that
lives for a long time (e.g. release version number that is
embedded inside binaries, which is what you use "git describe"
to generate), _and_ if you worry about two people in different
repositories giving the same name to different things which
would introduce a bogosity to that long-lived name, you would
need a way that is external to the uniqueness guarantee "git
describe" can give.

I do not mind low-impact new options and new features like this.
Everybody loves bells and whistles.  But I do want valid use
cases attached to them so that (1) we can justify their
existence; and (2) we can document them to explain what purpose
they serve, to help people to decide when to use them.

I even suspect that the --long flag might be useful in some
situation, but I do not think "a tag with the same name" is one
of the problems this patch lets you solve or work around.

Jakub's "it looks more uniform and does not treat a tagged
version any specially" may probably be a better argument for
this new feature.  I dunno.
