Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B242BC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355772AbiBULMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:12:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355419AbiBULMY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:12:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D10633B
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645440372;
        bh=+wDFIZjX9YQg9XHb79fIHgdm9GMcBZcq7qtx14YJ/nw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VT8BDOal80ATHVpP6h1WN2uPe+tm3LhqEM8NUC+LJMQIDaJQoYdDZkySKS4zVHJNv
         pG3gJjEQsCNi6eOasf8/KuxQHTwMY3gG9LXRTyD38LRwo+ws/XBVX6czoq/7zk2ita
         fEeud4/94XsYZy9Qb28X8i8ImCaxk5xk6BpWk9As=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1nipZh0MPF-00WHdH; Mon, 21
 Feb 2022 11:46:12 +0100
Date:   Mon, 21 Feb 2022 11:46:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HJI7boHxr/DvG+UcOFTUUAkX2DxhQ7fUfHS1TRp+spXr9JogIam
 jXOR16IvelcpMNhhS+YE/UAhJ5txi2t2I68NHOt2zNiFHamqGhSWqlf6J6a2QtyRHCRaP/9
 YOxrXYsEDSSwiKilvt5OTPbb466FmhoA3ny2FR7b5LaLv8TKcGGQD5UXIKLQuvMbxobmP/6
 oplOGzF3eHzmM5TogWgxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kvZycZKbnVY=:YeAvvvbRnwg7+SNYv3HNWf
 TRGwx8TmXq+ShhFhV8v2XbN0JNLW/Fmxi6Lmd2fOQo4JNiE/9xCUrdKXBLFt/XGDjuoaRq9P+
 vlVas52EbD/SGx8GUvfRkYL3DfBsY5hLgUFpoHaXYQ2eNP0EWmLhzN1YLDwNV1AIRrG1fXH6i
 9Cde5kEYyWceVMuTtNMmhKJapFAFA8lGNnW1mOrcaFO5d7KKNytyWhUt1pv9EnFa8vKkPB/CL
 NYslYP5FuNDbNNs8X7VzxQSWtfClfVBYxK2nbU09DmvmzoF5AEaCeiQ700kZJV/RLv8aycKDM
 Si7ZG1XGbN3tkvbJwdk90BH9J08CD/bieLkjEDRWqXEvk/kWWOkVanjJeBWLzbPMZjbuKZulo
 8W7MY79H+I+FX4U0/whdgezTqMz1hQrIpDqe3QBicAvAQ7SyJo01L6R1nG15LhjQg40JgCGUV
 bXWImyPCjeRlZNQoR9ELTDqtKO3IXA/Mu2xCOE7tRjWx8hKIUQ6Z62RFuPfsuCM8YMaM/Ivj7
 HhLq1jj9BP8OUk7bo6yrBMYVTlrDele9VX9QXBQ2D+13KLTYux3FVKGndyXPb7SKvYsi1VyTS
 Q1Eba/VrkE+Kq/D3pPFuDdeRCz15ASMuDm79j0GcHlJwOZh0JNsw+ZAagvtuSaTGq8GGlPffA
 oj1xluUeNQI2qADjMzF1CHXP4z+ffXfcGrfMwlLgJqGMhVKdsfCuwAeos6UYGIf1nh0yL6gNX
 I84XtcraQhFK0JzZuhJjNylH3tHltbcJrUMlqQJRMZWsGN9BoMkcl2mMc53I0rzf161cem0FG
 4Zkzmm0POSo65YP2DSHq3uuGmno00Xq7X7K1aJmN1QzAziE2QpS5ZtElPwzZ3tgaXTiE0HBxY
 Mm8Epkky8MVuAfstLP2MAUlXcNhjcU+elMn7UmvDfQd9OCH5UIKgQLR7Gf18Cpa3GOjyW087v
 UYNisZMWeXQSqjPFUN8xKCs3GXOXR718ARHwXTdLO9Zv8t5OBAldBEDkn++bCCgLO1ARxVFdF
 H3FiyeLrxAoA7w1gxX0qNw8dw4LSQ8K2FMlXq0oYP19Zi4fQj9byDcQI9S+wAOup6eQYQndBx
 5rZErzkYXHRZw0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 4 Feb 2022, Elijah Newren wrote:

> On Fri, Feb 4, 2022 at 3:10 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 29 Jan 2022, Elijah Newren wrote:
> >
> > > On Sat, Jan 29, 2022 at 12:23 AM Johannes Sixt <j6t@kdbg.org> wrote:
> > > >
> > > > Just a heckling from the peanut gallery...
> > > >
> > > > Am 29.01.22 um 07:08 schrieb Elijah Newren:
> > > > > On Fri, Jan 28, 2022 at 8:55 AM Johannes Schindelin
> > > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > >> Meaning: Even if stage 3 is missing from the first conflict and=
 stage 1 is
