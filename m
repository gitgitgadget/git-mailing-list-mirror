Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33BC32035F
	for <e@80x24.org>; Fri, 28 Oct 2016 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761980AbcJ1VkI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 17:40:08 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:54510 "EHLO
        homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761948AbcJ1VkH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Oct 2016 17:40:07 -0400
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id 8D4FD578190
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:content-type:date:mime-version:
        content-transfer-encoding; s=mattmccutchen.net; bh=IJFhjHuA6Gy6n
        G94Hk4H1b3KqPE=; b=Y+pDnVUzI8WDMXRj+0zDXXa7IMrOb9/w1v8XQo1v29x5X
        FiqqBt3KlerXtOEqhSrYidsPoKOCgVwOfzW2v2f5TTVy8KJ4cxAVuXRsveZSGnuq
        QwfPW5QzVIkZBk3QKZmqIKXETShS35xJIbPTsICyfqinF8Y8kT0qYKBa9tO/E0=
Received: from main (30-9-219.wireless.csail.mit.edu [128.30.9.219])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPSA id 47CE357811D
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 14:40:05 -0700 (PDT)
Message-ID: <1477690790.2904.22.camel@mattmccutchen.net>
Subject: Fetch/push lets a malicious server steal the targets of "have"
 lines
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 28 Oct 2016 17:39:50 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was studying the fetch protocol and I realized that in a scenario in
which a client regularly fetches a set of refs from a server and pushes
them back without careful scrutiny, the server can steal the targets of
unrelated refs from the client repository by fabricating its own refs
to the "have" objects specified by the client during the fetch. =C2=A0Thi=
s
is the reverse of attack #1 described in the "SECURITY" section of the
gitnamespaces(7) man page, with the addition that the server doesn't
have to know the object IDs in advance. =C2=A0Is this supposed to be well=
-
known? =C2=A0I've been using git since 2006 and it was a surprise to me.

Hopefully it isn't very common for a user to fetch and push with a
server they don't trust to have all the data in their repository. =C2=A0I
don't think I have any such cases myself; I have unfinished work that
isn't meant for scrutiny by others, but nothing really damaging if it
were released to the server. =C2=A0This attack presents no new risks if a
user already runs code fetched from the server in such a way that it
can read the repository. =C2=A0But there might be some users who just rev=
iew
embargoed security fixes from multiple sources (or something like that)
without running code themselves, and their security expectations might
be violated.

If my analysis is correct, I'd argue for documenting the issue in a
"SECURITY" section in the git-fetch man page. =C2=A0Shall I submit a patc=
h?

Thanks for your attention.

Matt
