Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BDA2018A
	for <e@80x24.org>; Sat,  2 Jul 2016 00:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbcGBAUX (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 20:20:23 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36432 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbcGBAUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 20:20:22 -0400
Received: by mail-pf0-f175.google.com with SMTP id t190so44443906pfb.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 17:20:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MAkrd2oisY2kKV4scUV5VNSnZt9MlUDjk27U2MhGqk8=;
        b=lccBactj2whCocZ/ZXzPzkbyMO5pvBRhkMcCa8ww1ov7PBN7zk8tSEvz6+ePSdosFg
         S5FoRPm/ZDcdfO6uTQGvneVYyI7/Dv9dVUCTvaxkDhnQOhP43tJ918URulbxmdnrbIK+
         7bRtiixosWM3Iz1ILcIck31OfSzfuRrJg+HYppDB6k9U4qQPyN4s6sgctEY6WPsXy4+F
         MNuJUVRbZI7xsuSvHGmudXBZ+9mhDz/Bq85u/AMzCgCal4LTfVluUuKXQuMgbKNhLEym
         2s6McrpiMAM8FHVteMJPU1OixQbXE9H7Z8+1JN8fZhcrHU5pwU+ZZPOc5f4hGLmSSL6X
         ocDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MAkrd2oisY2kKV4scUV5VNSnZt9MlUDjk27U2MhGqk8=;
        b=OM+EcbIU0nZgl2hTi5HVO6gXzXQLWxOkN91NfSfGgPDBmISDS/UKyOnbEP9+h7WAXb
         OFVooAybIaEa4MERd4QK06PmUK5qegVf1R2Irwls3vMyMOzV2XedFk6aDouLypbzL5ND
         fXZ+RC/TR54p3y8DGclNKO8/in+cKlF/ikbx0B3RAZ2h6lF9u04iswQYjNEV6ath+CFU
         7Oh+4pmVywAhXVdu2dtOeBZIqs8IkzOihcVGeiFhtKcM7CoezmGxzrnevO80ZTCjVx05
         5Rm6EBxPshuEB8YRNUaF19q8xqO7BMOwX0fZ+9qI/jov2CHqoHArXe/X7LexQr0JTc76
         KUoA==
X-Gm-Message-State: ALyK8tIH3lsJLtGvdYtibn13kwA54i59xVQ9rmvIxrmA48uSOkxbudnmB0A+r/dLr9zevmcU
X-Received: by 10.98.9.68 with SMTP id e65mr1579079pfd.121.1467418819286;
        Fri, 01 Jul 2016 17:20:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c009:86e6:19a6:486e])
        by smtp.gmail.com with ESMTPSA id k9sm357908pao.19.2016.07.01.17.20.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 17:20:18 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, peff@peff.net
Cc:	dwwang@google.com, gitster@pobox.com, dennis@kaarsemaker.net,
	Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 0/4] Push options in C Git
Date:	Fri,  1 Jul 2016 17:20:10 -0700
Message-Id: <20160702002014.29497-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gd59d3e9.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Allow a user to pass information along a push to the pre/post-receive hook
on the remote.

Jeff writes on v1:
> Whereas in Dennis's patches, it was about specific information directly
> related to the act of pushing.

This allows to transmit arbitrary information as the backends of $VENDOR
may have different options available related to the direct act of pushing.

Thanks,
Stefan

Cover letter v1:
================

Allow a user to pass information along a push to the pre/post-receive hook
on the remote.

When using a remote that is more than just a plain Git host (e.g. Gerrit,
Git{hub/lab}, etc) this may become more obvious: The (server backend specific)
push options can instruct the server to:
* open a pull request
* send out emails asking for review
* (un)trigger continuous integration
* set priority for continuous integration (i.e. bots pushing may ask to be
  treated with lower priority compared to humans)
* ... 

Most of these actions can be done on the client side as well,
but in these remote-centric workflows it is easier to do that on the remote,
which is why we need to transport the information there.

More concrete examples:
* When you want a change in Gerrit to be submitted to refs/heads/master, you
  push instead to a magic branch refs/for/master and Gerrit will create a change
  for you (similar to a pull request). Instead we could imagine that you push
  to a magical refs/heads/master with a push option "create-change".
  
* When pushing to Gerrit you can already attach some of this information by
  adding a '%' followed by the parameter to the ref, i.e. when interacting with
  Gerrit it is possible to do things like[1]:
    
    git push origin HEAD:refs/for/master%draft%topic=example%cc=jon.doe@example.org
  
  This is not appealing to our users as it looks like hacks upon hacks to make
  it work. It would read better if it was spelled as:
  
  git push origin HEAD:refs/for/master \
      --push-option draft \
      --push-option topic=example \
      --push-option cc=jon.doe@example.org
      
  (with a short form that is even easier to type,
   but this is is more intuitive already)

This is a patch series to Git core, which is developed at the same time
as a change is proposed to JGit by Dan Wang, see [2].

This code is also available at [3].

Thanks,
Stefan

[1] Not all Gerrit '%' options are documented, so here is a link to source code instead :(
https://gerrit.googlesource.com/gerrit/+/refs/heads/master/gerrit-server/src/main/java/com/google/gerrit/server/git/ReceiveCommits.java#1141

[2] https://git.eclipse.org/r/#/c/74570/ 
 
[3] https://github.com/stefanbeller/git/tree/pushoptions

Stefan Beller (4):
  push options: {pre,post}-receive hook learns about push options
  receive-pack: implement advertising and receiving push options
  push: accept push options
  add a test for push options

 Documentation/config.txt                          |  7 +-
 Documentation/git-push.txt                        |  8 ++-
 Documentation/githooks.txt                        |  4 ++
 Documentation/technical/pack-protocol.txt         | 10 +--
 Documentation/technical/protocol-capabilities.txt |  8 +++
 builtin/push.c                                    | 16 ++++-
 builtin/receive-pack.c                            | 85 +++++++++++++++++++----
 send-pack.c                                       | 29 ++++++++
 send-pack.h                                       |  3 +
 t/t5544-push-options.sh                           | 85 +++++++++++++++++++++++
 transport.c                                       |  2 +
 transport.h                                       |  7 ++
 12 files changed, 242 insertions(+), 22 deletions(-)
 create mode 100755 t/t5544-push-options.sh

-- 
2.9.0.141.gdd65b60

