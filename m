From: Richard Peterson <richard@rcpeterson.com>
Subject: Re: [Tagging Commits] feedback / discussion request
Date: Thu, 5 May 2011 11:39:41 -0400
Message-ID: <BANLkTinCxzXCmmtxXSM7=+yeve2hhLSYNQ@mail.gmail.com>
References: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com>
	<20110504084212.GB8512@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 17:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI0ed-0002J3-Gy
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 17:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab1EEPjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 11:39:45 -0400
Received: from edgy.cirtexhosting.com ([75.126.140.58]:38860 "EHLO
	edgy.cirtexhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab1EEPjo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 11:39:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41446)
	by edgy.cirtexhosting.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <richard@rcpeterson.com>)
	id 1QI0eg-0005pL-F8
	for git@vger.kernel.org; Thu, 05 May 2011 11:39:54 -0400
Received: by gyd10 with SMTP id 10so792316gyd.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 08:39:41 -0700 (PDT)
Received: by 10.236.194.73 with SMTP id l49mr3158412yhn.132.1304609981571;
 Thu, 05 May 2011 08:39:41 -0700 (PDT)
Received: by 10.147.98.11 with HTTP; Thu, 5 May 2011 08:39:41 -0700 (PDT)
In-Reply-To: <20110504084212.GB8512@sigill.intra.peff.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - edgy.cirtexhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - rcpeterson.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172839>

=46irst off, thanks for the awesome response, Peff, and Sverre and
Michael as well. Great stuff, and plenty that I had not thought of.

On Wed, May 4, 2011 at 4:42 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 03, 2011 at 07:36:51PM -0400, Richard Peterson wrote:
>
>> Here are some possible semantics you could assign to signing a commi=
t hash:
>>
>> * Making a verifiable claim of authorship of a commit
>> * Making a verifiable claim to have reviewed a commit or set of comm=
its
>> * Making a verifiable claim to have approved a commit or set of comm=
its for
>> some purpose
>> * Making some other verifiable claim about a commit TBD by your work=
flow
>> * Making a verifiable claim to have reviewed or approved the entire =
tree
>> under the commit
>
> Yeah, all of those make sense in certain workflows. But with the
> exception of authorship verification, they are not things you would w=
ant
> to do at _commit_ time,

Even authorship could be claimed after commit time too, for that matter=
=2E

> but rather something you say later about a
> commit. So I think fundamentally you are not interested in adding
> signatures to git commits themselves, but rather about making stateme=
nts
> about commits that happen to be signed. Which is good, because your
> problem is much easier. :)
>
> The nice thing is that git gives you a stable, cryptographically
> verifiable identifier for the commit. So all you have to do is mentio=
n
> it along with some metadata, sign it, and then store it somewhere.
>
> The first two parts can be as simple as something like:
>
> =A0(git rev-parse --verify HEAD
> =A0 echo "I reviewed this and it meets some standard X."
> =A0) | gpg --sign
>
> where probably you would want to define some kind of parsable metadat=
a
> format for your particular workflow.
>
> For storage, you basically have three options:
>
> =A01. Somewhere completely outside of git. There's no reason this nee=
ds
> =A0 =A0 to be stored in git at all, depending on your workflow. It ma=
y be
> =A0 =A0 simpler to keep it in some database related to your review sy=
stem
> =A0 =A0 (in fact, you may not doing anything cryptographic at all, bu=
t
> =A0 =A0 merely have a separate review system with a central database =
that
> =A0 =A0 mentions commits by sha1).

I see this as a useful option considering some poor souls in my
organization use Subversion, and we could factor out the audit / review
workflow to not depend on a single version control system.

On the other hand, it makes sense to keep data actually within git if i=
t
uses a git internal identifier as a key, and its useful to operate on i=
t with
the git tool set.

>
> =A02. In git tags. You can already do this with:
>
> =A0 =A0 =A0 git tag -s -m "I reviewed this" HEAD
>
> =A0 =A0 But tags aren't a good fit for a workflow that signs every co=
mmit
> =A0 =A0 (some of them perhaps even multiple times!). You end up with =
lots
> =A0 =A0 of tag refs.

Right - one of the reasons I don't like tags for this. Tags really just=
 don't
fit the bill, unfortunately.

>
> =A03. In git notes. You can do something like:
>
> =A0 =A0 =A0 (git rev-parse --verify HEAD
> =A0 =A0 =A0 =A0echo "I reviewed this"
> =A0 =A0 =A0 ) | gpg --sign -a |
> =A0 =A0 =A0 git notes add -F - HEAD
>
> =A0 =A0 though you'd probably want to be a little more complex, and h=
andle
> =A0 =A0 lists of signed notes for each commit. And you may want to st=
ore
> =A0 =A0 these in a separate notes ref from the default one.

