Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B4C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 07:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F75622228
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 07:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="cGO9rHIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJ3Hro (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgJ3Hrn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 03:47:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27889C0613D2
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 00:47:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dk16so6697175ejb.12
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aZ+2Ia/Syl9SA7f8Nyl0oA20k/9xu/Tx6ulebhV08+I=;
        b=cGO9rHIF74ZCb9BP/8/7mVGLS/QkhLi89gW9yRGurmFLTcPvMBiCHpzTuB+Lniy5d2
         JHYwS0aXFPuwT1X36Rt5CtL2KnebdpTm0hu2lqvtex7Onvur/1jyfsXwauxRW3AybAyl
         qpk8PZN7I+qo8xA3zvvW1e8miuEQV2eDoRFy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aZ+2Ia/Syl9SA7f8Nyl0oA20k/9xu/Tx6ulebhV08+I=;
        b=LzzVW1UJnPqqMvanLY/GO15RBF8HJ4JBZ9Sb8eYR955sbZZpS9I9yUviXhSqgPL6Sb
         iV4y7uhuzzG2xHCUOpsxow2WV143L1GOuEjZ/oa59ZISts4qafVKHkqZ6RBIUWW6M+R1
         4bb4G/TFkQnacU7cpBbD/agNtMrjJoev/vmLqn6cRIdJ78P8y72PFcv1OY1YrsfBE1+h
         L4eScJu45SVFhCyF2FclJTlzSAZ24Su3S/c5XUO1JSrwbZkgN/Lc3lRAFGoYb8Dp0emj
         tXK5ujHVfy92Rs9NVVA0oe5ExvGR0BdCKxclWLP5q+TBRZCWruM44fwHMrCnRzSOKXX8
         6fRA==
X-Gm-Message-State: AOAM531rvVvLdSAXJnvt+or6BjOM0QuLOsz5SSt0NFFGAlyiZsGTrs4n
        b3ol+A+HsSlO83iM0tLdt3fDHdCeDAGxmCa4yMjG0bjgPPbZoksm
X-Google-Smtp-Source: ABdhPJyLTDQS6SbzDz40zS7AWJW2YAz4vjrDk9j7C47Rm9DV7OyL1R/5h7DT2kfURTNaJE1ZN4NlkL9Pzh13gEKs52s=
X-Received: by 2002:a17:906:5618:: with SMTP id f24mr1219369ejq.86.1604044060497;
 Fri, 30 Oct 2020 00:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <1604022059-18527-1-git-send-email-dan@mutual.io> <20201030044012.GA3259692@coredump.intra.peff.net>
In-Reply-To: <20201030044012.GA3259692@coredump.intra.peff.net>
From:   Daniel Duvall <dan@mutual.io>
Date:   Fri, 30 Oct 2020 00:47:29 -0700
Message-ID: <CANo+1gv0otfjRexAVW6E+yPEvGLo55_tQWN-81mQMm4U0seCJQ@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to haves
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the welcome! I appreciate the lengthy feedback, because
above all else I'd love to understand the low-level workings of git
better than I do now.

On Thu, Oct 29, 2020 at 9:40 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Oct 29, 2020 at 06:40:59PM -0700, Daniel Duvall wrote:
>
> > During stateless packfile negotiation, it is normal behavior for
> > stateless RPC clients (e.g. git-remote-curl) to send multiple
> > upload-pack requests with the first containing only the
> > wants/shallows/deepens/filters followed by a flush.
>
> Hmm, is this normal? I'd expect it to send a "done" after the flush, and
> indeed that's what happens if I try it. I see:
>
> E.g., here's GIT_TRACE_CURL output from a v0 request (fetching into an
> empty repo):
>
>  Send data: 00a8want 4b379b7a1b97790f805c365b1e58b75b70d3d904 multi_ack_
>  Send data: detailed no-done side-band-64k thin-pack ofs-delta deepen-si
>  Send data: nce deepen-not agent=3Dgit/2.29.2.477.g2cec8aa0af.00000009don=
e
>  Send data: .
>  Info: upload completely sent off: 181 out of 181 bytes
>
> However, if I add --depth 1 to my fetch, I get:
>
>   Send data: 00a8want 4b379b7a1b97790f805c365b1e58b75b70d3d904 multi_ack_
>   Send data: detailed no-done side-band-64k thin-pack ofs-delta deepen-si
>   Send data: nce deepen-not agent=3Dgit/2.29.2.477.g2cec8aa0af.000cdeepen=
 1
