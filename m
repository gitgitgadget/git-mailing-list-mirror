Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D0C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624FC23788
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbhAUA4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:56:49 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:34014 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391717AbhAUAGn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 19:06:43 -0500
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10KN1MNO029533
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jan 2021 18:01:22 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10KN1MNO029533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611183682; bh=AhNjq/JKaAmLzLZhLoah/RmVoaACO3N8fEkTn8wIa3Y=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=TJMqORA3tRvJI3pKlmLcoR4jpp1m8/5ChVVfoDQ0T9QPKi7wPtpKNapl26qpf2ahK
         eupSd3vDa1s/ebFOsbflhCls9DEXFsJvyIUhkugNskkvnMSJgG0CytTdB5hR5WRIUB
         MosdPCfKfi6LfYuS+HDSnQRcs9zY+U8ni5XqJ04dzarZl6u3UAMBViJ9ymKc1a8r9X
         w8X6E/bQ/y8FlNQed5YgItkdUk0hAGxTsVo4KZ7T7TaIXzgScI9ZC3iJW1T4oA/HiW
         jT79eq63vPWPt8L7s51LNh3SVCjpTkr+Ky5oIldRGLlVgjfBXGnW8+o3CMu0c7Y7Wy
         4L/unUafgVQSQ==
Reply-To: "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
          "'Kyle Marek'" <kmarek@pdinc.us>,
          "Junio C Hamano" <gitster@pobox.com>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
        "'Kyle Marek'" <kmarek@pdinc.us>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>  <20210117110337.429994-1-kmarek@pdinc.us>       <20210117110337.429994-2-kmarek@pdinc.us>       <xmqq7dobmfrq.fsf@gitster.c.googlers.com>       <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us> <xmqqwnwajbuj.fsf@gitster.c.googlers.com>       <xmqqr1mij88k.fsf@gitster.c.googlers.com>       <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us> <xmqq1reginnq.fsf@gitster.c.googlers.com>       <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us> <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>       <01fd01d6ef3e$92e43b10$b8acb130$@pdinc.us> <xmqq35yvff98.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq35yvff98.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH 1/2] revision: Denote root commits with '#'
Date:   Wed, 20 Jan 2021 18:01:33 -0500
Message-ID: <009a01d6ef80$326572d0$97305870$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQJHGJacgXqgwI3Z8mKvOOtpVC9QaQIPWPTxAWqKtJ0CjS/zDwIOmFXbAj4EO1oBSKUeLQJMhZdkAgqPsIIBueaIOAHxr5jOAbl0TYoB42v/AqiW4EDg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Summary: --graph used with --oneline sometimes produces ambiguous output =
when more than one commit has no parents and are not yet merged

> From: Junio C Hamano
> Sent: Wednesday, January 20, 2021 4:52 PM
>=20
> "Jason Pyeron" writes:
>=20
> >> I actually do not see that as a problem.  In the past several =
years,
> >> I've never needed to see "log --graph" output that goes all the way
> >
> > I respect your needs, but they conflict with others' needs, while
> > this enhancement to resolve an ambiguity does not impede your
> > needs and solves others' needs.
>=20
> I am questioning if such "needs" really exist in the first place.
>=20
> Among 35k+ commits in the example project, if you had more than a
> few dozens of roots, then it may make sense to highlight them
> differently from ordinary commits whether they have parents in the
> shown part of the history.  It's like "log --decorate" shows branch
> tips marked specially.

That could work too.

>=20
> Yes, I am saying that such a "this is root" marking, if it is
> valuable, should go on a part of "log --oneline" output that is
> shown even without "--graph", just like we annotate the commit with

I do not have any preferences beyond not "being lied to by git graph".

| * 22222
| * 11111
| * 33333
| * 44444

Implies that 11111 and 33333 have a parent / child relationship.

Quoting the man page, "--graph Draw a text-based graphical =
representation of the commit history on the left hand side of the =
output. This may cause extra lines to be printed in between commits, in =
order for the graph history to be drawn properly", would be preferable =
to add blank lines.

> "(branch name)" in the output, instead of painting the commit in the
> graph by replacing the '*' node with something else.
>=20
> And how often do you really need to see commits near the root, say
> the earliest 100 commits, in the 35k+ commit history?  Is it really
> necessary to tell which among these 100 is the root? =20

Yes, and the assumption that they are at the beginning is flawed too.

$ git log --oneline --graph --all | cat -n | egrep $(git rev-list =
--max-parents=3D0 --all | cut -c 1-8 | tr '\n' '|' | head -c -1)
    87  | | * be2c70b7 bug 2252 test case (e.g. for tomcat 9 with =
unpackWARs=3Dfalse)
  2161  | | * 8ef73128 Add migrate-from-blackfat.sql
  2164  | | * 5505e019 initial
  2235  | | | | | | | | | | | | | * 83337c67 intial
  2921  | | | | * ca14dc49 Initial commit
  2931  | | | * cbdce824 initial commit
  2963  | | * 8f1828c1 Base applet
  2971  | * 658af21f parrent pom
  3026  * 8356af31 Initial commit from Create React App

