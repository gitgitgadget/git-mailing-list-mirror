From: Sundararajan R <dyoucme@gmail.com>
Subject: Fwd: [RFC] [GSoC Proposal Draft] Unifying git branch -l,git tag -l
 and git for-each-ref
Date: Tue, 24 Mar 2015 00:03:53 +0530
Message-ID: <CAPV5_7L=439EK6hjdY-d7FVpdCZaj=H0-Bubqxmk8NFFJNBgfw@mail.gmail.com>
References: <CAPV5_7+j=yAPX3NWnmoFuaedy5cet20diwXpgznssKEW5g4UFA@mail.gmail.com>
	<CAPV5_7LuqWyr+=fxrnfiWersDPZu8=_diWSdST9i8VMVX-84kw@mail.gmail.com>
	<CAPV5_7JfN3E4QQrEC-+O42yY=VCcQQgFd3o8M0kW+WKemdedyg@mail.gmail.com>
	<CAPV5_7KVxLWoWGRYksnq+is4tgdP_KS4=GVPMZZ23d-23dLKkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 19:34:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya7Au-00088k-Sj
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 19:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbbCWSeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 14:34:04 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33960 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbCWSdy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 14:33:54 -0400
Received: by oier21 with SMTP id r21so148366682oie.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=VVocE9Fvzv32ICPcN4sajS6+lD06dQMssCvIYDlsMnM=;
        b=Nk4Y2Gf1/bwZqS6aSd2sAdaoJMIjyPfSi30CabTMCM+eayuXGsdiT8Snm7EnMn+ygY
         5TthL2wgP8Q3VirfpP6wRpPJDph7mZXaM7zk8StuxNDTqvRoPs0EfqVdchb6RINF4gTq
         XzQpiS8Q1JAk7JkY8cTWA3+o3QBhwsqvxETSVUuRlTIGdHqV1U1f+44TvbOxqNFIqwwi
         57skqXea7JjBWCt/lNCMM55q3nbukLEBF8ox63u1aqCt2XVOk9Kja+uNC9v8PaLtilTT
         Biv2uq7BgRnyDGB/XYj8NPMQtzDP6PzF8BiQewOy4r9faVimSlmE6Y3WQrjZuxV4cDty
         m7cA==
X-Received: by 10.60.158.73 with SMTP id ws9mr448649oeb.24.1427135634006; Mon,
 23 Mar 2015 11:33:54 -0700 (PDT)
Received: by 10.202.82.144 with HTTP; Mon, 23 Mar 2015 11:33:53 -0700 (PDT)
In-Reply-To: <CAPV5_7KVxLWoWGRYksnq+is4tgdP_KS4=GVPMZZ23d-23dLKkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266156>

Hi all,

I have attempted a microproject [1][2] and this is my first draft of
the proposal.I have included only the matter regarding my approach
to solving the problem and shall add my personal details later.

Please be kind enough to go through my proposal and suggest modificatio=
ns
or detailing wherever required. Also give me feedback on whether my app=
roach to
solving the problem is correct.

In the meantime I am reading up the code of Jeff's attempt at
unification,here [3] for preparing my final proposal.

-----------------------------------------------------------------------=
---------

Title
-----

Unifying git branch -l,git tag -l and git for-each-ref

Abstract
--------

git for-each-ref and the list modes of git branch and git tag involve s=
electing
a subset of the refs and printing out the result. Currently the impleme=
ntations
are not shared in the sense that :-

SELECTION
1. git branch knows --contains,--merged and --no-merged
2. git tag only knows --contains

=46ORMATTING
1. git for-each-ref knows formatting which none of the other two comman=
ds know.

SORTING
1. git tag knows sorting only on the basis of refnames
2. git for-each-ref knows sorting on the basis of all the fieldnames
which can be
used in its --format option

The idea is to unify the computations for these processes in a common l=
ibrary
and teach these commands all these options uniformly.

Why do we need unification?
These commands try to accomplish more or less the same thing . So,new
features would
most likely be applicable to all three of them. So, unification will
allow us build
new features for all these commands in one go instead of doing it separ=
ately for
each of the three commands.

