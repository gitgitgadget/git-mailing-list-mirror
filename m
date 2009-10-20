From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] blame: make sure that the last line ends in an LF
Date: Tue, 20 Oct 2009 15:04:05 -0500
Message-ID: <fabb9a1e0910201304j2730e6f3j1ebc5c17be07dd12@mail.gmail.com>
References: <1256007988-13321-1-git-send-email-srabbelier@gmail.com> 
	<7vbpk2sg6m.fsf@alter.siamese.dyndns.org> <fabb9a1e0910200615x5d487cdk6f50e11c96f2cb6c@mail.gmail.com> 
	<7vbpk2ovio.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:04:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Kwa-0001B4-Sv
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbZJTUEW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 16:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZJTUEW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:04:22 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:60487 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbZJTUEV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 16:04:21 -0400
Received: by ewy3 with SMTP id 3so5228242ewy.17
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vbSEptOhV4qV8c48zP6o9gihoX53Be69VNvWEU3fW+0=;
        b=REgZFolVEGj8nniac6I7E3gzs2a4K2L+6oG/j5mfrD2JQ6x0Acxx6Ylm0VYnqBvddi
         3FIKZCYR85tDZUlbNRpk1sod0hKpOT5PH/jy1Gr7MQzOaBrpy+B+H85/eZnzuUCwCkM3
         Wxl2ex0QCu4MoYpviwjpr4OBNBJqke+f/VXnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dHkBRpNYWBuhNlZH1j2iVrSWSF1t+slie/FWFr0cIuo+x0kSXYthgifaoCZ6w+LLAP
         ObWju2XTK8tBK9NuQzHqo/btIqagrNLxVrduQN4nQGNFJFxoax5aWW49O4quSmXAvi9r
         0EELlLMLF2yqvIovq8/sdGj2NGKJJ2oMRCz7g=
Received: by 10.216.90.11 with SMTP id d11mr430442wef.187.1256069065146; Tue, 
	20 Oct 2009 13:04:25 -0700 (PDT)
In-Reply-To: <7vbpk2ovio.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130834>

Heya,

On Tue, Oct 20, 2009 at 11:55, Junio C Hamano <gitster@pobox.com> wrote=
:
> That is kind of surprising ;-) as I do remember that I never thought =
about
> this issue of dealing with the incomplete lines while writing the bla=
me
> algorithm. =A0I actually didn't even think about "well this will not =
work
> because I am ignoring the incomplete lines".

I used the following repo for testing:

$ git init
Initialized empty Git repository in /home/sverre/code/test/.git/
$ echo "first line" > test
$ git add test
$ git commit -m "initial"
[master (root-commit) d573d06] initial
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 test
$ echo -n "second line, no newline" >> test
$ git add test
$ git commit -m "second"
[master 76ad2f9] second
 1 files changed, 1 insertions(+), 0 deletions(-)

Regular output looks good:

$ git blame test
^d573d06 (Sverre Rabbelier 2009-10-20 12:30:56 -0500 1) first line
76ad2f90 (Sverre Rabbelier 2009-10-20 12:31:57 -0500 2) second line, no=
 newline

Porcelain output looks good too:

$ git blame -p test
d573d06f0dd50148ba8e59bf8f1ef8fa7ee9fc88 1 1 1
author Sverre Rabbelier
author-mail <srabbelier@gmail.com>
author-time 1256059856
author-tz -0500
committer Sverre Rabbelier
committer-mail <srabbelier@gmail.com>
committer-time 1256059856
committer-tz -0500
summary initial
boundary
filename test
        first line
76ad2f90bde689a65715e37afd37d45942c74954 2 2 1
author Sverre Rabbelier
author-mail <srabbelier@gmail.com>
author-time 1256059917
author-tz -0500
committer Sverre Rabbelier
committer-mail <srabbelier@gmail.com>
committer-time 1256059917
committer-tz -0500
summary second
previous d573d06f0dd50148ba8e59bf8f1ef8fa7ee9fc88 test
filename test
        second line, no newline

--=20
Cheers,

Sverre Rabbelier
