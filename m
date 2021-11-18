Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C82C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 04:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB7861AEC
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 04:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbhKREJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 23:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240638AbhKREJa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Nov 2021 23:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637208390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5FVZanSvq8wPv2/rct6KU+8H7+l/qnXwmgRDD+auBg=;
        b=K76i2nm5GJDDO+fwjnf3vFUsH2eHEFtBZrBUmnh9IFNvLf495lvJy3HAIdBsF41M8ZcnJZ
        9zzBjY9uyKc7XVapfkMkSiu7b64i6laStFLsoVbQAHGtgnK0DsidBVihKSQ8A7xGqEqdXb
        6hyRq3Kt0VvvZ2G2pAganfycJgYohY4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-HYbMO2RXOYGrEi8FU8kd9A-1; Wed, 17 Nov 2021 23:06:29 -0500
X-MC-Unique: HYbMO2RXOYGrEi8FU8kd9A-1
Received: by mail-pj1-f71.google.com with SMTP id n6-20020a17090a670600b001a9647fd1aaso4272075pjj.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 20:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5FVZanSvq8wPv2/rct6KU+8H7+l/qnXwmgRDD+auBg=;
        b=IQuuvUINp760G26SeuDVLLMAcwlJGl5cY/rjddugRhf8Gf1RIgaPtZSkk3fvQX7UZn
         RtbjmW/lCZaj2dpKVX/b7e//sYh872gfxlgTYzw4PWnaEhz+fAGbeQ4e4eDH95SB3A74
         49uAaXA9WYJGHYKnPVt3DAlIFrA4YYsa5LcQS0kGtMG/gtKInNMPYp86cljOUioWKkOY
         4g1n6PEpSXHZaYVC8jwdt6vazhKgNr2g+625+p9KDXYmRl9JhtU8ochcq9lLcPuRsE/f
         5JatSwNHIcrfJnBVmNxUbWbTE45j/Yui5Mi/rSRZjH77JfdoXuop5i91YjOKCo3MQWex
         +bZg==
X-Gm-Message-State: AOAM530P0pTO93Q97b9GdkC21CDhmMjNnOjSoz0E7sIFpzOMb8IshdJq
        r2uX9j+fOP5wgY8qlBAHIGQ9UWd+iCoXThE3NYICKVftM0Q25gbzjh0nUx5/lQiDsa2QqF8GDQf
        8qm9IwYMgFdPT
X-Received: by 2002:a17:902:c702:b0:144:ce0e:d47 with SMTP id p2-20020a170902c70200b00144ce0e0d47mr4528317plp.69.1637208388031;
        Wed, 17 Nov 2021 20:06:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl/5KTpUV74QTq+5FLXiXiLPYCGSbIE/m6s3cS23RBInj3ukXQZIoAkinCZdM+r74RO7xaXA==
X-Received: by 2002:a17:902:c702:b0:144:ce0e:d47 with SMTP id p2-20020a170902c70200b00144ce0e0d47mr4528282plp.69.1637208387742;
        Wed, 17 Nov 2021 20:06:27 -0800 (PST)
Received: from fedora19.localdomain (2001-44b8-4132-5a00-03c7-087f-fa32-45c8.static.ipv6.internode.on.net. [2001:44b8:4132:5a00:3c7:87f:fa32:45c8])
        by smtp.gmail.com with ESMTPSA id d2sm1106460pfu.203.2021.11.17.20.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 20:06:27 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:06:23 +1100
From:   Ian Wienand <iwienand@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Peter Kaestle <peter.kaestle@nokia.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] submodule: separate out not-found and not-empty errors
Message-ID: <YZXRPylIwkN4L30R@fedora19.localdomain>
References: <YZQ5Zk0ItWvfr8sF@fedora19.localdomain>
 <xmqqfsrv2kar.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfsrv2kar.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review!