Jeff has already worked quite a bit on unifying the selection part. I s=
hall use
that work as a starting point when I start off building the library
and its API calls.

Deliverables
------------

1. The unified library will borrow the --contains implementation from g=
it tag
(due to the speed up it had received), the --merged/--no-merged impleme=
ntation
from git branch and the --format implementation from git for-each-ref.

2. The commands will then be taught these options by making calls to
this library
functions and structures.

3. Add documentation and tests for these new features.

Optionals
---------

1. Implement the --sort option for these commands in the unified librar=
y.
2. Add documentation and tests for this feature

Approach
--------

The common library will contain a structure which will store the
present state of the
list of refs in the sense that after we perform a computation(eg.
--contains <commit>)
on the list of refs, the new list will store the result of that computa=
tion.

The structure will also have other attributes which the options
structure will take in
as its (void *)value attribute=E2=80=99s value before parsing the diffe=
rent
options. This is to
communicate to the structure about the various options(eg. --merged,
--format, --sort)
we want to use. The list of refs shall be fetched by the API in accorda=
nce with
the command(eg. git tag) and its option(eg. --merged) which were
passed to the API.

Next comes the matter of printing out the results according to the
format specified
(the default format for the command if no format is specified). This
will be done
in a method similar to how git for-each-ref prints out the results in
the given format.

Approximate Timeline
--------------------

(To estimate the amount of work that can be done in summers though it m=
ay change
 during the project[based on advice from mentors])

May 03 - May 10
Read and understand the implementation of --contains option in git tag =
and the
--merged/--no-merged implementation in git branch.

May 11 - May 17
Go through Jeff=E2=80=99s work on unification to get detailed pointers =
on how
to start with
unifying selection. Finalise all the structures required and also the A=
PI calls
the library would have to make for the selection options.

May 18 - May 24
Start working on the API.  Discuss ideas with mentor, brainstorm on
the details of
what function calls will be made to the API and what function calls
will be made by the API.

CODING PERIOD BEGINS

May 25 - May 31
Implement the --contains option in the library by taking the cue from
how git tag --contains
is implemented.

June 1 - June 7
Implement the -merge and --no-merged options similar to how they are
implemented in git branch

June 8 - June 11
Make computations more efficient, improve comments and start documentat=
ion.
Discuss about additional features and requirements with mentors.

June 12 - June 25
Teach the three commands to use the API for formatting and sorting.
Add tests and refactor
the code of the API if required. Complete the documentation for the
new features added.

MID-TERM EVALUATION

June 26 - June 30
Discuss with mentors about the state and the pace with which the
project is coming on.
Start finalising the details of the further goals to be accomplished.

July 01 - July 07
Start working on the formatting and sorting by going through their
code respective codes
in git for-each-ref. Put together a list of API calls along with their
functionality,
which we need to add to the library to implement these features.

July 08 - July 21
Implement the --format feature in the library with all the API calls
it needs to make

July 22 - August 04
Teach the three commands to use the API for formatting and sorting.
Improve comments
and code readability. Add documentation and tests for all the new
features that have
been implemented.

August 05 - August 16
I have kept these two weeks as a buffer. If a feature is taking more
time than expected
then I will concentrate on rectifying it. Else, I shall start working
on the implementation
of the --sort feature in the library by taking the cue from its
implementation in git for-each-ref.
I shall also add documentation and tests for this

SUGGESTED =E2=80=98PENCILS DOWN=E2=80=99 DATE

After August 16
Submit the project on the GSoC melange website .Try to contribute to
projects that fit my
skill set and remain active on mailing list.

-----------------------------------------------------------------------=
--------------------------
Thanks and regards,
R Sundararajan

[1] : http://thread.gmane.org/gmane.comp.version-control.git/265695
[2] : http://thread.gmane.org/gmane.comp.version-control.git/265696/foc=
us=3D265742
[3] : https://github.com/peff/git/commits/jk/for-each-ref-contains-wip
