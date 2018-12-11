Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EA320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeLKQm4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 11 Dec 2018 11:42:56 -0500
Received: from elnino.lfos.de ([46.165.227.75]:28237 "EHLO elnino.lfos.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeLKQm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 11:42:56 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2018 11:42:56 EST
Received: by elnino.lfos.de (OpenSMTPD) with ESMTPSA id 7e9315d6 (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256:NO)
        for <git@vger.kernel.org>;
        Tue, 11 Dec 2018 17:36:15 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     git@vger.kernel.org
From:   Lukas Fleischer <lfleischer@lfos.de>
Subject: [RFC] A global mailmap service
Message-ID: <154454625546.29948.6229097078125430492@typhoon>
User-Agent: alot/0.7
Date:   Tue, 11 Dec 2018 17:37:35 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I came up with the idea of creating a global mailmap service earlier
this year and, given a recent discussion on maintaining .mailmap, I
decided to bring it up here. While only marginally related to Git
development, I hope that it is relevant enough to not be considered
spam.

The basic idea of the service I imagine is simple:

1. You register a primary email address and specify a password. You
   receive a verification email to confirm that the address is yours.

2. At any time, you can add additional email addresses and link them to
   your primary email address, using your previously specified password.
   You can also update your primary email address. Any new addresses
   obtain verification emails such that you cannot steal somebody else's
   identity.

3. Anybody can use a public lookup interface to obtain the current
   primary email address corresponding to any registered email address
   they enter.

According to the principle of data economy, the full list of email
addresses is kept private. An email address is only returned if the user
performing a lookup already owns a (possibly outdated) email address of
the same user.

A batch query to the service can be used to automatically generate a
.mailmap file without having to maintain it on a per-project basis and
without having to be careful and confirm every entry manually.

I created a PoC here [1]. You can run

    git log --pretty='%ae' | sort -u | curl -Ftopic=git -Femails='<-' https://mailmap.org/

from the Git source tree to auto-generate a .mailmap file. Of course,
this idea only works if people agree that it is useful and the majority
of developers register their email addresses to the service.

I am aware that some users use different email addresses for different
projects. The current approach is allowing the user to add primary
"topic email addresses". A request can optionally specify a topic (such
as "git" in the request above) and the lookup may potentially return an
email address different from the generic primary address. Of course,
these topics need to be standardized in some way. There might be better,
more sophisticated ways to tackle this and I'd be happy to discuss them
if there is interest in the general approach.

I am also aware that this may not cover all potential uses of .mailmap
files but, according to my understanding and experience, it should cover
a fairly large amount. The remaining adjustments can still be made on
top on a per-project basis.

Best regards,
Lukas

[1] https://mailmap.org/
