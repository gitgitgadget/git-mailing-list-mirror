From: karthik nayak <karthik.188@gmail.com>
Subject: [RFC/GSoC] Proposal Draft: Unifying git branch -l, git tag -l, and
 git for-each-ref
Date: Mon, 23 Mar 2015 18:39:20 +0530
Message-ID: <55101080.90805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 14:09:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya26k-0006RS-DI
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 14:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbbCWNJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 09:09:25 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36822 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbCWNJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 09:09:24 -0400
Received: by padcy3 with SMTP id cy3so191312136pad.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=f+KXTRlVQk+ohKBLJ4MrZDzZ8j24fnyrjzV4K39keLs=;
        b=cBBVF63s+PIIFfk0Dz9JdCoMMIs3qX8g/5oX9y9HQbMi5A+0/0mGzw1U/uqH7o4i6D
         l/ycQ6euXI6OjjIljcaqIwWFwg77Fmi9be/EAyyfCOhoZ5IVzCBprFAw1Ng4pBeSD1X4
         v0E2OMjVl2bJpFpNPCHd3u4dHMQgPDBgEJVM+B43Fl1PHKUYTNpNrtsRf0dXuWpPXCVf
         JmHh5B1KjJms7qb7p+Pd7ol4uE9TF/iB8BQ7jwxI3HBmSE2+0rl7XzeOEkrpr6UyIhNT
         QAzOleHziW6w8zG1JuFw/qoqQHUnMMQEs0lqaXRpma4/xtuwOHLFVoMRcDvGnBtbur+p
         6KAA==
X-Received: by 10.68.250.131 with SMTP id zc3mr21117066pbc.97.1427116163758;
        Mon, 23 Mar 2015 06:09:23 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id hz8sm1105747pac.5.2015.03.23.06.09.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2015 06:09:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266138>

Hello,
I have completed the micro project[1] and have also been working on=20
adding a "--literally" option
for cat-file[2]. I have left out the personal information part of the=20
proposal here, will fill that in while submitting my final proposal.

Currently, I have been reading about how "branch -l", =E2=80=9Ctag -l=E2=
=80=9D and=20
=E2=80=9Cfor-each-refs=E2=80=9D work and how they implement the selecti=
on and formatting=20
options.

Since this is a draft for my final proposal I would love to hear from=20
you all about :

* Suggestions on my take of this idea and how I could improve it or=20
modify it.
* Anything more I might have missed out on, in the proposal.

GSOC Proposal : Unifying git branch -l, git tag -l, and git for-each-re=
f
-----------------------------------------------------------------------=
-----------------------------------------------------------------
# Main objectives of the project:

* Build a common library for which can handle both selection and=20
formatting of refs.

* Use this library throughout =E2=80=98branch -l=E2=80=99, =E2=80=98tag=
 -l=E2=80=99 and =E2=80=98for-each-ref=E2=80=99.

* Implement options available in some of these commands onto others.

-----------------------------------------------------------------------=
-----------------------------------------------------------------

# Amongst  =E2=80=98branch -l=E2=80=99, =E2=80=98tag -l=E2=80=99 and =E2=
=80=98for-each-ref=E2=80=99 :

* =E2=80=98git branch -l=E2=80=99 and =E2=80=98git tag -l=E2=80=99 shar=
e  the =E2=80=98--contains=E2=80=99 option.

* 'git tag' and 'git branch' could use a formatting option (This could=20
also be used to implement the verbose options)
	For eg: git branch -v could be implemented using :
	git for-each-ref refs/heads --format=3D'%(refname:short)=20
%(objectname:short) %(upstream:track) %(contents:subject)'
	This shows that having a formatting option for these two would mean=20
that the verbose options could be implemented using the formatting=20
option itself.

  * 'git for-each-refs' could use all the selection options. This would=
=20
enhance the uses of for-each-refs itself. Users can then view only refs=
=20
based on what they may be looking for.

* formatting options for =E2=80=98git branch -l=E2=80=99 and =E2=80=98g=
it tag -l=E2=80=99. This would=20
enable the user to view information as per the users requirements and=20
format.

-----------------------------------------------------------------------=
-----------------------------------------------------------------
# Approach

All three commands select a subset of the repository=E2=80=99s refs and=
 print=20
