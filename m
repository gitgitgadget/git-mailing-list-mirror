Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC3E208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 03:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbdIFDev (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 23:34:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57135 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752192AbdIFDeu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 23:34:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12BE3B0AAE;
        Tue,  5 Sep 2017 23:34:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=2zKMi7N+rU9mLdAS9jASmq7DOls=; b=AtBAAGqSfcwxpTQ5jUIf
        lnO7zgVy88Zp7adJdj9JWTCHXH8DrnyJvTWoDY69o7+suyvJOaSN52hpPRtAZcmp
        uXX7wJmIc9seyHH9Ze+5sbE847fCTBPd2Ffla4Vj8l34gqg+3kXCGABGpCKMudlM
        8P+5f7C6ZUrwWgh5dftvpes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=djWPkwaG8wFIs7/KyplhWmfQik9kPAdYCJQaO8vr6o9g3G
        1QYVATQqw3x0rFqEt0MolNHLcl5b4siqeGjZiU9Mg8WOynjzIeTuy3Vuy1oHmCSm
        UL28oFZ6r1Ri77yzeL4FWDA3Uw3iui1q1osxWPqteIi1G2Dfh5apVmp7UWCjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09007B0AAD;
        Tue,  5 Sep 2017 23:34:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58CA4B0AAC;
        Tue,  5 Sep 2017 23:34:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: use raw format for notes
References: <334a7be4f61c02db24008181eb1d6c80c95772f7.1503894009.git.sam.bobroff@au1.ibm.com>
Date:   Wed, 06 Sep 2017 12:34:48 +0900
Message-ID: <xmqqingw8ppj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 561076CA-92B4-11E7-8D55-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam Bobroff <sam.bobroff@au1.ibm.com> writes:

> If "--notes=..." is used with "git format-patch", the notes are
> prefixed with the ref's local name and indented, which looks odd and
> exposes the path of the ref.
>
> Extend the test that suppresses this behaviour so that it also catches
> this case, causing the notes to be included without additional
> processing.
>
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>
> Notes (foo):
>     Hi,
>     
>     I've noticed what appears to be a small cosmetic bug in git format-patch, as
>     I've described in the commit message.
>     
>     I'm not sure if this patch is the right way to fix it (or perhaps it's not even
>     a bug), but it should at least help to explain what I'm talking about.
>     
>     I've used "git format-patch --notes=foo" to prepare this email so that it is an
>     example of the issue :-)
>     
>     Cheers,
>     Sam.

Is the above addition from your 'foo' notes with or without this
patch?  I think the answer is "without", and the above "example"
looks just fine to me.

 - It is very much intended to allow The "(foo)" after the "Notes"
   label to show which notes ref the note comes from, because there
   can be more than one notes refs that annotate the same commit.

 - And the contents are indented, just like the diffstat and other
   stuff we place after "---" but before the first "diff", to ensure
   no matter what text appears there it will not be mistaken as part
   sure that the contents from the notes will not be mistaken as part
   of the patch.

I do not think an unconditional change of the established format,
like your patch does, is acceptable, as existing users have relied
on, and expect to be able to continue relying on, the above two
aspect of the current format.

But I am somewhat curious what your use case that wants to insert
the raw contents there is.  We may be able to construct a valid
argument to add such an output as an optional feature if there is a
good use case for it.

Thanks.

>  log-tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 410ab4f02..26bc21ad3 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -655,7 +655,8 @@ void show_log(struct rev_info *opt)
>  		int raw;
>  		struct strbuf notebuf = STRBUF_INIT;
>  
> -		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
> +		raw = (opt->commit_format == CMIT_FMT_USERFORMAT) ||
> +		      (opt->commit_format == CMIT_FMT_EMAIL);
>  		format_display_notes(&commit->object.oid, &notebuf,
>  				     get_log_output_encoding(), raw);
>  		ctx.notes_message = notebuf.len
