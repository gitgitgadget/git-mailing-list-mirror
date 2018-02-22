Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F011F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933727AbeBVSaF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:30:05 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:42989 "EHLO
        outbound-ss-1812.hostmonster.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933725AbeBVSaD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Feb 2018 13:30:03 -0500
Received: from CMOut01 (cmgw2 [10.0.90.82])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 8C292175E81
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:29:59 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by CMOut01 with 
        id DuVw1x00K0QvKlu01uVzM0; Thu, 22 Feb 2018 11:29:59 -0700
X-Authority-Analysis: v=2.2 cv=ft6sXBwf c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=Op4juWPpsa0A:10 a=eonSy44sy_rk5nA6RUsA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OdeuaTUWIcHcUkHGRk5khNV4mBCufYeQew4UqKdsG3E=; b=PrQX8Z6QpKNTSmHW3D+pCdEUQn
        wJqt4R4TyWQlxSX4ZO19dMSAkIxrKfr8qBdkPo0J/lsd5vEFFvdA/dsRwmJx0a7/6eLSiZprstqxJ
        yq8V7XTiEc3fh/wHWG5Zl+Mve;
Received: from [50.226.24.42] (port=49168 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1eovcx-000GyU-U8
        for git@vger.kernel.org; Thu, 22 Feb 2018 11:29:56 -0700
Message-ID: <1519324188.6391.156.camel@mad-scientist.net>
Subject: Git "branch properties"-- thoughts?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Git mailing list <git@vger.kernel.org>
Date:   Thu, 22 Feb 2018 13:29:48 -0500
Organization: I may be mad, but I'm a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Exim-ID: 1eovcx-000GyU-U8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:49168
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all.  I'm wondering if anyone has any thoughts about the best, or
even any, way to have "branch properties": some extra information which
is attached to a branch (that is, the actual branch name not the commit
it currently points to).

My requirements are that the information needs to be pushed to the
server, so that lets out branch descriptions for example.  Ideally the
information would also be easily updated and available in all clones
during normal fetch operations but this isn't a hard requirement: I
could script it.

My immediate desire is to find a way to mark a branch as "frozen", that
will control which pushes are allowed.  I use gitolite on my server and
I can easily write a server hook that will handle the checking,
rejecting, etc.  I already have such an infrastructure.  What I need is
a way to know which branches are in that state, so my hook can see that
and DTRT.  There are other "branch properties" I could envision, too,
but don't have a real need right now.

Of course I could embed the frozen state into the gitolite repository
configuration.  Indeed, I have already implemented "locks" for obsolete
branches.  But "frozen" is a more ephemeral state and requiring access
to the gitolite repository to manage it is just not what I want; it's a
separate repository so the state is not visible, requires privileges I
really don't want to hand out to everyone, and is generally difficult. 
I want some users to be able to manage frozen branches relatively
easily, and all users to be able to see the state of which branches are
frozen, etc.

So then I thought about creating a "frozen" tag, like "frozen/v1.0" or
something.  This is slightly weird because it is applied to a commit,
which is not really right, but whatever: it's just a marker so I would
just be checking to see if it exists or not.  The other problem is that
Git tags are not intended to be transient/moveable.  While you CAN
delete them and move them, when someone pulls the repository they won't
get that update by default.  Since the hook is server-side the fact
that the local repository has the wrong information doesn't matter for
behavior, but it's confusing for people.  So, it's not ideal.

I thought about creating a branch, like "frozen/v1.0", rather than a
tag.  I don't need a branch here, and no one would push to that branch
(I'd have to disallow that in my hooks), and the commit associated with
the branch would not be relevant most likely.  I would only check to
see if the branch existed, or not.  Branches are nice because creating
and deleting them is handled automatically (if you use prune
consistently, which we do because we have tons of transient branches).

Then I looked into using notes, and they look interesting, but they're
associated with a specific commit as well and I don't want that: a
frozen branch can still have new commits pushed to it they just have
meet certain criteria.  This makes them hard to translate into a branch
name.

So far, using a special branch name seems the most "reasonable".  But,
I wonder if I missed some cool aspect if Git that would work better, or
if anyone else has other suggestions.

Cheers!
