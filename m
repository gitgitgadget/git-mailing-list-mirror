From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] ls-files: do not trust stat info if lstat() fails
Date: Sat, 5 Apr 2014 15:03:31 +0700
Message-ID: <CACsJy8CTv5jZKjqq6fAJeVj-sqJHAF761V6TofVWs-V5GPnbcA@mail.gmail.com>
References: <CAPig+cRurqCHyFtpCFOisc=1u06JSpmE9rHQa0ioLxrQMuJ4Dw@mail.gmail.com>
 <1396012689-22480-1-git-send-email-pclouds@gmail.com> <xmqq38hvvbr7.fsf@gitster.dls.corp.google.com>
 <CACsJy8DBixHTeqitcAcQRAqY3b4prkwQGgJGuw7hbT7BQAZt9w@mail.gmail.com> <xmqqvbuqqstn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 10:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWLaS-0000BG-Re
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 10:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbaDEIEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 04:04:07 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50404 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbaDEIEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2014 04:04:02 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so288973qae.33
        for <git@vger.kernel.org>; Sat, 05 Apr 2014 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fP6/vxQj7kx6yPnT70ZQaohTVpx2UKWkkAQFHxPOuhY=;
        b=HVJvZPBqyozGtCUK5ROumljjoGgsIxTqnvhIcyofbKoWu4FxWdijLpV+zMZ2+6Vwwf
         uH3/F/ZjYxL+SlJMahhKL3eRUvaGzoM9U7z7epKtzKXaP86BemH/zTDJ+NM/e7WUuhvx
         uphH3ORR5m+BLfoM1iSJbZ7GtnHs10L3gXjI2zwgqs28RUeR2g2tqpGlHLoF3LCPy3qB
         JMaSED9yDNqsQG2IDdTLt4fPQVoB1iD46v9w9orJdQRv/PFxtlpJ8jA9gJV2J2TcNIv+
         S8GuifSele3LYk4+4Ok8/k23LSShIG6bBcTHqKKeBii30LNnoMRbL71o9uJhMe09YKwE
         NLXA==
X-Received: by 10.224.147.77 with SMTP id k13mr1380371qav.64.1396685041782;
 Sat, 05 Apr 2014 01:04:01 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Sat, 5 Apr 2014 01:03:31 -0700 (PDT)
In-Reply-To: <xmqqvbuqqstn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245778>

On Thu, Apr 3, 2014 at 11:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Apr 3, 2014 at 1:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I am guessing that, even though this was discovered during the
>>> development of list-files, is a fix applicable outside the context
>>> of that series.
>>>
>>> I do think the patched result is an improvement than the status quo,
>>> but at the same time, I find it insufficient in the context of the
>>> whole codepath.  What if errno were other than ENOENT and we were
>>> told to show_deleted (with or without show_modified)?  We would end
>>> up saying the path was deleted and modified at the same time, when
>>> we do not know either is or is not true at all, because of the
>>> failure to lstat() the path.
>>>
>>> Wouldn't it be saner to add tag_unknown and do something like this
>>> instead, I wonder?
>>
>> Or even better to show an error message when the error code is
>> unexpected? The unkown tag '!' says "there are problems" but if it
>> shows up sort of permanently, '!' won't help much, I think.
>
> I am OK with that approach, but then one question remains: should we
> say it is deleted, modified, both, or neither?

The question is moot if the user does not ignore stderr because they
should just ignore those error-reported entries. If they do
2>/dev/null, I think we should err on the safe side and say modified.
We only say deleted if lstat() returns ENOENT or ENOTDIR like in your
patch.
-- 
Duy
