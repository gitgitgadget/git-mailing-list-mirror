Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D54ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 16:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiIIQhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 12:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIIQhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 12:37:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408114050D
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 09:37:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so5863248pjp.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=KbWPX7Ma8twfjKQrPTRsvNjDLYnx6LdS4KDSlznX1h0=;
        b=n9KsdODutOznXtahkatKQDqp8I+5LOpAhs9pLdHY6rUm7M7NYp0OvV11Of0h/Px1e6
         uhc0YiWYYMYxVpCKEh2t1YEMhIco1gS0saNUOTRxNmhZRNP+YXB4Su8sUZuLRfdI7KLP
         m6pGA6UVjOWAO7PHcfD5Fdhzv6+cBUdRi6v7bhMbyPcTjWtOZg0XN02HobHUrkdZB+oW
         LULlKL/3jbMd92U9txhUVAYpPyETxqJ+6ntU6MtAJHCgRqkKF+MuD5OiKLxuN+axH+vd
         zsGT70OX4lu9XzM8soHuLS0KekJMFPXohU/1WxJ1PSGFqLordiwS+q1ZQiYslOHTaewv
         4cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=KbWPX7Ma8twfjKQrPTRsvNjDLYnx6LdS4KDSlznX1h0=;
        b=oUAcu8OOXrSXL1yq+uyUmlna1DV0o8OmiTrg/aWkS9+F0brGwmRhfcn1L/cEUkQO1i
         9GK3Qqhki1TEL5peBxLFMzXmg+El9Xywjkgk/hJ48rr0qvH9ufZTXpQ9VzYrqw1JZDX5
         YdmzOEHEID3DHctuYftE8/538jkbctn0bW5Sy4VthHO6kU4wnX7offuav0iJWSpxpqCz
         9y+EKOc6ZTEHMxcHkaRDCjO9aUVr9VnnnE4vt5R47xldig/DeqB6FJbW6f5nQo489F4G
         UwFYQUjWUO/kxkhTLpGjiFZ1PNnGnDQMIRBrJmhBk2LK6Ec4l9ci89ZldPSm0wGtX95j
         YtfA==
X-Gm-Message-State: ACgBeo1ieIJ4TgtR98+dfpCbHFDxYwWDM/lscKOzeYa3TZz//r0M+Q3R
        C0VNOe7fS4VBEujx5PPo0mw=
X-Google-Smtp-Source: AA6agR6qZdrdc4+X6SM/evdhoz8seU5kyy442rx8zQjx4TqPPSpQXIfWEBSzbawU4HQwvbz9+IZEXA==
X-Received: by 2002:a17:90a:28a5:b0:200:43bc:5728 with SMTP id f34-20020a17090a28a500b0020043bc5728mr10553850pjd.188.1662741424148;
        Fri, 09 Sep 2022 09:37:04 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e7-20020a056a0000c700b0052e6d5ee183sm746271pfj.129.2022.09.09.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:37:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        peff@peff.net, vdye@github.com
Subject: Re: [PATCH] builtin/mv.c: fix possible segfault in add_slash()
References: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
        <3cbfd1b4-7699-1301-042c-fdadea649066@github.com>
Date:   Fri, 09 Sep 2022 09:37:03 -0700
In-Reply-To: <3cbfd1b4-7699-1301-042c-fdadea649066@github.com> (Derrick
        Stolee's message of "Fri, 9 Sep 2022 10:14:00 -0400")
Message-ID: <xmqq35d0mrm8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 9/8/2022 7:02 PM, Shaoxuan Yuan wrote:
>> A possible segfault was introduced in c08830de41 (mv: check if
>> <destination> is a SKIP_WORKTREE_DIR, 2022-08-09).
>> 
>> When running t7001 with SANITIZE=address, problem appears when running:
>> 
>> 	git mv path1/path2/ .
>> or
>> 	git mv directory ../
>> or
>> 	any <destination> that makes dest_path[0] an empty string.
>> 
>> The add_slash() call segfaults when dest_path[0] is an empty string,
>> because it was accessing a null value in such case.
>
> It doesn't _always_ seg fault, since we have tests that cover this
> case. Adding this change will cause t7001-mv.sh to start failing
> in many places:
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 2d64c1e80fe..8216680ad3c 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -71,6 +71,10 @@ static const char **internal_prefix_pathspec(const char *prefix,
>  static const char *add_slash(const char *path)
>  {
>  	size_t len = strlen(path);
> +
> +	if (!len)
> +		die("segfault?");
> +
>  	if (path[len - 1] != '/') {
>  		char *with_slash = xmalloc(st_add(len, 2));
>  		memcpy(with_slash, path, len);
>
> I suppose it is better to say "could segfault". Running the test
> under --valgrind also causes a failure. It covers both cases, "."
> and "../".

While "could segfault" is of course more correct, I do not see a
huge difference here, but that is only because I learned to equate
"segfaults" in our log messages with "makes an access to
inappropriate memory address".

If I were to suggest updating the proposed log message, I would
rather spend a bit more bytes to explain what callers expect
add_slash() to do, why they call the helper for.  It would make it
obvious why it is the right behaviour the callers expect for the
function to return an empty string as-is.

I _think_ the reason is that the caller of add_slash has the name of
a directory in the working tree (relative to the root of the working
tree) and wants to add strings to form pathnames to things in the
directory.  They have "Documentation" directory and are told to move
"Makefile" from somewhere into it, so they pass "Documentation",
want "Documentation/" back, to form "Documentation/Makefile" by
concatenating.  If they are told to move something to the toplevel,
the target would be originally given as "." and while driving the
machinery to rename something to "./Makefile" might also work,
because the pathnames are normalized fairly early by removing excess
dots and resolving double-dots, the actual 'path' passed to
add_slash() by the caller in this case is an empty string, not a
single dot.  And "move this Makefile sitting somewhere else to ."
means "the path to the resulting file is Makefile" (as opposed to
"the path to the resulting file is ./Makefile"), which is correct.

Of course, I expect the log message to explain it a lot more
concisely, instead of spending more than a dozen lines ;-)

Thanks.

