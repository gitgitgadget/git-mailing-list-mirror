From: Victor Leschuk <vleschuk@gmail.com>
Subject: Re: [PATCH 2/2] git-svn: test for git-svn prefixed globs
Date: Thu, 17 Dec 2015 00:31:23 +0300
Message-ID: <5671D82B.8020107@gmail.com>
References: <1450270869-29822-1-git-send-email-vleschuk@accesssoftek.com>
 <1450270869-29822-3-git-send-email-vleschuk@accesssoftek.com>
 <20151216212811.GA19884@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 22:31:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9JfX-0002iW-GU
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 22:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965781AbbLPVb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 16:31:27 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34660 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbbLPVb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 16:31:27 -0500
Received: by mail-lf0-f50.google.com with SMTP id y184so38830206lfc.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 13:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=lo0n4/yAf8QbZdAD7CfPedi+C2/fpBHqy/1kuXno+OY=;
        b=GGI1vrpNbS7CB4Mzgl+GL5IFddUK308p+Sy6rdr5NtqjF6YIG5o1VrJHt6wfkhJCms
         RpnL09PKSuX2GnIpmPV6hMlNDwWoEV7mAKwYa8vQp8tC85dieBFvqW58fWcMImqAwvy6
         fLhSw9B61gMzlkh9JIgocSx0vnMKd9DeBbve9LYfMn3uNBbhEANkIhucoBixPu6fSXvv
         UJLsMMP5PVoOF2kvk7ln7mnf+VVKlC/rnw6HAAGnFTo7ISxZu68r2HSZCgj7qlT/Eewv
         ngP++ZKdXLMWjmLyWI3sa4UVnt6tWqLG5orhlRfgeKLyCwRlpn7FQVXXH4f8J/kC2U+6
         iTyg==
X-Received: by 10.25.165.17 with SMTP id o17mr1981280lfe.145.1450301485596;
        Wed, 16 Dec 2015 13:31:25 -0800 (PST)
Received: from [192.168.1.101] (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id l128sm1366968lfd.10.2015.12.16.13.31.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Dec 2015 13:31:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <20151216212811.GA19884@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282593>

Hello Eric, sorry, I just copy pasted your old t9108-git-svn-glob.sh, 
changed branch names to be prefixed and added test for "exact" prefix 
match. If it is necessary I can rewrite it according to current guidelines.

On 12/17/2015 12:28 AM, Eric Wong wrote:
> Thanks for this work.  Most things look fine with 1/2, comments
> on 2/2 below...
>
> Victor Leschuk <vleschuk@gmail.com> wrote:
>> Add test for git-svn prefixed globs.
> Why a separate patch?  Unless there's some documentation purpose
> for a regression, usually tests and a feature should be added
> atomically in the same commit.
>
>> --- /dev/null
>> +++ b/t/t9168-git-svn-prefixed-glob.sh
>> @@ -0,0 +1,136 @@
>> +#!/bin/sh
>> +test_description='git svn globbing refspecs with prefixed globs'
>> +. ./lib-git-svn.sh
>> +
>> +cat > expect.end <<EOF
> We prefer redirects in new code to be in the form of ">foo" (no space)
> (or ">>foo" for append).
>
> It wasn't in the old tests, either, but Documentation/CodingGuidelines
> favors this for new code.
>
>> +the end
>> +hi
>> +start a new branch
>> +initial
>> +EOF
> All the setup code be checked for errors with '&&' as well.
>
>> +	test "`git rev-parse refs/remotes/tags/t_end~1`" = \
>> +		"`git rev-parse refs/remotes/branches/b_start`" &&
>> +	test "`git rev-parse refs/remotes/branches/b_start~2`" = \
>> +		"`git rev-parse refs/remotes/trunk`" &&
> And we prefer $(command) instead of `command` for nestability
> as Documentation/CodingGuidelines suggests.
>
> (yeah, most of the old tests don't follow the guidelines, but the
>   guidelines also warn against fixup patches for them).
>
> Thanks again.
