From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/clean.c: Handle disappearing files
Date: Sat, 16 May 2015 12:21:04 -0700
Message-ID: <xmqqwq08e3bz.fsf@gitster.dls.corp.google.com>
References: <1431638200-20449-1-git-send-email-dturner@twitter.com>
	<xmqqk2waj0js.fsf@gitster.dls.corp.google.com>
	<1431640373.17436.16.camel@ubuntu>
	<xmqqbnhmiz78.fsf@gitster.dls.corp.google.com>
	<1431642839.17436.22.camel@ubuntu>
	<xmqqy4kqh0n8.fsf@gitster.dls.corp.google.com>
	<1431713612.17436.27.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat May 16 21:21:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ythe6-0005e8-7z
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 21:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbbEPTVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 15:21:08 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37109 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbbEPTVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 15:21:07 -0400
Received: by igbsb11 with SMTP id sb11so21793512igb.0
        for <git@vger.kernel.org>; Sat, 16 May 2015 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/4ZKyDS+bu1VW2FLKC4MYwWWQnjVfxskkwJl3OzC92I=;
        b=acWAf5KDnYi5Asl0Mm5dgFaEy5fMXgnxZzwTx/iFnybDTC7LaCBdtdDj9fqs5B2Tws
         34XYcuJ3/5yEbPQXYrHKpuCWUhdA2myWA/ccr5P6HpVx9LiFuINJZkxhdegIAocHiEXd
         buydQN0GxH0dMGL0YVImhU1U/1RWdv6H4SPAVwssNlIAInvWF+ATwHff0VnmsjQ2C5Kk
         hhHFTJ/1RSx6klPSDoEqxp16UmtfbM1v49n16JXsPufw94uiwrAJhHNGe2j7Sfyz1QBv
         hAfFCV5+rchUarfbtQD+EPoEjSYrK6/i5jRxIXwHUzwx6eczCcz8USPDnIgB6tSYe49N
         t2UQ==
X-Received: by 10.42.119.142 with SMTP id b14mr27325901icr.29.1431804066439;
        Sat, 16 May 2015 12:21:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c15a:d232:e950:b701])
        by mx.google.com with ESMTPSA id c10sm594667ioe.25.2015.05.16.12.21.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 16 May 2015 12:21:05 -0700 (PDT)
In-Reply-To: <1431713612.17436.27.camel@ubuntu> (David Turner's message of
	"Fri, 15 May 2015 14:13:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269201>

David Turner <dturner@twopensource.com> writes:

> So maybe we should just move the lstat below the pathspec check.  This
> is probably faster in some cases anyway.  What do you think?

I also was wondering about the placement of that lstat; because
having it before the pathspec filtering didn't make sense to me at
all.  If we are not told to clean some parts of the tree, we really
shouldn't be looking at that part of the tree.  I think such a
change is desirable and the justification of the change should be
based solely on the above---limit first and then check, don't check
what we were not told to look at.

And if such a change lets you solve your original issue, that is a
nice side effect I am happy to see.  By excluding the paths that are
unstable (because other processes randomly muck with them without
coordinating with the user) explicitly when running "git clean", the
user _is_ saying that s/he is aware of the issue and is actively
avoiding modifications by the third-party would not get in the way,
so I wouldn't call that sweeping it under the rug, like I did for
your original one.

Thanks.
