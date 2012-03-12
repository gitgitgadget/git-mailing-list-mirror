From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 22:21:09 +0100
Message-ID: <4F5E68C5.5070300@lyx.org>
References: <4F5E4B20.5080709@lyx.org> <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F5E5A77.1070605@lyx.org> <7vd38hr22e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:21:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7CgF-0005nF-VB
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab2CLVVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 17:21:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39893 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab2CLVVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:21:11 -0400
Received: by eaaq12 with SMTP id q12so1480579eaa.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 14:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Izw0w80ALDMJvBwT6SGTRBQUIth3D92ZRshq3TaHv48=;
        b=QsNaij2BynbWWVYDhqREb7Q3Inc6FSEbdq+gDVY3Y4iJm9tnlxzQoMIb/hcbdsThpN
         qNIVcLm/CZTUnxumsvuX3B6ccZWRe34PuvJzYxR+9pRGXUS0+zvesN2PgBXpMuv5gamW
         C13cSI4HdCDROWyzAmTB+cSze52MxDD1yGtmfFuZ11PFD7dndtbUjv91w9mKHq36jojS
         LYR1Orp5pcf6ebiKJ6ZbgEIsjz4VG2gFYWoCGjuwqDo5/GD3CqZB0n9JjD5XPpW1m2Sf
         LxQYPUjfZKXRi3YYidondM4m0DYAduV0mjtG6KVXnntbT2UvQkedBeQMI+asAJId9eTb
         +aSw==
Received: by 10.14.47.5 with SMTP id s5mr1988456eeb.97.1331587269644;
        Mon, 12 Mar 2012 14:21:09 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id r44sm16701316eef.2.2012.03.12.14.21.08
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 14:21:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vd38hr22e.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmHJV/Q3ro7rYMnxpzKlyAY662bFuTT3hYGK5Y13tynyd9MfbkQFS9oiIpEtmFSZlV3kc1T
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192948>

Op 12-3-2012 21:34, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>> Op 12-3-2012 21:01, Junio C Hamano schreef:
>> ...
>>> I haven't find it necessary in practice, as the re-fix for me
>>> typically would go like this:
>>>
>>>       $ git merge other-branch
>>>       ... rerere kicks in; eyeball the results
>>>       ... ah, my earlier resolution is no longer correct
>>>       $ edit $the_path
>>>       ... test the result of manual edit in the context of the merged whole
>>>       ... and be satisified
>>>       $ git rerere forget $the_path
>>>       $ git add $the_path
>>>       $ git commit
>>>       ... rerere records the updated resolution
>>>
>>> What scenario do you have in mind that you would need to re-fix more
>>> resolution than you need?

Here I was mistaken. I assumed that you could run 'git rerere forget' 
always and thus removing all conflict resolutions for a certain path. 
Now I see that the documentation clearly says "current conflict in 
<pathspec>"

> The problem I have with "rerere edit" is it is an offline process,
> and to validate that the update is correct, I would have to have the
> problematic merge in my working tree once _anyway_.  And at that
> point, updating the target file in the working tree and recording
> the updated resolution using the usual "git rerere" feels a more
> natural way to do so, and more importantly, it is a more convenient
> way to do the "update and validate".  On the other hand, "rerere
> edit" is a more convenient way to "update but not validate the
> result".

This last part probably makes the difference indeed. In my case the 
merge resolution was very very easy (the conflicting hunks have 
fileformat version numbers), but it is a bit annoying and it requires 
some 'vim'-skills to redo the merge conflict just to correct a newline 
somewhere, or a missing ','.

As I wrote, the merge resolutions in my case were very easy (logically), 
but just annoying (motorically).
These could even be resolved by some merge-conflict hook.

Examples:
- for this file we know the conflict always has to be resolved by adding 
the oldest hunk before the newest hunk. For example, new file formats 
will be added sequentially to a file.
- for this file we can resolve it anyway we want. For example, a release 
notes file which just enumerates all changes in random order.

Anyway, has anyone thought about such a hook ?

Vincent
