From: Johan Herland <johan@herland.net>
Subject: Re: Premerging topics (was: [RFD] annnotating a pair of commit objects?)
Date: Tue, 23 Apr 2013 08:34:42 +0200
Message-ID: <CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 08:35:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUWok-0008At-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 08:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab3DWGev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 02:34:51 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:50471 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab3DWGeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 02:34:50 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUWoQ-0009Ra-PL
	for git@vger.kernel.org; Tue, 23 Apr 2013 08:34:46 +0200
Received: from mail-oa0-f49.google.com ([209.85.219.49])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUWoQ-000A1j-DZ
	for git@vger.kernel.org; Tue, 23 Apr 2013 08:34:46 +0200
Received: by mail-oa0-f49.google.com with SMTP id j1so240121oag.22
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 23:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tiGtyC+EYTUG2KAzp6VOC8uvGB5d1HlahU6+fItggRk=;
        b=EqyEp5bIzzgMbT6ntntZwcH5M9Jk8UAYxOwMAKUaT7vbnVNa6oesDDIOlD6dzHvxIn
         JYPQmzS3otKai+I8vMITG5/a1v5GMA40Xc+Zk212IgA2P+aYbkF7x/GdLpR16oaT4MZ9
         uuV9qmZk04i57jqqml0ewsGsuQx1MhsMGsnHildkjksSzO0nbfVp4ewVeFJ1mx44WRwh
         Cw7umaUe8IJjkVucLaxTHqTxxM9kmLj12Wou9Q5DYV1MwlLttU561VbTB3lhUgEQyJG2
         Yj2a2UwHWOgdE1Zo5oyEJDtmR1VLbJjqYRw6E10HvngAwU7rbu8Kfbsq1WgFVeeJ23Fa
         +N2Q==
X-Received: by 10.60.28.2 with SMTP id x2mr16218155oeg.65.1366698883069; Mon,
 22 Apr 2013 23:34:43 -0700 (PDT)
Received: by 10.182.210.233 with HTTP; Mon, 22 Apr 2013 23:34:42 -0700 (PDT)
In-Reply-To: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222135>

On Wed, Apr 10, 2013 at 10:35 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> The goal is to propose a structure for storing and pre-merging pairs of commits.
>
> Data-structure
> ==============
>
> We could use a note ref to store the pre-merge information. Each commit
> would be annotated with a blob containing the list of pre-merges (one
> sha1 per line with sha1 pointing to a merge commit). The commit on the
> other side of a merge would also be annotated.
> The choice of the refname could be done like we do with notes:
> - Have a default value
> - Have a default value configured in config
> - Use a specific value when merging/creating the pre-merges
>
> Here are my concerns:
>
> Pros
> ----
> 1. Notes allow dynamic annotation a commit
> 2. If we manage to fix 4, we can easily download all pre-merges from a
> remote host by fetching the ref (or clean by deleting the ref).
> 3. Conflicts on pre-merge notes could probably be resolved by concatenation.
>
> Cons
> ----
> 4. Checking connectivity means opening the blob and parsing it

Can you solve this problem with a tree object, instead of inventing a
specially-formatted blob?

I.e. given pre-merge info P for a merge between commits A and B: A is
annotated by a tree object that contains all pre-merges where A is
involved. Each entry in the tree object has a filename and a blob
SHA1; we store other commit involved in this pre-merge (B) in the
filename, and the pre-merge data (P) in the blob SHA1.

Conversely, B is annotated with a tree object containing all pre-merge
entries concerning B, and within there, is an entry called A, pointing
to the same P.

You still need "special handling" in that you have to know that
"refs/notes/pre-merge" (or whatever it's called) stores tree objects
instead of blobs, and how to interpret the contents of those trees,
but you'll need such knowledge in any case.

A nice side-effect of using tree objects to store pre-merge entries,
is that you can do a tree-level merge of them, and it'll do the Right
Thing (assuming two-way merge with no common history), i.e. perform a
union merge, and leave you to handle conflicts of individual
pre-merges (i.e. you'll only get conflicts when both sides offer
different pre-merge data for A + B).

> 5. Regular notes and pre-merge notes have to be handled separately
> because of 4.

Sort of, but you get that for any automated usage of notes for a
specific purpose. Just look at the notes-cache mechanism in
notes-cache.{h,c}. That's another example of functionality layered on
top of notes that makes assumptions on how its notes trees are
structured.

> I'm hoping we can keep the pros and avoid the cons, but I'm kind of
> stuck here. Help would be really appreciated (or maybe this is a totally
> wrong direction, and I would also like to know ;)
>
> Merging (Using what we saved)
> =============================
> The goal is to merge branches J and B using existing pre-merges.
>
> E0. Create an empty stack S
> E1. Create set of commits 'J..B' and 'B..J' (that is probably already done)
> E2. For each commit C in smallest(J..B, B..J), execute E3
> E3. For each premerge P in notes-premerge(C), execute E4
> E4. If one of both parents of P belongs to biggest(J..B, B..J), stack P in S

I don't think _both_ parents of P can belong to biggest(J..B, B..J).
AFAICS J..B and B..J must always be completely disjoint sets of
commits (this is easier to see when you consider that "A..B" is
equivalent to "B ^A" for any commits A and B), and in E2/E3, you have
already made sure that P has a parent in one of them. There is then no
way that the same parent can occur in the other set, so you have at
most _one_ parent in the other set.

> E5. Merge J and B using all pre-merges from S

This is where things get complicated... :)

First there is one important thing that I have not seen a decision on
yet (maybe this was discussed in an earlier thread?):

Given pre-merge data P for commit A and B, does P encode the merge of
the entire history up to A with the entire history up to B, or does it
only encode the merging of the changes introduced in A with the
changes introduced in B? In other words, are we merging snapshots or
diffs?

In the former case, we only need to find the most recent commits A and
B on their respective branches - for which P exists - and then execute
that one P (or at most two Ps, if there is a criss-cross pre-merge
situation). In the other case, however, we need to enumerate all Ps
that apply to the two branches, and find a way to execute them
chronologically, dealing with missing Ps and conflicting Ps along the
way. IMHO, only the former approach seems practically solvable.

So you do not need to enumerate all Ps in J..B vs. B..J, you only need
to find the _most_ _recent_ P, and execute that one.

> Let's consider that |J..B| is smaller than |B..J|.
> E0 is executed only once
> E1 is O(|J..B| + |B..J|)
> E2 is O(|J..B|)
> E3 is O(|J..B| x the average number of pre-merge per commits P_avg)
> E4 is executed for each parent (let's say it's two/constant, after all
> the topic is "pair" of commits), so still O(|J..B| x P_avg)
> E5 I don't know (how it can be done, and what would be the resulting
> time complexity)
>
> So the time cost for steps E0 to E4 is O(|J..B| + |B..J| x P_avg)
>
> Tools (Save the pre-merges)
> ===========================
>
> Of course we need several tools to maintain the list of premerges, and
> to easily compute them. For example, it would be nice to be able to do
> something like:
>
>     $ git pre-merge topicA topicB topicC
>
> to find, resolve and store all interactions between the topics.

Let's leave out octopus merges for now, and only concentrate on two
branches at a time.


Hope this helps,

...Johan


PS: Could you also use this mechanism to store rerere information?


> We could
> then easily derive to something that would allow to pre-merge a new
> topic with all topics already merged in master..pu (for example).
> Anyway, this task is left for latter.

--
Johan Herland, <johan@herland.net>
www.herland.net
