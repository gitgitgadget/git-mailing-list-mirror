Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99843E784BD
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbjJBPRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbjJBPRx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:17:53 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623EA127
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:17:50 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77428e40f71so877456885a.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696259869; x=1696864669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UuSmfyTl0OILDH3RXOoKwcd/F7wiXVk3kT4HSu35nso=;
        b=VlKOeiZHrjAo/NUcEHmQnFGkVUurS19CalfKgv3Iv29ACwebsqDdhfxS/L0EpsbB79
         DV6Ow/UIjttaZ9dIvAikva/RQRjeg0YB1O22glnmEonG94dVaj1L6Q9UR32CdIHl/VHj
         zBbhIh2LLSydulfjTwr2+LLETuT6OEolMUo+yJxapNz8G7AGaHolq98UT0HtH6AijZg6
         /R05Qe8/QU7s8A8hQxXAxVh16VbkiRoxN/nfP0wC3kmOaRQnhQfLlY8Tb6GK27AYXFuH
         hbYvst/feUYMgs08VbZKjHea8xh4ley5ytIxEPydmiAYf8M7euhMYrTkGqxVhcDIZa+6
         xc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259869; x=1696864669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuSmfyTl0OILDH3RXOoKwcd/F7wiXVk3kT4HSu35nso=;
        b=c/uz/T1C2brwSJDPhB4kmKQTvu2taVo066nwFHtKtLT0wdWq6Wbfk1cnOg9ZZTmhZK
         vp46AbTme9wqwKtSGoQvwR0pZBZJRp1wiK1+jhVt/uDi6tffRd463WK4uCuWfUxN3GSl
         o+HQW1WLfoq6qrp42vFVlfM2unkR4Yy1E+AB6UI4136En+y4VOLEsX3PODwcXpuxVF/3
         auzWu4T99FpXUdsqfEuQYopsYKRe3rTk6dPoMDZ2YwLTPegLvMf8BDqpKDrScfm5OwDA
         8Ks2aj4qYUlNu3cz0S8DnyWkxaLzy9xkXefmZnLKQSFKtQV+6S2dR8c+Iy8LFaW/wRn0
         /k8g==
X-Gm-Message-State: AOJu0YxT1e28Nm3xxQnG1m71ZuRzdgchOwZacs4q6bfBkWZXRDUa35WX
        kLhx8I7JrCOiYttV1CHlxpS/oMBikfnNqWAc1rtu7A==
X-Google-Smtp-Source: AGHT+IHCGu9KjXvLxktKCvmIKK+Ek8yy0e6Cdx4QY+ho+AUaEvP480ADTBsrgc9eXSTbKpVRUwOaSA==
X-Received: by 2002:a05:620a:2490:b0:772:63d9:5264 with SMTP id i16-20020a05620a249000b0077263d95264mr14185857qkn.59.1696259869262;
        Mon, 02 Oct 2023 08:17:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a147c00b007743671a41fsm5651080qkl.72.2023.10.02.08.17.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:17:49 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:17:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 1/12] Next-gen reference backends
Message-ID: <ZRrfHJYDEfdNO4Ma@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Patrick Steinhardt, Notetaker: Karthik Nayak)

* Summary: There have been multiple proposals for reference backends on the
  mailing list. Trying to converge to one solution.
* Problem: At GitLab we have certain repos with large amounts of references.
  Some repos have multi-million refs which causes scalability issues.
   * Current files backend uses a combination of loose files and packed-refs.
   * Deletion performance is bad.
   * Reference lookups are slow.
   * Storage space is also large.
   * There are some patches which improved the situation. e.g. skip-list for
     packed-refs by Taylor.
   * Atomic updates are currently not possible.
   * This is not an issue only faced by GitLab
* Two solutions proposed:
   * Reftables: Originally implemented by JGit (Shawn Pearce, 2017)
      * Google was storing the data in a table with one ref per row. This data
        was encrypted, which changes the ordering.
      * This led to realizing the ref storage itself was not optimal, so based
        on existing solutions at Google there was a proposal by Shawn and was
        implemented in JGit.
      * This solved the ref storage problem at Google.
      * The implementation in JGit by adoption was low because of compatibility
        requirement with CGit.
      * New patch series submitted which swaps out the packed-refs with
        ref-tables while keeping the existing file based loose-refs.
   * Incremental take on reference backend (aka. packed-refs v2) by Derrick
      * Uses pre-existing infrastructure in the git project. Makes it a more
        natural extension.
      * First part was to support a multi backend structure
      * Second part was packed references v2 in the Git project
* Question: How do we take it forward from here.
   * Emily: If the existing backend exists as a library. Might be easier to
     replace and experiment with.
      * Jeff: A lot of work in that direction has already been landed. But there
        is still some bleed of the implementation in other parts of the code.
        Might be messy to cleanup.
      * Patrick: Different implementations by different hosting providers with
        different requirements might cause issues for clients.[b]
   * Deletion performance is not the only issue faced (at GitLab) there are also
     deadlocks faced around this.
   * brian: If you have a large number of remote tracking refs you face the same
     perf issues.
   * Patrick: Any preference of which solution to go forward. GitLab is
     interested to pick this up and mostly going forward with reftables.
   * Reftables does support tombstoning, should solve the problem with multiple
     deletions.
      * There is still a problem with refs being a prefix of other refs.
   * Is there a world where loose refs are removed completely and replaced with
     reftables.
      * Debugging is much easier with loose refs, reftables is binary
        formatting. Might need additional tooling here. This is already proved
        to be working at Google.
