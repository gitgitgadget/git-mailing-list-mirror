From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Sun, 30 Dec 2007 04:21:25 -0800
Message-ID: <7v8x3c8jay.fsf@gitster.siamese.dyndns.org>
References: <7vprwo8kzd.fsf@gitster.siamese.dyndns.org>
	<200712301158.lBUBwT3r004608@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 13:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8xBB-00083a-93
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 13:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbXL3MVm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Dec 2007 07:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbXL3MVm
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 07:21:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXL3MVl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2007 07:21:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B6BDB646F;
	Sun, 30 Dec 2007 07:21:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B5AD646E;
	Sun, 30 Dec 2007 07:21:32 -0500 (EST)
In-Reply-To: <200712301158.lBUBwT3r004608@mi1.bluebottle.com>
	(nanako3@bluebottle.com's message of "Sun, 30 Dec 2007 20:57:49
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69357>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

>> Heh, I can see that you do not care---the original did not even
>> add a newline when necessary (and that is why we have this
>> thread).  Instead you were adding a newline regardless to the
>> end of the first commit, but not doing so for the other ones.
>
> Aren't you being too harsh on Johannes these days?

Not on purpose, but perhaps I might have been.

> Everybody knows that you are capable of rewriting that part in Perl o=
r Python yourself to fix the issue.

I actually have been trying to avoid Perl (let alone Python nor
Ruby) as "rebase -i" is primarily Johannes's bailiwick, and I
had an impression that he avoided them for Windows portability.

Unfortunately, sed does not handle incomplete lines well, at
least portably.  POSIX says very little about it, except that
its input shall be "text files" (i.e. no NUL is allowed, each
line separated with <newline> and with less than {LINE_MAX}
bytes in length), and its default operation shall read each line
less its terminating <newline> and after manipulation spit it
out and immediately follow it with a <newline>.  But a popular
implementation (e.g. GNU) actually does not follow the output
with a <newline> if the input was incomplete line [*1*]

[Footnote]

*1* Otherwise, this would have been a way to add a
missing newline to a file that could end with an incomplete
line:

    $ sed -e '' <$file_that_may_end_with_an_incomplete_line
