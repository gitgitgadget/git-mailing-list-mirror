Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42CDC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjC1Ukw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjC1Uku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:40:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C758268C
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:40:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso13947650pjb.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680036046;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkGeKnMNaURgXgYHSTA4fvmMlLqe91ABi1HUy75aZqA=;
        b=QWSHTaY9KbJmkPNbPh1eE80/m+ifdNBuv95GjLePmBYwIq/i5nzh18aOSDnhIhcwO7
         K4Q258a52v5/3vBMZ7te0KZVZ8X2xKWz44KxqAapTI/N4wDcV3vmL/JuYcEQuVJM1HJl
         7BS8HlFyhvVvzSBjZZSO+yJsowuaxVrz4lBrAm/GqKR+olQ5xHMpLCuFdJ1CLVn1lJgR
         qnD+XesNY/vUy/OjZM1Zq75PDRr3rDHke8TPcC2ij9FJom79vCafBcCEArSxC+aXqspu
         vzBWZ5UO4Frtnbu8clHAZgot72HwPCzw1cPWJgV+uD9dZhpDsoL89B7mTleNuYs42ubg
         Q4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680036046;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkGeKnMNaURgXgYHSTA4fvmMlLqe91ABi1HUy75aZqA=;
        b=FYkX9n58ULRdAyYjA/OnsGSAj3x8bXpds2KGkpEHzQJMzixUbrkj7sL9oXdmte27xR
         diyh3F2FUAQs+ZIkLnCJB/XCKW1NkP4h84tJiClvteGXCQRnXvNUKix3wz5B5jSrfF8i
         6PJTHfbJ7ojkfSuOZQL1DpgQIqb9BPIl8mi1wor4wyhMi8GAhcNU0oIQvCvlyTMORKwJ
         QiIeeFEMebdd3Cdlqvi7N0umREn3diZNBJuzhpIDrYCRjZdm69VVeoGYFeaqDyjc6ENF
         ULKT4UWEqggn1M+cNonNlw+LeDIg1aDKZ2u+jEK8Zck4EMN4p4NkG8JuI6D8UrxglgZm
         crLQ==
X-Gm-Message-State: AAQBX9c5wEOSaF5g9fr3FsHTFlUs8Iw5skp0XwK4ARTUGik7W2byQj6L
        zyUaGm/R1hO5m7EwJnG/bpI=
X-Google-Smtp-Source: AKy350b8ZD0CUR4U6GaWvVkTOgGmaxFa0tHr6xYaOXJ4jUDToS3rHEHZM66kH2CUvVhPWhmw0y/SFA==
X-Received: by 2002:a17:902:c44a:b0:19e:6c02:801c with SMTP id m10-20020a170902c44a00b0019e6c02801cmr12416698plm.14.1680036046464;
        Tue, 28 Mar 2023 13:40:46 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902b68e00b0019a593e45f1sm7567806pls.261.2023.03.28.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:40:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 2/4] tests: replace chainlint subshell with a function
References: <20230328202043.GA1241391@coredump.intra.peff.net>
        <20230328202302.GB1241631@coredump.intra.peff.net>
Date:   Tue, 28 Mar 2023 13:40:45 -0700
In-Reply-To: <20230328202302.GB1241631@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Mar 2023 16:23:02 -0400")
Message-ID: <xmqqjzz0ehiq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> To test that we don't break the &&-chain, test-lib.sh does something
> like:
>
>    (exit 117) && $test_commands
>
> and checks that the result is exit code 117. We don't care what that
> initial command is, as long as it exits with a unique code. Using "exit"
> works and is simple, but is a bit expensive since it requires a subshell
> (to avoid exiting the whole script!). This isn't usually very
> noticeable, but it can add up for scripts which have a large number of
> tests.
>
> Using "return" naively won't work here, because we'd return from the
> function eval-ing the snippet (and it wouldn't find &&-chain breakages).
> But if we further push that into its own function, it does exactly what
> we want, without extra subshell overhead.

Cute.

> According to hyperfine, this produces a measurable improvement when
> running t3070 (which has 1800 tests, all of them quite short):
>
>   'HEAD' ran
>     1.09 ± 0.01 times faster than 'HEAD~1'

That is certainly a respectable improvement.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/test-lib.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 09789566374..cfcbd899c5a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1086,6 +1086,10 @@ test_eval_ () {
>  	return $test_eval_ret_
>  }
>  
> +fail_117 () {
> +	return 117
> +}
> +
>  test_run_ () {
>  	test_cleanup=:
>  	expecting_failure=$2
> @@ -1097,7 +1101,7 @@ test_run_ () {
>  		trace=
>  		# 117 is magic because it is unlikely to match the exit
>  		# code of other programs
> -		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
> +		if test "OK-117" != "$(test_eval_ "fail_117 && $1${LF}${LF}echo OK-\$?" 3>&1)"
>  		then
>  			BUG "broken &&-chain or run-away HERE-DOC: $1"
>  		fi
