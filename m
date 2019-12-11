Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC6EC2D0C5
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 11:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38F9208C3
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 11:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaSdQIyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfLKLv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:51:57 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:47056 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfLKLv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 06:51:56 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so8833753pjq.13
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NIy3XRLaFjY5l+EuB8aZIA3XH9hpqtVUH84wU3/P7z0=;
        b=FaSdQIyGrRybAThu797d1+458/L7FHOUDzjGLDg4kvUaCsxxZITuQDFf6ZWRnEnBKd
         iIgccjNjSAFunOoGLH/LMkKXV6kyUuAGlNomTnY+el5C03/2c1kWFZyXtyhtv3AWUH9l
         wvzow4/2upe6ZdRGfNnqjrra8NX6CEASWaCeWtUbG9qj2md1S2Tpbq5a85VjyMEuifNB
         DPqaqJRXJwT1Fau3tJMQDzNzIClINDdBR2dp3DBsqql7KQmJPznZftTzx3zz22xvQDX7
         YbJpiMtmklfH3n4Vke+wXvtyHnELWmX4YjoJFARgvIGlRw1JFriDh+1qMDmrVCG2v/rH
         BG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIy3XRLaFjY5l+EuB8aZIA3XH9hpqtVUH84wU3/P7z0=;
        b=eJyKFLsrh0V/h3Ysu601C4aVgCR5tNgB215Jmu948lVLg6ox1hQSMOuSH1KN4giQvu
         +8JHOk3dOMq7e7FPLWLLOAQvOI/I9hSn4At+p43NzxbTNNW3j+o93S1dWm116De6ZrnB
         kF1Qzw7LPe3FL9sG2qpbdMdYRolg0BicOoC0Jjokf7b7gGs85f02RBXlGv8A3NRL3DF/
         Ew3jNyi4Zvp6FA9uxeIf+xh2oRJ8QYXlE9KHVts3fxedNZjj4lkhOeME9o+dijv9yFkT
         yc8MSS1eW1wM/XEX3aU6AXmou0Yt0k5sCHtf4RSnCT6EHKydzenx3cj8nrj3AtpqUXBP
         xZFA==
X-Gm-Message-State: APjAAAWz7XcD9skJJ4w1cNWmBAHUYyQnYEEg6V4PhhAWIFFI7eGJ69gL
        yh7dk1MP6IePVFGiWA8B600=
X-Google-Smtp-Source: APXvYqyBJsmr1CjUlcDLBmttcGcQwX+oZUPwPqbN1zZqdcZuGw0SM7oqW8R8Nom0iE1PnYe3/30kKg==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr3044547pju.66.1576065115962;
        Wed, 11 Dec 2019 03:51:55 -0800 (PST)
Received: from generichostname (c-73-15-240-142.hsd1.ca.comcast.net. [73.15.240.142])
        by smtp.gmail.com with ESMTPSA id v8sm2855137pfn.76.2019.12.11.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 03:51:55 -0800 (PST)
Date:   Wed, 11 Dec 2019 03:52:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] git-p4: yes/no prompts should sanitize user text
Message-ID: <20191211115252.GB41678@generichostname>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
 <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
 <527b7b8f8a25a9f8abc326004792507f7fe5e373.1575991374.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527b7b8f8a25a9f8abc326004792507f7fe5e373.1575991374.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Tue, Dec 10, 2019 at 03:22:51PM +0000, Ben Keene via GitGitGadget wrote:
> diff --git a/git-p4.py b/git-p4.py
> index 60c73b6a37..0fa562fac9 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -167,6 +167,17 @@ def die(msg):
>          sys.stderr.write(msg + "\n")
>          sys.exit(1)
>  
> +def prompt(prompt_text, choices = []):

nit: remove space in the default assignment

But more importantly, perhaps we should use the empty tuple instead,
`()`. The reason why is in Python, the default object is initialised
once and the reference stays the same[1]. So if you appended something to
`choices`, that would stay between sucessive function invocations.

Since your function only reads `choices` and doesn't write, what you
have isn't wrong but I think it would be more future-proof to use `()`
instead.

Also, here's a stupid idea: perhaps instead of manually specifying
`choices` manually, could we extract it from `prompt_text` since all
possible choices are always placed within []?

Something like this?

	import re
	...
	choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))

> +    """ Prompt the user to choose one of the choices
> +    """
> +    while True:
> +        response = raw_input(prompt_text).strip().lower()
> +        if len(response) == 0:

It's more Pythonic to write `if not response`.

> +            continue
> +        response = response[0]
> +        if response in choices:
> +            return response
> +
>  def write_pipe(c, stdin):
>      if verbose:
>          sys.stderr.write('Writing pipe: %s\n' % str(c))
> @@ -1779,7 +1790,7 @@ def edit_template(self, template_file):
>              return True
>  
>          while True:
> -            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
> +            response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ", ["y", "n"])

Semantically, `["y", "n"]` should be a tuple too so that we emphasise
that the set of choices shouldn't be mutable.

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

Same here.

Thanks,

Denton

[1]: https://docs.python-guide.org/writing/gotchas/#mutable-default-arguments

>                              if not response:
>                                  continue
>                          elif self.conflict_behavior == "skip":
> -- 
> gitgitgadget
> 
