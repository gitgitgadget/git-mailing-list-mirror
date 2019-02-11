Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3761F453
	for <e@80x24.org>; Mon, 11 Feb 2019 08:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBKI7s convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 11 Feb 2019 03:59:48 -0500
Received: from mail.bjtu.edu.cn ([218.249.29.198]:53849 "EHLO bjtu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbfBKI7s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 03:59:48 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 03:59:47 EST
Received: by ajax-webmail-Jdweb3 (Coremail) ; Mon, 11 Feb 2019 16:57:19
 +0800 (GMT+08:00)
Date:   Mon, 11 Feb 2019 16:57:19 +0800 (GMT+08:00)
From:   =?utf-8?B?6IKW5bu65pm2?= <06271023@bjtu.edu.cn>
To:     "Eric Wong" <e@80x24.org>
Cc:     git@vger.kernel.org
Message-ID: <16f3efae.125ea.168dbc6689b.Coremail.06271023@bjtu.edu.cn>
In-Reply-To: <20181229041615.ay7pazjqozbvz7qz@dcvr>
References: <650358a3.8395.167f09e21b6.Coremail.06271023@bjtu.edu.cn>
 <20181229041615.ay7pazjqozbvz7qz@dcvr>
Subject: Re: Re: a git svn bug
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [111.194.118.207]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 4.0.8 dev build
 20150608(70565.7215.7117) Copyright (c) 2002-2019 www.mailtech.cn bjtu
X-SendMailWithSms: false
X-CM-TRANSID: d55wygC397DvOGFcToUQAQ--.16086W
X-CM-SenderInfo: yqwsliaqstquxmwxhvlgxou0/1tbiAwISAFOeS0Zb+AAAsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> 肖建晶 <06271023@bjtu.edu.cn> wrote:
> > hi,
> >    git developers. I found a bug when i want to convert webkit to git
> >    there are some branch named safari... in webkit svn repo.
> >    when i want to convert them to branch in git. a problem happen.
> > 
> >    if you want to reproduce the problem, just follow the guide below.
> >    1. git svn clone -s https://svn.webkit.org/......
> 
> Do you mean  https://svn.webkit.org/repository/webkit ?
>
You are right. I use this url to fetch svn repo
 
> >    2. when it runs to about r13800, stop it and rerun the above command
> 
> So running "clone" again?  Normally, I'd run "git svn fetch" if
> I stopped and want to resume (or my Internet connection drops,
> which happens a lot).
> 
In fact, git svn clone again and git svn fetch will do nearly the same thing.
So we could use these two commands either. I just get used to git svn clone.

> >    3. the git client will check the refs it already found, and
> >    if it met a ~ in the branch name. it will failed to
> >    proceed. error is git thinks it an invalid ref name
> >j
> >    i digged into it, and found a solution in
> >    git/perl/git/svn.pm. I mod this file and bypass the
> >    problem.
> 
> Can you show us what you did to perl/Git/SVN.pm?
> 
> the "refname" sub in perl/Git/SVN.pm already escapes "~",
> it seems.
> 

  ***  i used this sed to fix it:
       sed -i "/refname = /a\\\t\t\$refname =~ s/~/%7E/g;" perl/Git/SVN.pm
       sed -i "/refname = /a\\\t\t\$refname =~ s/ /%20/g;" perl/Git/SVN.pm
       You can use the regex above to find the exact place (about line 93 )where the issue happens. I think after the sentence refname = ....,  variable refname should be right, but it seems not. Please examine if after that sentence, refname contains some symbol like ~ or " "(space). If it does, the command after that may not deal with it correctly. Please be kind to check it again.

> >    plean be kind to fix the problem and remind me the fix
> >    commit, and i will update to a new version.
> 
> We'll try, but I think we need more information.  Thanks.

unfortunately, after several days of work. The whole webkit is not converted into git repo, because I met another problem. It said index mismatch. And I was not able to solve it anymore. I plan to convert it later again. It's awful.

If you have any question, feel free to inform me. I always eager to help in my spare time.

