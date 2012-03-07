From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Approaches to SVN to Git conversion
Date: Wed, 7 Mar 2012 15:08:20 -0800
Message-ID: <CA+7g9JzETuynGMCRo1MLuNErFiFc3AmhGS6Hr+jO-hoV2j4JDg@mail.gmail.com>
References: <4F536FE9.1050000@pileofstuff.org>
	<3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail>
	<CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com>
	<4F5690FB.9060800@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:08:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5PyC-0006ry-6v
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416Ab2CGXIW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 18:08:22 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60569 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758720Ab2CGXIV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 18:08:21 -0500
Received: by bkcik5 with SMTP id ik5so5716669bkc.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 15:08:20 -0800 (PST)
Received: by 10.204.10.66 with SMTP id o2mr1841915bko.30.1331161700326; Wed,
 07 Mar 2012 15:08:20 -0800 (PST)
Received: by 10.205.34.9 with HTTP; Wed, 7 Mar 2012 15:08:20 -0800 (PST)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <4F5690FB.9060800@pileofstuff.org>
X-Gm-Message-State: ALoCoQlMAr0xG46rEoDaItLtVQaUr4YWuYNKA6t0qomSDf7GxWaRhuKc0XW3Yc/qTONe6gc15cGU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192499>

On Tue, Mar 6, 2012 at 2:34 PM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:
[snip]
> On 06/03/12 19:29, Nathan Gray wrote:
> <snip>
>>
>> The problem of specifying and detecting branches is a major problem =
in
>> my upcoming conversion. =A0We've got toplevel trunk/branches/tags
>> directories but underneath "branches" it's a free-for-all:
>>
>> /branches/codenameA/{projectA,projectB,projectC}
>> /branches/codenameB =A0 (actually a branch of projectA)
>> /branches/developers/joe/frobnicator-experiment (also a branch of pr=
ojectA)
>>
>> Clearly there's no simple regex that's going to capture this, so I'm
>> reduced to listing every branch of projectA, which is tedious and
>> error-prone. =A0However, what *would* work fabulously well for me is
>> "marker file" detection. =A0Every copy of projectA has a certain fil=
e at
>> it's root. =A0Let's call it "markerFile.txt". =A0What I'd really lov=
e is a
>> way to say:
>
> This is quite close to the implementation I've got. =A0The SVN export=
er
> runs in two stages:
>
> In the first stage, the script treats any non-blacklisted file as a
> marker file, but only looks for trunk branches. =A0It looks all throu=
gh
> the history, traces back through the copyfroms, and tries to find the
> original directory associated with the file. =A0Usually it decides th=
at
> the only branch without a copyfrom is /trunk. =A0Searching just for t=
runks
> with this weak heuristic makes it much easier to hand-verify the resu=
lt.

I'm not sure I understand.  So if I have /trunk/projectA and
/trunk/projectB then do I have to blacklist /trunk/projectB to extract
only projectA's history?  Assuming it's always lived there will your
code detect /trunk/projectA as the "trunk?"  Would it be possible to
specify /trunk/projectA directly instead of blacklisting everything
else?

> In the second stage, the script looks through the history again, trac=
ing
> the copies of known branches in a slightly less clever way than
> described in my previous e-mail. =A0There's no need for marker files =
this
> time round, as we just assume any `svn cp /trunk
> /directory/not/within/a/branch` is a new branch. =A0In my experiments=
 this
> has been a pretty solid way of detecting branches without too much hu=
man
> input - I might be missing something (or have mis-explained something=
),
> but I'd be interested to hear examples of where this would go wrong.

That sounds pretty good, but it should probably also be transitive,
i.e. `svn cp /any/known/branch/root /some/new/path` is also a new
branch.  Sometimes we'll spin off hotfix branches from release
branches, for example.

I'll have to give your code a try and see how it works.

Cheers,
-n8

--=20
http://n8gray.org
