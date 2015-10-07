From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] Add a function to release all packs
Date: Wed, 07 Oct 2015 10:49:49 -0700
Message-ID: <xmqq4mi2va9u.fsf@gitster.mtv.corp.google.com>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
	<cover.1444131898.git.johannes.schindelin@gmx.de>
	<9953f8ed40d0cf99f1be7cfe2fa0b699b7769645.1444131898.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 07 19:50:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjsqm-0000MY-2v
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 19:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbbJGRt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 13:49:56 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35835 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbbJGRtz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 13:49:55 -0400
Received: by pacfv12 with SMTP id fv12so28144722pac.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gidJf6bAq+7rQqj9MYqWsp7VUdAgV/Zc9BMpKtVGPwM=;
        b=J677kDzHAzUkzE6bxJLkv8JuZLmKdy65nHerJ0G99aqR2SxRvwRy/oxo1ThCi6ZGxQ
         8nMvDDRwqL3CDtF68TFoJkVJVV7AM3mrcSCMVEyLD1DuQ25f2sD7jwRmeOWTFFRJty9m
         6JABsmjIo0BMiHksn82wVtKhjngaZAPiWq+Cvh+hASYXkvGmrNVkZunCi/mPlPLBqIH8
         f89OMZhofs/E0EHBKvRRj6sNmCo0TzLPXWCUlKCxFUvJP1GuWvKfV8raLj+zedmCYbCh
         WCA8jCOcSzdgkdU4l1baRlIevySzIptwQo+IIV6IQaPZuPjOrXHivWhMN+UyfSAiJTiS
         9Szg==
X-Received: by 10.66.159.66 with SMTP id xa2mr2554081pab.28.1444240194618;
        Wed, 07 Oct 2015 10:49:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c434:fdeb:15ec:325c])
        by smtp.gmail.com with ESMTPSA id dk2sm40641651pbd.57.2015.10.07.10.49.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 10:49:54 -0700 (PDT)
In-Reply-To: <9953f8ed40d0cf99f1be7cfe2fa0b699b7769645.1444131898.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 06 Oct 2015 15:18:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279189>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On Windows, files that are in use cannot be removed or renamed. That
> means that we have to release pack files when we are about to, say,
> repack them. Let's introduce a convenient function to close them
> pack files.
>
> While at it, we consolidate the close windows/close fd/close index
> stanza in `free_pack_by_name()` into the `close_pack()` function that
> is used by the new `close_all_packs()` function to avoid repeated code.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

This is the only one that was updated among the four and the change
looks sensible.  I'd reword the end of the first paragraph of the
proposed log message, though, to replace "close them pack files"
with "close all the pack files and their idx files".

Thanks.  

>  cache.h     |  1 +
>  sha1_file.c | 23 ++++++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 752031e..57f6a74 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1275,6 +1275,7 @@ extern void close_pack_index(struct packed_git *);
>  
>  extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
>  extern void close_pack_windows(struct packed_git *);
> +extern void close_all_packs(void);
>  extern void unuse_pack(struct pack_window **);
>  extern void free_pack_by_name(const char *);
>  extern void clear_delta_base_cache(void);
> diff --git a/sha1_file.c b/sha1_file.c
> index 8c3c913..ca699d7 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -798,6 +798,25 @@ static int close_pack_fd(struct packed_git *p)
>  	return 1;
>  }
>  
> +static void close_pack(struct packed_git *p)
> +{
> +	close_pack_windows(p);
> +	close_pack_fd(p);
> +	close_pack_index(p);
> +}
> +
> +void close_all_packs(void)
> +{
> +	struct packed_git *p;
> +
> +	for (p = packed_git; p; p = p->next)
> +		if (p->do_not_close)
> +			die("BUG! Want to close pack marked 'do-not-close'");
> +		else
> +			close_pack(p);
> +}
> +
> +
>  /*
>   * The LRU pack is the one with the oldest MRU window, preferring packs
>   * with no used windows, or the oldest mtime if it has no windows allocated.
> @@ -906,9 +925,7 @@ void free_pack_by_name(const char *pack_name)
>  		p = *pp;
>  		if (strcmp(pack_name, p->pack_name) == 0) {
>  			clear_delta_base_cache();
> -			close_pack_windows(p);
> -			close_pack_fd(p);
> -			close_pack_index(p);
> +			close_pack(p);
>  			free(p->bad_object_sha1);
>  			*pp = p->next;
>  			if (last_found_pack == p)
