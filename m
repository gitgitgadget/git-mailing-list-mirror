Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC302C4BA2E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20EB2072D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582752923;
	bh=KJmdrb2bANLpqSXOMh+XodHq6ceIOpQMPOdjxawPRQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x6DsWkGsuJEd7uiAf9iz7ci/lMwjWwgUP87YzebBc6suOJgTPoy0p5Lu7o3GRQrTw
	 IaaJKbeIlxyoo3H1+neY3mRBcmMpNFalvP0vmdRXCTGLF6lL7eqTicSowteHGjBW3b
	 3oioqtHdyiaGhRdt7qFXiQi7iL3/VDxEaZNj4Rgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgBZVfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:35:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44550 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgBZVfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 16:35:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so602640wrx.11
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 13:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2KENT8zLGFZ/R202Ku/kbqbb0Yeni6m4pIKrgGpzQg=;
        b=CZ201YYzjP21Y2y6Y5l7jBtyeNlP2X/+b2I1M6Seti7CeZ7hTS/Mb4rPALvjUvVXkL
         nEEjwu0hGrkLzGtEAc5yuh2G2wZATQZ/YXHgx04+tDJ7pkUDVtejAAPk8BqG9LOT/iOq
         YoLbGIH7jF6tOLO5qVYBKN0RY2legT3A0YKqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=I2KENT8zLGFZ/R202Ku/kbqbb0Yeni6m4pIKrgGpzQg=;
        b=nn7b1IhQ3c6c5RDT5yVbR6/Q6LEFwNnwVTRFjrVvEmAHBz/9zCMYzRAuSFC/s+Amo7
         dRXHdmUL8ORD1nOAW5EY/KBoxPLTfOn0+9iQ2OXX2AQUmyWol+c1Y/kU2bHChU9ziWu/
         Mpt0uF2aaXx9/wf33+aRhHoTOUnJiWBtpHrUUaXQV7K8+p9TfLGcjd0If2LKQ+Nespy0
         0TU/YcQ0Ys80/A2DFFjeRYu9j0XwRAzXmvmq2W+UPJlmIOIFYuk5d5p1Lf/YtvW6MZd0
         9+NNo/yqs2CD1ZDKXDe7AOpvFHeyoBs7k625eaTA1EWxG45UfTaK+JAU5ejzJcXluhWh
         SotQ==
X-Gm-Message-State: APjAAAVaB5155EHmAWkU4a1s+Wz+fBAB0yKadsi4Ve21FZ7e2CTIgWH6
        hCPRQsjfr8+kLJZay7IzzaSY36JOGR5R9w==
X-Google-Smtp-Source: APXvYqwjV0191y3hLf+IqIACkAsz5d20lLpsT9d/M3NA7ilmJYbvuN+Nceb13e23o3/sjKNPLXpWWQ==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr685426wrq.153.1582752919517;
        Wed, 26 Feb 2020 13:35:19 -0800 (PST)
Received: from chatter.i7.local ([185.220.101.75])
        by smtp.gmail.com with ESMTPSA id a7sm986259wmb.0.2020.02.26.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:35:18 -0800 (PST)
Date:   Wed, 26 Feb 2020 16:35:15 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, vegard.nossum@oracle.com
Subject: Re: Making GitGitGadget conversion lossless
Message-ID: <20200226213515.t2aa4o4nquaaz6vg@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vegard.nossum@oracle.com
References: <20200226200929.z4aej74ohbkgcdza@chatter.i7.local>
 <xmqq5zfthxlw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zfthxlw.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 01:01:15PM -0800, Junio C Hamano wrote:
> Isn't this already available by recording the base-commit
> information?
> 
> > - author/committer information
> > - cryptographic attestation (gpgsig)
> 
> I think you are aiming to come up with bit-for-bit identical commit
> the sender had, and I would imagine that the easiest and least
> disruptive way to do so is to add a compressed and ascii-armored
> copy of "git cat-file commit" output of the original commit after
> the "---" line before the diff/diffstat of the e-mailed patch.  The
> receiving end can then act on it when given some option by
> 
>  - first recover the contents of the commit object (call it #1);
>  - learn the parent commit(s) and check out the tree;
>  - apply the patch in the remainder of the patch e-mail to the tree;
>  - make sure that the result of patch application gives the tree object
>    recorded in #1;
>  - run "hash-object -t commit -w" over #1 that gives you a commit
>    object that is bit-for-bit identical.

Right, I just don't want to be doing this in a separate tool. :)

> As I said already, I do not think that the desire to get the
> bit-for-bit identical commit is compatible with the idea to discuss
> e-mailed patches---the pieces of patch e-mail will become "you may
> look at them, you may apply them, but it is no use to comment on
> them to get them improved".

I disagree -- specifically from the attestation point of view. One of 
the drawbacks of platforms like lore.kernel.org is that it creates an 
opportunity for a malicious actor to compromise it and modify patches 
that they know will be downloaded and applied by Linux maintainers -- so 
my goal is to ensure that we do not have to trust lore.kernel.org in 
order to trust patches downloaded from it. This means some mechanism for 
end-to-end patch attestation.

There are two avenues that I am pursuing for this purpose:

1. being able to submit attestation information out-of-band, see 
   discussion here: 
   https://lore.kernel.org/workflows/20200226172502.q3fl67ealxsonfgp@chatter.i7.local/T/#u
2. being able to preserve commit signatures as they are converted into 
   patches and back

I know that it is very uncommon for patches to be applied without any 
changes, because the maintainer would almost always add their 
Signed-off-by trailer before applying it to their tree. However, 
preserving full commit metadata allows checking cryptographic 
attestation *before* adding trailers or making any other edits, for 
example by making a shallow clone of the worktree, applying the series 
"verbatim", as you describe above, and then verifying the signature at 
the tip. If "git verify-commit HEAD" is successful, then the maintainer 
can be assured that patch contents have not been modified between when 
they left the developer's system and arrived at the maintainer's 
workstation.

This means nobody needs to trust me or other members of the sysadmin 
team responsible for lore.kernel.org in order to trust patches they 
retrieve from it.

Best,
-K
