From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Feature request: Limit git-status reports to a directory
Date: Thu, 25 Oct 2007 15:03:21 +0200
Message-ID: <445E2F73-709F-4A4A-8A16-0C9FF7D67D96@wincent.com>
References: <ffofbm$lmc$1@ger.gmane.org> <46dff0320710241914t7d93aae1t991fbcaacde77046@mail.gmail.com> <Pine.LNX.4.64.0710251050390.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yin Ping <pkufranky@gmail.com>, Michel Marti <mma@objectxp.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 15:04:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il2OD-00084N-FV
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 15:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbXJYNEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2007 09:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbXJYNEd
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 09:04:33 -0400
Received: from wincent.com ([72.3.236.74]:44576 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbXJYNEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 09:04:32 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9PD4Ex3007956;
	Thu, 25 Oct 2007 08:04:15 -0500
In-Reply-To: <Pine.LNX.4.64.0710251050390.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62317>

El 25/10/2007, a las 11:55, Johannes Schindelin escribi=F3:

> Hi,
>
> On Thu, 25 Oct 2007, Yin Ping wrote:
>
>> On 10/25/07, Michel Marti <mma@objectxp.com> wrote:
>>
>> It's also painful for me. IMHO, the behaviour of "git-status" should
>> keep consistent with "git-diff" and "git-log" which allow for the =20
>> path.
>
> I am not so sure.  In other SCMs, "git status" may be a way to do "gi=
t
> diff --name-only" or "git ls-files", but not in git.  Here, it =20
> strictly
> means "what would be happening if I were to commit _right_ _now_?".

Yes, but there's no reason why the user shouldn't be able to scope =20
that down to a specific path, just as they currently can for git-diff =20
(as you point out):

> IMHO it is not asking users too much when you say "git diff ." is =20
> for the
> current directory, and "git diff" is for the whole working tree.

Sometimes if you have a dirty tree with lots of modified files and =20
potentially lots of things added to the index the output of git-=20
status can be quite long, and perhaps all you want to know about is =20
what is the status of *this* directory or *that* file rather than =20
having to visually scan through the entire git-status output. =20
Accepting path info would therefore be a nice usability improvement.

Allowing git-status to accept a path would be consistent with how =20
other git commands (like git-diff) already work, and with other SCMs =20
too. The user is expected to know that what's in the index is what =20
will be committed, and that if he/she types "git-status foo" then he/=20
she may only be seeing a subset of what's staged in the index.

But the way git-status currently behaves when supplied path info is =20
puzzling to say the least. As the man page says:

> "The command takes the same set of options as git-commit; it shows =20
> what would be committed if the same options are given to git-commit."

This means that if you do try passing a path to git-status (as surely =20
many newcomers have done), you'll see the combined result of what is =20
already staged in the index *plus* what would happen if you git-added =20
the path(s) that you passed on the command line. I'd argue that this =20
is counter-intuitive, and I think that most would expect that the =20
paths would serve as scope *limiters* rather than indicators that =20
something should be *added* to the index.

To illustrate this, an example; just say you have git-status output =20
like this:

# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   foo/bar
#       modified:   baz
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       NOTES
no changes added to commit (use "git add" and/or "git commit -a")

And you type "git-status foo":

# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   foo/bar
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   baz
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       NOTES

I understand why it works this way, and it's explained by the man =20
page, but the behaviour is the very last thing I would expect.

Cheers,
Wincent
