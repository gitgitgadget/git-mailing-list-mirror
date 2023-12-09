Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YWrz3VPm"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3407613A
	for <git@vger.kernel.org>; Sat,  9 Dec 2023 08:13:52 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E86B1CFF14;
	Sat,  9 Dec 2023 11:13:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aSoFJSi1OCy08LXa+S01NajrbSspm9RdraFPfH
	+Qic8=; b=YWrz3VPmF3nxFgP47GoyFKtHlKJvzbzS8R0m8zKpvDXRWesMhO8l79
	QfWfcl/BghJSFKZXuf5/wyS0BsLxsfzlzs+jV0ICpSzoFKbhoTNB7zRdH7cVo4BA
	UoQzKq1CVSbwMgnOiLVbVP1k7pqOG1fFoScJpkcVmmn/WaUhodPmc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 767691CFF13;
	Sat,  9 Dec 2023 11:13:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D223F1CFF12;
	Sat,  9 Dec 2023 11:13:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Britton Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
    Matthieu Moy <git@matthieu-moy.fr>
Subject: Re* [BUG] git-bisect man page description of terms command doesn't
 mention old/new support
In-Reply-To: <CAC4O8c9ieZC4SBJf54ZuTfAvnkhGuDaibBQ-m9Zw_n5VhUFPag@mail.gmail.com>
	(Britton Kerin's message of "Sat, 9 Dec 2023 02:58:37 -0900")
References: <CAC4O8c9ieZC4SBJf54ZuTfAvnkhGuDaibBQ-m9Zw_n5VhUFPag@mail.gmail.com>
Date: Sat, 09 Dec 2023 08:13:49 -0800
Message-ID: <xmqqzfyjmk02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F0D13B96-96AD-11EE-9F09-25B3960A682E-77302942!pb-smtp2.pobox.com

Britton Kerin <britton.kerin@gmail.com> writes:

> It's a very small issue but it seems that git bisect terms does
> support --term-old and --term-new options, however the man page says:
>
>     git bisect terms [--term-good | --term-bad]
>
> The description for the start subcommand does document the support for
> the more general terms correctly:
>
>     git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
>
> so maybe it's worth fixing the git bisect terms documentation.

In the description, we see

    To get a reminder of the currently used terms, use

    ------------------------------------------------
    git bisect terms
    ------------------------------------------------

    You can get just the old (respectively new) term with `git bisect terms
    --term-old` or `git bisect terms --term-good`.

so you could read that

	git bisect terms --term-good
	git bisect terms --term-old

are the same thing, and when you squint your eyes, you can probably
guess that

	git bisect terms --term-bad
	git bisect terms --term-new

are the same.  But I agree that the documentation should not force
you to guess.  This dates back to 21b55e33 (bisect: add 'git bisect
terms' to view the current terms, 2015-06-29).

------------ >8 ------------ >8 ------------ >8 ------------
Subject: [PATCH] bisect: document "terms" subcommand more fully

The documentation for "git bisect terms", although it did not hide
any information, was a bit incomplete and forced readers to fill in
the blanks to get the complete picture.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-bisect.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git c/Documentation/git-bisect.txt w/Documentation/git-bisect.txt
index 191b4a42b6..16daa09c78 100644
--- c/Documentation/git-bisect.txt
+++ w/Documentation/git-bisect.txt
@@ -20,7 +20,7 @@ on the subcommand:
 		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
- git bisect terms [--term-good | --term-bad]
+ git bisect terms [--term-(good|old) | --term-(bad|new)]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
  git bisect (visualize|view)
@@ -165,8 +165,10 @@ To get a reminder of the currently used terms, use
 git bisect terms
 ------------------------------------------------
 
-You can get just the old (respectively new) term with `git bisect terms
---term-old` or `git bisect terms --term-good`.
+You can get just the old term with `git bisect terms --term-old`
+or `git bisect terms --term-good`; `git bisect terms --term-new`
+and `git bisect terms --term-bad` can be used to learn how to call
+the commits more recent than the sought change.
 
 If you would like to use your own terms instead of "bad"/"good" or
 "new"/"old", you can choose any names you like (except existing bisect