git log --oneline --graph produces 3026 lines in this example.

> What problem does it solve? =20

Avoiding confusion and non-compliance with the man page, which wastes =
human's time.

> Perhaps I am reacting to your solution without
> seeing the problem you are trying to solve?  First, I took the
> "replace <*> with {#}" as a solution for "parenthood becomes unclear
> in the --graph output" problem, and pointed out that the solution
> for that issue should apply to not just root commits but equally to
> the ones above the boundary.
>=20

I have no objection to that either as it neither helps or hinders the =
solution to the real and initial issue.

> But it seems that I am hearing that it is not "graph showing false
> parenthood" problem that you were trying to solve,=20

It is that graph is implying false parenthood. There was no intention =
for that (only) issue to morph.

> but "I want to
> see root differently for unspecified reason".

There is only one reason, the same reason that prompted the original =
email. Adjacent commits in the --graph formatted output were connected =
when they are actually not connected.

To quote earlier > From: Junio C Hamano
> Sent: Thursday, January 14, 2021 8:12 PM
> > | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> > | | |
> > | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) =
Added defau
> > | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from =
f7daf088)
> >
> ... is not so great in that it wastes a line, and the break
> won't be as noticeable when --graph is *not* used with --oneline.

No, because there would be no line connecting it.

| | | Date:   Tue Sep
| | |
| | |     Added defau
| | |
| | * commit 5505e019
| |   Author: xxxx
| |   Date:   Wed Jul
| |
| |       initial
| |
| | * commit 3e658f40
| | | Author: xxxx
| | | Date:   Tue Sep
| | |
| | |     Added defau
| | |
| | * commit ad148aaf
| | | Author: xxxx
| | | Date:   Tue Sep
| | |
| | |     Added defau
| | |

And to quote earlier > From: Junio C Hamano
> Sent: Thursday, January 14, 2021 8:12 PM
> > | | | #  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> > | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) =
Added defau
> > | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from =
f7daf088)
> This latter variant won't work.  Imagine we are showing --left-right
> for example.  Which side does '#' belong to?

There was no concerns or aversions about left/right. It was later =
clarified that being able to use the pagers search would be nice.

>=20
> I am asking why, and if the reason is because there are nontrivial
> number of them sprinkled throughout the history, I am offering my
> opinion that something like how we show the commits at the tips of
> branches and tagged ones would be a better model than changing the
> letter used for the node in the graph.

Happy to take that solution too, but does it fix the bug in the graph =
when used with --oneline? And don=E2=80=99t misunderstand me, this is a =
bug in --graph with --oneline.

>=20
> > Here are some messages:
> >
> > bug 2252 test case (e.g. for tomcat 9 with unpackWARs=3Dfalse)
> > Add migrate-from-blackfat.sql
> > Initial commit from Create React App
> > parrent pom
> > initial commit
> > Base applet
> > intial
> > Initial commit
> > initial
> > import prod
> > import prod sql
> > import prod
> > import coop/dev
> > import prod CMIS.zip
>=20
> You seem to have problems with not just root commits ;-)
> How many of these 5 "initial" commits are root?

100%, it was from:

git log --oneline $(git rev-list --max-parents=3D0 --all) | cut -c 10-

>=20
> > I'll ask the following questions, besides the left right and test =
case issues:
> >
> > What quality issues exists with the patch (e.g. bugs, strategy, =
etc)?
>=20
> By strategy I take that you mean design.  We've been talking about
> it, right?  Until that gets more or less settled, line-by-line bug
> hunting tends to become a waste of time, and I haven't had a chance
> to afford extra review bandwidth to dedicate to this topic.
>=20
> Now the problem being solved seems to be changing, so I am not sure
> how close to be "done" the posted patch is to the real solution.
> Sorry.

There was no intention for change, but adjustments were made based on =
feedback. For example, quoting earlier > From: Junio C Hamano
> Sent: Thursday, January 14, 2021 8:12 PM
> It would be great to show it more like this:
>=20
>  | | |   * 5505e019c2 2014-07-09 initial xxxxxx@xxxx
>  | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) =
Added defau
>  | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from =
f7daf088)
>=20

> From: Junio C Hamano
> Sent: Tuesday, January 19, 2021 5:10 PM
>=20
> I do not mind if the graph rendering fix does not happen yet again;
> IIRC the past contributors couldn't implement it, either.

This was a good idea, but not readily feasible.

So to close the loop, I would love to support the creation and =
integration of a patch to ensure "graph history s/to be/is/ drawn =
properly" and not lying to the reader of the graph about the ancestry.

And thank you for spending time on this thread, I think we can find a =
feasible and usable solution.

