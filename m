From: Thomas Nyberg <tomnyberg@gmail.com>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 14:59:18 -0500
Message-ID: <566F1F96.4060806@gmail.com>
References: <566EFF11.6010600@gmail.com>
 <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
 <566F05B2.8080403@gmail.com> <1450120801.1678.13.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:59:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ZHL-0006hj-VV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbbLNT7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:59:24 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36812 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbbLNT7X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:59:23 -0500
Received: by qget30 with SMTP id t30so21603928qge.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=UJXaZpiJD61xMQqfpk5Hq31dTHed8OJLD0BN34GsSkM=;
        b=sQevV30vw/rWcWFFEYy7QV7Io17UwCFvO9SnygdPLkA7HHdWWruY0cMyE9aNs+NY76
         hZhijCCz6X9e3k08gBukDal7XHPSpAJuXSbmhoiEXyzSICopwf3g+FDXp8U/3rcHJw/+
         zaidlGaSo87L4wQzN5X3C5uzaiM9uhM8FlcpTugFNQHl2lbV23zL3z5mexzJO9y+zM9H
         p9TU/kPYismF0vHucCUJVTtYh1CZTiLrpeJdL7WYUwpIom6YtCypgcKY9s6L1dPJph5z
         kQ8ClOxPyop9PnsNfqFH2+eINjKPvzERYviqHeFbffH1UUd+Yj+9KXhLR8Q9AR/mCfji
         Zl2w==
X-Received: by 10.140.216.14 with SMTP id m14mr38072350qhb.90.1450123160893;
        Mon, 14 Dec 2015 11:59:20 -0800 (PST)
Received: from [128.59.76.160] (dyn-128-59-76-160.dyn.columbia.edu. [128.59.76.160])
        by smtp.googlemail.com with ESMTPSA id c2sm939387qkb.41.2015.12.14.11.59.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 11:59:19 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1450120801.1678.13.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282397>

In the .git/config there is no [branch "frus"] section. At first this is 
expected (i.e. cleaning cloning), but nothing changes when I execute 
`git checkout frus`. When I execute `git checkout frus_body_cleaning` 
that gets added to .git/config as expected.

.git/refs/heads contains two files "master" and "frus_body_cleaning" 
pointing to their respective commits, but there is nothing else there. 
here's the other command

$ grep frus packed-refs
3a1dbe48299f6eda1cc4b69cab35284c0f0355eb refs/remotes/origin/frus
1750cba5a94b3fe6041aaf49de430a558a3b9bc8 
refs/remotes/origin/frus_body_cleaning

So here frus actually is showing up. The find command isn't working 
either. I changed it to add the * but only shows the frus_body_cleaning 
branch:

$ find .git -name 'frus*'
.git/logs/refs/heads/frus_body_cleaning
.git/refs/heads/frus_body_cleaning

So yeah this is pretty weird. I'm guessing you're looking for name 
collisions of some kind? I had the idea that the problem might that too 
and used git show-index to look for all objects, but none of them have 
frus in them (I thought that maybe if the sha of one of them started 
with "frus" that would explain it but no dice). Since the command `git 
checkout -b frus origin/frus` works, it seems to me like somehow git is 
getting confused going from the `git checkout frus` command to that 
expanded one.

It is pretty baffling.

On 12/14/2015 02:20 PM, David Turner wrote:
> On Mon, 2015-12-14 at 13:08 -0500, Thomas Nyberg wrote:
>> Hi Stefan thanks for much for the response! So I compiled release
>> version 2.6.4 as well as the current master branch on the git git
>> repository (2.7.0.rc0.20.g4b9ab0e) and the problem persists on both.
>>
>> To answer your questions, there are no weird characters. The name of the
>> bad_branch is "frus". There is another branch called
>> "frus_body_cleaning" that is totally fine.
>
> What's in .git/config under [branch "frus"] (if anything)?
>
> What does "grep refs/heads/frus .git/packed-refs" say?  What about
> find .git -name frus ?
>
> Sorry for the possibly-stupid questions, but I'm really baffled by this
> one.
>