> > > > >> missing from the second conflict, in the output we would see st=
ages 1, 2,
> > > > >> 2, 3, i.e. a duplicate stage 2, signifying that we're talking a=
bout two
> > > > >> different conflicts.
> > > > >
> > > > > I don't understand why you're fixating on the stage here.  Why w=
ould
> > > > > you want to group all the stage 2s together, count them up, and =
then
> > > > > determine there are N conflicting files because there are N stag=
e 2's?
> > > >
> > > > Looks like you are misunderstanding Dscho's point: When you have t=
wo
> > > > conflicts, the first with stages 1 and 2, the second with stages 2=
 and
> > > > 3, then the 2s occur lumped together when the 4 lines are printed =
in a
> > > > row, and that is the cue to the parser where the new conflict begi=
ns.
> > > > Dscho did not mean that all N 2s of should be listed together.
> > >
> > > Ah, so...I didn't understand his misunderstanding?  Using stages as =
a
> > > cue to the parser where the new conflict begins is broken; you shoul=
d
> > > instead check for when the filename listed on a line does not match
> > > the filename on the previous line.
> >
> > But that would break down in case of rename/rename conflicts, right?
> >
> > > In particular, if one conflict has stages 1 and 2, and the next conf=
lict
> > > has only stage 3, then looking at stages only might cause you to
> > > accidentally lump unrelated conflicts together.
> >
> > Precisely. That's why I would love to have a way to deviate from the
> > output of `ls-files -u`'s format, and have a reliable way to indicate
> > stages that belong to the same merge conflict.
>
> Ah, attempting to somehow identify and present logical separate
> conflicts?  That could be awesome, but I'm not sure it's technically
> possible.  It certainly isn't with today's merge-ort.
>
> Let me ask some questions first...
>
> If I understand you correctly then in the event of a rename/rename,
> i.e. foo->bar & foo->baz, then you want foo's, bar's, & baz's stages
> all listed together.  Right?  And in some way that you can identify
> them as related?

Yes, that was kind of my idea ;-)

> If we do so, how do we mark the beginning and the end of what you call
> "the same merge conflict"?  If you say it's always 3 stages (with the
> possibility of all-zero modes/oids), then what about the rename/rename
> case above modified so that the side that did foo->baz also added a
> different 'bar'?  That'd be 4 non-zero modes/oids, all of them
> relevant.  Or what if the side that did foo->bar also renamed
> something else to 'baz', giving us even more non-zero stages for these
> three paths?  Perhaps you consider these different conflicts and want
> them listed separately -- if so, where does one conflict begin and
> another start and which stages are parts of which conflict?

Thank you for calling me out on an only half-finished thought.

To be quite honest, I previously did not have much time to think of the
non-trivial nature of representing merge conflicts in a web UI when
performing merges with rename detection, in particular when performing
_recursive_ merges (where, as you point out so correctly, an arbitrary
number of rename conflicts can happen _for the same file_).

Of course, this gets even more complicated when we're also thinking about
type changes (file -> symlink, file -> directory, and vice versa).

> If you are attempting to somehow present the stuff that "belongs to
> the same merge conflict" are you also trying to identify what kind of
> merge conflict it is?  If so, do you want each type of merge conflict
> listed?  For example, let's switch from the example above of logically
> disjoint paths coming together to result in more than 3 stages, and
> instead pick an example with a single logical path with less than
> three stages.  And now let's say that path has multiple conflicts
> associated with it; let's use an example with 3: rename/delete +
> modify/delete + directory/file (one side renames foo->bar while
> modifying the contents, the other side deletes foo and adds the
> directory 'bar/').  In this case, there is a target file 'bar' that
> has two non-zero modes/oids in the ls-files-u output.  If all three
> types of conflicts need to be listed, does each need to be listed with
> the two non-zero modes/oids (and perhaps one zero mode/oid), resulting
> in six listings for 'bar'?  Or would the duplication be confusing
> enough that we instead decide to list some merge conflicts with no
> stages associated with them?
>
> Thinking about both sets of questions in the last two paragraphs from
> a higher level -- should we focus on and group the higher order stages
> by the individual conflicts that happen, or should we group them by
> the paths that they happen to (which is what `ls-files -u` happens to
> do), or should we not bother grouping them and instead duplicate the
> higher order stages for each logical conflict it is part of?
>
> As an alternative to duplicating higher order stages, do we sometimes
> decide to "lump" separate conflicts together and treat them as one
> conflict?  If so, what are the rules on how we decide to lump
> conflicts and when not to?  Is there a bright line boundary?  And can
> it be done without sucking in arbitrarily more stages for a single
> conflict?
>
>
> Some testcases that might be useful while considering the above
> questions: take a look at the "rad", "rrdd", and "mod6" tests of
> t6422.  How many "same merge conflicts" are there for each of those,
> and what's the boundary between them?  And can you give the answer in
> the form of rules that generically handle all cases, rather than just
> answering these three specific cases?
>
>
> I've thought about this problem long and hard before (in part because
> of some conversations I had with Edward Thompson about libgit2 and

