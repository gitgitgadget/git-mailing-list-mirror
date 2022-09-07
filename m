Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B6C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiIGVzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIGVzt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 17:55:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB4A261A
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 14:55:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d82so2312823pfd.10
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=qlpyaKi+ygVZbhQNXSkFwqw5smzCIWv2D1wNLXFOwf0=;
        b=WN4l0oIBL2tfMlELd4GCmG/84hNIfx/ZnUKfxGz/W2CtQA1prUW2lZUTRQD89hv4ON
         bpV0qnuaxZkkFRCw3UpA0XU/Fzpuzb/Ru/t0EcJ4JtKf7K3nLvIE7XweYmexUJwt4MBd
         t0vRDk7BbZ0Sb1EjE5vv6Ymf9ceS0FmJ+JZR3hxBm/4inf/615yp4UOQDDjNXb45fPUf
         2RSqvXrcZyDkKOVd4nQdzF/dFRArcRVEo0zJlS9MNPzG+Ofu4NkETp9Ye+VhypaVURmK
         nVsp7asM2NcTAMjmQ41Ne4eZhHwbmzqfnio9s8S/r0vA+tacU0TznqfQWqaPuCqTfpuy
         u/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=qlpyaKi+ygVZbhQNXSkFwqw5smzCIWv2D1wNLXFOwf0=;
        b=6yoXtagdvmO57lB/COrJjmK15iNGuJ7H465FUHq69Q4XKg9SMRyXr9XTzOVdmS42TL
         FGtR2c0+y+l89dOaJ9ef8UOeBgwySHgsF+El2QCnHyU+7SipstACu+fyg3cBJB1/NIkd
         k2wk95ei+tuNAHyjZ7ZbrFGnUSz4RJBqprcWpTSup0nIvOYoB341rE6AY17l05fcWzXo
         a/MH/KGe3O1sdo4c7LJDy5pWsUCSN3LsjcRF9wbfB00Sm1MpmOsDMJ9X64zeX2gVK1GC
         j51LhvG/JBase6ai/cXdyZ+XnSlSn9YsuxKWWvsD+5l+b/ljXx7NafG3lR7go5WzclDW
         mElQ==
X-Gm-Message-State: ACgBeo2tvQpBRSOB6Cc2rGMAb9fUWcZ9c4U74UWBuPXdm+VBRjTcx1nI
        BB+S9VWxFpW9tn02n+RxCMA=
X-Google-Smtp-Source: AA6agR74RV7y7PwJxvp45GFs5LbcL50idEasSVHLQ6pDv1hmhxxbAvUcWLpqGf61BiJpX7ChA6B1IQ==
X-Received: by 2002:aa7:888d:0:b0:538:328b:2ffb with SMTP id z13-20020aa7888d000000b00538328b2ffbmr5806026pfe.82.1662587735993;
        Wed, 07 Sep 2022 14:55:35 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902e35400b001726ea1b716sm6806751plc.237.2022.09.07.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:55:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [BUG] t1800: Fails for error text comparison
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
        <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
        <xmqq1qsnugsu.fsf@gitster.g>
        <YxkAxutS+B8//0WF@coredump.intra.peff.net>
        <001201d8c2fb$3f1c51b0$bd54f510$@nexbridge.com>
Date:   Wed, 07 Sep 2022 14:55:35 -0700
In-Reply-To: <001201d8c2fb$3f1c51b0$bd54f510$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 7 Sep 2022 16:48:49 -0400")
Message-ID: <xmqqh71isvc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> I am finding an issue with t1800.16 failing as a result of a text compare:
>
> -fatal: cannot run bad-hooks/test-hook: ...
> +fatal: cannot exec 'bad-hooks/test-hook': Permission denied
>
> I don't think this is actually a failure condition but the message
> text is platform and shell specific.

Isn't this coming from piece of code in start_command()?

		/*
		 * Attempt to exec using the command and arguments starting at
		 * argv.argv[1].  argv.argv[0] contains SHELL_PATH which will
		 * be used in the event exec failed with ENOEXEC at which point
		 * we will try to interpret the command using 'sh'.
		 */
		execve(argv.v[1], (char *const *) argv.v + 1,
		       (char *const *) childenv);
		if (errno == ENOEXEC)
			execve(argv.v[0], (char *const *) argv.v,
			       (char *const *) childenv);

		if (errno == ENOENT) {
			if (cmd->silent_exec_failure)
				child_die(CHILD_ERR_SILENT);
			child_die(CHILD_ERR_ENOENT);
		} else {
			child_die(CHILD_ERR_ERRNO);
		}

The test apparently expects CHILD_ERR_NOENT, which comes from
child_err_spew()

	case CHILD_ERR_ENOENT:
		error_errno("cannot run %s", cmd->args.v[0]);
		break;
	case CHILD_ERR_SILENT:
		break;
	case CHILD_ERR_ERRNO:
		error_errno("cannot exec '%s'", cmd->args.v[0]);
		break;
	}

but somehow your system fails the execve() with something other than
ENOENT.
