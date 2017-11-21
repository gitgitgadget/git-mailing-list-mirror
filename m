Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62C3202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 01:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdKUBsl (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 20:48:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55005 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751305AbdKUBsk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 20:48:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FA5EBBB63;
        Mon, 20 Nov 2017 20:48:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lw6MVNoZSWq13E7/b8GBH7yiII4=; b=KDzcts
        DsXZtnsP8h6phGerm7DsGwoD/u61pnJiuOFmAeqlO+LtN+7PZ7tnhNU1clBNMsnX
        B9FIxyAg9U0XxtPf54ZbF1YaAtyzNBCC2mZa0TlbVJGPWUOnIauJ5wqSSffWmpo8
        ujiC7/Jx8SmM7Gkgaq7bFnZhstYFOLNTE7h4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CWA2brFW1LIdS/Fy79huaKJL3566xQ5Q
        ktLA+grSLMY7HeJ+Fy4nIjLt3nFsdKUP36f4xdM7dMpxFMy1DZaAzq5LUCHf9ZBe
        nfhv9OvoJkpM7PNPCuHvevME3iy3QGGDF8g0epCWwZ8fgciQO7vCDbMV203xRLi8
        km5AngSk51o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87CD2BBB62;
        Mon, 20 Nov 2017 20:48:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E59F2BBB61;
        Mon, 20 Nov 2017 20:48:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 6/8] ssh: 'auto' variant to select between 'ssh' and 'simple'
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
        <20171120213004.57552ja3nmxy6pmc@aiede.mtv.corp.google.com>
Date:   Tue, 21 Nov 2017 10:48:37 +0900
In-Reply-To: <20171120213004.57552ja3nmxy6pmc@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 20 Nov 2017 13:30:04 -0800")
Message-ID: <xmqqlgj0jtai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 186E5040-CE5E-11E7-B8DD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Android's "repo" tool is a tool for managing a large codebase
> consisting of multiple smaller repositories, similar to Git's
> submodule feature.  Starting with Git 94b8ae5a (ssh: introduce a
> 'simple' ssh variant, 2017-10-16), users noticed that it stopped
> handling the port in ssh:// URLs.
>
> ...
> Reported-by: William Yan <wyan@google.com>
> Improved-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Not a big issue, but the above made me wonder, due to lack of any
signed-off-by before improved-by, what "base" was improved by JTan.
If you were writing a change before formally passing it around with
your sign-off and somebody had a valuable input to improve it, it
seems that people say helped-by around here.

>  ssh.variant::
> -	Depending on the value of the environment variables `GIT_SSH` or
> -	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
> -	auto-detects whether to adjust its command-line parameters for use
> -	with ssh (OpenSSH), plink or tortoiseplink, as opposed to the default
> -	(simple).
> +	By default, Git determines the command line arguments to use
> +	based on the basename of the configured SSH command (configured
> +	using the environment variable `GIT_SSH` or `GIT_SSH_COMMAND` or
> +	the config setting `core.sshCommand`). If the basename is
> +	unrecognized, Git will attempt to detect support of OpenSSH
> +	options by first invoking the configured SSH command with the
> +	`-G` (print configuration) option and will subsequently use
> +	OpenSSH options (if that is successful) or no options besides
> +	the host and remote command (if it fails).
>  +
> -The config variable `ssh.variant` can be set to override this auto-detection;
> -valid values are `ssh`, `simple`, `plink`, `putty` or `tortoiseplink`. Any
> -other value will be treated as normal ssh. This setting can be overridden via
> -the environment variable `GIT_SSH_VARIANT`.
> +The config variable `ssh.variant` can be set to override this detection.
> +Valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
> +`tortoiseplink`, `simple` (no options except the host and remote command).
> +The default auto-detection can be explicitly requested using the value
> +`auto`.  Any other value is treated as `ssh`.  This setting can also be
> +overridden via the environment variable `GIT_SSH_VARIANT`.
>  +

Cleanly written and easily read.  Good.

> @@ -982,6 +985,21 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
>  		variant = determine_ssh_variant(ssh, 0);
>  	}
>  
> +	if (variant == VARIANT_AUTO) {
> +		struct child_process detect = CHILD_PROCESS_INIT;
> +
> +		detect.use_shell = conn->use_shell;
> +		detect.no_stdin = detect.no_stdout = detect.no_stderr = 1;
> +
> +		argv_array_push(&detect.args, ssh);
> +		argv_array_push(&detect.args, "-G");
> +		push_ssh_options(&detect.args, &detect.env_array,
> +				 VARIANT_SSH, port, flags);
> +		argv_array_push(&detect.args, ssh_host);
> +
> +		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
> +	}

I briefly wondered if it safe to simply append "-G" in both cases,
i.e. where "ssh" came from GIT_SSH and it came from GIT_SSH_COMMAND,
but in the real invocation we see in the post-context of this hunk,
we'd push options the same way regardless, so it should be fine.

>  	argv_array_push(&conn->args, ssh);
>  	push_ssh_options(&conn->args, &conn->env_array, variant, port, flags);
>  	argv_array_push(&conn->args, ssh_host);

> +test_expect_success 'OpenSSH-like uplink is treated as ssh' '
> +	write_script "$TRASH_DIRECTORY/uplink" <<-EOF &&
> +	if test "\$1" = "-G"
> +	then
> +		exit 0
> +	fi &&
> +	exec "\$TRASH_DIRECTORY/ssh$X" "\$@"
> +	EOF

OK.

> +	test_when_finished "rm -f \"\$TRASH_DIRECTORY/uplink\"" &&
> +	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
> +	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
> +	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
> +	expect_ssh "-p 123" myhost src
> +'
> +
>  test_expect_success 'plink is treated specially (as putty)' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>  	git clone "[myhost:123]:src" ssh-bracket-clone-plink-0 &&

Thanks.
