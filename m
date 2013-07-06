From: Kyle McKay <mackyle@gmail.com>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and skelta mode
Date: Fri, 5 Jul 2013 18:01:27 -0700
Message-ID: <5675CCAE-F4E8-48B7-8B63-BE91AAE09DD5@gmail.com>
References: <kr7beq$ilk$1@ger.gmane.org> <E82AC74E-3294-415D-8E59-97DDD213B11A@gmail.com> <51D75196.4030100@acm.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Rothenberger <daveroth@acm.org>
X-From: git-owner@vger.kernel.org Sat Jul 06 03:01:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvGsl-0001uI-Fh
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 03:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab3GFBBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 21:01:31 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:60089 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab3GFBBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 21:01:30 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so4141432oag.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=Plvmc7PCKpGYEee656JwTmvz3xS8RNFOIXaup4gfgm0=;
        b=WExjUmgEtQsskApDPpZVGT5xs65lrhjx7clN6RFQXDyiK/siqI2giF5gPm/83962Fk
         fpvMsvhKBKCvdPlklglnfqnQXkdkgzL+K4GgGtLkP6FGqjcld7Ri+tUo+HADc8E1W0kM
         cwU7yJwnll5T1EqHzfJ0n51yuPLdqx53i6pizTel2rf2mwfv9qzW8PrybpGzYETFSWWY
         vRPqTtOi7SjSEs69RhcDDS/GgmOu5YvSn6XUJtCCN9e9ptJZGRS2zApVTMDb9GFftcBY
         9bsEYXXeogowNfMpNeKZM3JleKN4I55/9tQFc+v3nxBugaX3RoBZOAImBTurQjEboB/j
         PVog==
X-Received: by 10.60.124.69 with SMTP id mg5mr13335080oeb.104.1373072489637;
        Fri, 05 Jul 2013 18:01:29 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id r4sm19196203oem.3.2013.07.05.18.01.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 18:01:29 -0700 (PDT)
In-Reply-To: <51D75196.4030100@acm.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229686>

On Jul 5, 2013, at 16:07, David Rothenberger wrote:
> On 7/5/2013 3:58 PM, Kyle McKay wrote:
>> On Jul 5, 2013, at 13:48, David Rothenberger wrote:
>>> I recently upgraded my Subversion server to 1.8.0 and started
>>> receiving the following error from "git svn fetch":
>>>
>>> Temp file with moniker 'svn_delta' already in use at
>>> /usr/lib/perl5/vendor_perl/5.10/Git.pm line 1024.
>>>
>>> This occurs only when using an http:// URL; svn:// URLs work fine.
>> [snip]
>>> The client is Cygwin: svn version 1.8.0 and git version
>>> 1.8.3.2.
>>
>> The subversion 1.8 release has removed the neon library, all svn  
>> client
>> http access now always goes through the serf library.  If you put
>> "http-library = serf" in the "[global]" section of the
>> "~/.subversion/servers" file you will get the 'svn_delta' error with
>> git-svn when running earlier versions of the svn client as well.
>
> That was not my experience. I did try this with the 1.7 perl bindings
> and libraries and with "http-library = serf" in by servers and it  
> worked
> fine. I confirmed that serf was being used with a Wireshark trace.

I had it always fail right away from my home ISP (kinda slow  
connection), but when running on a host with quite a different  
internet connection it would sometimes run for a while before  
generating the error (maybe a couple hundred revisions fetched) for  
some sources, but it would *always* eventually fail.

For this reason I also believe the problem is timing sensitive.

Try doing "git svn clone --quiet http://dev.heuristiclab.com/svn/hl/ 
core" with "~/.subversion/servers" section "[global]" including  
"http_library = serf".  I find this one always seems to fail right  
away for me with git-svn over serf but will clone fine over neon (if  
you can stand to wait long enough).

I have been looking into using serf for git-svn clones ever since I  
discovered how very much faster snvrdump works on an http url over  
serf as compared to neon.

Kyle
