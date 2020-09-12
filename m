Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A349CC433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 11:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBB321548
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 11:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=boukeversteegh-nl.20150623.gappssmtp.com header.i=@boukeversteegh-nl.20150623.gappssmtp.com header.b="cx9tEMqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgILLXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 07:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgILLWj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 07:22:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348AEC061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 04:22:34 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t13so11321185ile.9
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 04:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boukeversteegh-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNK3THs+KRMmBx7mejVuMD9brmLag1TA7zOSIdfdtk8=;
        b=cx9tEMqSSnlbsuapapjmyCcClA0l73z9I3cABnnV78XZUVVwrnMQXaD/upVQ4xZFHV
         POwVMJIIiwvr9j0jCIa7PBco//ul0r7XFKWhM5Q1ChLDyr19IDxDFhKbXsuH3JFj/h8u
         hslm7RHs7r1h83hiOaVfpow4JxjN15ZL8RN2AJAnC9GUMdbjOvrgOCkOR0mMO4uBinkX
         DLXiqLSS4S3ql2r75DzpON8r52ZEUE/72EXS62nXkadzT3Nu3oC83Uqj1Iu3wWx6H3wH
         /HVVyii7AHorV2zwn6N1i23QxvdZ63JqHo7XBTryiQRe55V8xWjpYsweYa68ZCAORwSc
         biDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNK3THs+KRMmBx7mejVuMD9brmLag1TA7zOSIdfdtk8=;
        b=pX1C3vCpiFS+e2i5q1ydQyhv1bHugGheuC51WNrJ4QJjkx+XIsbDgTMwM5CVV69/2f
         HvVEkKiaAatlwP2ydzdBhrzeIGxW3HrsJunZMNv8+osV3C4bKcW98iHM/405aFTbnCxU
         k1IOoHZYQjG/qHZNlEDHs3j3hTmLji9FaqRQR94yIu1G1Ku3WOTqWxVP4SGjB+5SnLZ1
         cWJPfDiwUbxP757Nb0qbyE8ql71rInn/0uH6z9kEpOXpVqOUcb31ZTthZEj58/N9s3qQ
         nmXTX0mYGv5T8kjtUvw/yYrO+2zWTJH0amuZC4cBSn0BNrzcxinKkBWIY+M0ufP2dH8n
         Dn1Q==
X-Gm-Message-State: AOAM532DB5cD7kDQ0ECfibPHypSKbW1Gqb1Gg7nVsB7Ke9PXgcDw501S
        4kD54mAklolE6za0XXwy2bwAZsy/yHOpagsZtPCULO9maK79xQ==
X-Google-Smtp-Source: ABdhPJwfvG2i9Z1lHhLecmWxfZsWxle0rD+93Q/2fjp46vYLx/m6mGhduB/QKrFqnRigv0nqDw0sMHHLMd/HR9JnLhQ=
X-Received: by 2002:a92:c804:: with SMTP id v4mr693683iln.295.1599909753074;
 Sat, 12 Sep 2020 04:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFag0172JvkTgzXs2ieq2kSfnNRy_8n5YsP87uQ-Pyf5vB+yfw@mail.gmail.com>
 <20200911143321.GA2374950@coredump.intra.peff.net>
In-Reply-To: <20200911143321.GA2374950@coredump.intra.peff.net>
From:   Bouke Versteegh <info@boukeversteegh.nl>
Date:   Sat, 12 Sep 2020 13:21:57 +0200
Message-ID: <CAFag017mV=gE3GZ2Cn6gp9=kDF+SH1hm_Xb_UiV0MHsftDr3tw@mail.gmail.com>
Subject: Re: Docs: possible incorrect diagram of Delta Copy instruction
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

Thank you for your elaborate answer. So it turns out I misinterpreted
the diagram to represent the 8 opcode BITS rather than the whole
sequence of BYTES.
In hindsight there were some hints that I've overlooked, like the
first block containing 1xxxxxxx, which shows already its a byte, not a
bit, and the explanation below.

