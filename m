Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0438020756
	for <e@80x24.org>; Wed, 18 Jan 2017 02:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbdARCSJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 21:18:09 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:60106 "EHLO
        homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751898AbdARCSI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Jan 2017 21:18:08 -0500
X-Greylist: delayed 968 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jan 2017 21:18:08 EST
Received: from homiemail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTP id 7C713634085
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 18:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=mattmccutchen.net; bh=stV6NzHZkZ8J5
        Ua+W5Eubxmx2C0=; b=fTj0+9l2J7AnO+uDYdO2KZV3/IqYy1UOj4DEmYFK+dKl9
        vhnGnoNIngux1cskbz+eOi2Z9h9m4DE6Hx3bPOiWr7CKIOULCKedh8OREoHFt8iI
        9IxLQa1nkhaO8FWwdsZrvq8t41yG04J4n1qXWELGQ24SgZ/qbFWLdgZJfz+9U4=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTPSA id 2EBD8634080
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 18:01:59 -0800 (PST)
Message-ID: <1484704915.2096.16.camel@mattmccutchen.net>
Subject: "git diff --ignore-space-change --stat" lists files with only
 whitespace differences as "changed"
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git@vger.kernel.org
Date:   Tue, 17 Jan 2017 21:01:55 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.3 (3.22.3-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A bug report: I noticed that "git diff --ignore-space-change --stat"
lists files with only whitespace differences as=C2=A0having changed with =
0
differing lines.  This is inconsistent with the behavior without --
stat, which doesn't list such files at all.  (Same behavior with all
the --ignore*space* flags.)  I can reproduce this with the current
"next", af746e4.  Quick test case:

echo ' ' >test1 && echo '=C2=A0=C2=A0' >test2 &&
git diff --stat --no-index --ignore-space-change test1 test2

This caused me some inconvenience in the following scenario: I was
reading a commit diff that had a bulk license change in all files
combined with code changes.  I attempted to revert the bulk license
change locally using "sed" to more easily read the code diff, but my
reversion left some whitespace diffs where the original files had
inconsistent whitespace.  So the diffstat after my reversion was
cluttered with these "0" entries.

Regards,
Matt
