Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104FAC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E9760C40
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhJ3Uy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 16:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhJ3Uy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 16:54:57 -0400
Received: from viathinksoft.de (viathinksoft.de [IPv6:2001:1af8:4700:a07e:1::1337])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDBC061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:52:27 -0700 (PDT)
Received: by viathinksoft.de (Postfix, from userid 114)
        id 351EA61C7609; Sat, 30 Oct 2021 22:52:23 +0200 (CEST)
Received: from webmail.viathinksoft.de (localhost [127.0.0.1])
        (Authenticated sender: daniel-marschall@viathinksoft.de)
        by viathinksoft.de (Postfix) with ESMTPA id 552D061C17A9;
        Sat, 30 Oct 2021 22:52:01 +0200 (CEST)
MIME-Version: 1.0
Date:   Sat, 30 Oct 2021 22:52:01 +0200
From:   Daniel Marschall <info@daniel-marschall.de>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: git-svn bug: Output git directory has uncommitted changes
In-Reply-To: <20211027144111.y43o4qdp3pjp6xsh@tb-raspi4>
References: <77aacb3b44523223c7647bdae1702a31@daniel-marschall.de>
 <20211025094139.GA22377@dcvr> <20211026151442.65rndwsleyitxvvg@tb-raspi4>
 <5be6fa92074fb40f3167901d203941bc@daniel-marschall.de>
 <20211027144111.y43o4qdp3pjp6xsh@tb-raspi4>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <48d96db41fbe4400b995d9e9b9e03277@daniel-marschall.de>
X-Sender: info@daniel-marschall.de
Organization: ViaThinkSoft
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.2021 16:41, schrieb Torsten Bögershausen:
> On Tue, Oct 26, 2021 at 09:30:39PM +0200, Daniel Marschall wrote:
>> Am 26.10.2021 17:14, schrieb Torsten Bögershausen:
>> 
>> What I had in mind was the following:
>> I have files in my SVN repository which are CRLF, and some files are 
>> LF.
>> I wanted to tell GIT which line ending the files should have
>> so that they will have the exact same line endings after the repo is 
>> checked
>> out. I think text=auto will also do this, maybe I should try that.
>> 
>> The "AFS" files are very special, though. Due to compatibility 
>> reasons, they
>> must be in the ancient Macintosh format (CR) otherwise the program 
>> won't
>> work. Do I need to state "eol=cr" then? Or will GIT automatically use 
>> the
>> same line endings as in the files which I have added to SVN?
> 
> Git will not change files with CR as line ending:
> When there is neither a LF nor CRLF; then the file is "not text".
> 
> git ls-files --eol  | grep "^i/-text"
> 
> Will list png, afs and some other.
> You can remove the eol=cr (it doesn't do anything useful, and it is
> just confusing)

I looked at the git documentation, but I couldn't find an official 
statement
that only "lf" and "crlf" are legal values of "eol". I only found 
examples of CRLF and LF,
but I think that doesn't mean that the lack of a CR example implies that 
CR is forbidden.
Or did I miss something?

I think it would be great if "eol=cr" could be implemented.
If you have a legacy Mac OS9 project or a project that requires files in 
a
legacy text format, then I think it would be nice if Git could be able 
to diff these
CR-text-files. If I treat them as binary, I think there can't be a
text-like diff?

> 
> Better would be:
> *.afs -text
> or
> *.afs binary
> 
> I leave it to the reader, to find out what the difference is.

I thought a long time about it, but I can't figure it out.
Google can't help me either, because "-text" is will be treated as an 
exclusion in the search term.

Can you please tell me what the difference is?
I have the theory that "binary" tells Git to handle it binary, while 
"-text" tells Git to handle it neither as binary nor as text 
("undefined")?

