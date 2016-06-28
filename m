Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1AAE2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 21:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbcF1VKB (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 17:10:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752362AbcF1VKA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 17:10:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7617229965;
	Tue, 28 Jun 2016 17:09:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e4BVAt24++T+cGBk7RAx+pavd0Q=; b=MZqEok
	KpknPMOLFHqXQnCCbnxMwYAHzFzotS5puya4Yjw54JH+cwu/foYoIR2dnK4M9edf
	3QkDb14TfV7Ko7SRuZrqSIAp5+qzwh2m9veuAPoRM0VQa5uY7zgbhVY0HdLtW0vU
	FYe7/PRJmZlLQ7Ywce9ErlaBqcmoS8FI3o/ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w/pWk7sE+ENslUbFIvkp0N489mjlxrSB
	80javeChdp313SEw94dzczVCM7crlW3D5crZBmiHN05Ko8JciKNFbsHx7gnKNeyv
	1L5pupr5S0CJEq22pBltSv89O8uiBtLg6g2NYw0GMkDDixrNjm1g1jnhmCkdMxSO
	dKA+Ink8aZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EB0F29964;
	Tue, 28 Jun 2016 17:09:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAAB029961;
	Tue, 28 Jun 2016 17:09:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160628043526.19403-1-lfleischer@lfos.de>
	<xmqqa8i59rph.fsf@gitster.mtv.corp.google.com>
	<xmqq60st9qg5.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
	<xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr>
	<xmqq60st853d.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr>
Date:	Tue, 28 Jun 2016 14:09:56 -0700
In-Reply-To: <alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr> (Nicolas
	Pitre's message of "Tue, 28 Jun 2016 16:36:51 -0400 (EDT)")
Message-ID: <xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABCB0454-3D74-11E6-ADE3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

>> There is something else going on.  I cannot quite explain why I am
>> getting this failure from t5401-update-hooks.sh, for example:
>> 
>>     --- expect      2016-06-28 19:46:24.564937075 +0000
>>     +++ actual      2016-06-28 19:46:24.564937075 +0000
>>     @@ -9,3 +9,4 @@
>>      remote: STDERR post-receive
>>      remote: STDOUT post-update
>>      remote: STDERR post-update
>>     +remote: To ./victim.git
>>     not ok 12 - send-pack stderr contains hook messages
>> 
>> ... goes and looks what v2.9.0 produces, which ends like this:
>> 
>>     ...
>>     remote: STDERR post-receive        
>>     remote: STDOUT post-update        
>>     remote: STDERR post-update        
>>     To ./victim.git
>>        e4822ab..2b65bd1  master -> master
>>      ! [remote rejected] tofail -> tofail (hook declined)
>> 
>> The test checks if lines prefixed with "remote: " match the expected
>> output, and the difference is an indication that the new code is
>> showing an extra incomplete-line "remote: " before other parts of
>> the code says "To ./victim.git" to report where the push is going.
>
> Ah...  I think I know what's going on.
>
> The leftover data in the strbuf is normally (when there is no errors) an 
> unterminated line. So instead of doing:
>
> -                       fprintf(stderr, "%s: protocol error: no band designator\n", me);
> +                       strbuf_addf(&outbuf,
> +                                   "\n%s: protocol error: no band designator\n",
> +                                   me);
>
> you could omit the final \n in the format string and:
>
> -       if (outbuf.len > 0)
> -               fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
> +       if (outbuf.len)
> +               fwrite(outbuf.buf, 1, outbuf.len, stderr);
>         strbuf_release(&outbuf);
>
> and here a \n could be added before writing out the buffer.

Unfortunately, that is not it.

The basic structure of the code (without the "SQUASH" we discussed)
looks like this:

	strbuf_addf(&outbuf, "%s", PREFIX);
	while (retval == 0) {
		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
		...
		band = buf[0] & 0xff;
		switch (band) {
		case 3:
			... /* emergency exit */
		case 2:
			while ((brk = strpbrk(b, "\n\r"))) {
				int linelen = brk - b;

				if (linelen > 0) {
					strbuf_addf(&outbuf, "%.*s%s%c",
						    linelen, b, suffix, *brk);
				} else {
					strbuf_addf(&outbuf, "%c", *brk);
				}
				fprintf(stderr, "%.*s", (int)outbuf.len,
					outbuf.buf);
				strbuf_reset(&outbuf);
				strbuf_addf(&outbuf, "%s", PREFIX);
				b = brk + 1;
			}
			if (*b)
				strbuf_addf(&outbuf, "%s", b);
			break;
		...
		}
	}

	if (outbuf.len > 0)
		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);

Imagine we are reading from band #2 and we find a complete line.  We
concatenate the payload up to the LF at the end of the line to the
PREFIX we prepared outside the loop and emit it, and then we ASSUME
that we further have something after strpbrk() and add PREFIX to the
buffer, before going to the next line in the payload.

But there may not be anything after the LF.  outbuf.len is still
counting the PREFIX and we end up showing it, without termination.

This takes us back to what I said in my review of an earlier round,
in $gmane/297332, where I said:

    Instead of doing "we assume outbuf already has PREFIX when we add
    contents from buf[]", the code structure would be better if you:

     * make outbuf.buf contain PREFIX at the beginning of this innermost
       loop; lose the reset/addf from here.

     * move strbuf_reset(&outbuf) at the end of the next if (*b) block
       to just before "continue;"

    perhaps?

I think the strbuf_addf(PREFIX) above the loop should be removed,
and instead the code should use the PREFIX only when it decides that
there is something worth emitting, i.e.

	while (!retval) {
        	len = packet_read();
                ...
                band = buf[0] & 0xff;
                switch (band) {
                case 3:
                	... /* emergency exit */
		case 2:
                	while ((brk = ...)) {
                        	/* we have something to say */
				strbuf_reset(&outbuf);
                                strbuf_addstr(&outbuf, PREFIX);
                                if (linelen)
                                	strbuf_addf(...);
				else
                                	strbuf_addch(*brk);
				fwrite(outbuf.buf, 1, outbuf.len, stderr);
				b = brk + 1;
			}
                        if (*b) {
                        	/* we still have something to say */
				strbuf_reset(&outbuf);
                                strbuf_addstr(&outbuf, PREFIX);
                               	strbuf_addf(...);
			}
                        break;
		...
                }
	}


