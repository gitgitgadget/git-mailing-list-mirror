Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D63C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 20:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FAC206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 20:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uM9uMNR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCYUq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:46:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41431 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYUqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 16:46:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so1730974pgm.8
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9+QCVN5TxTZXYmHYiluKhu8YgPdDUq515bhBT0wxmA=;
        b=uM9uMNR2Ak772Td45KNMhlQhFSYOZ8ePhwJnEebVKINYDvhjy+4mND3UwjcU3Kg3Ak
         PSTg0xQd47FuiaBxYtwv4vYpUmj4wkXkPu8jNU1A23sM04cSmrXXalmpjO4wroUuXS9P
         GBzUsvkCMK1pb4wXo+CnhkqDZTlSW40HHenQC10mX3dYa4+DkIQXpF+Ap9iZGsZY/uhP
         4rJE2OM6p8ZW6wfMWJvZX08txf4HPcRCTLAywUDuCyvryS/Y+ldvBtt2rW48C3Bg0TXT
         geoZCMeMOc6cEZ+UWS13FS3MycRRtvYKlgVKwiTxvVIAps7MkGsiNM+MOGJPmrB02MER
         0ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9+QCVN5TxTZXYmHYiluKhu8YgPdDUq515bhBT0wxmA=;
        b=jYj0iFv93CEe5bt1JbTi13zRTYiUn3UFesOKHv1fS5HVxR/Ms5HLHA+sbZEnzokNRe
         FmY5Ci1dPemIg4hALCFldYw3+fk5n22ay1z1YgzkdC/r1ftRDTs1G4dUdHMWNYxSThRg
         i9iNW5M1i1mmrDkzu5FQ7KAqomXiVV1rARk/oAD74t1RGmmt+1Sbb9TeiyuWp9xneISe
         pYe6QU5TUhfzqxwdo73zD1MoaZVWgaAIWhVkQnBuOJs8s5+tuMxFYtS5DCEfPhfZd7Ke
         0UFkrbhFspwleAjyFMQL+SUv4GSsqsC7HRXS/PP7sTtEDk6p4xXPEntxt7mLm4VO/cZ3
         N9XQ==
X-Gm-Message-State: ANhLgQ1+4TPMpwQLdDaNKvSFe7oUugG91Pd1Z0OWBnlMft3HFkZAlIVt
        IjxXQKPHPAGfYDZzxx3/J5r39w==
X-Google-Smtp-Source: ADFU+vsTqsbmiyWbyeRN/wsNIyg2v/ErNaa4/haArTKHu3eqOzkUH+yZ6oZ7tqJi75lA7+j74m1YeA==
X-Received: by 2002:a65:55c6:: with SMTP id k6mr5181625pgs.52.1585169182890;
        Wed, 25 Mar 2020 13:46:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a185sm37582pfa.27.2020.03.25.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 13:46:22 -0700 (PDT)
Date:   Wed, 25 Mar 2020 13:46:17 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/2] revision: document get_reference()
Message-ID: <20200325204617.GA53368@google.com>
References: <20191228003430.241283-1-jonathantanmy@google.com>
 <cover.1578781770.git.jonathantanmy@google.com>
 <6dce9c79be3b9264f832852e9068347f42cf3ee0.1578781770.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dce9c79be3b9264f832852e9068347f42cf3ee0.1578781770.git.jonathantanmy@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 11, 2020 at 02:34:55PM -0800, Jonathan Tan wrote:
> In particular, document the behavior when the object is corrupt. The
> existing behavior when parse_object() encounters a hash mismatch has
> been there since cc243c3ceb ("show: --ignore-missing", 2011-05-19), and
> the existing behavior when the code disagrees on whether an object is a
> commit has been there since ec0c5798ee ("revision: use commit graph in
> get_reference()", 2018-12-28).

Does "disagreement on whether an object is a commit" count as corrupt
object? Otherwise I'm not seeing mention of it in the comment that was
added.

> ---
>  revision.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/revision.c b/revision.c
> index 8136929e23..91ca194388 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -355,6 +355,16 @@ void add_head_to_pending(struct rev_info *revs)
>  	add_pending_object(revs, obj, "HEAD");
>  }
>  
> +/*
> + * Returns the object corresponding to "oid" and sets the given flags on
> + * it.
> + *
> + * If that object is missing or corrupt, this function returns NULL if
> + * "revs" permits it (that is, if revs->ignore_missing is true or if
> + * revs->exclude_promisor_objects is true and the object is a promisor
> + * object), and dies otherwise. Note that corrupt objects are treated

The parenthetical is hard to parse. Is it "(revs->ignore_missing is
true) or (revs->exclude_promisor_objects is true and the object is a
promisor)" or something else? Maybe an extra comma,

  (that is, if revs->ignore_missing is true, or if
  revs->exclude_promisor_objects is true and the object is a promisor
  object)

> + * like missing objects, to preserve existing behavior.
> + */
>  static struct object *get_reference(struct rev_info *revs, const char *name,
>  				    const struct object_id *oid,
>  				    unsigned int flags)
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
> 
