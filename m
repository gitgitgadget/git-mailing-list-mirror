From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 20:40:51 +0200
Message-ID: <1309200051.2497.288.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 20:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbGhZ-0005gL-VJ
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 20:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab1F0SiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 14:38:23 -0400
Received: from mail11.surf-town.net ([212.97.132.51]:53335 "EHLO
	mailgw13.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753068Ab1F0SiV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 14:38:21 -0400
Received: by mailgw13.surf-town.net (Postfix, from userid 65534)
	id 2964D409A6; Mon, 27 Jun 2011 20:38:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw13.surf-town.net (Postfix) with ESMTP id 0A0B7409A6;
	Mon, 27 Jun 2011 20:38:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw3.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw13.surf-town.net ([127.0.0.1])
	by localhost (mailgw13.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LiybA6My2Qwv; Mon, 27 Jun 2011 20:38:13 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-35-11.w92-141.abo.wanadoo.fr [92.141.170.11])
	by mailgw13.surf-town.net (Postfix) with ESMTPSA id 46221409C1;
	Mon, 27 Jun 2011 20:38:12 +0200 (CEST)
In-Reply-To: <7vvcvrxlol.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176360>

=46irst of all thank you for your answer.

Le lundi 27 juin 2011 =C3=A0 09:51 -0700, Junio C Hamano a =C3=A9crit :
> henri GEIST <henri.geist@flying-robots.com> writes:
>=20
>> We can obviously solve this by doing trees of submodules just reflec=
ting
>> the trees of dependency but it create somme problems.
>>
>>   1. In project 4 I have 2 times project 1 and 3 times libraries 1 a=
nd 2
>>      And 2 times library 4.
>>   2. It is a wast of space.
>>   3. Different version of the same libraries or projects could be us=
ed.
>>   4. when linking object, multiples objects will export the same sym=
bols
>=20
> All of the above are something your build procedure needs to solve
> regardless, even if you are not using git submodules (or even if you =
are
> not using any SCM, for that matter).  If you want to (and you do want=
 to)
> avoid duplication, version drift and associated issues of use of the
> common library 1 across project 1 and project 2, you would organize y=
our
> source tree so that both of your (sub)projects to use the library cod=
e
> from a common location.
>=20
> One possible working tree organization may look like this:
>=20
> 	-+- lib1
>          +- project1/Makefile -- refers to ../lib1
>          +- project2/Makefile -- refers to ../lib1
>=20

I agree on this point.
And that is just what I do and mean by :

>> Anything/library_1
>> Anything/library_2
>> Anything/library_3
>> Anything/library_4
>> Anything/project_1 with a git submodule add ../library_1 ../library_=
2
>> Anything/project_2 with a git submodule add ../library_1 ../library_=
3
>> Anything/project_3 with a git submodule add ../library_2 ../library_=
4
>>                                             ../project_1
>> Anything/project_4 with a git submodule add ../library_4 ../project_=
1
>>                                             ../project_2 ../project_=
3

I would like git to do just the same thing that do my Makefile.

> The top-level superproject (what you called "Anything") binds project=
1,
> project2 and lib1 as its submodules, and it can say where you want yo=
ur
> users to fetch these submodules in its .gitmodules, and at what versi=
on
> lib1 (and projects) to use in its tree objects as gitlinks.
>=20

Until now I did not thought about making "Anything" a git repository.
It was just a simple directory containing all my projects.
And project_4 was not a submodule of anything.

May be I need to think more about it.

But actually it is just pushing the problem one rank more by making
"Anything" a kind of project_5 which contain submodules in sub
directories and will rase the same problem the day project_6 will need
project_5.
And it does not solve the problem of making project_1 knowing is need t=
o
be linked to library_1 in version "abcd1234..."

> People who are _only_ interested in project1 can still clone that
> top-level superproject, and "submodule init" only lib1 and project1,
> without running "submodule init" on project2.
>=20

I agree on this point.

> An interesting point your situation raises is that there is no direct=
 way
> to express module dependencies in .gitmodules file right now, I think=
=2E

And that is the real problem.
It could be done for submodule inside of the project main directory.
But not for modules outside of it.

> Ideally you would want "submodule init project1" to infer automatical=
ly
> that project1 needs lib1 and run "submodule init lib1" for you. My gu=
t
> feeling is that it belongs to .gitmodules of the superproject.
>=20

I do not really care about project_1 doing the submodule init.
I can easily do it by myself.
And in fact I use to write the libraries before the project using them.
then there git repositories already exist

what I really need is to do :

cd project_1
git add ../library_1

then in case of modification in library_1

A git status in project_1 directory will say me :

modified:   ../library_1 (modified content)
or
modified:   ../library_1 (new commits)
or even
modified:   ../library_1 (new commits, modified content)

Just like it do for submodules with out "../" in the path.

And I really think the metadata to do so should be stored in project_1
since it is him which depend on library_1 version "abcd1234..." and thi=
s
information need to be self contained.
May be in project_1/.git or project_1/.gitmodules

I do not see the point of having a third party project "Anything" Just
to say to project_1 hey you need library_1.
If it need it, it should already know it.


	Henri GEIST
