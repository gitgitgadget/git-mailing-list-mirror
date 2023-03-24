Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E97C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 15:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjCXPBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXPBP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 11:01:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD041A672
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 08:01:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ja10so2040499plb.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679670074;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PdbQQ0PamVNWu/RsZLH/tdjl7iehnJH5XLw3KGNAYI=;
        b=OnNqw9qF1HfQFAVqdE6RfnFZVtH+iVgzCsOVvPwE1cWZwWLsPPLTdGOHlrs32qd8qV
         1ziTcrN07lRjnTpVCZwbhCiC+JGxOa6976vLEPL/I0hwhCx1FNmr/4eOUQVl4ZESzQYR
         W+NyScQ1GT5UrSPGsyQEb0haI8bV1ud5E6PT7a+d431eqM5aFEI04McuEsmT6VR3U8m7
         ZMx6SfoLr2eVMKhYFQnzlncByIPMdc1Aq36nqiDJRbRtwzhh9yhBiioXPxNOBV4Ux5cq
         xvjWvSB2RyE6vLLKhKyxZlLwKTVwuxJjTKxmuyslGGvuKNrnBS9eX3jRTqHByzqYTdWw
         HquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679670074;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6PdbQQ0PamVNWu/RsZLH/tdjl7iehnJH5XLw3KGNAYI=;
        b=yA8pWAABULKnzsGvaNd3VO6nU29lTCLOhAue/srMfr1uRVXGVaGKgv6Yn6/fS08+Bq
         SAk6w0WwZi62LqfAgpqzJIqFbqfDqXpJtRWJmP7UvQd9joLJKgqoRxGIYhvbwxm38MgZ
         HWyPxiYSfdtVBilSMU+dhbiKgvxqO2r/pr71c1jWMhbWpzPIZJn3877xlfXcRB7RPkwO
         ER/3fjGDsuT2r2/5aglrEG8t00APAqIkKojUDNl/+Ya7g9wj1e/dbasAD+EjsKfT/Whl
         BdfsLEAqvq+YtTrrgaxv1oWCsxqm0WfvehTr1V/52Rb0mCkOyNsv2goQk+RCd529n6xp
         5uvQ==
X-Gm-Message-State: AAQBX9e5CcPm9ZGg5Ap3h+R1MmCs1uUx6AAflRgyEVt3/2zNDBjwGPLi
        OjB0eXkQayfqbSGEk2FtzFI=
X-Google-Smtp-Source: AK7set8IYnD4ZMfGMC3hQbjOxYxZ2fhZrGDRaQMoQBhIPcRIHeHYXzLDgPGkC1JhKPWHLF1v0FZHhw==
X-Received: by 2002:a17:90b:1b0c:b0:237:f925:f63 with SMTP id nu12-20020a17090b1b0c00b00237f9250f63mr3249922pjb.13.1679670073819;
        Fri, 24 Mar 2023 08:01:13 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id i1-20020a635401000000b004fbfefd5183sm13446726pgb.80.2023.03.24.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:01:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: rewrite save_head() in terms of write_message()
References: <20230323162235.995544-1-oswald.buddenhagen@gmx.de>
Date:   Fri, 24 Mar 2023 08:01:12 -0700
In-Reply-To: <20230323162235.995544-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Thu, 23 Mar 2023 17:22:35 +0100")
Message-ID: <xmqq1qle5h3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> Saves some code duplication.

There are two and a half small behaviour changes, but I think it is
a good change overall.

 - We used to fail with "could not lock HEAD", but now we give the
   real filename for "sequencer/head", when the locking fails.

 - We used to write the file in a single write_in_full() call, which
   in practice would have been done in a single write() system call.
   Now we do it in two steps, the body of the line in one, and a
   single terminating LF in another.  Also, there is a new error
   mode (object name gets written successfully but writing the
   terminating LF fails) with a new error message.

The former is definite improvement that may help debugging when
things go wrong.  The latter should not be measurable. The new error
mode probably is not noticeable in practice.

Looking good.  Will queue.  Thanks.

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>  sequencer.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..ff985fb2e9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3187,25 +3187,7 @@ static int create_seq_dir(struct repository *r)
>  
>  static int save_head(const char *head)
>  {
> -	struct lock_file head_lock = LOCK_INIT;
> -	struct strbuf buf = STRBUF_INIT;
> -	int fd;
> -	ssize_t written;
> -
> -	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
> -	if (fd < 0)
> -		return error_errno(_("could not lock HEAD"));
> -	strbuf_addf(&buf, "%s\n", head);
> -	written = write_in_full(fd, buf.buf, buf.len);
> -	strbuf_release(&buf);
> -	if (written < 0) {
> -		error_errno(_("could not write to '%s'"), git_path_head_file());
> -		rollback_lock_file(&head_lock);
> -		return -1;
> -	}
> -	if (commit_lock_file(&head_lock) < 0)
> -		return error(_("failed to finalize '%s'"), git_path_head_file());
> -	return 0;
> +	return write_message(head, strlen(head), git_path_head_file(), 1);
>  }
>  
>  static int rollback_is_safe(void)
