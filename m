Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C0ECE7A89
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 15:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjIWPWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 11:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjIWPWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 11:22:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CCBA9
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 08:22:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso3213361b3a.2
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695482525; x=1696087325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T7h82HrjP/ft1OMLDFDbZowAKwKYCNrFwqIeeU4pj0=;
        b=QpGox1/lpxrkrMpnR0QtGiuEO8PuZWlK/qZQ9gVe/Js4YYY836YcLcadBcDwpY4NcB
         dC2XU8/aIcDPoCIBOCHuy4YY1x9HxsyFONbjHGgkksuw9auJ3MQOnUVN9XYGVBb+DqHp
         Ye7yDo0AgHt4YiQAHqF/tso9tBCYLxlCnGKU8NBHOD6Onog8bcwAWLZUm/maCZI0a3MV
         OypaubN+U84m+qRp4tGTOBjXouZiw8bzSGmE7shO6pqRzCsFVqVuOBkWgK+15aOv7fA/
         miD9VoI4SLUdr+RQlKxEBnub4WiaX1Mwzg1FNqwq+8Dv/1P2RW9N4RheBUAsbmHv3yQG
         DOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695482525; x=1696087325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1T7h82HrjP/ft1OMLDFDbZowAKwKYCNrFwqIeeU4pj0=;
        b=e6FSyvIMZ16qi3lK6EE1G6m/QWAjbQAktZ7mnht6LQSaRkjeIkL6lZ5gjY77ke2GFO
         En6AmI4zgOh4Ie20YRkvXNCO+6xZsHIszs/VhHYbmp9UxkPEzwQ9QN4DTsK8uEALBl+L
         tGEOvzRyOS3ZaX/0F9NtIB9sJLqWB/llEtMbEjgDyW/18XPzPVEpWxYkVm9H513/mJvA
         VtulY5Q/Az1U9lPgccXuYNxlEdAXUCuMK/sC1m9BRfPAKSWGhi099GB6Ej20TOdvz+Ug
         YQ4AEzUm8kzubXRL+GtRhIiWAV/GhKWNirRrEkpAqEmNOGb2BD+aqq0g/3Xuvwazxz2t
         OEwQ==
X-Gm-Message-State: AOJu0YzX1eZkTxCO5rpKntwQOOWzXrstfx3G0/8IhKPw9NboGpkCtYA3
        VQ/IvH7AWSgmgmqqAP99W1gclEhHTYg=
X-Google-Smtp-Source: AGHT+IFlwUNu1f2+RdQvD7j4ud2YvPungbdlJMWrGXYraiAVv6qg2xIjKd5arVFBYvY7eRpxHZ4Yng==
X-Received: by 2002:a05:6a00:2401:b0:68f:cc67:e723 with SMTP id z1-20020a056a00240100b0068fcc67e723mr2296365pfh.17.1695482525145;
        Sat, 23 Sep 2023 08:22:05 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a001d1400b00692acfc4b3csm3084310pfx.136.2023.09.23.08.22.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Sep 2023 08:22:04 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 0/3] support remote archive from stateless transport
Date:   Sat, 23 Sep 2023 23:21:58 +0800
Message-Id: <20230923152201.14741-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <xmqqy1h2f5dv.fsf@gitster.g>
References: <xmqqy1h2f5dv.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Enable stateless-rpc connection in "connect_helper()", and add support
for remote archive from a stateless transport.

range-diff v1...v2:

1:  4457ca910b ! 1:  6fabd4dcab transport-helper: no connection restriction in connect_helper
    @@ Metadata
      ## Commit message ##
         transport-helper: no connection restriction in connect_helper
     
    -    For protocol-v2, "stateless-connection" can be used to establish a
    -    stateless connection between the client and the server, but trying to
    -    establish http connection by calling "transport->vtable->connect" will
    -    fail. This restriction was first introduced in commit b236752a87
    -    (Support remote archive from all smart transports, 2009-12-09) by
    -    adding a limitation in the "connect_helper()" function.
    +    When commit b236752a (Support remote archive from all smart transports,
    +    2009-12-09) added "remote archive" support for "smart transports", it
    +    was for transport that supports the ".connect" method. The
    +    "connect_helper()" function protected itself from getting called for a
    +    transport without the method before calling process_connect_service(),
    +    which did not work with such a transport.
     
    -    Remove the restriction in the "connect_helper()" function and use the
    -    logic in the "process_connect_service()" function to check the protocol
    -    version and service name. By this way, we can make a connection and do
    -    something useful. E.g., in a later commit, implements remote archive
    -    for a repository over HTTP protocol.
    +    Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
    +    2018-03-15) added a way for a transport without the ".connect" method
    +    to establish a "stateless" connection in protocol-v2, which
    +    process_connect_service() was taught to handle the "stateless"
    +    connection, making the old safety valve in its caller that insisted
    +    that ".connect" method must be defined too strict, and forgot to loosen
    +    it.
     
    +    Remove the restriction in the "connect_helper()" function and give the
    +    function "process_connect_service()" the opportunity to establish a
    +    connection using ".connect" or ".stateless_connect" for protocol v2. So
    +    we can connect with a stateless-rpc and do something useful. E.g., in a
    +    later commit, implements remote archive for a repository over HTTP
    +    protocol.
    +
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## transport-helper.c ##
-:  ---------- > 2:  1d687abc7e transport-helper: run do_take_over in connect_helper
2:  d4242d1f27 ! 3:  051d66f48e archive: support remote archive from stateless transport
    @@ Commit message
     
          1. Add support for "git-upload-archive" service in "http-backend".
     
    -     2. Unable to access the URL ".../info/refs?service=git-upload-archive"
    -        to detect the protocol version, use the "git-upload-pack" service
    -        instead.
    +     2. Use the URL ".../info/refs?service=git-upload-pack" to detect the
    +        protocol version, instead of use the "git-upload-archive" service.
     
    -     3. "git-archive" does not resolve the protocol version and capabilities
    -        when connecting to remote-helper, so the remote-helper should not
    -        send them.
    -
    -     4. "git-archive" may not be able to disconnect the stateless
    -        connection. Run "do_take_over()" to take_over the transfer for
    -        a graceful disconnect function.
    +     3. "git-archive" does not expect to see protocol version and
    +        capabilities when connecting to remote-helper, so do not send them
    +        in "remote-curl.c" for the "git-upload-archive" service.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
    @@ transport-helper.c: static int process_connect_service(struct transport *transpo
      		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
      		ret = run_connect(transport, &cmdbuf);
      		if (ret)
    -@@ transport-helper.c: static int connect_helper(struct transport *transport, const char *name,
    - 
    - 	fd[0] = data->helper->out;
    - 	fd[1] = data->helper->in;
    -+
    -+	do_take_over(transport);
    - 	return 0;
    - }
    - 

Jiang Xin (3):
  transport-helper: no connection restriction in connect_helper
  transport-helper: run do_take_over in connect_helper
  archive: support remote archive from stateless transport

 http-backend.c         | 15 +++++++++++++--
 remote-curl.c          | 14 +++++++++++---
 t/t5003-archive-zip.sh | 30 ++++++++++++++++++++++++++++++
 transport-helper.c     |  7 ++++---
 4 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.40.1.50.gf560bcc116.dirty

