Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC5FC77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 22:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbjEKWlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbjEKWlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 18:41:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BE25584
        for <git@vger.kernel.org>; Thu, 11 May 2023 15:41:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba6939e78a0so9190419276.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683844867; x=1686436867;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2StT1VwqACDseDtPB469qJ968iqKs343+VBCtXIhGXs=;
        b=2c7cfUCWlYDOqKgJbSH6k7fO8PBzvaAu6PAQjguVzc6hS3KzswTH4e3WTS88GLeAlm
         fl9yuVZLgBgnqjnAC2N8WMHwzfgeuZqxZ/pibx2ePK2ypuxE6fSncQy6L1SSQriYD3A4
         AjctIhKjXfCwP62oXQhpwlZBTjMSALSKdzqAkEl8+tDrRQyhehe5u5c9/+KQVdS9ONLU
         arEOadl86sQ+sbL2EXAlq+SlvkHPJUJO8RpN+v5p4V4Xk0xa/xqFoa+PO32jhgxag8uy
         Lr0/SHtS7fFw06MHRg7KQqbViQNqV4RNHy8V3DxenX30jCJI76gCkauFRNg41K4tXpEW
         CwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844867; x=1686436867;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2StT1VwqACDseDtPB469qJ968iqKs343+VBCtXIhGXs=;
        b=P6ufhviY2rFyt9UGWCvbwjWqamYcHPT1s/XhMPwGtFcOYjJeCZmpiYNZMU1mSUdKC5
         lMQx26yNBcvqnLZKDQqPao9+NydftTiepYovl/VPf+iNh4SWtsZp4HCfj+ThPfG7GxVw
         9/IykgouIUe0hGtdFj9jIe60Bz8mCMCuuS7N+A2sMGcbxZNmDuufRVz6stTPpYqACgYP
         eJ2YPsdgqvzICVkXCd954OwvZw/S73wwWuCf6ZO0ELVZ4gUfzDWgT7TdaGjNJXtGpofI
         Ca+AdKfkSKafRF2kiNyCySdDiaRNk8tqzcQ6qgFFbhvNLjjWG4q3hWC+5WC7k7Iq57jv
         TnwQ==
X-Gm-Message-State: AC+VfDzcqJ21Uok1gBvxv2+LeG+q0Az1g+SYIOX5KB9RTq4IUXwXZ8y9
        c+OkZiu4KfM2AOiwNTZob9CnGjoQvxWVuFDFHk5fmhC37HSIW32NRgOzJ+xNhKagbVi2068MK+H
        TYN9GFMTa6S2KwCuQbhZkWWyD9GDfOLNqK+N/3o4lXPQfQGBNJivKyPZA7VJXDMi0oby7PemkSN
        /Z
X-Google-Smtp-Source: ACHHUZ46HWOFRsKvf0cYFd+w9ZuG7T76XbMsWYsBPYz5K4e8kZ+cbGlap0iNZ3we5BY25IJsk5I7wXg1I6XAD5gdvDVV
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:aa27:e943:1ce4:723f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:5e55:0:b0:ba2:58d2:bd86 with
 SMTP id s82-20020a255e55000000b00ba258d2bd86mr11245896ybb.5.1683844866865;
 Thu, 11 May 2023 15:41:06 -0700 (PDT)
Date:   Thu, 11 May 2023 15:40:59 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511224101.972442-1-jonathantanmy@google.com>
Subject: Changed path filter hash differs from murmur3 if char is signed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This issue arose while I was implementing changed path filters (the
bloom filters in the commit graph file) for JGit [1].

It turns out that if a repository contains paths that have at least one
character greater than 0x7f, Git writes these filters and interprets
them (when read from the commit graph file) differently depending on
whether "char" is signed or unsigned, and when "char" is signed (this
can be controlled by a compiler flag), the implementation of the murmur3
hash differs from the one in Wikipedia and elsewhere. (I looked into
Git's Makefile and didn't see anything that controlled whether "char"
is signed, so I presume that the default of the compiler used applies.)
This can be seen from the murmur3_seeded() function in bloom.c:

> uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
> {
[snip]
> 		uint32_t byte1 = (uint32_t)data[4*i];

Note that data[4*i] is of type "char". When I first read this, I thought
that no sign extension would occur regardless of the signedness of char
(that is, (uint32_t)(signed char)-1 == (uint32_t)(unsigned char)-1)
but it turns out that sign extension does occur if the thing being cast
is signed (that is, (uint32_t)(signed char)-1 != (uint32_t)(unsigned
char)-1) [2]. The implementation of the murmur3 hash in Wikipedia (and
presumably the intention of the author here, since the variable is named
"byte1") expects this value to not exceed 0xff, but this is not the case
if sign extension occurs.

I looked if this was discussed at the time this patch was presented [3]
but couldn't find anything related.

So...how do we proceed? I can see at least 2 ways:

 - Decide that we're going to stick with the details of the existing
   implementation and declare that "data" is always interpreted as signed.
   In that case, I would put "signed" wherever necessary, rename the
   function to something that is not "murmur3", and change the names of
   byte1 etc. to indicate that they are not constrained to be less than or
   equal to 0xff.

 - Bump the version number to 2 and correct the implementation to
   match murmur3 (so, "data" is unsigned). Then we would have to think of
   a transition plan. One possible one might be to always reject version
   1 bloom filters, which I'm personally OK with, but it may seem too
   heavy a cost to some since in the perhaps typical case where a repo has
   filenames restricted to 0x7f and below, the existing bloom filters are
   still correct.

Of the two, I prefer the latter, but I'm open to suggestions.

[1] https://git.eclipse.org/r/c/jgit/jgit/+/201851/2
[2] Verified in practice and also prescribed by the C standard; see
  e.g. https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf section
  6.3.1.3 point 2.
[3] https://lore.kernel.org/git/a5aa3415c05ee9bc67a9471445a20c71a9834673.1586192395.git.gitgitgadget@gmail.com/


