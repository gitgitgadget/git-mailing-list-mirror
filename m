Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910B5201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 02:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdKMCIP (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 21:08:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59308 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751516AbdKMCIM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 21:08:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B122F95AC9;
        Sun, 12 Nov 2017 21:08:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xwRjZ5EErulgq8fg67nG7m8JFPc=; b=OezPni
        v5kfgF6GWU6j72pvDt1fGt4AWnD8UTGJhvlWicW/6hpjvz63EJ12wF07ehsXD27L
        H5/Vy2Dv9DKQeuvgOMBRhB66uWjXtT/oJGsuGx6FSrQdHnfEL6AAMybGcrqdxPA5
        FXYaar8PhUmo50FmUhIKKms9QGjQcBn6UGEDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c2DOKjuB/wauzcpIxRv2oDM7dt/NVG+n
        S5XlOWVCl7ljzMbHCqliHhkmZImrExtbZZ7fIy0cKjXS/vMVVrDNt87K5JV54lGH
        h88jZLZmamp8Bhk6/+f8bUsWSJvnum1DpHA3y/VT/QKnDQaXkMLmpgY1kPFed1fO
        uBWq3+b/4VM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A955495AC8;
        Sun, 12 Nov 2017 21:08:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 287B095AC7;
        Sun, 12 Nov 2017 21:08:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jerzy Kozera <jerzy.kozera@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] gpg-interface: strip CR chars for Windows gpg2
References: <20171112130710.16000-1-jerzy.kozera@gmail.com>
        <CAPig+cSR_GGog2vATwGgMWDofVzkgDE7K=VvZ4GEyrzYC1t-GQ@mail.gmail.com>
Date:   Mon, 13 Nov 2017 11:08:09 +0900
In-Reply-To: <CAPig+cSR_GGog2vATwGgMWDofVzkgDE7K=VvZ4GEyrzYC1t-GQ@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 12 Nov 2017 12:32:43 -0500")
Message-ID: <xmqqk1yvaq2e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FC9B95C-C817-11E7-B360-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks for the re-roll...
>
> On Sun, Nov 12, 2017 at 8:07 AM, Jerzy Kozera <jerzy.kozera@gmail.com> wrote:
>> This fixes the issue with newlines being \r\n and not being displayed
>> correctly when using gpg2 for Windows, as reported at
>> https://github.com/git-for-windows/git/issues/1249
>
> It's still not clear from this description what "not being displayed
> correctly" means. Ideally, the commit message should stand on its own,
> explaining exactly what problem the patch is solving, without the
> reader having to chase URLs to pages (which might disappear). If you
> could summarize the problem and solution in your own words in such a
> way that your description itself conveys enough information for
> someone not familiar with that problem report to understand the
> problem, then that would likely make a good commit message.

Thanks.  I was wondering if I am the only one who does not
understand what the revised wording wants to say.

>> @@ -145,6 +145,20 @@ const char *get_signing_key(void)
>> +/* Strip CR from the CRLF line endings, in case we are on Windows. */
>> +static void strip_cr(struct strbuf *buffer, size_t bottom) {
>
> It's not at all clear what 'bottom' means. In the original, when the
> code was inline, the surrounding context would likely have given a
> good clue to the meaning of 'bottom', but here stand-alone, it conveys
> little or nothing. Perhaps a better name for this argument would be
> 'start_at' or 'from' or something.

I personally do not mind 'bottom' (especially when it appears in
contrast to 'top') too much, but start_at would be much clearer.

>> +       size_t i, j;
>> +       for (i = j = bottom; i < buffer->len; i++)
>> +               if (!(i < buffer->len - 1 &&
>> +                               buffer->buf[i] == '\r' &&
>> +                               buffer->buf[i + 1] == '\n')) {
>
> Hmm, was this tested? If I'm reading this correctly, this strips out
> the entire CRLF pair, whereas the original code only stripped the CR
> and left what followed it (typically LF) alone. Junio's suggestion was
> to enhance this to be more careful and strip CR only when followed
> immediately by LF (but to leave the LF intact). Therefore, this seems
> like a regression.
>
>> +                       if (i != j)
>> +                               buffer->buf[j] = buffer->buf[i];
>> +                       j++;
>> +               }

I think the "negate the entire thing" condition confuses the
readers.  The negated condition is "Do we still have enough bytes to
see if we are looking at CRLF?  Are we at CR?  Is the one byte
beyond what we have a LF?  Do all of these three conditions hold
true?"  If not, i.e. for all the bytes on the line except for that
narrow "we are at CR of a CRLF sequence" case, the body of the loop
makes a literal copy and advances the destination pointer 'j'.  The
only thing that is skipped is CR that comes at the beginning of a
CRLF sequence.

So I think the loop does what it wants to do.

In any case, I think this should be a two patch series---one with
the code as-is with a better explanation, but without "make sure
only CR in CRLF and no other CR are stripped" improvement, and the
other as a follow-up to it to make the improvement.

Thanks.
