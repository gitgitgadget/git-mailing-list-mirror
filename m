From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Sat, 22 Dec 2007 00:39:07 -0800
Message-ID: <7vhcibyvh0.fsf@gitster.siamese.dyndns.org>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	<20071219184457.GC3015@steel.home>
	<57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
	<4769A7FB.1070904@lsrfire.ath.cx>
	<57518fd10712200244o656c7f44j426cc71c89515de3@mail.gmail.com>
	<476A5DFF.40803@lsrfire.ath.cx>
	<57518fd10712200508x4b15f9acy10aed83a3cebeba@mail.gmail.com>
	<57518fd10712210247s2fcbbf61ke67bbdc0f5ffe70b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 09:39:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5ztU-0001ro-Er
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 09:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbXLVIjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 03:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbXLVIjR
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 03:39:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbXLVIjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 03:39:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D662764D1;
	Sat, 22 Dec 2007 03:39:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 260D964CD;
	Sat, 22 Dec 2007 03:39:09 -0500 (EST)
In-Reply-To: <57518fd10712210247s2fcbbf61ke67bbdc0f5ffe70b@mail.gmail.com>
	(Jonathan del Strother's message of "Fri, 21 Dec 2007 10:47:45 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69126>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> Has anyone actually managed to reproduce my problem?  I've got
> multiple repos here that show the problem in several commits, made by
> different people.  However, I can't actually come up with a way to
> reproduce it at will...

Marking an issue as a "serious bug" without giving enough
material for reproduction nor diagnosis tends to discourage
people from looking into it seriously, as the issue cannot be
even judged if it is really serious.  For example:

  On Dec 19, 2007 6:44 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
  > Could you try
  >
  >     git cat-file 18d2480ab689b483ef1ebbdb3f7420904049ba0b
  >
  > (or any other problematic commit) and post its output here?

  You mean git cat-file commit ... ?
  I get the normal output, but the problematic commits don't show a
  newline character at the end of the cat-file output.

"I get the normal output" is not what Alex asked you to supply,
nor would be sufficient information.  There may be some
abnormality in the commit object that you probably did not spot,
but Alex or other people may have been able to if you were
actually posted its output here.

I have been suspecting that there is a NUL in the middle of the
message somehow (I know the lowest-level plumbing commit-tree
allows any byte sequence in the log message if you worked hard
enough), which the parser is not prepared to cope with, but we
haven't seen enough evidence to support nor refute that theory.
We do not have much to work from.

One thing I noticed funny in your original message was "-1-".
Is it essential that the number is spelled incorrectly to
reproduce this problem?

  $ git rev-list -1- --pretty=format:"%s%n%b"
  18d2480ab689b483ef1ebbdb3f7420904049ba0b
  commit 18d2480ab689b483ef1ebbdb3f7420904049ba0b
  Try to flush log files before terminating the app
  tree 57bc7cf30a10aee96251852125cf30fd2c81d7aa
  parent 04c833865828538315fcdf6e187da077869ce444
  author Jonathan del Strother <jon.delStrother@bestbefore.tv> 1197901755 +0000
  committer Jonathan del Strother <jon.delStrother@bestbefore.tv> 1197901755 +0000

  Check that ThreadWorker's work method actually returns a value with
  method signatures
