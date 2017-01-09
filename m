Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5A51FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 22:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764271AbdAIW5i (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 17:57:38 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35313 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdAIW5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 17:57:36 -0500
Received: by mail-qt0-f170.google.com with SMTP id x49so84295630qtc.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 14:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=BfHrFKcEyZNQpwT/+k79obafan/il0yVY9Uj8czqjZ4=;
        b=imbg2BTN1iXUD4yh6i3tS7x0b3ImeJflfouI5TPyHY5VSbrcVD99IpWeenfQu7o/zJ
         Qe+slAWaf/Evd8+HfJnH0aMHvgsexmrV+SEtkEj2RCXLO0/q+Rd0NDvUo72tdItdBEvA
         IDBtBHtPKUakSAmCSEabRMsgFJWewAHFzswUKGydR77ikyxE4kKN6UoS9tVSNNKTibeX
         bK1s/CfymEjM5rDg+Tpr09ed3HuxIJxW4HzbuE01QMCc1DAYUIsiBF9YyrlRQQakUbMQ
         RCEDtRjqH8caNwRTs1T3HKQkEGvRqDO0mbOi6QatmfsmTIg/6xAkl3TMB0Rrj9LznJhe
         etlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=BfHrFKcEyZNQpwT/+k79obafan/il0yVY9Uj8czqjZ4=;
        b=R5fYoiIVDxKa3VLXk2vkwuOg+GiIC5x1N6Sw9FQRHWols64SbnLuM87g/Ku/6bNBoJ
         OxoHmG9KkuPu/M9cMRaxVaIoIa3UtUCyv42iQHzxs86mv1lOi6RGXNLo4JQfBeVoYMfF
         ozpV7OHHfguTu+3zAjBK4GdZ4deHuzMy6XOVKwpAgGqaAZ+gE2NkTIA76ETvHSoNx9Oy
         t5tLJj0snTuOeHP0eQ1yRsCSneKYQsFFsorUD10DANUyDHR/VJs+vAoPKShmxKw13a2Z
         bT9aoYJZJ98qaX9upm0drNUjQGU+LMlrHeUmwxxv8pxjwwhF7yJdBkh1kFJE43QWdYJa
         RPEg==
X-Gm-Message-State: AIkVDXIK07VjPIQgDWHV7uPGNIEZAah2bAgKmUs3waHEkpJZfoAlbtGtD6+fOl2+Mx+D+nFp
X-Received: by 10.237.53.56 with SMTP id a53mr111584qte.78.1484002655188;
        Mon, 09 Jan 2017 14:57:35 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([2620:0:1004:2:c4d:bcd2:8be8:b9f6])
        by smtp.gmail.com with ESMTPSA id k20sm1457993qkl.11.2017.01.09.14.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2017 14:57:34 -0800 (PST)
Subject: Re: [PATCH v3 13/13] mergetool: fix running in subdir when rerere
 enabled
To:     Junio C Hamano <gitster@pobox.com>
References: <20170106010945.79382-1-hansenr@google.com>
 <20170109054238.42599-1-hansenr@google.com>
 <20170109054238.42599-14-hansenr@google.com>
 <xmqq4m18ump1.fsf@gitster.mtv.corp.google.com>
 <xmqqvatot5ob.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, j6t@kdbg.org,
        sbeller@google.com, simon@ruderich.org
From:   Richard Hansen <hansenr@google.com>
Message-ID: <472a8db7-a2d1-5f3a-a43c-0942e744f90b@google.com>
Date:   Mon, 9 Jan 2017 17:57:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqvatot5ob.fsf@gitster.mtv.corp.google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a11c0302a220e920545b14b41"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a11c0302a220e920545b14b41
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2017-01-09 14:05, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I wonder if it makes more sense to always move to toplevel upfront
>> and consistently use path from the toplevel, perhaps like the patch
>
> s/the patch/the attached patch/ I meant.
>
>> does.  The first hunk is what you wrote but only inside MERGE_RR
>> block, and the second hunk deals with converting end-user supplied
>> paths that are relative to the original relative to the top-level.
>>
>> The tweaking of $orderfile you have in the first hunk may have to be
>> tightened mimicking the way how "eval ... --sq ... ; shift" is used
>> in the second hunk to avoid confusion in case orderfile specified by
>> the end user happens to be the same as a valid revname
>> (e.g. "master").
>
> And here is a squash-able patch to illustrate what I mean.

Thanks for this; I'll cook up a reroll.

I tried this approach before I emailed the v3 reroll, except I left out 
the "--" argument to rev-parse.  This caused the tests to fail due to 
"ambiguous argument: unknown revision or path not in the working tree". 
I didn't think to add the "--" because I got it in my head that "--" 
shouldn't be used with --prefix because it shows up in the output, plus 
the example in the rev-parse documentation doesn't use it.  I'll patch 
rev-parse's man page to use "--" in the example.

Thanks,
Richard

>
> I removed both of the comment blocks as the code always works with
> the worktree-relative pathname after this patch while adjusting
> end-user supplied paths from relative to original cwd.  As that is
> how the core parts of the system (including the parts written in C)
> work, even though an explanation you did in the log message is
> needed to explain why the change was needed and what the change
> intended to do to readers of "git log", it is not necessary to
> explain it to the readers of the latest code, which is what the
> in-code comment is about.
>
> The single-liner addition to the test creates a branch whose name is
> the same as the specified orderfile to deliberately create a
> confusing situation.  I haven't tried, but I am fairly sure that the
> test will demonstrate how broken the orderfile=$(...) in the
> original is, if you apply the test part of the attached patch,
> without the changes to git-mergetool.sh, to your version.
>
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 22f56c25a2..21f82d5b58 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -454,53 +454,34 @@ main () {
>  	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
>  	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
>
> -	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
> +	prefix=$(git rev-parse --show-prefix) || exit 1
> +	cd_to_toplevel
> +
> +	if test -n "$orderfile"
>  	then
> -		# The pathnames output by the 'git rerere remaining'
> -		# command below are relative to the top-level
> -		# directory but the 'git diff --name-only' command
> -		# further below expects the pathnames to be relative
> -		# to the current working directory.  Thus, we cd to
> -		# the top-level directory before running 'git diff
> -		# --name-only'.  We change directories even earlier
> -		# (before running 'git rerere remaining') in case 'git
> -		# rerere remaining' is ever changed to output
> -		# pathnames relative to the current working directory.
> -		#
> -		# Changing directories breaks a relative $orderfile
> -		# pathname argument, so fix it up to be relative to
> -		# the top-level directory.
> -
> -		prefix=$(git rev-parse --show-prefix) || exit 1
> -		cd_to_toplevel
> -		if test -n "$orderfile"
> -		then
> -			orderfile=$(git rev-parse --prefix "$prefix" "$orderfile") || exit 1
> -		fi
> +		orderfile=$(
> +			git rev-parse --prefix "$prefix" -- "$orderfile" |
> +			sed -e 1d
> +		)
> +	fi
>
> +	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
> +	then
>  		set -- $(git rerere remaining)
>  		if test $# -eq 0
>  		then
>  			print_noop_and_exit
>  		fi
> +	elif test $# -ge 0
> +	then
> +		eval "set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")"
> +		shift
>  	fi
>
> -	# Note:  The pathnames output by 'git diff --name-only' are
> -	# relative to the top-level directory, but it expects input
> -	# pathnames to be relative to the current working directory.
> -	# Thus:
> -	#   * Either cd_to_toplevel must not be run before this or all
> -	#     relative input pathnames must be converted to be
> -	#     relative to the top-level directory (or absolute).
> -	#   * Either cd_to_toplevel must be run after this or all
> -	#     relative output pathnames must be converted to be
> -	#     relative to the current working directory (or absolute).
>  	files=$(git -c core.quotePath=false \
>  		diff --name-only --diff-filter=U \
>  		${orderfile:+"-O$orderfile"} -- "$@")
>
> -	cd_to_toplevel
> -
>  	if test -z "$files"
>  	then
>  		print_noop_and_exit
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index dfd641d34b..180dd7057a 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -678,6 +678,11 @@ test_expect_success 'diff.orderFile configuration is honored' '
>  		b
>  		a
>  	EOF
> +
> +	# make sure "order-file" that is ambiguous between
> +	# rev and path is understood correctly.
> +	git branch order-file HEAD &&
> +
>  	git mergetool --no-prompt --tool myecho >output &&
>  	git grep --no-index -h -A2 Merging: output >actual &&
>  	test_cmp expect actual
>

--001a11c0302a220e920545b14b41
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6QYJKoZIhvcNAQcCoIIS2jCCEtYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBPMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNtaW1lY2Ex
LmNydDAdBgNVHQ4EFgQUbPFPDSp3rGDbNu3Pb8jJO+QTw0AwHwYDVR0jBBgwFoAUyzgSsMeZwHiS
jLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIFoDAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAG7GEcPrcRoMakd1
k8cdl7NUgGsEGoTzcS1ASh1ZaKlEzGR0uHyB7QwpX1hSHCvUKMRAqe5vXqZWhVhiPNPc0792yPHo
K+K5sV1W+pF66TlYY/9qlz0IDyKlMRKyCkc77PdrXubuJjauu2WGnbDpHvVwLTqwwlR5O0OLig48
m4YUSo869xADdrGrWJ7KzroFbucLZYh3niIjVICp7fh9wtLgbX7X/akdubehYhy/l+AIMml6Zlyu
GNGCGIleyQ0bAdjjG+dKrDErUlui8wd/YplvelaTAzSvNpxcrr+2YB8UBWcYkgULkp5GDCC2guKl
rMF1mTS6N6GMxUi30sZicbMxggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxAgwvfEOc
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGZRnDAVdXaKvXX6mWJk
8AhNvD2AkoqT+FrTNbb3QtPzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwOTIyNTczNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCl/X2IXX0c7cMimlS1qFbFjF5sm/RB92wrXG11
kvl9OXoV2/lyp5R7IYZcALypLz7URDbIiJ1Mm+xsdvWgkE83W+1tM+D1aNgLDzKMhLS5DdL79/g3
14qy/7sG11yXyZwroMpZSxGzkf+3bnL2KlGMLEzGZt2NuyTbC+hRQeAB0dEMG1mf3CmrAGtmv9R5
qiZ4ww2oz1O3n1KcWLujbdTSNoAVVqBBguaBfUnuAlHk+wjs3kdm+0QwEgsg/glKytlvPVD6wQL7
u4He1nwpPCbaqNA3Jb4L1cNBa1FD4TWuMCHxAxkN45izzbFLBkEgOYCxDPeSJ327X6K1bMT898oL
--001a11c0302a220e920545b14b41--