Thanks again for taking the time to explain!

Kind regards, Bouke

On Fri, 11 Sep 2020 at 16:33, Jeff King <peff@peff.net> wrote:
>
> On Fri, Sep 11, 2020 at 02:30:20PM +0200, Bouke Versteegh wrote:
>
> > While working on an implementation of git in dart, I've noticed a
> > possible error in the documentation. I hope I'm using the correct
> > channel to report this issue.
>
> This is definitely the right place.
>
> > On [pack format](https://git-scm.com/docs/pack-format#_instruction_to_copy_from_base_object)
> > a diagram is shown, that explains the format of a Copy instruction
> > inside a Deltified pack entry:
> >
> > +----------+---------+---------+---------+---------+-------+-------+-------+
> > | 1xxxxxxx | offset1 | offset2 | offset3 | offset4 | size1 | size2 | size3 |
> > +----------+---------+---------+---------+---------+-------+-------+-------+
> >
> > The documentation specifies that diagrams follow the RFC950
> > (https://www.ietf.org/rfc/rfc1950.txt) format.
>
> I think you mean rfc1951 here, but yeah, it is clear in that document
> that bytes are in MSB order. And also that each of those boxes is a
> single byte.
>
> > That means that the left bit is MSB, and the right bit is LSB, so the
> > OpCode is MSB (1xxxxxxx), which is correct and matches other sources.
>
> Right, agreed.
>
> > It also would mean that offset 1-4 should be read from bit 7, 6, 5 and
> > 4 (i.e. 0x40, 0x20, 0x10, 0x08)
>
> I don't think this follows, though. "offset1" is a separate byte. We
> have a sequence of bytes here, some of which may be present. Their
> presence is determined by the bits "xxxxxxx", but the diagram does not
> say anything about the order.
>
> The paragraphs below do say:
>
>   This is the instruction format to copy a byte range from the source
>   object. It encodes the offset to copy from and the number of bytes to
>   copy. Offset and size are in little-endian order.
>
> So "offset1" is the lowest byte of the offset value. We still don't know
> which bit in the instruction byte tells us whether it's there yet,
> though. The next paragraph says:
>
>   All offset and size bytes are optional. This is to reduce the
>   instruction size when encoding small offsets or sizes. The first seven
>   bits in the first octet determines which of the next seven octets is
>   present. If bit zero is set, offset1 is present. If bit one is set
>   offset2 is present and so on.
>
> So bit zero of the "xxxxxxx" (the LSB) is offset1, and we have to check
> that first. Which I think is what happens in:
>
> >   PARSE_CP_PARAM(0x01, cp_off, 0);
>
> That's reading the low bit of the command byte, and then reading the
> _next_ byte from data, and shifting it not at all (because it's the low
> byte of the offset). That macro looks like this:
>
>   #define PARSE_CP_PARAM(bit, var, shift) do { \
>                           if (cmd & (bit)) { \
>                                   if (data >= top) \
>                                           goto bad_length; \
>                                   var |= ((unsigned) *data++ << (shift)); \
>                           } } while (0)
>
> > However, looking at the git source-code and other documentation (see
> > [1] [2]), I see that offset [1-4] are read from the LOWEST 4 bits, and
> > the SIZE  bits are stored right after MSB (opcode).
>
> I think both the code and diagram are right. It's just that the order of
> the follow-on bytes is not part of that diagram, but rather the
> explanation below it.
>
> > From this source code, I would conclude that the diagram should look
> > like this instead:
> >
> > +----------+---------+---------+---------+---------+-------+-------+-------+
> > | 1xxxxxxx | size3 | size 2 | size1 | offset4 | offset3 | offset2 | offset1 |
> > +----------+---------+---------+---------+---------+-------+-------+-------+
>
> That would definitely be wrong. If there's an offset1 byte, it
> immediately follows the command byte.
>
> -Peff
