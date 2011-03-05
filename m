From: Adam Monsen <haircut@gmail.com>
Subject: frustrated forensics: hard to find diff that undid a fix
Date: Fri, 04 Mar 2011 22:20:46 -0800
Message-ID: <4D71D63E.3030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 07:21:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvkrs-00056c-8e
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 07:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab1CEGVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 01:21:17 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52460 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab1CEGVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 01:21:16 -0500
Received: by iwn34 with SMTP id 34so2510007iwn.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 22:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=6kqcFevjl/Xf2U17Np4/Qt9TqRiJyn20fzlUmzlzgqQ=;
        b=FzlEVXbvxkrYD8WTd/YV4oFhbI5TrROA8G5R4tPvbqhLWcxqP0xTac5S43gv/8ZiRs
         q0sg4QueQW1+qJ2jKjuuW4DsHLcYr8f6oKnh2jgVC+R+B8U15sUyt+RreQhioudgssEB
         LAqbKCjC02336zmeX69i+LkaCUJDcn94XiV+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=Ap9bRJdbXjInxzh61C5bN0rNRiMRGxeo+xj/H+0RIN4Z8Ia1dir1zKQCFghcB4Z8yC
         Xw99wbRslw7l6Mxdy0g6kGNVxhIdlLE/Gdvh21QQrRMPySc65/p61SQe8velNT2OXwE4
         lt97o+lYRbjonIAKvjYrKJClBZXQRkPtwBV+g=
Received: by 10.42.147.8 with SMTP id l8mr1518777icv.517.1299306076107;
        Fri, 04 Mar 2011 22:21:16 -0800 (PST)
Received: from [192.168.13.8] (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id xa8sm200709icb.10.2011.03.04.22.21.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 22:21:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.14) Gecko/20110221 Lightning/1.0b2 Thunderbird/3.1.8
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168481>

I made a fix a month ago on the master branch in a shared repo. A week
later, a colleague did a merge that undid the fix. I didn't figure out
the problem until just now because I'd been assuming the fix was still
on master. I mean, if it wasn't, I should see a reverse patch using "git
log -p master", right? Wrong. Turns out the fix was undone as part of
merge conflict resolution (I think).

Is there some way to include merge conflict resolutions in "git log -p"
or "git show"? Apparently some important information can be hidden in
the conflict resolution. Or, more likely, I just don't understand how
this bit of git works.

I also tried bisect and pickaxe. Bisect wrongly identified the first bad
commit, and pickaxe just didn't see the change at all.

    ~ * ~

Here's some details in case anyone wants to (a) point out where I messed
up or (b) help me avoid this kind of blunder in the future.

1. The repo is git://mifos.git.sourceforge.net/gitroot/mifos/head
(mirror: https://github.com/mifos/head ). Branch master.

2. My commit 2a1ed0436 introduced a fix that includes the text
"native2ascii". Shows up in "git log -p -1 2a1ed0436" and "git show
2a1ed0436". Life is good.

3. It appears that the merge commit 0f8132386 tossed my "native2ascii"
fix. The only way I could figure out to actually visualize this is "git
diff 58320586..0f813238".

This took a while to figure out. Am I missing something obvious?
