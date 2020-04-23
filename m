Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E0C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381F02074F
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vRD8Lxby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDWAZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWAZj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 20:25:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA2C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:25:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so1995925pfw.13
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rjQ2mizzavpHqjwY5LXo8uUcnNmjQCe0VXCsIcIihDw=;
        b=vRD8LxbyiA54zSnpJ9/S1fnduBMhrKdXDrwy7NDtQNhlefZEk3PDhF34gUqH8aKiaf
         HBxmcgBE6ZlSWSXUQOREe9X8qkQCPMlIlvxSrmqau1roMuX7c/rpseSUWn4zbrgPVGw5
         qkiyhCnN+9zRttETuEJilN065rJdl4e6kU4cZ4HvmoHoh85/ygJMbAC0g5KG7h5s1mKR
         CEqeYCIgKKPP+NYoOoo2hiJs3zMlWWhUeEkiLd/tpja4KoxwOftknqX/zoiI6W68cDMg
         nr/Fprd59HwcYiixs5aOi1iVzAtWdN+bLeUGQjBOYvdh3yRIaOUkppcMzs8bimcMC7IZ
         Ls8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjQ2mizzavpHqjwY5LXo8uUcnNmjQCe0VXCsIcIihDw=;
        b=TpYl73QCtL+Fvx5jgLmjNFb+/BSBtyd88c3M15ScV79AjE0jqh63A+tX2e7iKTKm0g
         3/oe4oIbGmaq9ZTkZUuAr/IclFX/Q8QUHLPcWv8MEQnPqfZ1WXar3FWYGANxTQWSZH+a
         EhLt5hV7uiUvnWMacvOhQjTJUQE/lgDeh8/hL74t6RwlOg7gV084gcGlJnSS936bvCGf
         rPcLxelB5Ir3StQOJaWKmuEWfks6n99AWukxmiABaMMrm3EYgCouTn7y3iXUn0yNoi2b
         iFEX7jSZ7gDC398aIVQTHzySmWFeSdamVXz36kpGzrj1qttDsAtZEX1+DC3jsQfm6sE8
         PGPA==
X-Gm-Message-State: AGi0PuaoOaMN554khEgX6XrT/uyETrHhtzAsUPedc1EAkJkbyYBfUN6O
        VOipGs1Z6VrqXjA+Oc2lFP+5wt6oS34iJA==
X-Google-Smtp-Source: APiQypIcGUnd+gH6zTMYqV8nTgpj+fP7UJN4mNRsdFJUt6s7kNlBJ1788e7OQzt9ukhWUXBjoCl1XA==
X-Received: by 2002:a63:5952:: with SMTP id j18mr1557609pgm.272.1587601538723;
        Wed, 22 Apr 2020 17:25:38 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t11sm656218pfl.122.2020.04.22.17.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 17:25:37 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:25:36 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com
Subject: [PATCH v2 0/2] shallow.c: reset shallow-ness after updating
Message-ID: <cover.1587601501.git.me@ttaylorr.com>
References: <20200423001438.GC19100@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423001438.GC19100@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is an updated version of the patch that I sent above (which was
itself an updated version of a patch that I sent to some other
sub-thread...).

In this version, I added an extra patch at the beginning to clean up
some surrounding tests in t5537 so the new ones are added both in a good
style, and in a way that is consistent with the surrounding code.

I also adopted a suggestion from Junio that introduces
'{commit,rollback}_shallow_file()' as thin wrappers around
'{commit,rollback}_lock_file()', which makes this whole thing a lot
tidier.

Thanks in advance for another look...

Taylor Blau (2):
  t5537: use test_write_lines, indented heredocs for readability
  shallow.c: use '{commit,rollback}_shallow_file'

 builtin/receive-pack.c   |  4 +-
 commit.h                 |  2 +
 fetch-pack.c             | 10 ++--
 shallow.c                | 30 ++++++++----
 t/t5537-fetch-shallow.sh | 99 +++++++++++++++++++---------------------
 5 files changed, 77 insertions(+), 68 deletions(-)

--
2.26.0.113.ge9739cdccc
