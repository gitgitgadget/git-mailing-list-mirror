Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2111F406
	for <e@80x24.org>; Tue, 15 May 2018 01:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeEOBUX (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:20:23 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38553 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeEOBUW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:20:22 -0400
Received: by mail-yb0-f196.google.com with SMTP id w14-v6so4792678ybm.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MI4UjA1nZDEtIiYDx+dam5Vw0fyk8C0qc4OBVxVLw38=;
        b=MGnsfaIZFgOQyr/rSvicD+PZ4qJL4mhuTPAFmeoQIUBhb0IJPTmKf37q1AeO1smuo1
         uNmHIgne4ax+Egb5jSEse/xGHHOdL/K9t56eD12PCVFgToqMVAklmZvvq4c+KJlwpOSP
         qjROdMUjdh2AWzeNnTQSK3lFulOuT0bOY1wfdNSGCbkjirv9ssQJ6VFq5g7EvAXkodm7
         cKfZ+FSwS15ex22AJQ1UZkoHuV3hNLpDG01aGmpeqhOuOweVd7OfYyFyR196plFxyJau
         ekoTMolGmH6c3BH+cN32AhpC9oqyGeiULMExkrW5VMNQyPxu+ELg77+TKpIkg8j1TcVU
         Zc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MI4UjA1nZDEtIiYDx+dam5Vw0fyk8C0qc4OBVxVLw38=;
        b=KsDvD7vlypuLrZ8nXkK8qIuUEf0piRRAuWvNdRbJGGEJqYQg5gOh1um3ZThIWTUiDX
         Dori3HQu2EAFolkoVXxEJZ78OizD46AY6ksC1luUpl875VOZx2bnrU0XRMfTB0h0rn8C
         N9qTibY/OzsMaVobsTBVQvap11LQy34R8xAptVWpkNXSPp8U7oE/sHOOG8zZurDn/N+H
         etMmAKTDy+sge3mXgtpbSgJFZogDkOh3h3Cpz4daGl4UE+rYHJ1zMOzgv3Xu/zQ1azb6
         26amB/xKqrnzjDHzLDzn7JU/veKsDlNTohvBUJ61UUGGRnRuM/nyCgeGIVoEs7We2Mo1
         A79w==
X-Gm-Message-State: ALKqPwei4XF7e2gnf3OGxUJDMBSEvDYG09Mrg2iMa+CrXC/pDwf8Xlnh
        k+KMv2B1XxtVBCNSHz91KzgXuHQDvc2NlsK1PEZaXaHNzlQ=
X-Google-Smtp-Source: AB8JxZoxsSNwj46+KNfB4uVq76wtEK6xs7UGm/m/ZI4aDbgBRjdvvVzENsuHwEUhJiDGXnjwiR3Qr778fdFdxsvOpWo=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr8167111ybc.307.1526347221740;
 Mon, 14 May 2018 18:20:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Mon, 14 May 2018 18:20:21
 -0700 (PDT)
In-Reply-To: <20180514105823.8378-3-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it> <20180514105823.8378-3-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 May 2018 18:20:21 -0700
Message-ID: <CAGZ79kbx-xsmOFLoi7dkarkwdgZcXwzBfnqo5Hd7bu_veiQOBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/10] submodule: factor out a config_gitmodules_set function
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> Introduce a new config_gitmodules_set function to write config values to the
> .gitmodules file.
>
> This is in preparation for a future change which will use the function
> to write to the .gitmodules file in a more controlled way instead of
> using "git config -f .gitmodules".
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>
> Not sure about the name, and maybe it can go in config.c for symmetry with
> config_from_gitmodules?

What is the function about (in the end state and now) ?
is it more of a
* configure_submodules_config()
  which would convey it is a generic function to configure submodules
  (i.e. it may not even write to *the* .gitmodules file but somewhere else,
  such as a helper ref)
  This doesn't sound like it as we make use of the function in
  update_path_in_gitmodules() that is used from git-mv, which would want
  to ensure that the specific .gitmodules file is changed.
* gitmodules_file_set()
  that focuses on the specific file that we want to modify?
* ...

Let's continue reading the series to see the end state for
a good name.

Stefan
