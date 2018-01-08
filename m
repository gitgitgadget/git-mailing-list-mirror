Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE601F404
	for <e@80x24.org>; Mon,  8 Jan 2018 03:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755225AbeAHDuX (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 22:50:23 -0500
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21315 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754987AbeAHDuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 22:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1515383419;
        s=zoho; d=myles.hk; i=i@myles.hk;
        h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1670; bh=9Gh2wlXD912AULnmwaVMwlui7uFKL38t/YtxzWwT0Ek=;
        b=Rte7X/V75aLaYZJJIU86ToJjL6JvV60vONYIXzYEb07t4z9MizWxYU1SNQU4C3DN
        i+2fO/8VuLRHXZ7+8P1P6uymoJ69fDciSvf1EcsvrsOK+XFB92HpWfaa+lRFKMLq4/t
        1lfGQ6wEOi6Sf8Pq29Pi8k7rhzs9l2FMdOSuY3kg=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1515383419541342.29928837895875; Sun, 7 Jan 2018 19:50:19 -0800 (PST)
Date:   Mon, 08 Jan 2018 11:50:19 +0800
From:   Myles Fong <i@myles.hk>
Reply-To: i@myles.hk
To:     "git" <git@vger.kernel.org>
Message-ID: <160d3e3f291.df909f06277296.7997490218741761365@myles.hk>
Subject: Possible bug report: git checkout tag problem
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brief description:
When two tags are pointing to the same commit, e.g. tagA and tagB, if I do `git checkout tagA` then `git checkout tagB`,  and then `git status`, it shows `HEAD detached at tagA`

Expected behaviour:
I'm expecting it to show `HEAD detached at tagB`, though I understand this makes no difference for the repo code, but still a bit confusing for me.

Found workaround:
If I do an extra step `git checkout master`, followed by `git checkout tagB`,  and then `git status`, it shows `HEAD detached at tagB` as expected. ("master" can be any branch name)

Affected version:
This happens with the latest git version 2.14.3.

Detailed background:
We have a system consists of many git repos, and are using tags of global version numbers to ensure the same version of repos are deployed in the whole system. Sometimes when we have a new minor version of the system, there is no new commits for some repos. Still we need a new version tag for those repos to match the system version number, so we put a new version tag pointing to the same commit as the previous version tag. This is how we ran into the above situation and I was suspecting that our deploying script didn't run properly when I see `HEAD detached at {old-version}` in some locations of a {new-version} system.
I'm not sure if this is an expected behaviour or not because I didn't found any useful information after some Goolgling, except the following discussion.

Related discussion:
I found this discussion to be related to the same problem:
https://stackoverflow.com/questions/30631000/git-checkout-tag-issues-tag-is-unchanged/30631434#30631434

Regards,
Myles Fong


