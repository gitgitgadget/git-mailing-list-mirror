Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA74C32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 06:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E4F222C4
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 06:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qrpff.net header.i=@qrpff.net header.b="Bw4P+lU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgADGWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 01:22:43 -0500
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:8408 "EHLO
        egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgADGWm (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Jan 2020 01:22:42 -0500
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 626CE50172D
        for <git@vger.kernel.org>; Sat,  4 Jan 2020 06:22:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a6.g.dreamhost.com (100-96-6-5.trex.outbound.svc.cluster.local [100.96.6.5])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BC7E85016FA
        for <git@vger.kernel.org>; Sat,  4 Jan 2020 06:22:39 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from pdx1-sub0-mail-a6.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Sat, 04 Jan 2020 06:22:40 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|stevie@qrpff.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Bitter: 33b0af8e75e52b7b_1578118960166_1138220064
X-MC-Loop-Signature: 1578118960166:457410776
X-MC-Ingress-Time: 1578118960166
Received: from pdx1-sub0-mail-a6.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a6.g.dreamhost.com (Postfix) with ESMTP id E261A7F5D1
        for <git@vger.kernel.org>; Fri,  3 Jan 2020 22:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=qrpff.net; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=qrpff.net; bh=+hexk2n9qD1yeLYT0vDCF1xNaws=; b=B
        w4P+lU+09gqKjZ4JG4NDyVOv3Ce0M61fOgslrcYLrIa3gdutLICGwn2+xrm0pC1F
        eKyR4Ue5nn3Bji1oCLD2FsjMHJfFBfmOSe6MgPBRyJRqHEfpaiP2GflK9pOq1Wqk
        VXW36Vm5ZYUFHCyhrbR4K5gEhtWqDO8h0RVDOktVmM=
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stevie@qrpff.net)
        by pdx1-sub0-mail-a6.g.dreamhost.com (Postfix) with ESMTPSA id 8B0367F5CE
        for <git@vger.kernel.org>; Fri,  3 Jan 2020 22:22:35 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id l2so45814952lja.6
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 22:22:35 -0800 (PST)
X-Gm-Message-State: APjAAAWuHO7H23wrgnDIITKjC7w8hR+tYS2Xf5SIq3DL7sOIHQyzdGSz
        lcis2MZu7EYIm5djlGWFsCWAdy1++O6WSFuSz0Q=
X-Google-Smtp-Source: APXvYqyubb952VXaMKkB09yF5JpW2PBQb1I5MF69GmQVL3s/afR8/2HHtSDwbypUpA4sUmDzLTqIfymKOxCDoDmW06E=
X-Received: by 2002:a2e:b054:: with SMTP id d20mr41661695ljl.190.1578118953770;
 Fri, 03 Jan 2020 22:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20200103043027.4537-1-stevie@qrpff.net> <xmqqftgvdhpz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftgvdhpz.fsf@gitster-ct.c.googlers.com>
X-DH-BACKEND: pdx1-sub0-mail-a6
From:   Stephen Oberholtzer <stevie@qrpff.net>
Date:   Sat, 4 Jan 2020 01:22:21 -0500
X-Gmail-Original-Message-ID: <CAD_xR9fUxDTvwmAsfH-6=buRP+UmwBHhQJSV+T3paUOy-S1CGw@mail.gmail.com>
Message-ID: <CAD_xR9fUxDTvwmAsfH-6=buRP+UmwBHhQJSV+T3paUOy-S1CGw@mail.gmail.com>
Subject: Re: [RFC PATCH] bisect run: allow inverting meaning of exit code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeggedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpeggfhgjhfffkffuvfgtsehttdertddttdejnecuhfhrohhmpefuthgvphhhvghnucfqsggvrhhhohhlthiivghruceoshhtvghvihgvsehqrhhpfhhfrdhnvghtqeenucfkphepvddtledrkeehrddvtdekrdduieelnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqlhhjuddqfhduieelrdhgohhoghhlvgdrtghomhdpihhnvghtpedvtdelrdekhedrvddtkedrudeiledprhgvthhurhhnqdhprghthhepufhtvghphhgvnhcuqfgsvghrhhholhhtiigvrhcuoehsthgvvhhivgesqhhrphhffhdrnhgvtheqpdhmrghilhhfrhhomhepshhtvghvihgvsehqrhhpfhhfrdhnvghtpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

