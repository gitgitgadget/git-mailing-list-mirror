From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame (take
 2)
Date: Tue, 03 Jun 2008 16:23:36 +0200
Message-ID: <484553E8.4050007@gmail.com>
References: <1212497890-4101-1-git-send-email-rgarciasuarez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 16:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3XR5-0001b2-8k
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbYFCOXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbYFCOXg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:23:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:3589 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYFCOXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 10:23:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1043606fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=1rKrjPm5mR2Lx7PJntsq4NUjn5GQMOJHrS/v9XIsol4=;
        b=sk7kWSHcbQyQmrNFjtHMN/HfxekSHV1GSgb2N/AoyATz/xob/fOA5nJp6J75Vmzh1dSZLrGMiM37Ng5u8uHxP67ZKdJmETJxIN8PfMitebipq9UHBztiX5+ybb/B/XXIKlfzHWfA2kSqPJy0nfP81KOUjIGIDHy4k7kdn+HdfEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=n9w+GoAWeA0sUNsRinj+kXiCMKzX7aQzREu6oiEQYFYQ2rTpnvbuaUHDb9nHNTrORCgJH38NWnUFBVqyvDRYU69AoqKDpx+BW0cWpIdwR+GriZCtSeIfLXsT5r95NS1pa6wqHRHLb5ZZXxqHYoGeRpx9PIOXeKmrqc3duwEXgyw=
Received: by 10.86.49.13 with SMTP id w13mr7474353fgw.65.1212503003333;
        Tue, 03 Jun 2008 07:23:23 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id l12sm52585fgb.6.2008.06.03.07.23.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 07:23:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212497890-4101-1-git-send-email-rgarciasuarez@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83663>

Rafael Garcia-Suarez wrote:
> Finally, to avoid forking git-rev-parse too many times, cache its
> results in a new hash %parent_commits.

I'm not too happy with this:

1) Minor point: I'm working on caching for the backend right now (IOW, 
basically what you're doing, just centralized in a separate module), so 
you're essentially duplicating work, and you're making it (a little) 
harder for me to refactor gitweb since I have to rip out your cache 
code.  Those few lines won't hurt, but in general I suggest that nobody 
make any larger efforts to cache stuff in gitweb for the next few weeks.

2) Major point: You're still forking a lot.  The Right Thing is to 
condense everything into a single call -- I believe "git-rev-list 
--parents --no-walk hash hash hash..." is correct and easily parsable. 
Its output seems to be lines of
     hash parent_1 parent_2 ... parent_n
with n >= 0.  Can you implement that?  It would be very useful and also 
reusable for me!

-- Lea

P.S.: I believe that the usual way to post follow-up patches is to label 
them [PATCH vN] for N >= 2 in the subject (since "take 2" shouldn't be 
part of the commit message), and to send them as In-reply-to a message 
in the original thread -- just provide git-send-email with the 
Message-ID of the message you want to reply to.  </nitpick>
