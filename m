Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AACE784BC
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjJBPTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbjJBPTi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:19:38 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA9190
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:19:35 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77574c6cab0so494211985a.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696259974; x=1696864774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bM6nhUQwxj9hNAzTqC1VrRxzCVrrDrKmxvfzD+JTyew=;
        b=vLZUUvaXAc12i2fOBuqEjc+r2WDsJxS2q2GZoKoTRMLhnzfZi1lw62as/IcKiLw5Ox
         zGb1UYkcKLUwUjk7BJfiDHScZ6vIZbPwbRXpLweDpHwKwlAKjoP3svHt2ofl/joJDIO+
         IQxFlM+249fuw2FPDA88IBJX0VUengNEDXEXeciODpQQ7vB8c8sda8b4QOgynVEzNULB
         hWQ1684WjAnQJZnRv3aX6EXDsjsWXyseTSsqQA/hxl/pZgCOtQmpV7C5+jpaXYiH2qcv
         lKwGhiv04E/PNWyBYRW33vlIp+vFqPD2/jF4PvWVBZ8E8DzladWcZ+TbZCG7UtmZKJNh
         dKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259974; x=1696864774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM6nhUQwxj9hNAzTqC1VrRxzCVrrDrKmxvfzD+JTyew=;
        b=STrUUOPaCXadt3HhxdOWvwkLAZgFrea+vvVPCxzQx4V5kaH6nwXxbgaLJJ5nEW7qUV
         tolJIIFztCquJEW6PcPYTV3GDtqGyAlhD8tcMGFMU0cWfo7JHS1MBkIjRyUuNSgZp5R2
         /nsp9y7Bp4bBgVpeTHBgUe8hI/sEykzEmnhCJi8lXAm+JGH5BacBCCIelRwKmNX0ntKd
         Ld8CBe0P4+yHBI4wMMjeTgdGEDLOyCkVuMU0VX+eO0tIjaSp+JjYQOr/byWUHFSVU1Xh
         soe1iub2jEIGsdmoRZNo7TY05FwWTqL3SfDaPcs/04CIQRuVAWVzgAsVETg+P4XYdp1H
         f9XQ==
X-Gm-Message-State: AOJu0Yymps4K8QRbSazlnUyU0qPEU+NuubyRFDKpBhR16tKllBH1z44O
        731nSt+Ve4rFNOGavX/ahr/FmpyLYifMnOGhOqDSZA==
X-Google-Smtp-Source: AGHT+IENbtkebHGbXIpluNeRq20foTqvhO1kA7u7d3bij/64wz+19/g14AbvxxETRLfv8IFfCVy4PQ==
X-Received: by 2002:a0c:cc85:0:b0:64a:a5f8:6314 with SMTP id f5-20020a0ccc85000000b0064aa5f86314mr11504041qvl.0.1696259974200;
        Mon, 02 Oct 2023 08:19:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0062ffbf23c22sm7508674qvm.131.2023.10.02.08.19.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:19:33 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:19:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 5/12] Replacing Git LFS using multiple promisor remotes
Message-ID: <ZRrfhMbExAa7cmX0@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Christian Couder, Notetaker: Jonathan Nieder)

* Idea: Git LFS has some downsides
   * Not integrated into Git, that's a problem in itself
   * Not easy to change decisions after the affect about what blobs to offload
     into LFS storage
* So I started work some years ago on multiple promisor remotes as an
  alternative to Git LFS
* Works! Requires some pieces
   * Filtering objects when repacking (git repack --filter, due to be merged
     hopefully soon)
* I'm curious about issues related to Git LFS - what leads people not to use Git
  LFS and to do things in other, less efficient ways?
* Choices
   * We can discuss details of a demo I worked on a few years ago
   * We can discuss Git LFS, how it works, and how we can do better
* brian: Sounds like this is a mostly server-side improvement. How does this
  work on the client side for avoiding to need old versions of huge files?
   * Christian: On the client side, you can get those files when you need them
     (using partial clone), and repack --filter allows you to remove your local
     copy when you don't need them any more
   * There could be more options and commands to manage that kind of removal
