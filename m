From: David Aguilar <davvid@gmail.com>
Subject: Re: is git-p4 compatible with p4/linux?
Date: Sat, 20 Apr 2013 03:50:53 -0700
Message-ID: <CAJDDKr4gLWev=N-yMw3j0norzVxBp99ie_EYAbNcUvWcL-_70w@mail.gmail.com>
References: <7BF81DF9-941D-400B-8304-6DA5F5C82D4F@aivor.com>
	<20130419000947.GB9048@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Tomlinson <alex@aivor.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 12:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTVNu-0000OF-Rv
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 12:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977Ab3DTKuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 06:50:55 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:35447 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab3DTKuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 06:50:54 -0400
Received: by mail-we0-f172.google.com with SMTP id r3so4353741wey.31
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8kGIae4Rfm+aPnKJOdsfdCYo2Qo/5AeDXjrLCNRZ3+Q=;
        b=hEbyIcgZVdb9b2gqQ6FJIOQ6ddPRTVbTr3eaYRPRUyf2U5zyU6BX1W+xu6kGlQFZHz
         h+zbw2NCFW3DWx5NUDhi0r+1t7ycz1ULDYkSmFXvB+yOHcJ0nxpzeSTN2IvJrhrVulWe
         h93BAGn1LtlJpejT0ofrtd8l9w25tviJnT1hFARWPRw6HLFdHj5azprMwpPbTeiXDA9T
         CF4A68s7tG3ADmqRn3Wm8PAy6fPzYg5RgbCcpG8ivqYJWCY10az9FdQq8ymYV3z9UnAK
         ArD/FxZY6xlldICNv107MuHvh9vpP6kCKHmUWTAq9D50u0rvN4xoK1Hz1KaQLDZoFYv5
         XVKw==
X-Received: by 10.194.89.234 with SMTP id br10mr33825905wjb.43.1366455053565;
 Sat, 20 Apr 2013 03:50:53 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Sat, 20 Apr 2013 03:50:53 -0700 (PDT)
In-Reply-To: <20130419000947.GB9048@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221844>

On Thu, Apr 18, 2013 at 5:09 PM, Pete Wyckoff <pw@padd.com> wrote:
>> First issue
>> -----------
>>
>> git-p4 assumes the output of 'p4 print' adds a newline to the
>> target.  To work around this, git-p4.py strips the last char from
>> symlinks as shown in the following snippet:
>>
>>     if type_base == "symlink":
>>         git_mode = "120000"
>>         # p4 print on a symlink contains "target\n"; remove the newline
>>         data = ''.join(contents)
>>         contents = [data[:-1]]

This line could be made more robust by changing it to:

    contents = [data.rstrip('\n')]

That way it only strips off newlines if they exist, which essentially
papers over these rogue depot files.
Alternatively, it could use rstrip() with no arguments to cast a wider
net and catch all whitespace.
-- 
David
