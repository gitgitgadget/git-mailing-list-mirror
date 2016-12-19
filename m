Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CD651FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932752AbcLSXTc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:19:32 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35033 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbcLSXTa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:19:30 -0500
Received: by mail-qt0-f178.google.com with SMTP id c47so161906285qtc.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MB1PBf8mQxIp0oIqR7BpydP+kg0Tzk7q3yVyNR+HtQo=;
        b=Uy9fEAfQSKK2QF0nUKlna4kxinCld2O5lBm6MRSMNygZtQEw7VLv0L960/BozvLLrC
         5xCcHI5AT0Po3JM/94KcsDIynh0c5xicN35tVSA2ne+cUlEMLDNc3bWf92RsbsieS8gz
         +dRW7dxrLvgM2a2ekC8uRH/PcxM1fXHTlSvB+YjU7YJLyMtsf8qubAg6ZvrRvtiWxIeQ
         glrIVlA6+kdLrGoExT3+igY/WQqP3l5fTus9XmCuK1JDP3+PWO5K++b0SosqtRT3FohY
         GjgU3CHYrQkqIxJCXIzJPOvPtO8yB0Ub+jxgv/V841QBIiNoJ9pH6NI3ZA26GMBqVxr3
         0VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MB1PBf8mQxIp0oIqR7BpydP+kg0Tzk7q3yVyNR+HtQo=;
        b=Cguicdj/BiHOGOl98L73fb/LDf1AT3/cPx7vFwtDIOYYvUhknwghOwgL4V1/fhKOXY
         IjjSzrPhohWXa+4Ja8mmQvZc/nQWfzJQW/0IL9wJKRbUOuVvLylbnqGDVPlyJY5Tb1KD
         bDSS9iFEeZKLxMBM+SIiuJrLChEjW8whHICF83zc+kTrPRWjaTGl65bDz2iI9RDxx6PY
         2cFfn6BVIKpIc/af0Ziqk1y0zBa4L999n2jxEGNVCIWura2R7na8tCeuFU8vPdjD+ZHz
         YpsTpZvMu9dEbn7kygg6hy9rmLkBlcSXZTNFn7CbuCeNYEWIBWOLs8AJOFgx3R1pOn3i
         6kCw==
X-Gm-Message-State: AIkVDXK2cUyTGgW39rlHBU4zSmAI8e1/NjL+5QwFqtJHYbxYDu6GR3hDZ1g0SEI5iSNwKMmojn6174OPxm6ry9pO
X-Received: by 10.237.34.206 with SMTP id q14mr17210353qtc.101.1482189569306;
 Mon, 19 Dec 2016 15:19:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 15:19:28 -0800 (PST)
In-Reply-To: <20161219222551.GA41080@google.com>
References: <20161219215709.24620-1-sbeller@google.com> <20161219215709.24620-3-sbeller@google.com>
 <20161219222551.GA41080@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 15:19:28 -0800
Message-ID: <CAGZ79kZoiFfi9+-yqHZmF3Ofp3X-CV6s0qg1bm2CRpN-ETbDLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dir.c: add retry logic to relocate_gitdir
To:     Brandon Williams <bmwill@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 2:25 PM, Brandon Williams <bmwill@google.com> wrote:
> On 12/19, Stefan Beller wrote:
>> Relocating a git directory consists of 3 steps:
>> 1) Move the directory.
>> 2) Update the gitlink file.
>> 3) Set core.worktree correctly.
>>
>> In an ideal world all three steps would be part of one transaction, such
>> that either all of them happen correctly or none of them.
>> However currently we just execute these three steps sequentially and die
>> in case of an error in any of these 3 steps.
>>
>> Dying is ok in 1) as the transaction hasn't started and the state is
>> recoverable.
>>
>> When dying in 2), this is a problem as the repo state is left in an
>> inconsistent state, e.g. the git link file of a submodule could be
>> empty and hence even the superproject appears to be broken as basic
>> commands such as git-status would die as there is it cannot tell the
>> state of the submodule.
>> So in that case try to undo 1) to be in a less sufferable state.
>
> I now see why an atomic filesystem swap operation would be useful :)
>
>>
>> 3) is less of an issue as experiments with submodules show. When
>> core.worktree is unset or set incorrectly, git-status still works
>> both in the superproject as well as the working tree of the submodule.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  dir.c       | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>>  dir.h       |  6 ++--
>>  submodule.c |  3 +-
>>  3 files changed, 91 insertions(+), 12 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index b2cb23fe88..e4e3f69869 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -2749,30 +2749,66 @@ void untracked_cache_add_to_index(struct index_state *istate,
>>       untracked_cache_invalidate_path(istate, path);
>>  }
>>
>> -static void point_gitlink_file_to(const char *work_tree, const char *git_dir)
>> +/*
>> + * Just like write_file, we try hard to write the full content to the file.
>> + * If there is suspicion the write did not work correctly, make sure the file
>> + * is removed again.
>> + * Return 0 if the write succeeded, -1 if the file was removed,
>> + * -2 if the (partial) file is still there.
>> + */
>> +static int write_file_or_remove(const char *path, const char *buf, size_t len)
>> +{
>> +     int retries = 3;
>> +     int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
>> +     if (write_in_full(fd, buf, len) != len) {
>> +             warning_errno(_("could not write '%s'"), path);
>> +             goto err;
>> +     }
>> +     if (close(fd)) {
>> +             warning_errno(_("could not close '%s'"), path);
>> +             goto err;
>> +     }
>> +     return 0;
>> +err:
>> +     while (retries-- > 0) {
>> +             if (file_exists(path))
>> +                     unlink_or_warn(path);
>> +             else
>> +                     return -1;
>> +     }
>> +     return -2;
>> +}
>
> Any reason why on attempt 2 or 3 this would succeed if it failed on try
> 1?
>

This code is heavily inspired by refs/files-backend.c which upon
closer inspection only retries directory things within the git directory
(which is assumed to be accessed in parallel by different invocations
of Git)

So I think we could drop the retry logic.

>>  {
>> +     char *git_dir = xstrdup(real_path(new_git_dir));
>> +     char *work_tree = xstrdup(real_path(path));
>> +     int c;
>
> I guess in a later patch we could clean up these calls to real_path to
> use real_pathdup from bw/realpath-wo-chdir.

good point.
