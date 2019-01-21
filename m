Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C5F1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 14:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfAUORk (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 09:17:40 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:53623 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbfAUORi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 09:17:38 -0500
Received: by mail-it1-f173.google.com with SMTP id g85so16561098ita.3
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=25IVKl9I3mXx6L2lQIEZs2zAsqmPBh4Nk2Wlh2flfcE=;
        b=rV8IFzuGPumOb+9nifQVzfoZHC01IKsvFTE+s3XWeBxON4JlgZxu0zf6esbyy1P3se
         xSnzuIDNUmnism+bAbKGirujnmvDGQs3xJVrimmj8+Y3IEJnBx/cS/KLj+1QMybRX1hT
         gfYsF5vPEjGZUfHksqoZpICdAOEVS/btykhoDl4v08hssCfkyGa/V364S1KkjY2EtFSh
         lBwzhwIat/CFogZC9zAgWVAtTYbsE/17MOQ4agCjEc7uFOLf+9YjAkTzod8SY1dLx+Mi
         oSfGx5H7yjfkOngu2Ywa445uCepUbhbFIoVn9x04HqghEyzrSsxhg5hxLp8n5ImuIoZE
         Y/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=25IVKl9I3mXx6L2lQIEZs2zAsqmPBh4Nk2Wlh2flfcE=;
        b=jQKolRb2pcNs9J/iIDUMGnXjHTeeH3kntOINLJQq0MjS5Dp7FsqVpxy0l8JDIXr5H7
         FVd+O3e+0DLKgdkzz0w7HZAZMmo/+XOhlOyIQPZ1WpsUalEK5WdVWT4DnxYhrI7mrKnK
         qfTkAMqfJcsRLxJ3Kj3opZI1OaTiC46Xxvh/JdJUi1QaIkufEyyOIyALSfgAoxNhkGpd
         nM4uW/Sdej1NF4C0UAgMW63AC83CofrZ5gaob7d6YhPJHcUO/lVOGm3z2R9ap6aIYl1M
         r/cTlAMROscmLTkjSLXFofOl+U8W0ZqfQG8J0AhASeRgvUaTLXpPZ3U2rGJILWXtw2j/
         4YMQ==
X-Gm-Message-State: AJcUukfnsMH8zwTZhhwKYZs/ZpsGsHVka2YN4D3uLCxtTQRTwznDXruv
        Hkb/d9cLd3MnUQP+sQvkPAMkIIc+9NZnLSKUov9TSw==
X-Google-Smtp-Source: ALg8bN7/crxiWo6zTF05p3vsWw1lZWnOtK8xunjG+AxDRIJiN+Sl7Ce1ch1ft9bK2zdTva4JsrNLVQa0UxGN6HceeIg=
X-Received: by 2002:a24:99c5:: with SMTP id a188mr16274462ite.110.1548080256881;
 Mon, 21 Jan 2019 06:17:36 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Fanjul <daniel.fanjul.alcuten@gmail.com>
Date:   Mon, 21 Jan 2019 15:17:00 +0100
Message-ID: <CAPktr3kFpP-CwWxwQP37g2xvuztDBSf-ksbGKqTyK9E7hoifgw@mail.gmail.com>
Subject: checkout with given mtime
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

When the mtimes of my tracked files are updated during usual git
commands some other tools that depend on them have trouble. So I
restore their mtimes for these other tools and then git ends rereading
contents of files that have not changed. I would like to improve this.

Is there a way to check out a file with a given mtime so I do not have
to update it later and force git to reread it?

Something like 'git checkout --mtime $mymtime -- $myfile'. If the file
is not there or does not have the proper contents, git would write the
file, set the mtime of the file and update the index accordingly. If
the file is there and does have the proper contents according to the
index, git would update the mtime of the file, update the index
accordingly, and not read or write the contents at all.

Thanks, and regards,
Daniel.
