From: Andrew Wong <andrew.kw.w.lists@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Wed, 03 Oct 2012 17:52:53 -0400
Message-ID: <506CB3B5.808@gmail.com>
References: <CAGAhT3kofdaQEye9QHnvFhAAzoQqZtR7d5UzbxU+zEdkAHVfuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtKR-0001DP-9q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab2JCVwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 17:52:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59246 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562Ab2JCVwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 17:52:54 -0400
Received: by ieak13 with SMTP id k13so18399634iea.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YSvu/vlvzIuIMwHeMULYwxXhqIPesbaW3zgDtT+LLyY=;
        b=hPRXJfL2xdR4+8sbDaTzb35ctIOWJ1hPbbfZTZl8v599u8DKEP6rGiusEkZo2wRkIX
         tS/W1BhhFpjyM16wwVy61qLwGLK50sNU5MSFxLq30extJF+/pyq59RliCAwcjF+Xg/lX
         aUFx9C+CpW6WB2YjCk+qwaUbUltUJdo/DrLvdCdNoKOEYHWUnCWFfzW0IEOKMV8XfuhL
         KVgxH6Z4G3z11bSDcthNJfY7fQGWcZsYWt8NR55+bcKq8kuU4qpuZGf2jIZ9jvsNGhbB
         nZkYiyGizC0TVHfFWMFIRq2x1tknxcAeMUBL6iE5Dz2odueUppnxm0AfYUEf97hrquDO
         hrHQ==
Received: by 10.50.202.71 with SMTP id kg7mr3319407igc.55.1349301174328;
        Wed, 03 Oct 2012 14:52:54 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id 10sm11798883ign.5.2012.10.03.14.52.53
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 14:52:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAGAhT3kofdaQEye9QHnvFhAAzoQqZtR7d5UzbxU+zEdkAHVfuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206932>

On 10/03/2012 03:47 PM, Alexander Kostikov wrote:
> Expected behaviour:
> - restore branch to pre-rebase location on out of memory exception
> - not to fall with out of memory in the first place. But for our
> repository that could be fixed only after either:
> --- a) msysgit would have x64 binary (currently it's not available)
> --- b) rebase -m option could be used by default somehow (currently
> it's not possible so specify default -m)
There are already some logic in "rebase" that will handles failures. And 
in the case of failures, the behavior is that "rebase" will just stop 
and not modify the branch. That allows you can go back to the pre-rebase 
state by "rebase --abort".

In your case, it's possible that "rebase" is failing at unexpected 
places, and the error wasn't caught. I tried a few simple cases by 
forcing some commands to fail during a rebase, but I couldn't reproduce 
the behavior that you're having. It might help if we can figure out 
which part of "rebase" or "git" is failing (or running out of memory).

And since you're using msysgit, I guess another possible source of the 
problem is be that msysgit is not catching the error properly, or not 
relying the error back to git properly.