* Terry: with multiple promisor remotes, does gc write the large files as their
  own separate packfiles? What does the setup look like in practice?
   * Christian: You can do that. But you can also use a remote helper to access
     the remotes where the large files live. Such a cache server can be a plain
     http server hosting the large files, and the remote helper can know how to
     do a basic HTTP GET or RANGE request to get that file.
   * It can also work if the separate remote can be a git remote, specialized in
     handling large files.
   * Terry: So it can behave more like an LFS server, but as a native part of
     the git protocol. How flexible is it?
   * Christian: yes. Remote helpers can be scripts, they don't need to know a
     lot of things when they're just being used to get a few objects.
* Jonathan Tan: is it important for this use case that the server serve regular
  files instead of git packfiles?
   * Christian: not so important, but it can be useful because some people may
     want to access their large objects in different ways. As they're large,
     it's expensive to store them; using the same server to store them for all
     purposes can make things less expensive. E.g. "just stick the file on
     Google Drive".
* Taylor: in concept, this seems like a sensible direction. My concern would be
  immaturity of partial clone client behavior in these multiple-promisor
  scenarios
   * I don't think we have a lot of these users at GitHub. Have others had heavy
     use of partial clone? Have there been heavy issues on the client side?
   * Terry: Within the Android world, partial clone is heavily used by users and
     CI/CD and it's working well.
   * jrnieder: Two qualifications to add, we've been using it with blob filters
     and not tree filters. Haven't been using multiple promisor remotes.
   * Patrick: What's nice about LFS is that it's able to easily offload objects
     to a CDN. Reduce strain on the Git server itself. We might need a protocol
     addition here to redirect to a CDN.
* Jonathan Tan: if we have a protocol addition (server-side option for blob-only
  fetch or something), we can use a remote helper to do the appropriate logic,
  not necessarily involving a git server
   * The issue, though, is that Git expects packfiles, as the way it stores
     things in its object store.
   * As long as the CDN supports serving packfiles, this would all be doable
     using current Git.
   * If the file format differs, may need more work.
* jrn: Going back to Terry's question on the distinction between this and using
  an LFS server. One key diff is that with git LFS, is that the identifier is
  not the object ID, it's some other hash. Are there any other fundamental
  difference?
   * Christian: With git LFS if you want some blobs to be stored with LFS and
     they're not stored in LFS anymore you have to rewrite the history.
   * Using the git object ID gives you that flexibility
* brian: One thing Git LFS has that Git doesn't is deduping
   * On macOS and Windows and btrfs on Linux, having only one underlying copy of
     the file
   * That's possible because we store the file uncompressed
   * That's a feature some people would like to have some time. Not out of the
     question to do in Git, would require a change to how objects are stored in
     the git object store
* jrn: Is anyone using the demonstrated setup?
   * Christian: Doesn't seem so. It was considered interesting when demoed in
     GitLab.
* Jonathan Tan: is the COW thing brian mentioned part of what this would be
  intended to support?
   * Christian: Ultimately that would be possible.
   * brian: To replace Git LFS, you need the ability to store uncompressed
     objects in the git object store. E.g. game textures. Avoids waste of CPU
     and lets you use reflinks (ioctl to share extents).
   * Patrick: objects need the header prefix to denote the object type.
   * brian: Yes, you'd need the blobs + metadata. That's part of what Git LFS
     gives us within GitHub, avoiding having to spend CPU on compressing these
     large objects to serve to the user.
* jrn: Going back to the discussion with multiple promisors. When people turn on
  multiple promisors by mistake, the level of flexibility has been a problem.
  This causes a lot of failed/slow requests - git is very optimistic and tries
  to fetch objects from everywhere. This suggests the approach that Jonathan
  suggested, where the helper is responsible for choosing where to get objects
  from, it might help mitigate these issues.
   * Christian: yes
* Minh: can the server say "here are most of the objects you asked for, but
  these other objects I'd encourage you to get from elsewhere"?
   * Christian: you can configure the same promisor remote on the server. If the
     client doesn't use the promisor remote and only contacts the main server,
     the server will contact the promisor remote, get the object, and send it to
     the client. It's not very efficient, but it works. Another downside is that
     if this happens, that object from the promisor remote is now also on the
     server, so you need to remove it if you don't want to keep it there.
   * Minh: it seems someone has to pack the object with the header and compute
     the git blob id for it, which is itself expensive
   * Christian: if the promisor remote is a regular git server, then yes, the
     objects will be compressed in git packfile format. But if it's a plain HTTP
     server and you access with a helper, it doesn't need to. But of course, if
     the objects are ever fetched by the main server, then it's in packfile or
     loose object format there.