Not a big deal for _me_, but I seem to remember that Ed cared a lot about
having no p in their surname ;-)

> merging at Git Merge 2020).  It wasn't at all clear to me that libgit2
> had considered anything beyond simple rename cases.  The only rules I
> ever figured out that made sense to me was "group the stages by target
> filename rather than by logical conflict" (so we get `ls -files -u`
> populated) and print a meant-for-human message for each logical
> conflict (found in the <Informational Messages> section for
> merge-tree), and make NO attempt to connect stages by conflict type.
>
> I'm sure that's not what you wanted to hear, and maybe doesn't even
> play nicely with your design.  But short of ignoring the edge and
> corner cases, I don't see how to solve that problem.  If you do just
> want to ignore edge and corner cases, then just ignore the
> rename/rename case you brought up in the first place and just use
> `ls-files -u`-type output as-is within your design.  If you don't want
> to ignore edge cases and want something that works with a specific
> design that somehow groups conflicted file stages by conflict type,
> then we're going to have to dig into all these questions above and do
> some big replumbing within merge-ort.

There is sometimes a big difference between what I want to hear and what I
need to hear. Thank you for providing so many details that I needed to
hear.

So let's take a step back and look at my goal here, as in: the
over-arching goal: to use merge-ort on the server side.

=46rom what you said above, it becomes very clear to me that there is very
little chance to resolve such conflicts on the server side.

For example, if a topic branch renames a file differently than the main
branch, there is a really good chance that the user tasked with merging
the topic branch will have to do a whole lot more than just click a few
buttons to perform that task. There might very well be the need to edit
files that do not contain merge conflict markers (I like to call those
cases "non-semantic merge conflicts"), and almost certainly local testing
will be necessary.

So I guess the best we can do in those complicated cases is to give a
comprehensive overview of the problems in the web UI, with the note that
this merge conflict has to be resolved on the local side.

Which brings me to the next concern: since `merge-tree` is a low-level
tool meant to be called by programs rather than humans, we need to make
sure that those messages remain machine-parseable, even if they contain
file names.

Concretely: while I am not currently aware of any web UI that allows to
resolve simple rename/rename conflicts, it is easily conceivable how to
implement such a thing. When that happens, we will need to be able to
teach the server-side code to discern between the cases that can be
handled in the web UI (trivial merge conflicts, trivial rename/rename
conflicts) as compared to scenarios where the conflicts are just too
complex.

Here's an excerpt from t4301:

=2D- snip --
Auto-merging greeting
CONFLICT (content): Merge conflict in greeting
Auto-merging numbers
CONFLICT (file/directory): directory in the way of whatever from side1; mo=
ving it to whatever~side1 instead.
CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in =
side1.  Version side1 of whatever~side1 left in tree.
=2D- snap --

This is the complete set of messages provided in the `test conflict
notices and such` test case.

I immediately notice that every line contains at least one file name.
Looking at https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1899, it
does not seem as if the file names are quoted:

		path_msg(opt, path, 1, _("Auto-merging %s"), path);

(where `path` is used verbatim in a call to `merge_3way()` before that,
i.e. it must not have been quoted)

I would like to register a wish to ensure that file names with special
characters (such as most notably line-feed characters) are quoted in these
messages, so that a simple server-side parser can handle messages starting
with `Auto-merging` and with `CONFLICT (content): Merge conflict in `, and
"throw the hands up in the air" if any other message prefix is seen.

Do you think we can switch to `sq_quote_buf_pretty()` for these messages?
For the `Auto-merging` one, it would be trivial, but I fear that we will
have to work a bit on the `path_msg()` function
(https://github.com/git/git/blob/v2.35.1/merge-ort.c#L630-L649) because it
accepts a variable list of arguments without any clue whether the
arguments refer to paths or not. (And I would be loathe to switch _all_
callers to do the quoting themselves.)

I see 28 calls to that function, and at least a couple that pass not only
a path but also an OID (e.g.
https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1611-L1613).

We could of course be sloppy and pass even OIDs through
`sq_quote_buf_pretty()` in `path_msg()`, knowing that there won't be any
special characters in them, but it gets more complicated e.g. in
https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1648-L1651, where we
pass an `strbuf` that contains a somewhat free-form commit message.

I guess we could still pass those through `sq_quote_buf_pretty()`, even if
they are not paths, to ensure that there are no special characters in the
machine-parseable lines.

What do you think?

Ciao,
Dscho
