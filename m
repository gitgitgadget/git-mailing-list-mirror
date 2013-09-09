From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] version-gen: avoid messing the version
Date: Mon, 9 Sep 2013 02:00:55 -0500
Message-ID: <CAMP44s1B4F8k_TEgXT8reatCw9UKATDAH=D31v=79QA6voEKOw@mail.gmail.com>
References: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
	<1378702889-21638-3-git-send-email-felipe.contreras@gmail.com>
	<7vtxhuilv1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 09:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIvT3-0007SF-LG
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 09:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab3IIHA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 03:00:58 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:44656 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab3IIHA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 03:00:57 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so4426699lab.8
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 00:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FeljEOJzJxHzQhC8DR+TdMgLZcjLkFSDenY86zKBEwY=;
        b=ef9KygmTfo0HJutWsJiVJvHDQufHcytQbbGEN+zCOvo32jOSbtla0epaBdsbpHhXaJ
         hWd1O7ieFR9cG7FlVaAFVs48uRwjPSIO9049Z4QLBf0170eZyr1/S/K0IWiR7L7kIhpE
         EPENMSUkf2uALEjerViwxB8aIHu2fHAmUC4rIyCp163sDtgTvlNXzvYOrk2N1jcxpCzI
         E+2xapFgYIGvVSzxwtSSYVbeoUxSNLS/0dwoYL1unXo4HZs8Lanzaqy1H2L4zdYVZTuy
         Fu7gHVW1RQxXAns5cTvoo9Bl3Yp5qnP13bYFnhg7NKfAXvgZsT06eY5+/LNbNctsWpZl
         j2tw==
X-Received: by 10.152.115.176 with SMTP id jp16mr15126084lab.17.1378710055665;
 Mon, 09 Sep 2013 00:00:55 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 9 Sep 2013 00:00:55 -0700 (PDT)
In-Reply-To: <7vtxhuilv1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234315>

On Mon, Sep 9, 2013 at 12:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> If the version is 'v1.8.4-rc1' that is the version, and there's no need
>> to change it to anything else, like 'v1.8.4.rc1'.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  GIT-VERSION-GEN | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
>> index b0db139..2b9fd2f 100755
>> --- a/GIT-VERSION-GEN
>> +++ b/GIT-VERSION-GEN
>> @@ -24,7 +24,6 @@ then
>>               VN="$VN-dirty"
>>               ;;
>>       esac
>> -     VN=$(echo "$VN" | sed -e 's/-/./g')
>>  else
>>       VN="$DEF_VER"
>>  fi
>
> The log message of 5c7d3c95 (Allow building of RPM from interim
> snapshot., 2006-01-16) leaves a lot to be desired, but I do remember
> that this was added due to user request.  Before that commit, we did
> not strip dashes, and RPM packaging did not like dash in the version
> name, hence folks on RH and derived distributions could not package
> the software out of the box themselves.

Of course they could, by doing the replace themselves, or by simply
using a 'version' file. Didn't you just recently suggested somebody to
do exactly that?

> I do not offhand know if that RPM limitation was lifted.  I do not
> know if there are other packagers with a similar limitation that
> have been relying on this version mangling, either.  This change may
> end up being a regression for these users.

Of course not. First of all, who exactly is packaging release
candidates nowadays? And second, why they can't they use the existing
tools, like the 'version' file?

The information behind the commit 5c7d3c95 is basically non-existant,
as I cannot even find a patch for that change in the mailing list. I
guess you decided the commit was so trivial it didn't merit a patch
for review and discussion. Anyway, it happened before the 'version'
file option was present, so it's quite likely they (whatever "they"
might be) would not have any issue.

> The mangling is done only for auto-generated names, so I suspect
> that anybody who wanted the dash in their version names for whatever
> reason has already been using the "version file" escape hatch (or
> nobody had a desparate need to use dash instead of dot).

So, let me get this straight; the nominal version of Git has a dash
(v1.8.3-rc1), but the internal version of doesn't (1.8.3.rc1), there
is no real reason for that, except that you say "some people" need it
that way, but then you say the people that need it in the nominal way
should use the 'version' file. Why couldn't the people that want the
non-nominal form use the 'version' file instead?

It doesn't follow.

-- 
Felipe Contreras
