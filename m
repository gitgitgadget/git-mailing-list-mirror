From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug when git rev-list options "--first-parent" and "--ancestry-path"
 are used together?
Date: Sat, 25 May 2013 20:40:51 +0200
Message-ID: <51A105B3.9020304@alum.mit.edu>
References: <519DEA48.10108@alum.mit.edu> <7vtxltfwaa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 25 20:41:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgJOn-0007J1-3o
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 20:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757640Ab3EYSk4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 May 2013 14:40:56 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:55415 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757598Ab3EYSkz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 14:40:55 -0400
X-AuditID: 12074412-b7f216d0000008d4-3b-51a105b69aaf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.FF.02260.6B501A15; Sat, 25 May 2013 14:40:54 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4PIep2o022626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 14:40:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vtxltfwaa.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqLuNdWGgwccrqhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xo8rxxkL7mtVNK6+x9bAeE2ui5GTQ0LARGLm
	q0lsELaYxIV764FsLg4hgcuMEvP+7GCBcM4zSUxu/soCUsUroC3x40APmM0ioCrxbdVJMJtN
	QFdiUU8zE4gtKhAm8X7ZVFaIekGJkzOfgNWICKhJTGw7BGRzcDAD1T98kwgSFhZIk7j97Rwj
	iC0kECzx8/1tsDGcAmYSd77PYYQoV5dYP08IJMwsIC/RvHU28wRGgVlIFsxCqJqFpGoBI/Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJAQFdrBuP6k3CFGAQ5GJR5egfL5
	gUKsiWXFlbmHGCU5mJREeVf8XRAoxJeUn1KZkVicEV9UmpNafIhRgoNZSYT35jWgHG9KYmVV
	alE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwMB4eSBO8RloWBQoJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgKI0vBsYpSIoHaO9TkHbe4oLEXKAoROspRmOOzecnv2PkmPED
	SAqx5OXnpUqJ8z4AKRUAKc0ozYNbBEtOrxjFgf4W5t0LUsUDTGxw814BrWICeTF3PsiqkkSE
	lFQDYzmDn941s+CJLuc5uuYbGRvwaxbfOvdzY8zKBw+dFpRGxsXv1rz/keeZid5q4QrO8hey
	pZ7HXCasmX2T7eIdX+X8W2kPX5me+VYxz8c75fK6uXc6t8x3zrU/skCh8F996yVt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225528>

[Junio, sorry for the dup; somehow I failed to CC the first version to
the mailing list.]

On 05/23/2013 07:20 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
>> It seems to me that
>>
>>      git rev-list --first-parent --ancestry-path A..B
>>
>> is well-defined and should list the commits in the intersection betw=
een
>>
>>      git rev-list --first-parent                 A..B
>>
>> and
>>
>>      git rev-list                --ancestry-path A..B
>>
>> But in many cases the first command doesn't provide any output even
>> though there are commits common to the output of the last two comman=
ds.
>>
>> For example, take as an example the DAG from test t6019:
>>
>> #          D---E-------F
>> #         /     \       \
>> #    B---C---G---H---I---J
>> #   /                     \
>> #  A-------K---------------L--M
>>
>> (The merges are always downwards; e.g., the first parent of commit L=
 is
>> K.)  The command
>>
>>     git rev-list --first-parent --ancestry-path D..J
>>
>> doesn't generate any output, whereas I would expect it to output "H =
I
>> J".
>=20
> As I do not see how "only show first-parent chains from near the tip
> but stop immediately when the chain deviates from the ancestry path"
> could be a sensible operation (in other words, I do not offhand
> think of examples of what useful things you can do with that
> information), I actually expect that "-f-p -a-p D..J" should error
> out, instead of giving no output.
>=20
> You are correct to point out that sometimes -f-p and -a-p _could_ be
> compatible, e.g. "-f-p -a-p A..M", or "-f-p -a-p B..M".  But I think
> the only case that they are compatible is when "-f-p" output is a
> strict subset of what "-a-p" without "-f-p" would give.

I guess I should tell you the application that motivated the use of
these options together.  Maybe you can suggest a better approach.

I'm trying to find the most general conditions where an incremental
merge [1,2] makes sense.  The simple case is merging two linear
branches, call them "branch" and "master":

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
     \
      A - B - C - D      =E2=86=90 branch

My tool git-imerge does this (conceptually) by constructing the pairwis=
e
merges between each commit on master and each commit on branch:

o - 0 - 1  - 2  - 3  - 4   =E2=86=90 master
    |   |    |    |    |
    A - A1 - A2 - A3 - A4
    |   |    |    |    |
    B - B1 - B2 - B3 - B4
    |   |    |    |    |
    C - C1 - C2 - C3 - C4
    |   |    |    |    |
    D - D1 - D2 - D3 - D4  =E2=86=90 final merge
    =E2=86=91
  branch

Each of the new items [ABCD][1234] is a merge commit between its
neighbor above and its neighbor to the left.  The idea is that the
pairwise merges are less likely to conflict, and if they conflict are
likely to be easy to reconcile.

I am trying to generalize this approach to a more complicated situation
where the two branches are not linear.

The current incremental merge algorithm requires that each commit
0,1,2,3,4 and 0,A,B,C be a direct descendant of its predecessors.
That's trivial for linear branches.  But if the situation looks like th=
is:

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
     \
      A - B - C - D      =E2=86=90 branch
           \     /
            X - Y

then there is no correct ordering of 0,A,B,C,D,X,Y that has the
descendancy property.  So currently I always take use the first-parent
list of commits on each branch (i.e., omitting X and Y), which does hav=
e
that property.

Now assume a slightly more complicated situation, in which master has
been merged to feature branch at some point:

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
     \       \
      A - B - C - D      =E2=86=90 branch
           \     /
            X - Y

Now when we do an incremental merge branch into master, how do we
generate the list of commits to put one each axis of the table?  The
merge base is "2", so I think the best answer is

1- 2 - 3  - 4   =E2=86=90 master
   |   |    |
   C - C3 - C4
   |   |    |
   D - D3 - D4  =E2=86=90 final merge
   =E2=86=91
 branch

The simplest way I can think of to generate the list C,D is

    git rev-list --first-parent --ancestry-path 2..D

We need --ancestry-path to avoid getting commits A and B.  It's still
not clear that this is always the best approach but at least it seems
safe.  For example, suppose that the first parent of D is Y rather than=
 C:

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
     \       \
      A - B - C --.
           \       \
            X - Y - D    =E2=86=90 branch

In this case, the above command (it it worked correctly) would just
output "D".  This is correct and could be used for a (degenerate, in
this case) incremental merge [3].

This is my reason for wanting --first-parent and --ancestry-path to wor=
k
together.

=46or now I'm just running rev-list twice and computing the intersectio=
n
by hand, but it was surprising that git could not do this for me.

Michael

[1] https://github.com/mhagger/git-imerge
[2]
http://softwareswirl.blogspot.com/2013/05/git-imerge-practical-introduc=
tion.html
(and references therein)
[3] It might be more helpful to use C,D in this case rather than just D=
,
but I haven't yet figured out whether this is just a special case or
whether it hints at an algorithm that is more clever than
"--first-parent --ancestry-path".

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
