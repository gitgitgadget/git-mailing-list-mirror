From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] pre-commit: check .top* files in the 
	to-be-commited tree
Date: Thu, 4 Jun 2009 23:29:15 +0200
Message-ID: <36ca99e90906041429o32dcc093sccaa2fba21fddd10@mail.gmail.com>
References: <1243975238-4807-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090604052716.GA24414@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:30:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKWP-000575-EC
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbZFDV3R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 17:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbZFDV3Q
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:29:16 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:61489 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbZFDV3P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 17:29:15 -0400
Received: by bwz9 with SMTP id 9so1070825bwz.37
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KmqcpbP2zcOOe5H+w+W/XAQUhkdp9aLCLQ/LqyNwGJY=;
        b=ov1S8/JWMxLsIz5fzEq2zX8E1bH//xoWYN6PzbDkmtAIcNJkQonhUnPq4+n/lTUUhN
         yiDP0bw2XrPqcf/bxhHnODlkhLlWIT44WyUtrolSyf4k72w00wc/47U6f91EJ1SKA6T6
         c94mfSmCx4UYHM19lU9rkRaZnfUmkgGsmI/P0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GNugtiMAP6dz6JVVwIll82hAT9wfCiKrwrNlqhzyg5hC4o1FuhBs5/P/ibbpUmiCab
         ul5xDiOYg5JHaZSnMWRKZHQeL7pXmNecnqH28E9RgkY6xDpHxgwaj2RqXXmp2vI9YA5H
         i4vVpK0yBHUIg5juIbEFvv2rZeI4UOueMeC34=
Received: by 10.223.117.14 with SMTP id o14mr1695838faq.21.1244150955227; Thu, 
	04 Jun 2009 14:29:15 -0700 (PDT)
In-Reply-To: <20090604052716.GA24414@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120713>

2009/6/4 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
Hi Uwe,

>
> On Tue, Jun 02, 2009 at 10:40:38PM +0200, Bert Wesarg wrote:
>> We currently check fo these files only in the working tree. But we s=
hould check
>> what would be commited. We use write-tree to be able to utilize ls-t=
ree and
>> check the result.
> <nitpick> I prefer not speaking about "us" in the commit log. =C2=A0B=
etter
> use passive voice. </nitpick> =C2=A0So what about:
>
> The pre-commit hook used to check that the working copy has the .top*
> files. =C2=A0Instead of that assert that the tree that is about to be
> commited has these files.
Yes, thats right, Your message is nice, you can use it for the commit.

>
>> +# I suspect this can't fail, but who knows
>> +tree=3D$(git write-tree) ||
>> + =C2=A0 =C2=A0 die "Can't write tree"
> Actually you don't need to write the tree. =C2=A0You can use:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cat-file -t :0:.topdeps
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-> blob
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cat-file blob :0:.topdeps | grep .
Hmm, not very nice:

$ git init
Initialized empty Git repository in /home/bertw/tmp/has-file/.git/
$ touch .topdeps
$ git add .topdeps
$ git commit -m.topdeps
[master (root-commit) 8193982] .topdeps
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 .topdeps
$ git rm .topdeps
rm '.topdeps'
$ git cat-file -t :0:.topdeps
fatal: Not a valid object name :0:.topdeps
$ echo $?
128
$ git cat-file blob :0:.topdeps | grep .
fatal: Not a valid object name :0:.topdeps
$ echo $?
1

My proposal:

$ git ls-tree --long "$(git write-tree)" .topdeps
$ echo $?
0

Here I know, that all git commands don't die(), they all succeed. The
=2Etopdeps file, I'm looking for, is not in the tree, i.e. empty output=
=2E

Bert

> Best regards
> Uwe
