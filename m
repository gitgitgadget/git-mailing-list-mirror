From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: Do not redefine _WIN32_WINNT
Date: Wed, 11 Sep 2013 14:51:28 -0700
Message-ID: <xmqq61u7rpr3.fsf@gitster.dls.corp.google.com>
References: <52309507.1090908@gmail.com>
	<xmqq4n9rtdol.fsf@gitster.dls.corp.google.com>
	<CAHGBnuPdixkH42SNW0enF8C-GFwH8gX8NOXb69VscV3qvA6bxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 23:51:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJsK4-0000KC-GG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 23:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370Ab3IKVvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 17:51:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292Ab3IKVvf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 17:51:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E3341235;
	Wed, 11 Sep 2013 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2nidv2gODaPQage6bHUkiyANfTE=; b=NCL2Y3
	N6ycNCovJq3DHez1T6zPoex+H0P23yiS0sUW8PqmyTZ8AcnjqWBn6gstTg3/CGXu
	sJho41zyDqSs3ObHfIj+wQSWbk8Z1IylaxlLtdjFRTC0qf1vN4LKKWaJbtqBSJqX
	6WuYsPAGgeAb0q8Q6YlNL2/lqqekgxO5eRjF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TGqSWgn+MRv2TgXRKm/qIQyT+/JlplSL
	SWAWKMMNse7dLIVa+VpM2W/CYOuJJygA5IgmFYil5Wya1Brk9za2YR50S0d7oos2
	Yxlkl5Tn4BoAd7X1jBALggu+mBiUb6poc1A0cnPonDDR/avX+6cJXH9ewCb7ci01
	9giFNGA5nF0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DC9F41232;
	Wed, 11 Sep 2013 21:51:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D9EA4122C;
	Wed, 11 Sep 2013 21:51:32 +0000 (UTC)
In-Reply-To: <CAHGBnuPdixkH42SNW0enF8C-GFwH8gX8NOXb69VscV3qvA6bxg@mail.gmail.com>
	(Sebastian Schuberth's message of "Wed, 11 Sep 2013 22:03:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 523979E2-1B2C-11E3-AC9F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234611>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Wed, Sep 11, 2013 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> This unfortunately does not seem to match what I have. I think the
>> patch is based on the codebase before these two:
>>
>>  380395d0 (mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE, 2013-05-02)
>>  41f29991 (msvc: Fix compilation errors caused by poll.h emulation, 2013-01-31)
>>
>> I could of course wiggle it in, if you want, but I wanted to know
>> what is going on.  Is it a pre-release freeze period on your side or
>> something?
>
> That's right, I currently have a code freeze at Git 1.8.3 because I
> need to solve several other issues with Git 1.8.4 on Windows first.
> I'd be grateful if you could "wiggle it in".

It seems that compat/poll/poll.c also defines _WIN32_WINNT (but only
with _MSC_VER defined).  The change to git-compat-util.h in this
patch avoids redefinition for both MinGW and MSVC case.  Do you also
need to have this, too?

Here is what I tentatively queued on top of the three from Karsten,
and your "Fix stat definitions".

-- >8 --
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Wed, 11 Sep 2013 18:06:31 +0200
Subject: [PATCH] Windows: do not redefine _WIN32_WINNT

With MinGW runtime version 4.0 this interferes with the previous
definition from sdkddkver.h.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/nedmalloc/malloc.c.h | 2 ++
 compat/poll/poll.c          | 2 +-
 git-compat-util.h           | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index ed4f1fa..f216a2a 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -499,7 +499,9 @@ MAX_RELEASE_CHECK_RATE   default: 4095 unless not HAVE_MMAP
 #endif  /* WIN32 */
 #ifdef WIN32
 #define WIN32_LEAN_AND_MEAN
+#ifndef _WIN32_WINNT
 #define _WIN32_WINNT 0x403
+#endif
 #include <windows.h>
 #define HAVE_MMAP 1
 #define HAVE_MORECORE 0
diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 4410310..31163f2 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -39,7 +39,7 @@
 
 #if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
 # define WIN32_NATIVE
-# if defined (_MSC_VER)
+# if defined (_MSC_VER) && !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0502
 # endif
 # include <winsock2.h>
diff --git a/git-compat-util.h b/git-compat-util.h
index 9549de6..7776f12 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -86,7 +86,7 @@
 #define _SGI_SOURCE 1
 
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
-# if defined (_MSC_VER)
+# if defined (_MSC_VER) && !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0502
 # endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
-- 
1.8.4-469-g57f7e3a
