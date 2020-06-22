Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B40C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 20:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D6A20767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 20:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=smartsoftwareinc.com header.i=@smartsoftwareinc.com header.b="a78gx/He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgFVUbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:31:41 -0400
Received: from mail.smartsoftwareinc.com ([24.230.151.194]:41574 "EHLO
        mail.smartsoftwareinc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgFVUbk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 16:31:40 -0400
Received: from mward.lin.pirsss (unknown [10.0.0.166])
        by mail.smartsoftwareinc.com (Postfix) with ESMTPSA id 8F14B63452;
        Mon, 22 Jun 2020 15:31:38 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smartsoftwareinc.com;
        s=default; t=1592857898;
        bh=FRsV1KGRJuehEpbb9MhwyHB2ssMlVBS/XvCySonjEsk=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=a78gx/HenQVaEk9XxqK/nsvJLd9FBOG/HXJoGPkGPsbXanw0oKDoueW/XiMlDnfhW
         7M8gl6nlwfQnXOloiSD0fRyHT4moMEsrt/POesiB4x7kuwVWbEEIehlnJIeM8U9PY4
         v8x8T2Ep2d/jnZZFKBHkuK68zUmEFEkj4UWvnUUQ=
Subject: Re: Git 2 force commits but Git 1 doesn't
From:   Michael Ward <mward@smartsoftwareinc.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
Organization: Smart Software Solutions, Inc.
Message-ID: <c8dda2b1-9707-b7c2-aeee-239f470593ae@smartsoftwareinc.com>
Date:   Mon, 22 Jun 2020 15:31:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-smartsoftware-MailScanner-Information: Please contact the ISP for more information
X-smartsoftware-MailScanner-ID: 8F14B63452.AAC8A
X-smartsoftware-MailScanner: Found to be clean
X-smartsoftware-MailScanner-SpamCheck: not spam (whitelisted),
        SpamAssassin (not cached, score=-0.3, required 4, autolearn=not spam,
        ALL_TRUSTED, BAYES_50, DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU)
X-smartsoftware-MailScanner-From: mward@smartsoftwareinc.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops, 2.26.2 is the Fedora version. Not 2.27.2.

Michael

On 6/22/20 3:30 PM, Michael Ward wrote:
> Versions in use are 2.27.2 and 1.8.3.1. This behavior is seen with 
> regular pushes.
>
> I'll look into the http-backend functionality. If that will help 
> control that, we'll definitely want to use that instead. What 
> surprises me, though, is that even with DAV a 1.8 client appears to 
> work correctly in that it will warn the user that their push is about 
> to clobber the head, but 2.27 doesn't.
>
> Michael
>
> On 6/22/20 3:21 PM, brian m. carlson wrote:
>> On 2020-06-22 at 19:40:15, Michael Ward wrote:
>>> We have some repositories we are hosting here using Apache's DAV 
>>> module to
>>> handle remote connections.
>>>
>>> The repositories are created using the following:
>>>
>>> mkdir [reponame].git
>>> cd [reponame].git
>>> git --bare init
>>> git update-server-info
>>>
>>> Our Apache location directive is as follows:
>>>
>>> <Location /[reponame].git>
>>>          DAV on
>>>          AuthType Basic
>>>          AuthName "Git"
>>>          AuthBasicProvider ldap
>>>          AuthLDAPUrl [ldap server info]
>>>          <RequireAny>
>>>                  require [ldap filter]
>>>          </RequireAny>
>>> </Location>
>>>
>>> The repository config generates with the values in the core section 
>>> below,
>>> and we add the receive and advice sections:
>>>
>>> [core]
>>>          repositoryformatversion = 0
>>>          filemode = true
>>>          bare = true
>>> [receive]
>>>          denyNonFastForwards = true
>>>          denyDeletes = true
>>> [advice]
>>>          pushFetchFirst = true
>>>
>>> The odd behavior comes when we have git 1 vs git 2 clients 
>>> attempting to
>>> push in changes on the same branch. Git 1 clients will prompt the 
>>> user that
>>> they are out of date and need to pull. Git 2 clients don't and will 
>>> force
>>> push and overwrite the head revision. This occurs with either Git 1 
>>> or Git 2
>>> on the server.
>> Are you seeing this behavior when users are doing a force push, or just
>> a regular push?  I see that there exists code for the DAV-based protocol
>> to fail if a user attempts a regular push and is out of date, but I
>> haven't verified it works.
>>
>> If you're seeing this when users are doing a force push, then that's
>> expected.  The receive.* options have no effect here, since those
>> require an appropriate git process to run on the server, and you're
>> using the dumb (DAV-based) protocol, not the smart protocol. Therefore,
>> no git process runs on the server, so all the checking is done on the
>> client side and the client side allows force pushes with an appropriate
>> option.
>>
>> If you want to have more control over what's pushed, you'll need to use
>> the smart protocol instead, which is outlined in the git-http-backend
>> documentation.
>>
>> As a note, there are a lot of differences between Git 2.0.0 and the
>> latest version, Git 2.27.0, so it's probably best if you mention the
>> full version when reporting issues.  You haven't mentioned the specific
>> versions you're using, but it's possible if you're using the CentOS 6 or
>> 7 versions that they simply didn't support force pushing in this way.
