Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61BEC2BA15
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 23:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9FD2073B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 23:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJPUDsGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbgDBXB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:01:57 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52434 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBXB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 19:01:57 -0400
Received: by mail-pf1-f201.google.com with SMTP id i1so4360637pfo.19
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 16:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bhcSvDWqIYK//n9pfZkFScen0S2i8bKDtkcBiZpfhKk=;
        b=eJPUDsGcMId6sAHRDgZSRvKg+GA9qrYiRfkWX7OKzykYbBO4NAueckkI/nrFYX1DBo
         3tJnB9K7YrTTV/B7ksTi/duspJFweayxGIrR3z+tzNEgLOpUhnHMHEnlpOflEfDpYYZr
         HHkrRybdgTMzlvbIywCR8TYY3aHW2pW86kIAeuvV4Rz14P2HN9W/eMaMX7dX7WBZZSoI
         xdbyAQA9r1O38VIrpqruqwgyD1K3Dj8Y2ne7MOi5zmg62Lc+M1QOxjJd6UTTmzCPU2xn
         kTra5gWgVnZjsW3v0igtzDboze43Lz3ut2oT+q5NfUPnwlPDi+xehHSgJO+Nmp5Jya8y
         +ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bhcSvDWqIYK//n9pfZkFScen0S2i8bKDtkcBiZpfhKk=;
        b=To+ZHTxWa58NNiA6FhL2iso39xk0WBoNnPa2RyB2nffpqJXCRlBcN7n8DOrmaYg9tH
         PGkObp78sV78NbZ9skZkY2DS3dRR3sFUyYm+eZd6BEjzvj1acdgiwmYUCPvRQKv71hnM
         H/iSGKLlBCFua6e9TiU1UpBBzhNtZ+r5opAcf/K6ae9sjn8iExW5cpP5lbpOlrub66D4
         GzbqJV+zywe8UT2xSebQPzkrhKphhB7UA+3r+o1inTGL1RpK4SuEtZNBRd2arrN+iicc
         bcrPfJCT2JUU6E4w5CADOLBGyq5t8lhxQkEdDftt+inEUAuxKyu+hzLDTsA9xg1XhP92
         1HDQ==
X-Gm-Message-State: AGi0Pub6RfZRKt6NcKRwA6qUlOV3raWd9laijTej+OK4v5ypGnWNizgF
        7AZCgz0PF5uNUi8LDj5zrj8ZOIw8fs1/HHJN4pc6
X-Google-Smtp-Source: APiQypKdexMTcEEXdVlv84xQ1x36saMDJd0Hvm++/dOardG6hk0vh8tYSbfTE3fFuBla4IzHsZqQTVeqrSRiJdWlftLq
X-Received: by 2002:a17:90b:11c9:: with SMTP id gv9mr6179610pjb.90.1585868515787;
 Thu, 02 Apr 2020 16:01:55 -0700 (PDT)
Date:   Thu,  2 Apr 2020 16:01:53 -0700
In-Reply-To: <xmqqblo93c31.fsf@gitster.c.googlers.com>
Message-Id: <20200402230153.45407-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqblo93c31.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: Re: [PATCH v2 1/2] promisor-remote: accept 0 as oid_nr in function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > + * If oid_nr is 0, this function returns 0 (success) immediately.
> 
> Is this worth saying?  If you ask to lazily grab 0 objects, it is
> probably clear that no object would be read before the helper
> returns.
> 
> When oid_nr==0 you are allowed to pass oids==NULL, but otherwise,
> oids==NULL would be an error.  Is that the kind of difference you
> wanted to point out, I wonder?

Thanks for taking a look. Yes that was the difference I wanted to point
out. After some thought, maybe I'll replace it with "oids points to an
array of OIDs of size oid_nr. If oid_nr is 0, oids can be anything.".
