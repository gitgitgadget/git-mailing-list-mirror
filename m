From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 5/6] test-lib: allow prefixing a custom string before "ok
 N" etc.
Date: Fri, 17 May 2013 09:00:13 -0400
Message-ID: <CABURp0rjaQq28gAB_WkopE6J+3xDm9GJwZS6zNJ=ia_PFDyjmA@mail.gmail.com>
References: <cover.1368736093.git.trast@inf.ethz.ch> <f440021d75345b1242e54f47697c3d2ac9593e99.1368736093.git.trast@inf.ethz.ch>
 <CABURp0pZQFB37oBDab1h3r8w7nj6jb+HXwPrbn=9pQhfLkTMMQ@mail.gmail.com> <87fvxmc9y0.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 17 15:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdKH7-0002Vv-Fw
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 15:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab3EQNAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 09:00:34 -0400
Received: from mail-vb0-f50.google.com ([209.85.212.50]:41332 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab3EQNAe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 09:00:34 -0400
Received: by mail-vb0-f50.google.com with SMTP id w15so1089101vbb.37
        for <git@vger.kernel.org>; Fri, 17 May 2013 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nEPTJqm16clZy+7z7yGmljTDHqfXNjIbehumobLw36g=;
        b=0vrYjlJbmHRmV0HHYT9zvqTYJDnuzZFYAELYB9mttxxqOaKCUu2PAqlCzQ3i9LlTZs
         oOzMUIFS6R3nu4jzk6tEaSFTAlCSL2+NW30SH6QOLy67yBXZn2XIexVutOJWr36b2iVV
         gAMJOVleyCL9QxQKMb1JXg1cQjXmrg7iEKYFmJcMZf9y3tgtqGMzCUUbKBDpClhg2E0o
         tVbB8fAXbXjHBsTHiCcJSlw3Vh8xjTyj1/Tx5aqgcgpdtIIt64F+tQEgYZ/mhhEFYXOh
         3xhW3zGKg3KJBOfsVzSH5gZivElG+FzHN1tBni8D86x93QHWTeYTnNxu0Lbo7rJ2+vmV
         789Q==
X-Received: by 10.58.196.129 with SMTP id im1mr29742167vec.46.1368795633400;
 Fri, 17 May 2013 06:00:33 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Fri, 17 May 2013 06:00:13 -0700 (PDT)
In-Reply-To: <87fvxmc9y0.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224688>

On Fri, May 17, 2013 at 4:00 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> On Thu, May 16, 2013 at 4:50 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> This is not really meant for external use, but allows the next commit
>>> to neatly distinguish between sub-tests and the main run.
>>
>> Maybe we do not care about standards for this library or for your
>> use-case, but placing this prefix before the "{ok,not ok}" breaks the
>> TAProtocol.
>> http://podwiki.hexten.net/TAP/TAP.html?page=TAP
>>
>> Maybe you can put the prefix _after_ the "{ok, not ok}" and test number.
>
> Actually that was half on purpose.  You will notice I did not document
> that option, as it is intended only to be used to distinguish between
> the parallel runs implemented in [6/6].
>
> Those parallel runs look something like
>
> [4] ok 1 - plain
> [4] ok 2 - plain nested in bare
> [...snip until othes catch up...]
> [4] ok 33 - re-init to update git link
> [4] ok 34 - re-init to move gitdir
> [3] ok 1 - plain
> [2] ok 1 - plain
> [4] ok 35 - re-init to move gitdir symlink
> [4] # still have 2 known breakage(s)
> [4] # passed all remaining 33 test(s)
> [4] 1..35
> [3] ok 2 - plain nested in bare
>
> It's invalid TAP no matter what: there are N plans and the ok/not ok
> lines from N runs all intermingled.  So I'd rather not even pretend that
> it is valid in any way.

Yes, I guessed this might have been the goal.  Maybe you can mention
it in the commit message.

I hope some future change might even unwind these back into a valid
continuous TAP stream.  But at least for now, if someone needs such a
stream, she can unwind it herself.

Phil
