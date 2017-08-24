Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8F120285
	for <e@80x24.org>; Thu, 24 Aug 2017 22:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbdHXWx4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 18:53:56 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:38406 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdHXWxz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 18:53:55 -0400
Received: by mail-pg0-f47.google.com with SMTP id b8so4642422pgn.5
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 15:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E93j/qf5ZcgjxPGZlfEVpOdLWS7jvysVeo25PIghi30=;
        b=Q6i8fNJqGKObt2Q/FzzkJmywLJQtZCFWs3WyU2wBc8ZNJk0HQ/TAnMjp+lmap++43r
         6at/H2iGlMPEw91XJ8OtEqcO92mNKmoAOFw/NSwK21SS1k8nkSqeCrD0xeGXQNXu9CQw
         33s4OiLqTsi0zUyenZ9yqMrQ+zelEHhTpbIoEThL6U8m1hdT5+vcocKPqarGp0Qy344X
         aVUPIRAvzqdA0AOYa4XJGwgpqJ3Z6yz4bLOc26kWnI5CINWbL/vYqn7P9+ewON2aX5ys
         xiMgqdUVH6yibXltI2geEgFIyZw7k7aj/3wh8twGYZs3Y29ty1SnfUmtAZxEGxnFmb0U
         3Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E93j/qf5ZcgjxPGZlfEVpOdLWS7jvysVeo25PIghi30=;
        b=M9b0oIpHCLaPdPqjX7pxsCwC/kW2lSo9DFm52ynNeB0mgoGbgMh6vEc+FG6jl9SoUD
         LIxK6PU/YLCsqXb+gWGW2TFvDHuw+Ap64ZnzqG+y9qzL6zlB+RNtGUK0MDiKzZijn9cT
         PgjItp/jRL6EEOvCpe9hxfJmtqWxYvNhTOuKeImpSKyF1JZRNpfWq/W7ihuEe6hCEH1h
         d96ylcPIH6p8kc15KXYDWXs57UvhxCyHtFVDsM3SI4m8rj25TCaTrS/tMXTRt7XwtRSa
         K0X/VvDYyvKp23mmwwHQZ4c1LhKQF3ZvN4yHwVyM1ERuH0vx6hkOcVlETE6XbCtUef3h
         dYGw==
X-Gm-Message-State: AHYfb5hkl6ZQAMJIfolWJW5z/CALGl+Ifd7mUtc/k5mt/P/Co11qOzTt
        1N+8ej4ZWWflpv+yqbJ26A==
X-Google-Smtp-Source: ADKCNb62Gv8fetlm1YASHaDCYdJ5/zBiINEXWld9BKFxvmYssvk+2hUmgigKw7a+c8upYsKHPe2R5g==
X-Received: by 10.84.225.19 with SMTP id t19mr8404331plj.212.1503615234365;
        Thu, 24 Aug 2017 15:53:54 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x8sm9402667pfi.174.2017.08.24.15.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 15:53:53 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 0/7] transitioning to protocol v2
Date:   Thu, 24 Aug 2017 15:53:21 -0700
Message-Id: <20170824225328.8174-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another version of Git's wire protocol is a topic that has been discussed and
attempted by many in the community over the years.  The biggest challenge, as
far as I understand, has been coming up with a transition plan to using the new
server without breaking existing clients and servers.  As such this RFC is
really only concerned with solidifying a transition plan.  Once it has been
decided how we can transition to a new protocol we can get into decided what
this new protocol would look like (though it would obviously eliminate the ref
advertisement ;).

The best way to preserve functionality with old servers and clients would be to
communicate using the same end point but have the client send a bit of extra
information with its initial request.  This extra information would need to be
sent in such a way that old servers ignore it and operate normally (using
protocol v1).  The client would then need to be able to look at a server's
response to determine whether the server understands and is speaking v2 or has
ignored the clients request to use a newer protocol and is speaking v1.

Patches 1-5 enable a client to unconditionally send this back-channel
information to a server.  This is done by sending a version number after a
second NUL byte in git://, in the envvar GIT_PROTOCOL in file:// and ssh://,
and in an http header in http://, https://.  Patches 6-7 teach a client and
upload-pack to send and recognize a request to use protocol v2.

The biggest question I'm trying to answer is if these are reasonable ways with
which to communicate a request to a server to use a newer protocol, without
breaking current servers/clients.  As far as I've tested, with patches 1-5
applied I can still communicate with current servers without causing any
problems.

Any comments/discussion is welcome!

Brandon Williams (7):
  pkt-line: add packet_write function
  pkt-line: add strbuf_packet_read
  protocol: tell server that the client understands v2
  t: fix ssh tests to cope with using '-o SendEnv=GIT_PROTOCOL'
  http: send Git-Protocol-Version header
  transport: teach client to recognize v2 server response
  upload-pack: ack version 2

 builtin/fetch-pack.c         |   4 +-
 builtin/send-pack.c          |   5 +-
 connect.c                    | 196 +++++++++++++++++++++++++++----------------
 daemon.c                     |  28 ++++++-
 http.c                       |   7 ++
 pkt-line.c                   |  27 ++++++
 pkt-line.h                   |   2 +
 remote-curl.c                |   7 +-
 remote.h                     |  22 ++++-
 t/lib-proto-disable.sh       |   1 +
 t/t5551-http-fetch-smart.sh  |   2 +
 t/t5601-clone.sh             |  10 +--
 t/t5602-clone-remote-exec.sh |   4 +-
 transport.c                  |  60 +++++++++++--
 upload-pack.c                |  11 +++
 15 files changed, 286 insertions(+), 100 deletions(-)

-- 
2.14.1.342.g6490525c54-goog