I had looked at this option, but had failed to see the usefulness of us=
ing
a different ref. I was worried about cluttering things up, overloading =
the
intended purpose of notes, and so forth. I wasn't really sure if notes =
were
intended to be general purpose storage for systematic, structured data.

My inclination was to do this outside notes, or even in a parallel
implementation to notes, factoring out the common parts. I suppose that
looking at notes as somewhat of a free-for-all obviates this need. Is t=
his
really what notes are for?

>
> =A0 =A0 The advantage of notes are that they are designed for lots of
> =A0 =A0 per-commit storage, and can be accessed fairly efficiently.

That was my other concern about notes - performance. Not sure how
notes are stored, but I certainly trust you that they're efficient.

>
> So now you have your review storage system (or authorship, or whateve=
r
> metadata you want to stick in there). You can peek at it manually, of
> course, when you suspect something is not right. But you probably als=
o
> want to do automatic things, like making sure nothing goes into some
> branch "foo" that isn't signed with an authorship note.
>
> Assuming you are storing with git notes (if you are using some extern=
al
> system, replace the call to git-notes below with whatever database
> lookup you would want), you could use a pre-receive hook that did
> something like:
>
> =A0git rev-list $old..$new |
> =A0while read commit; do
> =A0 =A0git notes show $commit >tmp
> =A0 =A0gpg --verify tmp >data 2>siginfo || die "$commit: signature is=
 bad"
> =A0 =A0# ugh, is there really no better way to get this info from gpg=
?

See? We need functions for this stuff! I'll share whatever I come up wi=
th,
and maybe it will be useful in general.

> =A0 =A0perl -lne 'print $1 if /Good signature from "(.*)"/ siginfo >s=
igner
> =A0 =A0git show --format=3D"%an <%ae>" $commit >author
> =A0 =A0cmp author signer || die "$commit: signer and committer don't =
match"

Yes this needs to be handled robustly. The signer would need to be told
at sign-time if his signature didn't match.

> =A0 =A0test "`head -n 1 data`" =3D $commit ||
> =A0 =A0 =A0die "$commit: signed commit does not match"
> =A0done
>
> And obviously that is hacked together and you would want something mo=
re
> robust,

Thank you - this is all solid stuff to get me started.

> and you'd need to handle the web of trust for the signing keys
> somehow (though I think that is external to this script, and is about
> setting up the desired keyring). But I hope it gives a sense of what =
you
> can do. You could also replace gpg completely with something like
> openssl using x.509 certs, if that makes more sense to your
> organization.

You read my mind. Everybody in my organization has a set of x.509 certs
on smartcards. That's phase 2 of my project.

>
> Developers would have to make a note and push their notes tree first,

You mean for hook / verification purposes? Or is there some underlying
reason to push notes first?

> and then push their actual commits into a branch (and you might want =
to
> do some verification on the notes they push, like checking that entri=
es
> for commit $X actually contains signatures for $X, or that the signer
> identity matches some ssh credential, or that the pusher isn't deleti=
ng
> any signatures or erasing note history).
>
> I suspect you already thought through some of this already. But I wan=
ted
> to start with first principles, because I really don't think this is =
a
> _git_ problem as much as it is a _workflow_ problem. So it's importan=
t
> to first define the workflow you want, and then think about how git c=
an
> help. Stable commit identifiers already provide much of the basis. I
> think notes provide a nice storage format that is efficient and
> push-able to other repos (though in a centralized shop, some other
> database might make sense, too). What really remains to be done is:
>
> =A01. Define the metadata format that encapsulates what you want to s=
ay
> =A0 =A0 about commits.
>
> =A02. Write scripts to help developers and reviewers make these notes=
,
> =A0 =A0 and verify them. =A0Write hooks to implement policy on lettin=
g
> =A0 =A0 commits into certain branches, as above.
>
> And both of those happen outside of git (though if you write them in =
a
> generic enough form, I'm sure people on the list would be very happy =
to
> see them shared).

I'll be sure to share.


