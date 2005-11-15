From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Tue, 15 Nov 2005 09:54:43 +0000
Message-ID: <b0943d9e0511150154y2d2af24ck@mail.gmail.com>
References: <20051113194225.20447.57910.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 10:56:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbxWZ-0002aT-Qr
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 10:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVKOJyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 04:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVKOJyp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 04:54:45 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:20524 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751413AbVKOJyo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 04:54:44 -0500
Received: by xproxy.gmail.com with SMTP id i30so1375136wxd
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 01:54:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GrQHrUPI1Mupcjc2B4Ierb1gu8Q6sTkpT6vuvweR8q06zMBN65o6AbEpOoGMkuEU7OPjMGpbkgCC1adQkfdcrq7b+EHVHl2dhpPYOEZqFBnCXCXPmCU4RkN5J0Jv7ulRCKqXBkGq1JjFbQZKca7DzkNTYZM/ma25qBGY4+J7j5Q=
Received: by 10.70.60.5 with SMTP id i5mr2573936wxa;
        Tue, 15 Nov 2005 01:54:43 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Tue, 15 Nov 2005 01:54:43 -0800 (PST)
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20051113194225.20447.57910.stgit@zion.home.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11891>

On 13/11/05, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> wrote:
> I just got a "removal vs. changed" conflict, which is unhandled by StGit. That
> is taken from git-merge-one-file resolver, but is bad, as stg resolved does not
> handle unmerged entries (and probably it should be fixed too).

I think it 'stg resolved' should be fixed as well (in case there are
unmerged entries for other reasons). My initial idea was to make
gitmergeonefile not to leave any unmerged entries in the index. As you
could see, there are cases where it failed.

I can see the following scenarios for a file:

1. deleted in the base and modified by the patch. It should leave the
file in the tree together with file.older. Another option would be to
remove the file and leave both file.older and file.remote in the tree
(here .remote means the version in the patch) but I would prefer the
first one.

2. changed in the base but deleted by the patch. It should remove the
file from the tree but leave file.older and file.local. The other
option is to leave the file in the tree but, as above, I prefer the
first one.

Maybe StGIT should try to track the renaming as well but I haven't
played with this feature in GIT at all.

--
Catalin