Thank you for your feedback! Several of your concerns were already
raised by Jonathan Nieder; I'm going to focus on the specifics you
brought up that Jonathan didn't, to avoid repeating myself too much.

On Fri, Jan 3, 2020 at 10:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Hmm.
>
> No off-the-shelf tool I know of exits 125 to signal "I dunno", so if
> you have to care about the special status 125, the "command" you are
> driving with "git bisect run" must be something that was written
> specifically to match what "git bisect" expects by knowing that 125
> is a special code to declare that the commit's goodness cannot be
> determined.  Now, what's the reason why this "command" written
> specifically to be used with "git bisect", which even knows the
> special 125 convention, yields "this is good" in the wrong polarity?
>
> The only realistic reason I can think of is when the user is hunting
> for a commit that fixed what has long been broken.  In such a use
> case, commits in the older part of the history would not pass the
> test (i.e. the exit status of the script would be non-zero) while
> commits in the newer part of the history would.

That's nearly exactly what happened: after bisecting the problem to
find when it was introduced, I found that an updated version did not
fail the test.  I wanted to bisect the "fix" in order to review the
change and verify that it did, in fact, fix the problem -- as opposed
to change things so my test didn't fail (as it turned out, it was the
latter: rather than fix the issue, the "fix" commit simply turned the
bugged feature off by default.)

> I'd suggest dropping "-r", which has little connection to "--invert".

I was simply trying to be thorough, so if it doesn't need a short
name, that's fine by me.  (And it's probably going to be
--invert-status.)

> Let's not make the style violations even worse.

Jonathan pointed that one out; you can see my corrected version in my
(at his suggestion) split-out version that simply adds support for
'run -- cmd'

> > +                     # how to localize part 2?
>
> Using things like "%2$s", you mean?

Hah, yeah, that was a leftover comment from before I came up with the
'$(printf $(gettext))' trick.  (Which is now eval_gettext.)

> As I alluded earlier, it is unclear how this new feature should
> interact with the "we use 'xyzzy' to mean 'good', and 'frotz' to
> mean 'bad'" feature. One part of me would want to say that when
> running bisect with good and bad swapped, we should reverse the
> polarity of "bisect run" script automatically, but the rest of me
> of course would say that it would not necessarily be a good idea,
> and it is of course a huge backward incompatible change, so anything
> automatic is a no go.

This new feature works just fine with that (in fact, the last round of
tests in the test script explicitly covers this interaction.)
With "--invert-status" it doesn't matter what your names are, and with
"--success=<term>" it honors whatever terms you specified.

> > +             echo "exit code $res means this commit is $state"
>
> Is this a leftover debugging output?

Yep, missed that one during my cursory review before uploading (since
test scripts hide their output by default, I didn't realize I'd left
it in there.)

> In any case, I wonder why something along the line of the attached
> patch is not sufficient and it needs this much code.
>
>  git-bisect.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index efee12b8b1..7fc4f9bd8f 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -247,6 +247,15 @@ bisect_run () {
>                 "$@"
>                 res=$?
>
> +               if test -n "$invert_run_status"
> +               then
> +                       case "$res" in
> +                       0)      res=1 ;;
> +                       125)    ;;
> +                       *)      res=0 ;;
> +                       esac
> +               fi
> +

Unfortunately, that doesn't behave properly.
As far as 'git bisect run' is concerned, there are four distinct sets
of status codes:

1. Test passed (translated to 'git bisect good') -- status 0
2. Test failed (translated to 'git bisect bad') -- status 1-124 or 126-127
3. Untestable (translated to 'git bisect skip') -- status 125
4. Malfunction (causes 'git bisect run' to halt immediately, leaving
the bisection incomplete) -- anything else

What needs to happen is that status code lists for "test passed" (#1)
and "test failed" (#2) are swapped; even when bisecting a fix, #3
(untestable) and #4 (malfunction) remain unchanged.  Your patch remaps
case #4 to case #1.

(I'm actually going to put together a patch to allow the user to pare
down the exit code list for #2 to a specific list, to make 'run' less
dicey in the face of complex test requirements.)

-- 
-- Stevie-O
Real programmers use COPY CON PROGRAM.EXE
