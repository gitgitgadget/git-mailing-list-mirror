From: Christian Couder <christian.couder@gmail.com>
Subject: Watchman/inotify support and other ways to speed up git status
Date: Thu, 22 Oct 2015 07:59:29 +0200
Message-ID: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 07:59:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp8ub-0007oC-BN
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 07:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbbJVF7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 01:59:32 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36129 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbJVF7b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 01:59:31 -0400
Received: by lffz202 with SMTP id z202so35753680lff.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=yFICOvcz166cU/pYvbC3t6i9J5Qu/1DTPUKuCYfi91c=;
        b=csCcDQQh2p+1OUG8vXC+ijwKOonr12KcN6YKtxl/ncCV7OiV9OjDxuUh/gYF42y4ij
         W6+Y+wyYwR6A3djvHWG+jV9OVTXZUYANc2rCe5OkvOaVidUIjqZ88Jnzot8J5QqbFTNC
         /up9dcUKtEbMcuoGvVaGJGrEbsBtZ6TRTiJx78BpR/HGg6PR809Czql60A9y0Dw2sb+3
         pm6QTbbznLw3z2fTLNtJ7hI5yZOLDvxI+KlEvpWYUjyphx0WeYiTwaEWXwjYlbaMf0HR
         m/GRAeiIrPD3jyYCjkqATNjIHnTGTW7O8AF6iXDOQ/bD5XI101QzvvCg2rR9ofdH8dVS
         SL1w==
X-Received: by 10.112.72.99 with SMTP id c3mr5839560lbv.113.1445493569860;
 Wed, 21 Oct 2015 22:59:29 -0700 (PDT)
Received: by 10.25.89.130 with HTTP; Wed, 21 Oct 2015 22:59:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280040>

Hi everyone,

I am starting to investigate ways to speed up git status and other git
commands for Booking.com (thanks to AEvar) and I'd be happy to discuss
the current status or be pointed to relevant documentation or mailing
list threads.

>From the threads below ([0], [1], [2], [3], [4], [5], [6], [7], [8]) I
understand that the status is roughly the following:

- instead of working on inotify support it's better to work on using a
cross platform tool like Watchman

- instead of working on Watchman support it is better to work first on
caching information in the index

- git update-index --untracked-cache has been developed by Duy and
others and merged to master in May 2015 to cache untracked status in
the index; it is still considered experimental

- git index-helper has been worked on by Duy but its status is not
clear (at least to me)

Is that correct?
What are the possible/planned next steps in this area? improving
--untracked-cache? git index-helper? watchman support?

Thanks,
Christian.

[0] March 8 2015: [PATCH 00/24] nd/untracked-cache updates
http://thread.gmane.org/gmane.comp.version-control.git/265053/

[1] November 11 2014: [RFC] On watchman support
http://thread.gmane.org/gmane.comp.version-control.git/259399/

[2] October 27 2014:[PATCH 00/19] Untracked cache to speed up "git status"
http://thread.gmane.org/gmane.comp.version-control.git/258766

[3] July 28 2014: [PATCH v3 0/9] Speed up cache loading time
http://thread.gmane.org/gmane.comp.version-control.git/254314/

[4] May 7 2014: [PATCH 00/20] Untracked cache to speed up "git status"
http://thread.gmane.org/gmane.comp.version-control.git/248306

[5] May 2 2014: Watchman support for git
http://thread.gmane.org/gmane.comp.version-control.git/248004/

[6] March 10 2014:
http://git.661346.n2.nabble.com/question-about-Facebook-makes-Mercurial-faster-than-Git-tt7605273.html#a7605280

[7] January 29 2014:
http://git.661346.n2.nabble.com/inotify-support-nearly-there-tt7602739.html

[8] January 12 2014:
http://git.661346.n2.nabble.com/PATCH-0-6-inotify-support-tt7601877.html#a7603955
