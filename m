Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0045E211B4
	for <e@80x24.org>; Tue,  4 Dec 2018 04:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLDETP (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 23:19:15 -0500
Received: from www.dnalounge.com ([3.16.178.106]:51362 "EHLO
        cerebrum.dnalounge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDETP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 23:19:15 -0500
Received: from [10.0.1.2] (70-36-236-109.dsl.static.fusionbroadband.com [70.36.236.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cerebrum.dnalounge.com (Postfix) with ESMTPSA id 225EFE48;
        Mon,  3 Dec 2018 20:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jwz.org; s=mail;
        t=1543897154; bh=ci8c94V2l0aEHh4DXFbDGGoIyU9MLI70tlgFAk+kSgc=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=f3PBaaEvRVXrb4pmD2uatViiSQKCyzZKEKho6cJw4FYzaU9C4h1GUk5bhX3uxWt1/
         nr0wtXQMnnpFEVV0yVdv/2dFlf/95MR/V6q6Au9NCgFOGZYbwl9xta0I2yMnO+6NLl
         B59Yz/cjfRKfk5sXaGQYBfzC/PSuJwve3ylnb8gQ=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: sharedrepository=group not working
From:   Jamie Zawinski <jwz@jwz.org>
In-Reply-To: <20181204040903.GA17059@sigill.intra.peff.net>
Date:   Mon, 3 Dec 2018 20:19:12 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <53C59F2A-6D97-45F9-AF86-E255F6777E7F@jwz.org>
References: <F9365CBF-3D2D-4A05-AC0D-4604067B5826@jwz.org>
 <20181204040903.GA17059@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 3, 2018, at 8:09 PM, Jeff King <peff@peff.net> wrote:
>=20
> but it works fine. Might there be some effective-uid trickiness with =
the
> way the server side of git is invoked? Or is this a network mount =
where
> the filesystem uid might not match the process uid?

Huh. They're on the same ext4 fs (it's an AWS EBS sc1 volume, but I =
think that still counts as "not a network mount" as far as Linux is =
concerned.)

The way I was seeing this fail was a CGI invoking "git push", as user =
"httpd" (and I verified that when the cgi was invoked, "groups" reported =
that "httpd" was a member of group "cvs") but when I tried to reproduce =
the error with "sudo -u apache git push" it didn't fail. So possibly =
something hinky is going on with group permissions when httpd invokes =
git, but I did verify that whoami, groups and pwd were as expected, so I =
couldn't tell what that might be... (Oh, I didn't check what umask was, =
but it should have been 022...)

--
Jamie Zawinski      https://www.jwz.org/      https://www.dnalounge.com/