the result. There has been an attempt to unify these commands by Jeff=20
King[3]. I plan on continuing his work[4] and using his approach to=20
tackle this project.

As per the common library for =E2=80=98branch -l=E2=80=99, =E2=80=98tag=
 -l=E2=80=99 and =E2=80=98for-each-ref=E2=80=99 I=20
plan on creating a file (mostly as ref-filter.c in terms with what Jeff=
=20
has already done) which will provide API=E2=80=99s to add refs to get a=
 list of=20
all refs. This will be used along with =E2=80=98for_each_*_ref=E2=80=99=
 for obtaining=20
the refs required. This gives us the basic functionality of obtaining=20
the refs required by the command.

Here we could have a basic data structure (struct ref_filter_item) whic=
h=20
would denote a particular ref and have another data structure to hold a=
=20
list of these refs (struct ref_filter). Then after getting the required=
=20
refs, we could print the information.

=46or extended selection behaviour such as =E2=80=98--contains=E2=80=99=
 or =E2=80=98--merged=E2=80=99 we=20
could implement these within
the library by providing functions which closely mimic the current=20
methods used individually by =E2=80=98branch -l=E2=80=99 and =E2=80=98t=
ag -l=E2=80=99. For eg to=20
implement =E2=80=98--merged=E2=80=99 we implement a =E2=80=98compute_me=
rge()=E2=80=99 function, which=20
with the help of the revision API=E2=80=99s will be able to perform the=
 same=20
function as =E2=80=98branch -l --merged=E2=80=99.

=46or formatting functionality provided by =E2=80=98for-each-ref=E2=80=99=
 we replicate the=20
=E2=80=98show_ref=E2=80=99 function in =E2=80=98for-each-ref.c=E2=80=99=
 where the format is given to the=20
function and the function uses the format to obtain atom values and=20
prints the corresponding atom values to the screen. This feature would=20
allow us to provide format functionality which could act as a base for=20
the =E2=80=98-v=E2=80=99 option also.

As Jeff has already done, we could also add parse options. Although Jef=
f=20
has built a really good base to build upon, I shall use his work as mor=
e=20
of a reference and work on unification of the three commands from=20
scratch. I plan on coding for this project using a test driven=20
development, where I will write tests (initially failing) which will be=
=20
based on the objectives of the project and then write code to pass thos=
e=20
tests.

-----------------------------------------------------------------------=
-----------------------------------------------------------------

# Timeline

This is a rough plan of how I will spend the summer working on this pro=
ject.

Community bonding period:
	Work on understanding how all three commands work in total detail. And=
=20
build up on the design of unification of the three commands. Read=20
through Jeff=E2=80=99s attempt at unification and get a grasp of what t=
o do.

Week 1 :
	Write tests and documentation which will the goal of this project. Thi=
s=20
will set the deliverables of the project and what the code will try to=20
achieve in the project.

Week 2 :
	Build a basic library which will function to get the required refs.

Week 3 :
	Since =E2=80=98tag -l=E2=80=99 has the least options to be satisfied i=
nitially, modify=20
=E2=80=98tag -l=E2=80=99 to use the newly created library.

Week 4 - 5 :
	Implement =E2=80=98--merged=E2=80=99 and other selection options to th=
e library.

Week 6 :
	Modify =E2=80=98branch -l=E2=80=99 to use the library created as this =
can be done=20
without implementing the =E2=80=98--format=E2=80=99 options.

Week 7 :
	Implement =E2=80=98--format=E2=80=99 options in the library, by using =
the=20
implementation used by =E2=80=98for-each-ref=E2=80=99 as a reference.

Week 8 :
	Modify =E2=80=98for-each-ref=E2=80=99 to use the library.

Week 9 - 10 :
	Modify all three commands to include most of the selection and=20
formatting options.

Week 11 - 12 :
	Polishing of code.
	Write more tests and Documentation as and if required.
	Resolve any issues, if generated.

References :
[1] http://thread.gmane.org/gmane.comp.version-control.git/264911
[2] http://article.gmane.org/gmane.comp.version-control.git/265604
[3] http://thread.gmane.org/gmane.comp.version-control.git/230694/focus=
=3D2308
[4] https://github.com/peff/git/commits/jk/for-each-ref-contains-wip
