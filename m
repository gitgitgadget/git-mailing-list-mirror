Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18325C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42A1207DD
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZZvNyftw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgD3VLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726937AbgD3VLb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 17:11:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484FC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 14:11:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so1405994pjh.2
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PPYlMBD6pjuUxbasknM+Lu8HK4GWQbIpgwuixqkzZ+0=;
        b=ZZvNyftwH81GYxjRTl6AzQYzFEifWT0xoQK25T2PA5Z0wgqA4uWyikDT9rU02CuKmf
         4/KPX0YrOW7vqTJyQe3QEJMrAdK5hnzEDLma8cDBx+u2P7PmOg9Sgt6ON2ioSvBzlG7T
         +TnVg2s+LUM6ezM5WZ6ni+QwP3FFXBINd5jLzqp+kOqGiR0IXxzVShuaqyCDSnFokPEv
         maI19fAa/6bjBucRLKqLE9lJf7BgMaUU4fkM5f5s9Hqc5ZYblu/mX1Ztnve6wG5df+6L
         HWEjZqzEfxES2seB9CSYpORb0WPCRsk5Yd8QBd2m5/ltV1euwTg2BrP/26Fmj99e0SsA
         +sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PPYlMBD6pjuUxbasknM+Lu8HK4GWQbIpgwuixqkzZ+0=;
        b=iuHcbUSuTtmxxUtBL1O0M+ph85qGPZD2G0IRL62cp/3R3WLsru2GVhUPCE8/0LaCXR
         k6QsrFQIhyfPZMA5e+yGXXFlj7BZ06XkthvP2yw1KdEoExzIflCRAPs9/dv1sV0nNgYv
         NzDBd8G9JOy9vjqY0XPQrqhq7GKI2rPT2qoBobCUM6mbprTXC3stzgbhzuyQQcrgvDMD
         lETkqyojbfx7VYGjQT736uO4/uBmlVMamplVPMc57M284FG1X93Re3qU9dPvaob3xGgV
         XDFJ9HCPk5K+uJIxzRTpxQhxRvVtXyqfY7rXyplJWQc55Sc8eDMBsXp1ObZR9EMnzpZO
         Ky1Q==
X-Gm-Message-State: AGi0PuYev9dfyTuFiNYHjhlHxiH8A0Waj37Qt/uiDgrVYaYkVvwl2w3v
        Ztu+Rr4HX6GKhIgXixBckzi0Gg==
X-Google-Smtp-Source: APiQypJz3kN0M3QN3Ej2/ZLf0DOLvQdlToLN4LvgC5SPD/V4YNuZIB57CYTF8NrevwX4nQ/DbxQdWg==
X-Received: by 2002:a17:902:ee15:: with SMTP id z21mr920235plb.71.1588281090473;
        Thu, 30 Apr 2020 14:11:30 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r31sm530715pgl.86.2020.04.30.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:11:29 -0700 (PDT)
Date:   Thu, 30 Apr 2020 15:11:28 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/4] commit: make 'commit_graft_pos' non-static
Message-ID: <20200430211128.GA24821@syl.local>
References: <cover.1588275891.git.me@ttaylorr.com>
 <cb8dde2ae2e78d0bcfb61382fe7769c12804336b.1588275891.git.me@ttaylorr.com>
 <xmqqbln8r8wg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbln8r8wg.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 01:55:11PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > -static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
> > +int commit_graft_pos(struct repository *r, const unsigned char *sha1)
> >  {
> >  	return sha1_pos(sha1, r->parsed_objects->grafts,
> >  			r->parsed_objects->grafts_nr,
> > diff --git a/commit.h b/commit.h
> > index ab91d21131..eb42e8b6d2 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -236,6 +236,7 @@ struct commit_graft {
> >  typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
> >
> >  struct commit_graft *read_graft_line(struct strbuf *line);
> > +int commit_graft_pos(struct repository *r, const unsigned char *sha1);
>
> In an earlier exchange, I saw this:
>
> >> - could include a comment saying that it's an index into
> >>   r->parsed_objects->grafts
> >
> > This and the below are both good ideas to me. I prefer this one, since
> > we'd have to duplicate yet another static function
> > ('commit_graft_sha1_access()' directly above) that is called by this
> > one.
> >
> >> - I'm usually loathe to suggest unnecessary duplication of code, but
> >>   it might make sense to duplicate the function into shallow.c.  Or
> >>   even to inline it there (in the single call site, that ends up
> >>   being pretty readable).
> >
> > I am not at all offended by duplication of code where it makes sense to
> > do so, but having to duplicate two functions seems like we'd be better
> > off simply documenting the function in commit.h.
>
> and I think I agree with that direction.  Forgot to add those
> comments?

Thanks for remembering. I did apply this locally, but must've dropped it
on the floor during a rebase. In any case, please swap in this patch
instead:

-- >8 --

Subject: [PATCH] commit: make 'commit_graft_pos' non-static

In the next patch, some functions will be moved from 'commit.c' to have
prototypes in a new 'shallow.h' and their implementations in
'shallow.c'.

Three functions in 'commit.c' use 'commit_graft_pos()' (they are
'register_commit_graft()', 'lookup_commit_graft()', and
'unregister_shallow()'). The first two of these will stay in 'commit.c',
but the latter will move to 'shallow.c', and thus needs
'commit_graft_pos' to be non-static.

Prepare for that by making 'commit_graft_pos' non-static so that it can
be called from both 'commit.c' and 'shallow.c'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit.c | 2 +-
 commit.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index c7099daeac..b76f7d72be 100644
--- a/commit.c
+++ b/commit.c
@@ -110,7 +110,7 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }

-static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
+int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 {
 	return sha1_pos(sha1, r->parsed_objects->grafts,
 			r->parsed_objects->grafts_nr,
diff --git a/commit.h b/commit.h
index ab91d21131..0fe1e1b570 100644
--- a/commit.h
+++ b/commit.h
@@ -236,6 +236,8 @@ struct commit_graft {
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);

 struct commit_graft *read_graft_line(struct strbuf *line);
+/* commit_graft_pos returns an index into r->parsed_objects->grafts. */
+int commit_graft_pos(struct repository *r, const unsigned char *sha1);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
--
2.26.0.113.ge9739cdccc

