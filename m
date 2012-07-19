From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 12:48:04 -0400
Message-ID: <CAPBPrntB3ixuRFDP5fp8saJoEZvYOEd631Nh2=-WGudB-UK=kw@mail.gmail.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
	<20120719115558.GC29774@sigill.intra.peff.net>
	<CA80E335-AD87-4DFC-9569-A010D3E850C0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Stefan Haller <lists@haller-berlin.de>,
	git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 18:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srttc-0003fU-Rn
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 18:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab2GSQsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 12:48:07 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61297 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab2GSQsF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 12:48:05 -0400
Received: by weyx8 with SMTP id x8so1908271wey.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qNUG0SZeXobV/O9V2mMw+RHlMbdmrYvEc9gXOLNDgf8=;
        b=FVpEpjatrgbFSetdED6Zrcwu68iXmykKit4zRIDPFAHHN2F++ar9OinPk+Ftd9hLgS
         0r7hFbyZ/UavvvoifbJDZZmCkTX4UGyCEqw8vfGtSNMbmphx4qMqtBDuBPeYUtl6Qy17
         2OC8ojYh3vTG3jd8Z7by+atKoYvy2mWJBuHppiY+WM/qGZX7UT/EynsQzZa8Izzb8qLw
         Qj9iXtqjV1ngzGkNMfAW3ASaa2OdK4TEXD1JGqt2qfuA1tlUb8Mhdan2YqSvfNYqeEnD
         V/ZANBL2i1bliVjQS2RbCccLevwXcFXAIAUg/AheskQP0V1kZhr6Y5ZbO6O2iR7f55P5
         b77w==
Received: by 10.180.82.164 with SMTP id j4mr6347274wiy.18.1342716484114; Thu,
 19 Jul 2012 09:48:04 -0700 (PDT)
Received: by 10.14.201.4 with HTTP; Thu, 19 Jul 2012 09:48:04 -0700 (PDT)
In-Reply-To: <CA80E335-AD87-4DFC-9569-A010D3E850C0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201740>

On Thu, Jul 19, 2012 at 12:40 PM, Alexey Muranov
<alexey.muranov@gmail.com> wrote:
> On 19 Jul 2012, at 13:55, Jeff King wrote:
>
>> I agree it would be much less confusing. However, one downside is that
>> we do not keep reflogs on deleted branches (and nor did the commits in
>> remote branches necessarily make it into the HEAD reflog). That makes
>> "git fetch" a potentially destructive operation (you irrevocably lose
>> the notion of which remote branches pointed where before the fetch, and
>> you open up new commits to immediate pruning by "gc --auto".
>
> If i understand correctly, existence of a reflog entry will not stop "gc" from removing a commit, will it?
> In this case, if a remote branch was rebased or reset, commits can be lost anyway, right?
From the git-gc man page:
git gc tries very hard to be safe about the garbage it collects. In
particular, it will keep not only objects referenced by your current
set of branches and tags, but also objects referenced by the index,
remote-tracking branches, refs saved by git filter-branch in
refs/original/, or reflogs (which may reference commits in branches
that were later amended or rewound).

So yes, a reflog entry does stop gc from removing objects, including
commits. It will expire old reflog entries (90 days by default)
though, so it's not like they will stay around forever.
-- 
-Dan
