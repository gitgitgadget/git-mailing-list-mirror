From: Andreas Ericsson <ae@op5.se>
Subject: Re: =?ISO-8859-15?Q?Schr=F6dinger=27s_diff?=
Date: Tue, 07 Jul 2009 09:52:14 +0200
Message-ID: <4A52FEAE.90705@op5.se>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 09:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO5TX-0007Br-71
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 09:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbZGGHwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 03:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754056AbZGGHwQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 03:52:16 -0400
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41708 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750959AbZGGHwP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 03:52:15 -0400
Received: from source ([209.85.219.213]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSlL+sVuicCJXtgE0ejEjjDAaYWT3uW6y@postini.com; Tue, 07 Jul 2009 00:52:19 PDT
Received: by ewy9 with SMTP id 9so486887ewy.23
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 00:52:17 -0700 (PDT)
Received: by 10.210.118.13 with SMTP id q13mr6765143ebc.45.1246953136985;
        Tue, 07 Jul 2009 00:52:16 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 28sm2541832eyg.52.2009.07.07.00.52.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 00:52:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122827>

Eric Raible wrote:
> git version 1.6.3.2.1299.gee46c (msysgit)
>=20
> In trying to track down some annoying crlf corruption in a repo
> I have found a Schr=F6dinger's diff.  In other words it's unknown
> whether the diff will produce output or not on any particular run
> of the following script.
>=20
> Sometimes it does, and sometimes it doesn't (seems to be about
> 50/50).  But either way in any given repo rerunning the git-diff will
> always give the same result.
>=20

I don't get the same result in the same repo, although it only
differs in 1-1.5% of the tests.

> Doing an "git ls-tree HEAD" gives an identical tree in both cases.
>=20
> Can anyone explain why the output to this is not deterministic?

On Linux with git version 1.6.3.3.354.g3b4cc

Pasting your commands into "repro.sh", but redirecting output from
git commit to /dev/null, and then running the following commands
has yielded 9 to 15 sample.$i files over 5 tries of the following:

sh repro.sh > correct
for i in $(seq 1 1000); do
  sh repro.sh > sample && cmp sample correct >/dev/null || \
     { echo "fail $i" && cp sample sample.$i; };
done

> I'm at a complete loss.
>=20

Inserting "sync" between calls as shown below doesn't fix the issue
(although it drops from 9-15 to 4-10 fails on Linux; Not a very good
improvement and only two test-runs). I have no idea how it can behave
so strangely, and I refuse to believe that the ext3 fs driver allows
dirty reads.

> 	# Clean up from last run and start over
> 	rm -rf .git has-crlf
> 	git init
> 	git config core.autocrlf false
>=20
> 	# Add a "bad" file
> 	perl -e 'printf( "12%c%c", 0xd, 0xa )' > has-crlf
> 	git add has-crlf
> 	git commit -m"add crlf"
>=20

sync

> 	# I realize that switching is ill-advised, but I'm
> 	# trying to track down a possibly related problem...
> 	git config core.autocrlf true
>=20

sync

> 	# This sometimes produces output and sometimes it doesn't.
> 	# Either way rerunning just git-diff always gives the same result
> 	# as the first run in this repo.
> 	git diff
>=20

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