>
>> There are 200 developers working on a financial trading system, and =
each of
>> them has the opportunity to slip malicious code into the project. Wh=
en the
>> final release is prepared, the project lead signs the tip commit, th=
us
>> signing the whole tree. Now it is discovered that someone did slip s=
ome
>> malicious code in. =A0How do you audit the system? Could higher leve=
ls of
>> individual accountability have discouraged this scenario?
>
> I like this example. It shows that signing a commit is not really
> meaningful by itself; you have to understand the semantics of that
> signature (and maybe they're included as comments in the tag object, =
or
> maybe it is assumed by your organization's workflow).
>
> In the case of the kernel, Linus signing a commit with a tag implicit=
ly
> means "I think what is in this tree and everything before it is good,=
 so
> you should feel comfortable using it" (or at least insofar as you tru=
st
> Linus).
>
> But it doesn't have to be that way. Your project lead signing may mea=
n
> "this is good and we should ship it". But developers signing commits =
may
> simply mean "I promise that I wrote the changes between this commit's
> tree and its parent". Those are all signatures of commits, but they m=
ean
> very different things; the key is adding metadata to know which is
> which.
>
>> I've seen it argued that a proper SSH setup and user management are =
the key.
>> These are good for security and access control, but not for some dur=
able
>> form of accountability.
>
> Right. You are trusting the server's records, not cryptography. The m=
ain
> advantage is that it's efficient and easy to set up. :)

The main reason this doesn't work for me is that codebases are passed a=
round
my organization like hand-me-down clothes. It is not unheard of to get =
the
entire repository for a critical application delivered from one shop to=
 another
on CD. We need to be able to verify the integrity of a repository entir=
ely
independently of any outside information.  The only centralized source =
of trust
in our organization is the certificate authority.

Now my big question to ponder: what do do when the CA expires a cert? H=
mm...


>
>> It seems that creating a signed tag is the same as signing a commit.=
 =A0There
>> are a few problems, though. =A0Tags don't provide a secure means of =
asserting
>> the type of signature being applied to the commit hash. That is - is=
 the
>> hash signed because someone is claiming authorship? Because they are
>> asserting the integrity of the entire tree? Because they have review=
ed the
>> code? Because they reviewed a certain subset of the tree? Of course =
there's
>> also the issue that tags live in a cluttered namespace. Signing a co=
mmit is
>> essentially a different thing from providing a name for a commit. Us=
ing tags
>> just to sign commits requires a glut of tag names.
>
> Again, metadata. Say what you mean in the free-form content of the ta=
g.
> For the kernel, there is nothing to be said. Linus signing tags has a
> well-known meaning in the community. But in an organization signing f=
or
> a lot of different reasons, you would want the signed data to say why=
 it
> was signed.
>
>> I propose expanding the concept of tags, or alternately creating a n=
ew
>> concept which subsumes the existing tag concept. I'll call this new =
concept
>> a "sig" for the purposes of this discussion. The concept of a sig cr=
oss-cuts
>> the concept of a tag.
>>
>> A tag signs the commit hash. A sig signs a SHA1-based absolute commi=
t
>> reference with a (possibly null) string concatenated to it. For inst=
ance, a
>> sig might sign the following string:
>
> A tag can already include arbitrary data.
>
> In fact, tags basically do what you want already; it's just that stor=
ing
> one tag ref per commit is going to be ugly. It might make sense to
> replace the ad-hoc gpg signatures I used in my examples above with ta=
g
> objects, and then store the tag object in the notes tree.
>
>> "0b9deecf625677cf44058a42c2abd7add5167e81^0 author"
>> which would mean that the signor is claiming authorship of that indi=
vidual
>> commit. (Suggestions for notating a single commit are welcome. "^0" =
seemed
>> natural.)
>
> See? You're defining metadata now. :)
>
>> * What on earth does it mean to tag a range of commits? With commit =
ranges
>> being siggable, and tags containing sigs, what does it mean to tag a=
 range
>> of 10 commits, for instance? Is that desirable? Does it make any sen=
se
>> whatsoever? Does it hurt anything if it happens?
>
> It's slightly more efficient. If I wrote 10 commits, I can either sig=
n
> each individually saying "I wrote this", or I can make a single
> signature showing them all. The tradeoff is that parsing and verifyin=
g
> metadata becomes a lot more complex. But crytographically speaking, a
> range is not ambiguous;
>
>> * Performance? I think it would be extremely quick to verify a bunch=
 of
>> sigs, but I don't know. Maybe I'm not thinking clearly about it.
>> Fortunately, sigs can be ignored entirely and need not affect things=
=2E
>
> Compared to usual git operations, no, it's not quick. But you don't h=
ave
> to verify all the time. You can verify commits when they enter your
> repo, or when you're interested in some aspect of them, or when you
> suspect something fishy is going on. You don't have to do it on every
> rev-list.

Good point. I had thought it would be something to see every time I run
git-log, but I suppose it makes perfect sense to do this thing in the n=
ightlies
or some other rarer occasion.

Thanks,

Richard Peterson
