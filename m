Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2775C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7598A20726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yGrC1VYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLIWBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:01:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58703 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLIWBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 17:01:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15996AA576;
        Mon,  9 Dec 2019 17:01:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j6NRMX2QcNdRw9DDbMiraAtIp/g=; b=yGrC1V
        Ya8EvRqqC8aUN/YcMWN8DTzbl2MVuGKiXZR2dU/ilAE56/iPd4XX4154neyy2nK8
        xajeCHNXIxtmQEvq6ws37ivBSf7EzxPvy2eeD1gs7a7i/xupJPhP3wcDbj1TlG5z
        rHpuYDyFbPhh5Dqy0FZ8YlSWsU1FipjgOmpI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rJJpKloI5idKjmXDEMfMGpG5fkR2LVWD
        0QidtxSPilinWEUX5CWweNo4Ls5E1Pd4frUyzds8GAIq0+jFXT10ahZRkSoch5PW
        vjy2kzMGWkatqrXrOw5z6kDwD2pArmyCjCV/duJEwh5oNjxloXTV8DyrLnX5vbvt
        VhLaaBfENhw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E363AA575;
        Mon,  9 Dec 2019 17:01:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 13DC4AA570;
        Mon,  9 Dec 2019 17:00:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH 1/3] git-p4: [usability] yes/no prompts should sanitize user text
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
        <e721cdaa008263b896c1d162e411c4e7a04c5710.1575901009.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:00:55 -0800
In-Reply-To: <e721cdaa008263b896c1d162e411c4e7a04c5710.1575901009.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Mon, 09 Dec 2019 14:16:47
        +0000")
Message-ID: <xmqqimmptazs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61497690-1ACF-11EA-A3DE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> When prompting the user interactively for direction, the tests are
> not forgiving of user input format.
>
> For example, the first query asks for a yes/no response. If the user
> enters the full word "yes" or "no" or enters a capital "Y" the test
> will fail.
>
> Create a new function, prompt(prompt_text, choices) where
>   * promt_text is the text prompt for the user
>   * is a list of lower-case, single letter choices.
> This new function must  prompt the user for input and sanitize it by
> converting the response to a lower case string, trimming leading and
> trailing spaces, and checking if the first character is in the list
> of choices. If it is, return the first letter.
>
> Change the current references to raw_input() to use this new function.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  git-p4.py | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 60c73b6a37..0fa562fac9 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -167,6 +167,17 @@ def die(msg):
>          sys.stderr.write(msg + "\n")
>          sys.exit(1)
>  
> +def prompt(prompt_text, choices = []):
> +    """ Prompt the user to choose one of the choices
> +    """
> +    while True:
> +        response = raw_input(prompt_text).strip().lower()
> +        if len(response) == 0:
> +            continue
> +        response = response[0]
> +        if response in choices:
> +            return response

I think this is a strict improvement compared to the original, but
the new loop makes me wonder if we need to worry more about getting
EOF while calling raw_input() here.  I am assuming that we would get
EOFError either way so this is no worse/better than the status quo,
and we can keep it outside the topic (even though it may be a good
candidate for a low-hanging fruit for newbies).

>  def write_pipe(c, stdin):
>      if verbose:
>          sys.stderr.write('Writing pipe: %s\n' % str(c))
> @@ -1779,7 +1790,7 @@ def edit_template(self, template_file):
>              return True
>  
>          while True:
> -            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
> +            response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ", ["y", "n"])
>              if response == 'y':
>                  return True
>              if response == 'n':
> @@ -2350,8 +2361,8 @@ def run(self, args):
>                          # prompt for what to do, or use the option/variable
>                          if self.conflict_behavior == "ask":
>                              print("What do you want to do?")
> -                            response = raw_input("[s]kip this commit but apply"
> -                                                 " the rest, or [q]uit? ")
> +                            response = prompt("[s]kip this commit but apply"
> +                                                 " the rest, or [q]uit? ", ["s", "q"])
>                              if not response:
>                                  continue
>                          elif self.conflict_behavior == "skip":