>   Send data: 0000
>   Info: upload completely sent off: 184 out of 184 bytes
>
> Which maybe makes sense if we need the shallow response from the server
> to determine the next step of the request. It doesn't matter for my
> trivial case here (we end up resending the same request with a "done"
> added), but I guess it could in other cases.

Right. This is what I was observing too=E2=80=94in a trivial case, the same
roundtrip being made again with nothing additional but "done". I
should have clarified that I thought it was normal only when a depth
was provided. I've been learning the packfile negotiation protocols as
I've been debugging this issue, so I probably should have reserved my
assertion of "normal" for when I have a firm grasp of them. :)

>
> > When run in stateless mode, continuing on without first checking that
> > the client request has reached EOF can result in a bad file descriptor
> > during get_common_commits.
>
> When you say "bad file descriptor" that makes me think we're getting
> EBADF after trying to use a closed descriptor. But we'd die() as soon as
> the pkt-line code tries to read and gets eof, right?

Right. It's still a valid file descriptor but a premature die() upon
EOF. I'll clarify that.

>
> That's also worth fixing, but I want to make sure I understand the
> problem completely. I think this part of the commit message would be a
> good place to talk about the real-world effects:
>
>   - the client doesn't care; by definition it has hung up at this point
>     and will keep going with its next request

That's true in the case where the server doesn't surface the non-zero
exit code from git-upload-pack=E2=80=94which results in git-http-backend
existing non-zero as well. An apache setup I used in testing doesn't
seem to care about the failure=E2=80=94it responds 200 and so the client is
happy=E2=80=94but in our (dayjob) case, we're running a Phabricator instanc=
e
which handles a non-zero exit from git-http-backend by responding 500,
and the client dies.

$ git fetch --depth 1
https://phabricator.wikimedia.org/source/phabricator.git HEAD
error: RPC failed; HTTP 500 curl 22 The requested URL returned error: 500
fatal: the remote end hung up unexpectedly

>
>   - likewise, the server doesn't care in terms of its response; by
>     definition it is stateless, so the next request the client makes
>     will start fresh

That makes sense to me.

>
>   - it is annoying for server admins who get a bunch of useless logs
>     with "remote end hung up unexpected", or if they are tracking exit
>     codes from upload-pack

Yes! Phabricator tries to work around this by detecting this stderr
output with a regex, which doesn't seem to hold up too well over time.

See https://secure.phabricator.com/D21484

This is actually how I started down this rabbithole. It seemed odd to
me that git-http-backend was exiting non-zero in the first place. Then
again, I didn't much understand packfile negotiation, so it was just a
hunch that there was some kind of bug. Knowing more about the protocol
now, it definitely seems buggy.

>
> As somebody who has admin'd a busy git site, unexpected client network
> drops are just a fact of life and you have to look past them in your
> logs. But I still think it's worth keeping it as uncluttered as possible
> and having upload-pack handle this without an error message.
>
> > Instead, upload-pack should gently peek for an EOF between the sending
> > of shallow/unshallow lines (followed by flush) and the reading of clien=
t
> > haves. If the client has hung up at this point, exit normally.
>
> Should we do this only if we saw a deepen line? From my reading of the
> client code, that's the only thing that would cause this early request.
> I don't know if there's any particular advantage to being more strict
> here.

I'm not sure what would be more correct. It seems to go against the
"server doesn't care" in a stateless case to be that strict, but maybe
there are additional benefits to strictness I'm not aware of.

>
> If we're _not_ going to be strict, then I actually wonder if we ought to
> simply teach get_common_commits() that seeing an EOF is OK in stateless
> mode, wherever it comes. It can't possibly impact the correctness of the
> protocol conversation (since we're stateless and the client is gone),
> but maybe it's useful if you're trying to count how often clients really
> do hang up.

I originally took that approach, but gently handling an EOF in the
get_common_commits loop resulted in a NAK being sent back because of:

                if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL) {
                        [...]
                        if (data->have_obj.nr =3D=3D 0 || data->multi_ack)
                                packet_write_fmt(1, "NAK\n");
                        [...]
                        if (data->stateless_rpc)
                                exit(0);
                        [...]
                }

