Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24858C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 16:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377109AbiATQvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 11:51:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51110 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346704AbiATQvl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 11:51:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEB081140B6;
        Thu, 20 Jan 2022 11:51:40 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        0hbDBrHjbEbK3A8fIMDAAWkTTHqjCfzGd3zwi8rwMIM=; b=XS8TNETLfWmp7MlL
        ESLLs+w+J+jIfBehru3OFSFbByD9iabHYUJb0E6lxs7eKqt2oGCXPf+S8y7iwlT4
        CsEPG9Auz/4n3mWGeRToKPogVk/lGwfIZw1gXMVIjh76N6VD49zasQBjPI2yYYy6
        VajcWuU4ftLSegVnr6iUNXPYCqI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B49141140B5;
        Thu, 20 Jan 2022 11:51:40 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1508A1140B4;
        Thu, 20 Jan 2022 11:51:40 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 20 Jan 2022 11:51:37 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: [BUG] builtin/checkout.c:1098: should be able to skip past
 'refs/heads/'
Message-ID: <YemTGQZ97vAPUPY0@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 3D321E62-7A11-11EC-9201-CB998F0A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A bug was filed in the Fedora/Red Hat bugzilla today for the
git 2.35.0 rc (rc1, but it's the same in rc2).  Petr (Cc'd),
ran the following

    git clone https://github.com/psss/fmf /tmp/fmf
    cd /tmp/fmf
    cp .git/refs/remotes/origin/HEAD .git/refs/heads/__DEFAULT__
    git checkout -f __DEFAULT__
    git checkout -f __DEFAULT__

The second git checkout call runs into the BUG() call added
in 9081a421a6 (checkout: fix "branch info" memory leaks,
2021-11-16):

    BUG: builtin/checkout.c:1098: should be able to skip
    past 'refs/heads/' in 'refs/remotes/origin/master'!
    Aborted (core dumped)

This worked in 2.34.1, so it's new to 2.35.0.  Should this
work or does the manual copy to setup a branch fall into a
new category of "don't do that"?

(It's novel to get a bug report from rc testing of a distro
build -- that doesn't happen often.)

-- 
Todd
