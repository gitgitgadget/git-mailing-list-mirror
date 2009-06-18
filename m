From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for 
	the given branches
Date: Thu, 18 Jun 2009 16:40:50 +0200
Message-ID: <adf1fd3d0906180740t637da9braea02deb3cba2680@mail.gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	 <m3iqithd24.fsf@localhost.localdomain>
	 <adf1fd3d0906180655q5c142889r3375169b6cf1f8b0@mail.gmail.com>
	 <200906181617.07802.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 16:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHInU-0000Lz-5U
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 16:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757828AbZFROkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 10:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757407AbZFROku
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 10:40:50 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:36481 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbZFROkt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 10:40:49 -0400
Received: by fxm8 with SMTP id 8so1102661fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 07:40:51 -0700 (PDT)
Received: by 10.204.118.207 with SMTP id w15mr1414351bkq.126.1245336050847; 
	Thu, 18 Jun 2009 07:40:50 -0700 (PDT)
In-Reply-To: <200906181617.07802.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121848>

2009/6/18 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 18 June 2009, Santi B=E9jar wrote:
>> 2009/6/18 Jakub Narebski <jnareb@gmail.com>:
>
> [cut]
>> >
>> > =A0$ git remote tracking <remote> <remote branch>
>> >
>> > would show all local branches that track <remote branch>, and have
>> > <remote> as default remote,
>>
>> Maybe my description is unclear, but it's not about local branches
>> which track <branch> on <remote>, it is about the local branch
>> representation of the remote branch, i.e. not 'master' but
>> origin/master (git remote tracking origin master in a default clone)=
=2E
>
> Ah, the problem with the same (or similar) name for two different
> things. =A0If we have local branch 'local' set to track branch 'maste=
r'
> on remote 'origin', we have:
>
> =A0 /------- local repository ------\ =A0 =A0 =A0 =A0 =A0 =A0/- origi=
n -\
> =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
\ =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0\
> =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0|
> =A0'local' =A0--------> =A0'origin/master' -----------> 'master'
> =A0refs/heads/local =A0 =A0refs/remotes/origin/master =A0 refs/heads/=
master
>
> =A0branch.local.remote =3D origin
> =A0branch.local.merge =A0=3D refs/heads/master
>
> =A0remote.origin.fetch =3D +refs/heads/*:refs/remotes/origin/*
>
> 'origin/master' is called remote-TRACKING branch (for 'master' branch
> on remote 'origin'). =A0Setting up automerge information for local br=
anch
> 'local' which _follows_ branch 'master' on remote 'origin' is done
> using --TRACK option to git-branch.
>
> Therefore the confusion.

OK, but I wonder if the documentation for the new command is clear
enough or can be improved.

>
>
> Do I understand correctly that you want for
>
> =A0$ git remote tracking origin master
>
> to return
>
> =A0origin/master

In this particular case (the above settings) not exactly, as master
does not match exactly the lhs of the refspec. It would be:

$ git remote tracking origin refs/heads/master
refs/remotes/origin/master

>
> (and perhaps also origin/HEAD?).

HEAD is another beast, as the local HEAD symlink is a local config,
that defaults to the remote default branch, but that you can change
with "git remote set-head".

Ops, you are saying to return origin/HEAD for "git remote tracking
origin master", no? I don't think it makes sense, I think of "git
remote tracking" more as a mapping function, it applies the map (the
refspec) to the given argument.

Santi
