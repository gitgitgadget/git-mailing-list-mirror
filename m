Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3197B1F859
	for <e@80x24.org>; Tue, 23 Aug 2016 05:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbcHWFFk (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 01:05:40 -0400
Received: from elvis.mu.org ([192.203.228.196]:36557 "EHLO elvis.mu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932436AbcHWFFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 01:05:39 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Aug 2016 01:05:39 EDT
Received: from Alfreds-MacBook-Pro-2.local (unknown [IPv6:2601:645:8003:a4d6:3557:600f:9140:4bf])
        by elvis.mu.org (Postfix) with ESMTPSA id E7333346DDE2;
        Mon, 22 Aug 2016 21:58:32 -0700 (PDT)
Subject: Re: git-svn bridge and line endings
To:     Eric Wong <e@80x24.org>, Lucian Smith <lucianoelsmitho@gmail.com>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
 <20160823030721.GA32181@starla>
Cc:     git@vger.kernel.org
From:   Alfred Perlstein <alfred@freebsd.org>
Organization: FreeBSD
Message-ID: <5e17164f-f669-70c2-de78-25287ab59759@freebsd.org>
Date:   Mon, 22 Aug 2016 21:58:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160823030721.GA32181@starla>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/22/16 8:07 PM, Eric Wong wrote:
> Adding Alfred to the Cc:, more below...
>
> Lucian Smith <lucianoelsmitho@gmail.com> wrote:
>> I'm attempting to use the git-svn bridge, and am having problems with
>> line endings on Windows.
>>
>> The setup is that we have a git repository on github, and I've checked
>> out a branch on my Windows machine using Tortoise svn.  I make
>> changes, commit them, and the branch is updated.  In general, this
>> works fine.
>>
>> If this was just SVN, I could set the 'eol-style' for files to
>> 'native' to let it know to expect Windows/linux/mac line endings for
>> particular files.  This seems to be handled in git by using the
>> '.gitattributes' file instead.  Unfortunately, the git/svn bridge
>> doesn't seem to be translate the information in the .gitattributes
>> file to appropriate eol-style settings in SVN.  Checking out a file
>> using SVN on Windows leaves me with a file without CRLF's, and if I
>> check in a CRLF file, that's the way it goes into the repository.
>> Differences in CRLF alone show up as 'real' differences that can be
>> checked in, and, if this happens, this causes problems with other
>> people's repositories.
>>
>> Am I doing something wrong; is there another way to handle this; or
>> can I file this as a bug report/feature request?
>>
>> Thank you!
>>
>> -Lucian Smith
> Lucian: Which version of git are you using?
>
> As of git v2.3.0 and thanks to Alfred, the "git svn propset"
> command exists for setting new props via git; however it
> only got documented recently in v2.9.1.
>
> It also seems to support setting props via "svn-properties"
> in the .gitattributes file based on reading the code;
> but I'm not familiar with this area, so I defer to Alfred.
>
> Alfred: "svn-properties" isn't documented anywhere, yet;
> is this something that should/could be documented?
>
> Thanks.
>
> cf. commit 83c9433e679635f8fbf8961081ea3581c93ca778
>      ("git-svn: support for git-svn propset")
>      https://bogomips.org/git-svn.git/commit/?id=83c9433e6796
>
>      commit 19a7f24b6f8aa89ea5899c928c2fa350f4b1521e
>      ("git-svn: document the 'git svn propset' command")
>      https://bogomips.org/git-svn.git/commit/?id=19a7f24b6f8a
>
>      https://public-inbox.org/git/?q=s:%22git-svn+propset%22
>
> Anyways I've never used SVN props much myself, so don't much
> have experience in this area; nor do I have much experience
> with git-side gitattributes.
>
Thank you.  I'm going to need some time to look into this.  The addition 
of svn-properties support was mostly to facilitate those that needed 
attributes set for other svn consumers or "repo meister" (the person 
that runs VCS).  An example being FreeBSD's 'Keyword expansion' on 
checkout facility, that says whether or not to expand $FreeBSD$.

I hadn't anticipated there be to translation between svn props and 
.gitattributes, it sounds a bit messy but possible, that said, is it not 
possible to commit .gitattribute files to the svn repo?  Even in FreeBSD 
land such small token files are permitted.

As far as documenting svn-properties, most of the properties are used on 
the Subversion side either by subversion itself, or by scripts in the 
subversion repository.  Perhaps a blurb "see the subversion 
documentation and/or your local subversion administrator's guide for 
properties and their uses." would suffice?

Opinions?  Happy to look into it.

-Alfred






