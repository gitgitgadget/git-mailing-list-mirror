From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 18:02:37 -0700
Message-ID: <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Thu Nov 03 02:03:02 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RLlht-00064f-9N
	for lnx-linux-ide@lo.gmane.org; Thu, 03 Nov 2011 02:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab1KCBC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;lnx-linux-ide@m.gmane.org>); Wed, 2 Nov 2011 21:02:59 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49610 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab1KCBC7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2011 21:02:59 -0400
Received: by ggnb2 with SMTP id b2so746209ggn.19
        for <multiple recipients>; Wed, 02 Nov 2011 18:02:58 -0700 (PDT)
Received: by 10.147.154.20 with SMTP id g20mr1661767yao.15.1320282178109; Wed,
 02 Nov 2011 18:02:58 -0700 (PDT)
Received: by 10.147.167.9 with HTTP; Wed, 2 Nov 2011 18:02:37 -0700 (PDT)
In-Reply-To: <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184688>

On Wed, Nov 2, 2011 at 13:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Nov 1, 2011 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>> But on the other hand, in many ways, publishing your commit to the o=
utside
>> world, not necessarily for getting pulled into the final destination
>> (i.e. your tree) but merely for other people to try it out, is the p=
oint
>> of no return (aka "don't rewind or rebase once you publish"). =A0"pu=
shing
>> out" might be less special than "please pull", but it still is speci=
al.
>
> So I really think that signing the top commit itself is fundamentally=
 wrong.