On Wed, Nov 17, 2021 at 01:39:08AM -0800, Junio C Hamano wrote:
> Ian Wienand <iwienand@redhat.com> writes:
> 
> >  			    !is_empty_dir(empty_submodule_path.buf)) {
> >  				spf->result = 1;
> > -				strbuf_addf(err,
> > -					    _("Could not access submodule '%s'\n"),
> > -					    ce->name);
> > +				/* is_empty_dir also catches missing dirtectories, but report separately */
> > +				if (!is_directory(empty_submodule_path.buf)) {
> 
> I was hoping that inspecting errno after is_empty_dir() returned
> might be sufficient (of course, we need to clear errno before
> calling is_empty_dir() if we go that route), but because this is an
> error codepath that we do not need to optimize, a call to
> is_directory() that incurs another system call would be fine.

That was my thinking too, I do admit it's a bit of an obscure case to
end up in, but the regular path doesn't need any more checking.

> > +				  strbuf_addf(err,
> > +					      _("Submodule directory '%s' not found (incorrect --git-dir?)\n"),
> 
> "not found" is something the code definitely knows (eh, not quite,
> but let's read on).  
> 
> But let's not make an uninformed guess.  This code didn't even check
> if the user gave a --git-dir option.
> 
> If the user is advanced enough to have given "--git-dir", "not found"
> should be sufficient to hint that the way the user specified the
> repository location incorrectly, and a wrong "--git-dir" might be
> one of the many things the user might suspect on their own.

Ok, I can drop that bit, as you say it's a guess.

> Another problem with the message is !is_directory() can mean "there
> is no filesystem entity at the path" (i.e. "submodule directory '%s'
> does not exist") and it can also mean "there is a filesystem entity
> at the path, but that is not a directory).  "not found" is not exactly
> a good message to give in the latter case.
> 
> We are giving two messages here in this codepath.  For example, the
> original one would have said something like:
> 
> 	Could not access submodule 'foo'
> 	Submodule directory 'foo' is not empty

Actually in the original patch I dropped the "Could not access..."
bit, but I agree it makes more sense with the more specific details
added.  I've put that back and append the secondary message below.

> So I suspect that a more appropriate phrasing for the other one (the
> new one you added) would be something like
> 
> 	Could not access submodule 'foo'
> 	Path to the submodule 'foo' is not a directory
> 
> perhaps?

Done

-i

From 6ea39c3e43eccf93e4567329cfb1b9c642154283 Mon Sep 17 00:00:00 2001
From: Ian Wienand <iwienand@redhat.com>
Date: Wed, 17 Nov 2021 09:39:40 +1100
Subject: [PATCH] submodule: separate out not-found and not-empty errors

After upgrading past 505a2765963 a long-working script to cache git
repos started failing with

 Could not access submodule '...'

for every updated submodule on each fetch [1].

Ultimately this turned out to be using "--git-dir=" from outside the
repo; i.e. we really wanted "-C" in this script (the man page does
warn about this -- but it was working for a long time).

Although obvious in hindsight, this was very difficult to diagnose
from the error message.  It required me adding debugging to these
functions to determine why it was falling into this path when
everything looked right on disk.

This proposes separate messages for the directory missing v. being
present but having unexpected contents.  Both messages are modified to
give the path that is being examined.

[1] https://review.opendev.org/c/openstack/diskimage-builder/+/818053

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 submodule.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/submodule.c b/submodule.c
index c689070524..352ee50f2e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1524,6 +1524,16 @@ static int get_next_submodule(struct child_process *cp,
 				strbuf_addf(err,
 					    _("Could not access submodule '%s'\n"),
 					    ce->name);
+				/* is_empty_dir also catches missing directories, but report separately */
+				if (!is_directory(empty_submodule_path.buf)) {
+				  strbuf_addf(err,
+					      _("Submodule path '%s' is not a directory\n"),
+					      empty_submodule_path.buf);
+				} else {
+				  strbuf_addf(err,
+					      _("Submodule directory '%s' is not empty\n"),
+					      empty_submodule_path.buf);
+				}
 			}
 			strbuf_release(&empty_submodule_path);
 		}
-- 
2.33.1

