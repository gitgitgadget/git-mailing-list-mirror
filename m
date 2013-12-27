From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH] git-svn: workaround for a bug in svn serf backend
Date: Fri, 27 Dec 2013 11:52:50 +0400
Message-ID: <CANiYKX4qGn0ZCVWTwWdrMfV_95mCePdd=q_BLJ6KH=MYOmqWbw@mail.gmail.com>
References: <87ha9wdh8g.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
	<1388059524-4864-1-git-send-email-rkagan@mail.ru>
	<20131226202805.GV20443@google.com>
	<CANiYKX6VA2KvJ_YWYOegb6+VFg_unL96P9qUBthYPFuo9fhAMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	Benjamin Pabst <benjamin.pabst85@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 08:53:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwSEN-0003zv-Vs
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 08:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab3L0Hwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 02:52:51 -0500
Received: from mail-qe0-f48.google.com ([209.85.128.48]:57621 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab3L0Hwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 02:52:51 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so8686724qeb.21
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 23:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=l6KWmbA/bIrDOKWZGxFH1dZWUJ1nCOgB+YXnfIbKAB8=;
        b=KU/hBvEbKjfq+6DE3FkBRScvH9xQG2Yv3ILuhSHi+xD3vzUxRt14/Gy39hwSq/F+BU
         raTTbZJefr31mAOSFQ0yFfwUirfGU0GZ4THxRV2Lqpt4YLdC2xjzMfSSUmLk2HdajdRV
         hEE51ioyjzo1xeWucYWs0f6aE57wFyj2NcGrPl8mU3VKV1ngGMJ61oth+3lUgKLZWBmI
         rn3aFaIEaV7fT/Wo6vNhInuoS9Jh37+tkBK042eUyEs/vm0aQW2uHTQP5ZEqGOUxsm2q
         yd25ygxG9l0e78+WcJewIl25tTRb07B4xMLwoSK5NlC+y/nbnwsyogc+RwFUMTgECZ57
         z4qQ==
X-Received: by 10.224.67.137 with SMTP id r9mr78701843qai.8.1388130770436;
 Thu, 26 Dec 2013 23:52:50 -0800 (PST)
Received: by 10.224.98.146 with HTTP; Thu, 26 Dec 2013 23:52:50 -0800 (PST)
In-Reply-To: <CANiYKX6VA2KvJ_YWYOegb6+VFg_unL96P9qUBthYPFuo9fhAMA@mail.gmail.com>
X-Google-Sender-Auth: 7qKOPzHUanEm6FbRlVblJFUpYJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239721>

2013/12/27 Roman Kagan <rkagan@mail.ru>:
> 2013/12/27 Jonathan Nieder <jrnieder@gmail.com>:
>> Could this be reproduced with a test script to make sure we don't
>> reintroduce the bug again later?  (It's okay if the test only fails on
>> machines with the problematic svn version.)
>
> That would need a fairly fancy setup phase, as the bug triggers only
> on http(s)-accessed svn repositories.  I'll take a look if there's
> something already available in the existing test scripts

Turns out the stuff is all there, and the tests doing file renames and
dcomit-ting them do exist (t9115-git-svn-dcommit-funky-renames.sh for
one).

However, the httpd setup is seriously broken; I haven't managed to get
it to run on my Fedora 20 with apache 2.4.6.  Apparently git-svn tests
(almost) never get executed against an http-based repository; even
those who don't set NO_SVN_TESTS get them run against file-based
repository and thus don't trigger the error.

Someone with better apache-foo needs to take a look into that.  Once
that is sorted out I believe the tests will start triggering the bug.

Meanwhile I assume that the patch doesn't need to include an extra testcase.

Roman.