I really disagree. I like the signed commit approach. It allows for a
lot more workflows than just providing a way for you to validate a
pull from a trusted lieutenant. Debian/Gentoo folks want a way to sign
every commit in their workflow. Just because you don't want that and
think its crazy doesn't mean its not a valid workflow for that
community and is something Git shouldn't support. I never use `git
stash`. I hate the damn command. Yet its still there. I just choose
not to use it. Junio's gpgsig header on each commit is also optional,
and communities/contributors can choose to use (or ignore) the feature
as they need to.

> That commit may not even be *yours*. You may have pulled it from a
> sub-lieutenant as a fast-forward, or similar. Amending it later would
> be actively very very *wrong*.

Obviously you shouldn't amend a commit that would otherwise be a
fast-forward. But why not write a new empty signed commit on top, and
teach `git log` without the verify signatures flag to skip over
commits that have a gpgsig header line, have exactly one parent, and
whose parent tree matches the commit's own tree? This removes these
commits from the normal `git log` revision output, but yet the flow of
changes is still very visible within the history.

As I understand it, the point of multiple Signed-off-by lines in
commit message bodies is to show the flow of a change, who reviewed
and applied a given commit, until it finally lands in a tree where its
commit SHA-1 is frozen in stone and you can later pull it. The empty
signed commit on top of a fast-forward provides that same flow of a
change, readily visible with standard `git log` tools, but doesn't
have to clutter up history if we teach log how to skip this particular
type. Similar to the --no-merges way to skip merges. :-)

> So quite frankly, I think the stuff in pu (or next?) is completely
> mis-designed. Doing it in the commit is wrong for fundamental reasons=
,
> which all boil down to a simple issue:

Totally disagree. I'm really in favor of embedding these into the
commit headers the way Junio has done.

> =A0- you absolutely *need* to add the signature later. You *cannot* d=
o
> it at "git commit" time.

Why can't you add it at commit time? What is stopping me from running
`git commit -S` every time I make a commit? Is it that my fingers will
wear out more quickly because I have to type my pass-phrase too often?

What is wrong with making a signed commit on a commit I have a high
level of confidence in, but not signing the others? In my own workflow
I make a lot of commit --amends  / rebases until I am pretty confident
in the code being written and organized the way I think it should be
for distribution to others. But at some point in that workflow I'm
doing an --amend or a rebase to make that last final touch, and during
that commit I can add -S to make it signed, because I'm pretty certain
its ready to go. At that point, barring some horrific bug or reviewer
comments, I am unlikely to change the commit. I know at the time I
make that commit that I am pretty confident in the commit, so I take
the extra few key strokes to sign it.

> That's a fundamental issue both from a "workflow model" issue (ie you
> want to sign stuff after it has passed testing etc,

Why do I have to wait until its tested to sign it? The gpgsig
signature isn't any more special than the Signed-off-by line I put
into my commit message to agree to the developer's certificate of
origin, nor is it any more special than the committer line in the
commit header. Its just a statement on the commit that I have a
reasonable enough confidence in the value of this particular commit
and its ancestors that I should take the time to unlock my GPG key and
sign the content in case I do distribute this to others.

If you are going to spend time testing a commit, its probably going to
take longer to perform that testing than it is to perform the GPG key
unlock and signature. So why are you complaining about the time it
takes to sign something you think is worthy of testing?  If the tests
fail, you'll need to rewind/amend/whatever to address the breakage. If
the tests pass, the commit is already signed and ready for
distribution. If you are spending a lot of time signing commits that
are highly likely to fail tests, well, maybe you should look at other
ways to improve your workflow so that you have a higher level of
confidence in the code you record and assume will be a permanent part
of the project's history.

> but you may need
> to commit it in order to *get* testing),

Maybe consider allowing a ".dirty" suffix like git-core does on
builds? Or if you are submitting the code to a remote test cluster
that auto-compiles the code for you (and that is why you need a
commit), it sounds like the time it takes for that to push, compile,
test, and report back is way higher than the time it takes to make the
signature. So you probably should only be submitting something that
you had a reasonable level of confidence in. So you should go ahead
and sign it before sending it for testing, in case the tests do pass
and you want to publish that commit.

> as well as from a
> "fundamental git datastructures" issue (ie you would want to sign
> commits that aren't yours.

Sure. But this is why you can make an empty commit and sign that.

> "git commit --amend" is not the answer - that destroys the fundamenta=
l
> concept of history being immutable, and while it works for your local
> commits, it doesn't work for anybody elses commits, or for stuff you
> already pushed out.

Nobody said you had to amend everything. You can add an empty commit.

> And "add a fake empty commit just for the signature" is not the answe=
r
> either - because that is clearly inferior to the tags we already had.

Really? I disagree. The commit DAG scales quite well. The tag
namespace does not. A refs/signatures/$COMMIT_SHA1 namespace also does
not scale well.

An empty commit with a gpgsig header has about the same object cost as
an annotated tag once packed. But it has the advantage that the damn
thing doesn't clog up the reference space, the reference handling
code, or the advertisements in the native protocol. As history goes
on, older signatures are less relevant, and automatically are
avoided/skipped/bypassed by the normal DAG walking code. Tags don't do
this well because they have no relationship to the project history.

The only downside to an empty commit with the gpgsig header is I
cannot grab an arbitrarily deep ancestor and say "Who has signed a
commit that depends on this"? Today we already have this with git
describe --contains (aka git name-rev) for annotated tags. Its a new
feature we have to teach to some part of the log machinery, but the
algorithm will be easier because it doesn't have to mess with the
mapping table of tag objects. It just has to start digging from roots,
remembering each commit that has a gpgsig on any given branch path,
and then outputting the matches when it finds the commit in question.

The commit approach also has the advantage that your tree
automatically carries any lieutenant's signatures, by virtue of them
already being frozen in the commits.  This allows anyone downstream of
you to verify the same signatures, and check them against their own
keyring contents. If the signatures are all detached in some transient
annotated tag space, its impossible for anyone other than you to
verify pull requests. I would hate to say we have this nice
distributed version control system, but only Linus can prove the pull
requests in his repository are what they claim, and we have to then
implicitly trust you to resign that data without the original
signatures being present. $DAY_JOB would feel a lot better about the
integrity of the Linux kernel repository if _ANYONE_ can validate pull
requests offline after they have happened.

> I dunno. Did I miss something? As far as I can tell, the signed tags
> that we've had since day one are *clearly* much better in very
> fundamental ways.

Completely disagree. :-)
