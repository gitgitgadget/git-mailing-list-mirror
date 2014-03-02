From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Sat, 1 Mar 2014 18:02:54 -0800
Message-ID: <F9B4418D-9414-4857-9199-EDBA20B952C6@gmail.com>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com> <20140301061532.GC20397@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
To: Conley Owens <cco3@android.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 03:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJvkb-0002Zc-4U
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbaCBCC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 21:02:58 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:39116 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbaCBCC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:02:57 -0500
Received: by mail-pb0-f42.google.com with SMTP id rr13so2360078pbb.15
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=4EojqQZtJ7yH4NulaSMI2/ECLOqeuFwBVLqwLoZpkMQ=;
        b=D/8EEVyKAFPne+cRQZjwpNmZd0zKQaqim+3srhGfhPDqxwkPhjzO7lP0D5G+N5kitB
         EtYTX5/POc3A5V77rGY/QO1w18QdEXt/h8QoYkkBf8wO7qGc/5DbMNWpN0lL9pb3C9ER
         yKaso4LNGWxqZfk3JslPpFBcCagJFzSVkGmu+unY2AfecjizIl1JogE+Tq1VSKr4tdgR
         d1UY/qyMk/1T9SnudjmLX96CkebFqG3/KOA7ue7DbZA0ivXV03lzT65OTlp4r24kBMjJ
         UjNqnDw+5MH6PFLyIqC1PaQewF9lPhXcwqe/8KHv1TVSW4QoVuaJWYxxqHgYqsVoVDZy
         br8w==
X-Received: by 10.67.2.106 with SMTP id bn10mr11888053pad.38.1393725777407;
        Sat, 01 Mar 2014 18:02:57 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ns7sm20749683pbc.32.2014.03.01.18.02.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 18:02:56 -0800 (PST)
In-Reply-To: <20140301061532.GC20397@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243116>

On Feb 28, 2014, at 22:15, Jeff King wrote:
> On Fri, Feb 28, 2014 at 03:26:28PM -0800, Conley Owens wrote:
>
>> test.sh
>> """""""""""""""""""""""""""""""""""""
>> #!/bin/bash
>> rungit() {
>>    mkdir $1
>>    GIT_DIR=$1 git init --bare
>>    echo '[remote "aosp"]' > $1/config
>>    echo '    url =
>> https://android.googlesource.com/platform/external/tinyxml2' >>
>> $1/config
>>    GIT_DIR=$1 git fetch aosp +refs/heads/master:refs/remotes/aosp/ 
>> master
>
> I don't think this is affecting your test, but you probably want  
> ">>" to
> append to the config for the first line, too. Otherwise you are
> overwriting some of git's default settings.

I replaced it with a call to git config in my version.

>> When everything cools, you can see that there are some fetches  
>> hanging
>> (typically).
>> $ ps | grep 'git fetch'
>> ...
>> 63310 ttys004    0:00.01 git fetch aosp
>> +refs/heads/master:refs/remotes/aosp/master
>> [...]
>
> I can't reproduce here on Linux. Can you find out what the processes  
> are
> doing with something like strace?

I can't reproduce, mostly, on Mac OS X 10.5.8 or 10.6.8.

What I mean by mostly is that the very first time I ran the test  
script I got approximately 36 of these errors:

fatal: unable to access 'https://android.googlesource.com/platform/external/tinyxml2/' 
: Unknown SSL protocol error in connection to android.googlesource.com: 
443

The rest of the fetches completed.  That was with Git 1.8.5.1.

However, I was never able to reproduce those errors again.  All the  
subsequent runs completed all fetches successfully using that same Git  
version so I also tried Git 1.8.5.2, 1.8.5.5 and Git 1.7.6.1 on the  
original and another machine.

I am, however NAT'd, so it's possible the NAT was somehow responsible  
for the initial 36 failures.

Perhaps you are seeing a similar issue.

You might try setting these sysctl variables:

# Timeout new TCP connections after 30 seconds instead of 75
net.inet.tcp.keepinit=30000
# Always keep alive TCP connections
net.inet.tcp.always_keepalive=1
# Start keep alive checks after 30 seconds instead of 2 hours
net.inet.tcp.keepidle=30000
# Wait 5 seconds between probes instead of 75
# Note that 8 probes in a row must fail to drop the connection
net.inet.tcp.keepintvl=5000

then running your test again and see if the hanging git fetch  
processes die with some kind of failed connection error within about  
70 seconds or so.  With the default sysctl settings, even with Git  
enabling keep alives, it would likely take a bit over two hours for a  
dead connection to be noticed.

--Kyle
