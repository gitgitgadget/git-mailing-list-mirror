From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list 
	available repositories
Date: Wed, 28 Jul 2010 17:21:29 -0700
Message-ID: <AANLkTikaBoMOEGvLU8FL4Cvw4zBecXytvAnAYTS9GBa3@mail.gmail.com>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	<20100726232855.GA3157@burratino>
	<AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
	<201007270916.59210.j.sixt@viscovery.net>
	<20100727174105.GA5578@burratino>
	<AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
	<20100728003336.GA2248@dert.cs.uchicago.edu>
	<AANLkTik1D45_cHPapbmMMys-V544ssCyoxrs5Fxck7oP@mail.gmail.com>
	<20100728064251.GB743@dert.cs.uchicago.edu>
	<1280358894.31999.9.camel@balanced-tree>
	<20100728235249.GA29156@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@mit.edu>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 02:21:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeGsW-0007c0-I3
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 02:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab0G2AVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 20:21:34 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:42532 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab0G2AVd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 20:21:33 -0400
X-AuditID: 1209190d-b7c82ae000000a16-0a-4c50c98fb2cb
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id A8.BB.02582.F89C05C4; Wed, 28 Jul 2010 20:21:35 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6T0LVt4020179
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 20:21:32 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6T0LUnC016597
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 20:21:31 -0400 (EDT)
Received: by iwn7 with SMTP id 7so5101885iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 17:21:30 -0700 (PDT)
Received: by 10.231.35.77 with SMTP id o13mr12716136ibd.92.1280362890005; Wed, 
	28 Jul 2010 17:21:30 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Wed, 28 Jul 2010 17:21:29 -0700 (PDT)
In-Reply-To: <20100728235249.GA29156@dert.cs.uchicago.edu>
X-Brightmail-Tracker: AAAABRVg7GoVYO0mFWDyNRVhqPUVYcPu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152132>

Anders brings up a good point.

And note that as I alluded to before, there is another attack

$ echo 'DEFINE pager evilscript' > /tmp/.manpath
$ HOME=3D/tmp su git -m -c "git-receive-pack '--help'" (3)

which only requires being able to control HOME.

(Incidentally, I just noticed a segfault with

$ unset HOME
$ su git -m -c "git-receive-pack '~'"

that's probably worth fixing... if people don't think this is too
pedantic of a case to fix, I'll submit a patch for it in a later
series [I think the segfault comes from path.c:expand_user_path].)

Anyway, i'll revise my first patch to use HOME rather than getpw*.

Greg



On Wed, Jul 28, 2010 at 4:52 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Anders Kaseorg wrote:
>> On Wed, 2010-07-28 at 01:42 -0500, Jonathan Nieder wrote:
>
>>> (if you use getpwent instead of getenv to fetch $HOME).
>>
>> That seems like it could lead to problems with multiple users with t=
he
>> same UID, and possibly also on Windows. =A0If it=92s important to be
>> paranoid here, what about all the other places Git already uses
>> getenv("HOME"), including where it reads ~/.gitconfig?
>
> Thanks for a sanity check. =A0I do not see the multiple-user problem
> (git-shell is meant to be the login shell, no?) but I think you are
> right about using getwpwent instead of $HOME being a pointless
> precaution. =A0My confusion came from a misreading of how 'su' works.
>
> Here was my worry: that a user could do something like this:
>
> =A0$ mkdir /tmp/git-shell-commands
> =A0$ ln -s /bin/sh /tmp/git-shell-commands/sh
> =A0$ HOME=3D/tmp su git -m -c sh; =A0 =A0 =A0 =A0 =A0 # (1)
>
> and get a shell with the privileges of the user with git-shell
> as login shell, which is exactly what a restricted shell like
> this should be preventing.
>
> Now if that is possible, what is to stop me from this?
>
> =A0$ PAGER=3Devilscript su git -m -c git-receive-pack --help; # (2)
>
> which became possible (modulo the su bit) as an unintended
> consequence when receive-pack became builtin.
>
> If I understand the manual correctly, then at least on some
> systems, luckily su protects correctly against such problems.
>
> =A0 =A0 =A0 =A0-m
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preserve the current environment.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If the target user has a restricted sh=
ell,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0this option has no effect (unless su i=
s
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0called by root).
>
> Is that behavior portable? =A0It certainly seems like the
> only sane way to behave. =A0It=92s a moot question for the
> inclusion of this patch series: if we need to worry about
> (1), then it is still not a regression because (2) was possible
> already.
>
> The same discussion would seem to apply to ssh with
> PermitUserEnvironment enabled.
>
