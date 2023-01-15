Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD53C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 21:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjAOVpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 16:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAOVpl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 16:45:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFC2F77C
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:45:40 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so29325638pjj.4
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQd1htaxeKe3/f/E6E0pDJv558rXjERLcirzk2ohBG0=;
        b=g5MC63r86JcLICQtL6lz1XnOwU5eya0TyEhbhn3UTKm5XI1IA4/TKTDfYkh0vz2W4A
         v2NS27LKKGsIjkRRdSd3fknw4O4xiVvOdy2ivK2UarDC5+La2wvejHhyDyUUr/lA+T9X
         zM8QYCQr9dIJkkyfwWM9b42J+EPJGV8ETDaNdbia0B/steCuxCSm1PetfGzaWuVQYa+Q
         mNwQ/GmvnD5JCjW9OdzBFY1lE80R/a+0r/nJ4TKCL8bc+yQrijiA/JOG+dRAvyYMQ8/s
         mcFCEGsWpn2n6CTWywi7hG5vfRiKrKTqBq+FlYhey7IZIJ4OK8lfbovg6v0UK0ZWgn0u
         AFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RQd1htaxeKe3/f/E6E0pDJv558rXjERLcirzk2ohBG0=;
        b=H9KQmTMYQV2L/kRlThjzAXCIaZ9/CKYMOXgllY+VkVlPrgIFdK3+w3ueuw7EfPbasS
         2mJW1W7YXd42E/D+fHsFXx5hzHaSCOAmQP5QaTgPMR0VkYOmBPlH8IkMmwRd3nXSpVFr
         GjlwGDV5yZLeHijxe3cJvhaQL8bEv/GbZkENrw6a7cvtdevU0qc9m3NHhKGQEgj29KkC
         aTE4Hy00j4Cn0cOsdR2279p0bAhSO1hQhfP8aMtjfEeK0ka7F3NZ01xuHh/uaWcPrmRh
         SiSZip2Ujix7VylkD5CycTDrala3CeVa2cPaClMEnf0z+VAmAECh6oHubCOlpXVl/Gos
         MOSA==
X-Gm-Message-State: AFqh2ko+e/KJIWLhWEAUjhJvvvLVs5WG9wmnfmWBbFZRTnTqmEaWdvvy
        shN5nXezfdy0l4b80pZPIWM=
X-Google-Smtp-Source: AMrXdXseFYlACsOls33ZhdhZ5Zv/GG2BfGmtR/WF9MJYsNBCEC5OJmt+8c+IPg8OTv8gCzc6beEt5w==
X-Received: by 2002:a17:90a:f609:b0:228:cda9:f608 with SMTP id bw9-20020a17090af60900b00228cda9f608mr21956866pjb.15.1673819140339;
        Sun, 15 Jan 2023 13:45:40 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090a298100b00225ab429953sm3406702pjd.6.2023.01.15.13.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 13:45:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 2/3] http: prefer CURLOPT_SEEKFUNCTION to
 CURLOPT_IOCTLFUNCTION
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
        <Y8Rd0KXYcHKykvjq@coredump.intra.peff.net>
Date:   Sun, 15 Jan 2023 13:45:39 -0800
In-Reply-To: <Y8Rd0KXYcHKykvjq@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 15 Jan 2023 15:10:56 -0500")
Message-ID: <xmqqilh7fp4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The IOCTLFUNCTION option has been deprecated, and generates a compiler
> warning in recent versions of curl. We can switch to using SEEKFUNCTION
> instead. It was added in 2008 via curl 7.18.0; our INSTALL file already
> indicates we require at least curl 7.19.4.
> ...
> +	if (offset < 0 || offset >= buffer->buf.len) {
> +		error("curl seek would be outside of buffer");
> +		return CURL_SEEKFUNC_FAIL;
>  	}
> +
> +	buffer->posn = offset;
> +	return CURL_SEEKFUNC_OK;
>  }

Now we depend on having at least cURL 7.19.5 because
CURL_SEEKFUNC_{FAIL,OK} are not available before that version.

cf.  https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions#L127

Which is fine, as 7.19.5 is from May 2009 that is old enough.  We
just need to update the place where you got the 7.19.4 above from.

Thanks.