which the client died on with an "expected shallow list" message. I
didn't see a straightforward way of modifying the conditions _inside_
the loop while ensuring I wasn't changing any expected behavior upon
EOF.

>
> > --- /dev/null
> > +++ b/t/t9904-upload-pack-stateless-timely-eof.sh
>
> We usually try to group related tests by number. Maybe t5705 would be a
> better spot? I also wondered if this could go into t5704, but its title
> is "protocol violations". It's not clear to me yet if this is a
> violation that happens to be mostly harmless, or something we need to be
> doing. :)

Ah! Okay, I was wondering about that, whether the numbered prefixes
were serial or otherwise meaningful. I'll try to group it
appropriately.

>
> > +test_expect_success 'upload-pack outputs flush and exits ok' '
> > +     test_commit initial &&
> > +     head=3D$(git rev-parse HEAD) &&
> > +     hexsz=3D$(test_oid hexsz) &&
> > +
> > +     printf "%04xwant %s\n%04xshallow %s\n000ddeepen 1\n0000" \
> > +             $(($hexsz + 10)) $head $(($hexsz + 13)) $head >request &&
>
> We have a helper function that makes this a bit easier to read:
>
> diff --git a/t/t9904-upload-pack-stateless-timely-eof.sh b/t/t9904-upload=
-pack-stateless-timely-eof.sh
> index f8385a7ebd..1108401e8f 100755
> --- a/t/t9904-upload-pack-stateless-timely-eof.sh
> +++ b/t/t9904-upload-pack-stateless-timely-eof.sh
> @@ -9,10 +9,13 @@ D=3D$(pwd)
>  test_expect_success 'upload-pack outputs flush and exits ok' '
>         test_commit initial &&
>         head=3D$(git rev-parse HEAD) &&
> -       hexsz=3D$(test_oid hexsz) &&
>
> -       printf "%04xwant %s\n%04xshallow %s\n000ddeepen 1\n0000" \
> -               $(($hexsz + 10)) $head $(($hexsz + 13)) $head >request &&
> +       {
> +               packetize "want $head" &&
> +               packetize "shallow $head" &&
> +               packetize "deepen 1" &&
> +               printf "0000"
> +       } >request &&
>
>         git upload-pack --stateless-rpc "$(pwd)" <request >actual &&
>
>
> > +     git upload-pack --stateless-rpc "$(pwd)" <request >actual &&
>
> You can just use "." here, which is a little shorter. It's not entirely
> cosmetic; the difference between $PWD and $(pwd) on Windows always trips
> me up, so I try to avoid using either whenever I can. ;)

Very cool re: the helpers. I'll make those changes.

>
> It would be nice if we could test this through a real use of Git, but it
> might not be worth the hassle. I guess we'd have to mine the apache logs
> in one of our http test scripts to see if upload-pack failed. And I
> guess if we _do_ change the client side to stop sending the extra
> request but want to treat historical clients more gracefully, we'd still
> need a manual test like this.

Yeah I just went with the minimal case I'm familiar with, but I'm game
to set up a more thorough case with some guidance.

>
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -1344,7 +1344,18 @@ void upload_pack(struct upload_pack_options *opt=
ions)
> >                                  PACKET_READ_DIE_ON_ERR_PACKET);
>
> The actual fix looks correct to me, modulo the alternatives I raised
> earlier.
>
> This function only handles the v0 protocol. For v2, we end up in
> upload_pack_v2(). But my reading of the client side do_fetch_pack_v2()
> is that it _doesn't_ send this extra request. And a simple test seems to
> confirm it. Which gives me further pause as to whether the extra request
> is necessary for v0.

When I do a trace using v2, I see two roundtrip requests as well. I
haven't tested the exit status of git-upload-pack in that case
however. It's getting late for me but I'll investigate tomorrow.

>
>
> Well, that review ended up a bit longer than I had imagined. So let me
> add what I should have said at the top: welcome to the Git list, and
> thanks for looking into this issue. :)

Thanks again! I appreciate all the feedback.
