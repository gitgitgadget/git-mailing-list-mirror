Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D488C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjDYRGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjDYRGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 13:06:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306F95FF7;
        Tue, 25 Apr 2023 10:06:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso4869026b3a.2;
        Tue, 25 Apr 2023 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682442377; x=1685034377;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWly5LOsfjOzFS+rOBQshUHGQRCOCU7+ddGEcJEuofA=;
        b=cqSYS5L/Ak25YQ+UZVB9IkSCJnI+yYe6uxjQjtMWcXnzMIpgi70rTlLBFqRZkTnUfV
         GUAI0NL75eju/cXcMgy4el9iLRe09f3HLlPSxRX1bX6asJzOWbP+5YmKLm0dhPXfxqXe
         iBJQOk9cXJc+MBNkTJ9ej+pOPwIEkDGHeqotmKV7dO57gIfiH0PD6fHuTlxsbs9gl0+w
         f9kumNpg5JpBODF3C6SH8dE9vuCjUFJc2JQjpSU5QRWCPHHsp+GQ9myjIxgMLylxUWfA
         wnul6Mnxc/V8eTnrJ46G+6fIL1fGbxeC8gdlG5oI3HZMBi4G5PM6dcwv1Vfo0SiloE5h
         fKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682442377; x=1685034377;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KWly5LOsfjOzFS+rOBQshUHGQRCOCU7+ddGEcJEuofA=;
        b=P51PlQ0RZ/gNsfRbTw4S/PNnYSj4Bqz5EXFMUEEJdaMy9YsIpJUEqD3oEB4G0Kn+Fo
         OrfpiPtU07k3pb9YoxZ/gYH5XXs0mZQxweTFoXt8lyVSByFmzmlGMIKU7DNgH3LWZkLc
         nx5xt4bz0pSpVS/X7aiaZ2ADND+Q9joCbjOVzatHgnyccQVLkKmgGhqQG0gEzpIcOsiQ
         OSEqROAqJmA2MvReAGHm1XX3FsOQHRBnG6lOd9Gsb16tcbPa0yB2wc6u5VELHfSnJZ56
         eZBz4Pi3HuffYtQIvbXo2XXD+etcneDQlFjQ0aMnWzyKgjh3nVQWh7oloHe4QUe4dwRw
         TnzA==
X-Gm-Message-State: AAQBX9eup6c2QICZFg7KICaveYv2+JqNV1pfWmWJOPDotMBSZJ6CQf/r
        taoqzVgsHTUeG43Iw5ce/1YYJZjHEpc=
X-Google-Smtp-Source: AKy350Yv/is3ZvWythLhOTpcul0kCtTQTQ3YaV11KQXNlH7pU738lDHbO9qBksIGHWD61j6HJKWVAA==
X-Received: by 2002:a05:6a00:1882:b0:63b:59a7:eafa with SMTP id x2-20020a056a00188200b0063b59a7eafamr26004675pfh.25.1682442377158;
        Tue, 25 Apr 2023 10:06:17 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h17-20020a056a001a5100b005abc30d9445sm9537231pfv.180.2023.04.25.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:06:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com, oss-security@lists.openwall.com,
        git-security@googlegroups.com
Subject: [ANNOUNCE] Git v2.40.1 and friends
Date:   Tue, 25 Apr 2023 10:06:16 -0700
Message-ID: <xmqqa5yv3n93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A maintenance release Git v2.40.1, together with releases for older
maintenance tracks v2.39.3, v2.38.5, v2.37.7, v2.36.6, v2.35.8,
v2.34.8, v2.33.8, v2.32.7, v2.31.8, and v2.30.9, are now available
at the usual places.

These maintenance releases are to address security issues identified
as CVE-2023-25652, CVE-2023-25815, and CVE-2023-29007.  They affect
ranges of existing versions and users are encouraged to upgrade.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.40.1'
tag, as well as the tags for older maintenance tracks listed above:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

The addressed issues are:

 * CVE-2023-25652:

   By feeding specially crafted input to `git apply --reject`, a
   path outside the working tree can be overwritten with partially
   controlled contents (corresponding to the rejected hunk(s) from
   the given patch).

 * CVE-2023-25815:

   When Git is compiled with runtime prefix support and runs without
   translated messages, it still used the gettext machinery to
   display messages, which subsequently potentially looked for
   translated messages in unexpected places. This allowed for
   malicious placement of crafted messages.

 * CVE-2023-29007:

   When renaming or deleting a section from a configuration file,
   certain malicious configuration values may be misinterpreted as
   the beginning of a new configuration section, leading to arbitrary
   configuration injection.

Credit for finding CVE-2023-25652 goes to Ry0taK, and the fix was
developed by Taylor Blau, Junio C Hamano and Johannes Schindelin,
with the help of Linus Torvalds.

Credit for finding CVE-2023-25815 goes to Maxime Escourbiac and
Yassine BENGANA of Michelin, and the fix was developed by Johannes
Schindelin.

Credit for finding CVE-2023-29007 goes to André Baptista and Vítor Pinho
of Ethiack, and the fix was developed by Taylor Blau, and Johannes
Schindelin, with help from Jeff King, and Patrick Steinhardt.

Thanks.
