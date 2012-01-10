From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git grep doesn't follow symbolic link
Date: Tue, 10 Jan 2012 11:00:34 +0100
Message-ID: <877h0zlvwd.fsf@thomas.inf.ethz.ch>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
	<CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Bertrand BENOIT <projettwk@users.sourceforge.net>,
	<git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 11:00:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYVW-0006nT-7y
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 11:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab2AJKAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 05:00:37 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:43013 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab2AJKAg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 05:00:36 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 11:00:33 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 11:00:34 +0100
In-Reply-To: <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 10 Jan 2012 11:26:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188243>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Bertrand,
>
> Bertrand BENOIT wrote:
>> When using git grep, symbolic links are not followed.
>> Is it a wanted behavior ?
>
> I'd imagine so: symbolic links are not portable across different file
> systems; Git's internal representation of a symbolic link is a file
> containing the path of the file to be linked to.

I'd actually welcome a fix to this general area, for an entirely
different reason.  With bash and ordinary diff I can do things like

  diff -u <(ls) <(cd elsewhere && ls) | less

But I lose all the cute features of git-diff.  I *could* say

  git diff --no-index <(ls) <(cd elsewhere && ls)

and it helpfully tells me

  diff --git 1/dev/fd/63 2/dev/fd/62
  index 55ccbe5..d796c45 120000
  --- 1/dev/fd/63
  +++ 2/dev/fd/62
  @@ -1 +1 @@
  -pipe:[607341]
  \ No newline at end of file
  +pipe:[607343]
  \ No newline at end of file

Of course that's diff and not grep, but I think they suffer from the
same flaw: they share the file-kind handling logic of the rest of git in
a case where it's not very helpful.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
