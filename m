From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH] Avoid problem with xpg4 grep in Solaris that broke t9400
Date: Thu, 19 Apr 2012 09:55:53 -0700
Message-ID: <xmqqfwbzslt2.fsf@junio.mtv.corp.google.com>
References: <1334002409-5708-1-git-send-email-bwalton@artsci.utoronto.ca>
	<1334445524-sup-1455@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Apr 19 18:56:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKueH-0004vU-6v
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 18:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab2DSQz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 12:55:56 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:35671 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab2DSQzz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 12:55:55 -0400
Received: by ghbz15 with SMTP id z15so993730ghb.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=V49kn8ORkqBCL42BAeRV6zGlYUUvNgGDT24PHt2Jsrw=;
        b=M7ndb+quFgPqz5/6gzeoH7XsFR+6PujPmIy9qVcMASdu8w4n2J+MVcU1AcN6FdhtPf
         OYkOos1kl1IT/T25Pw/xs/5qsj5NNOfXzq8Pgq5vNsIsSgHbJ9PtH5cqTCtFwsUgaYbP
         YvQGZzbpl27KJBJIKS0ZJ6ILcey131Zm2fVo29ZRhfPPJCfjqiXVryb6kkc/Jo6FzJZ5
         lCzAbMLhTSCeJp9uSihpaW2naxVVnja6ilkEswAlVQDX8oACvrTOWqmqkwU7nXHM9FFE
         ojWTl3ylGdSShS/fLv+tYRQz+RQ4BaU3CyA8IW4YkGHvLDK2uiAw1Ohn0H/sX+77BCcQ
         nk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=V49kn8ORkqBCL42BAeRV6zGlYUUvNgGDT24PHt2Jsrw=;
        b=XgcnBHxZrZ5EBJn4WwGqiBYKrApt26NzY4xGlSskIOKA2O1/PiaqnjpucFOoTaPOy7
         HORdAYDCWxI422n64ForUo02O33+P8X18NqILkJ+JINCyXRzEwycFPvw42qIi+9qj/no
         XbDuyqAmrZ+HRZZUvX85Vc4sqY9SMDAVuJTYvhdKTKip4ZupfgVB3+09hW5RSDflVJOh
         0+2xOMZGZBXl9tVBkfHLpmuOSuq0ZyoX7/NbRoPsImZwlEq86bVjkiiF/kd/3pCZSRI2
         X2wLv9vM2y3vFh1CRpKlTgH1BZ7aa9W8UzYOoy9Mv2KJuz+pQ+Ul46G96PEm52UlDB0N
         HmYA==
Received: by 10.101.151.23 with SMTP id d23mr1014505ano.11.1334854554735;
        Thu, 19 Apr 2012 09:55:54 -0700 (PDT)
Received: by 10.101.151.23 with SMTP id d23mr1014491ano.11.1334854554629;
        Thu, 19 Apr 2012 09:55:54 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id g49si2654594yhe.6.2012.04.19.09.55.54
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 09:55:54 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 8379110004D;
	Thu, 19 Apr 2012 09:55:54 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 0D9B6E554F; Thu, 19 Apr 2012 09:55:53 -0700 (PDT)
In-Reply-To: <1334445524-sup-1455@pinkfloyd.chass.utoronto.ca> (Ben Walton's
	message of "Sat, 14 Apr 2012 19:19:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlB+pF08XzwgRGRWVvctNT74K1IVviy7uj9U9ihDUNxQlK2W70anhNrulI/2QzLnu7kwyND3v8pIezx2S8AOli/X8NvpPq6Dh/qgoGryTVpQMdh7LzCsaA+YBlIHVqWemWdDWHywkic1gCkIAmLuaCjhtEWUow6gLYeiX3webKN7tzHyMM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195952>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Excerpts from Ben Walton's message of Mon Apr 09 16:13:29 -0400 2012:
>
> Bump?
> ...
>> It's possible that the specific pair of grep statements is required.
>> It's looking for tab or space, so maybe we get either character in
>> some cases, depending on cvs version?

Bump, anybody, on this point?

>> If there is a reason for the original construction, I'll find a more
>> creative work around for this problem.
>> 
>>  t/t9400-git-cvsserver-server.sh |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
>> index 9199550..df1405f 100755
>> --- a/t/t9400-git-cvsserver-server.sh
>> +++ b/t/t9400-git-cvsserver-server.sh
>> @@ -500,8 +500,8 @@ test_expect_success 'cvs status (no subdirs in header)' '
>>  cd "$WORKDIR"
>>  test_expect_success 'cvs co -c (shows module database)' '
>>      GIT_CONFIG="$git_config" cvs co -c > out &&
>> -    grep "^master[     ]\+master$" < out &&
>> -    ! grep -v "^master[     ]\+master$" < out

Is it really the character class, or is it the GNUism "\+", that breaks
this?

In other words, does it work if you patch it like this instead?

 t/t9400-git-cvsserver-server.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9199550..173bf3d 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -500,8 +500,8 @@ test_expect_success 'cvs status (no subdirs in header)' '
 cd "$WORKDIR"
 test_expect_success 'cvs co -c (shows module database)' '
     GIT_CONFIG="$git_config" cvs co -c > out &&
-    grep "^master[	 ]\+master$" < out &&
-    ! grep -v "^master[	 ]\+master$" < out
+    grep "^master[	 ][ 	]*master$" <out &&
+    ! grep -v "^master[	 ][ 	]*master$" <out
 '
 
 #------------
