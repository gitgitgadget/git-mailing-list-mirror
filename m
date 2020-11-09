Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E27C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 20:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11646206A1
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 20:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VvKWv4+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgKIU7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 15:59:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51166 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIU7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 15:59:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35CA29205E;
        Mon,  9 Nov 2020 15:59:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gmOSXY/svLOiVkq0hRjZIgp4OzM=; b=VvKWv4
        +uuj0E0Zi+j/d/lUa3HHMkQawr1g37pKeg7uBmqIsTJ/U6teftXoTe5jj5uxo9Ku
        MK8lpnKpGUASFz1Ydx2OcuQAo+Y0CRVXCOIaw98GbKWwodqzSjaG+iEZpP2wdoAz
        sQUmCYhlyhMat2TBrQjJ62umHH4vH7RFKeN40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E1AJndC1HwWmiGcgaUOQLXUzYHntb5Df
        Dd4x9Jl1WbiX4BxZKIMvm7Z09hbVC6D4NGt8VDMrvb2kQWPgyBijeEdHZPnaCBUj
        NxBA1YdJSCYBYK0ZDVw25T3D/MIl3P0aoduNdfUy/t3KjBOc53cRqA/Eu8L3hgrM
        mV+cm79Iv1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2589B9205D;
        Mon,  9 Nov 2020 15:59:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A633492058;
        Mon,  9 Nov 2020 15:59:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] t5411: consistent result for proc-receive broken test
References: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
        <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com>
Date:   Mon, 09 Nov 2020 12:59:24 -0800
In-Reply-To: <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Mon, 9 Nov 2020 18:58:46 +0800")
Message-ID: <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 733E11BE-22CE-11EB-BDBE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index bb9909c52e..6bd402897c 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1172,6 +1172,7 @@ static int run_proc_receive_hook(struct command *commands,
>  	if (version != 1) {
>  		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
>  			    version);
> +		close(proc.in);
>  		code = -1;
>  		goto cleanup;
>  	}
> @@ -1196,11 +1197,12 @@ static int run_proc_receive_hook(struct command *commands,
>  		packet_flush(proc.in);
>  	}
>  
> +	close(proc.in);
> +
>  	/* Read result from proc-receive */
>  	code = read_proc_receive_report(&reader, commands, &errmsg);
>  
>  cleanup:
> -	close(proc.in);
>  	close(proc.out);
>  	if (use_sideband)
>  		finish_async(&muxer);

OK, without us closing our end, the hook cannot even tell that it
read to the end of our input.

> diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
> index 42164d9898..9f7fbc5b7a 100644
> --- a/t/helper/test-proc-receive.c
> +++ b/t/helper/test-proc-receive.c
> @@ -12,6 +12,7 @@ static const char *proc_receive_usage[] = {
>  
>  static int die_version;
>  static int die_readline;
> +static int die_report;
>  static int no_push_options;
>  static int use_atomic;
>  static int use_push_options;
> @@ -52,8 +53,10 @@ static void proc_receive_verison(struct packet_reader *reader) {
>  		}
>  	}
>  
> -	if (server_version != 1 || die_version)
> +	if (server_version != 1)
>  		die("bad protocol version: %d", server_version);
> +	if (die_version)
> +		die("die with the --die-version option");

If any of these trigger, wouldn't we end up dying without consuming
what receive-pack said?

>  
>  	packet_write_fmt(1, "version=%d%c%s\n",
>  			 version, '\0',
> @@ -79,9 +82,15 @@ static void proc_receive_read_commands(struct packet_reader *reader,
>  		    *p++ != ' ' ||
>  		    parse_oid_hex(p, &new_oid, &p) ||
>  		    *p++ != ' ' ||
> -		    die_readline)
> +		    die_readline) {
> +			char *bad_line = xstrdup(reader->line);
> +			while (packet_reader_read(reader) != PACKET_READ_EOF)
> +				; /* do nothing */
> +			if (die_readline)
> +				die("die with the --die-readline option");
>  			die("protocol error: expected 'old new ref', got '%s'",
> -			    reader->line);
> +			    bad_line);
> +		}

This part is different from the previous one in that it slurps all
the input before dying evein in die_readline case.

> @@ -166,6 +177,8 @@ int cmd__proc_receive(int argc, const char **argv)
>  				fprintf(stderr, "proc-receive> %s\n", item->string);
>  	}
>  
> +	if (die_report)
> +		die("die with the --die-report option");

And at this point we have already read everything the other end
said (if so, there is no need for the artificial "read everything
before we die")?

> diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
> index c5fe4cb37b..5c5241bc95 100644
> --- a/t/t5411/test-0013-bad-protocol.sh
> +++ b/t/t5411/test-0013-bad-protocol.sh
> @@ -55,19 +55,16 @@ test_expect_success "proc-receive: bad protocol (hook --die-version, $PROTOCOL)"
>  	test_must_fail git -C workbench push origin \
>  		HEAD:refs/for/master/topic \
>  		>out 2>&1 &&

Are these expected to conflict with Dscho's changes to move 'master'
around?

> -	make_user_friendly_and_stable_output <out >actual &&
> -
> +	make_user_friendly_and_stable_output <out |
> +		sed -n \
> +			-e "/^To / { s/   */ /g; p; }" \
> +			-e "/^ ! / { s/   */ /g; p; }" \
> +			>actual &&

It's the same thing but I somehow find "s/  */ /g" easier to read.
The comparison is between "there may be two things or more---squish
them down to one" and "After one thing, there may be any number of
things---remove all the extra ones".

Makes me wonder if make_user_friendly should optionally have an
option to do something like this for us.  I doubt it that it is
worth to do something like the attached patch.


 t/t5411/common-functions.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git c/t/t5411/common-functions.sh w/t/t5411/common-functions.sh
index 6580bebd8e..6919639c60 100644
--- c/t/t5411/common-functions.sh
+++ w/t/t5411/common-functions.sh
@@ -40,7 +40,9 @@ create_commits_in () {
 # `GIT_TEST_GETTEXT_POISON=true` in order to test unintentional translations
 # on plumbing commands.
 make_user_friendly_and_stable_output () {
-	sed \
+	local en=
+	case "$#" in 0) ;; *) en=-n ;; esac
+	sed $en \
 		-e "s/  *\$//" \
 		-e "s/   */ /g" \
 		-e "s/'/\"/g" \
@@ -52,5 +54,6 @@ make_user_friendly_and_stable_output () {
 		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
 		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
 		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#" \
-		-e "/^error: / d"
+		-e "/^error: / d" \
+		${1+"$@"}
 }
