From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 15:34:49 -0500
Message-ID: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 15 22:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UciPX-0003X1-9B
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 22:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555Ab3EOUev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 16:34:51 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:60925 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab3EOUeu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 16:34:50 -0400
Received: by mail-lb0-f172.google.com with SMTP id y6so2367164lbh.31
        for <git@vger.kernel.org>; Wed, 15 May 2013 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=+pHbV3wDaeQZL5K1e6iNMxq4mCJjfdAl/Tj6LT9Jfw0=;
        b=tN8CeNbhIT3TTo0B3EYNGDwxZusiQ3xZxU8EcWN/qGMKLry2QvBQQdD9SVvcrCExm4
         131X8rDykocp58qY5Howo6+DXOlG2PECsBD7cWoNQcRCJNRjnFChFO7qwMkEE+c3AiTd
         4EMxJBbcKGC7FUwMlKqsrv10JiZla3K1k1oNX4JUPZLxM6DSPXLoMfyookzH4dxuCemx
         6voWFaezsbzWaGbzf2Fe1dckSMsbH0TgeJTMp70f0WXze28lH4TKNvsaYxP5Oi5lZc5P
         PesacEpOAMh9Hska6sh7IlqCs/icGx47Fn5Z/dKnc4HTqrbwyB/pglN4P8fYXuQ51SKX
         ctJA==
X-Received: by 10.152.27.132 with SMTP id t4mr9510690lag.46.1368650089412;
 Wed, 15 May 2013 13:34:49 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 13:34:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224449>

Hi,

I've been using Git from the start, but only lately have I forced
myself to configure upstream branches for all my branches, and I've
found a few things more convenient, but others completely contrary to
what I expected.

Inconvenient:

Before, I used to do 'git fetch' to simply fetch from 'origin', but
now, it depends on where 'upstream' is set to.

Convinient:

Now, I can just do 'git rebase --interactive' and I don't have to
specify the starting point, which is particularily useful when there's
a lot of branches one depending on another.

I think I'm using 'upstream' for something it was not intended to, and
I think the current 'upstream' behavior should be split into
'upstream' and 'base'.

== base ==

The 'base' branch will be set each time you create a branch from another;
'git checkout -b foobar master' sets 'master' as the 'base' of 'foobar'.

Then you can do 'git rebase foobar@{base}' or simply 'git rebase', and
Git will pick the right branch to rebase unto, even if you have no
'upstream'
configured.

This way 'git fetch' will keep picking 'origin', and other commands
that make use of 'upstream' would be undisturbed.

If both 'base' and 'upstream' are defined, I think 'git rebase' should
use 'base', but since that would break old behavior, perhaps there
should be a configuration variable to enable a different behavior.

I already started writting the patches, and although tedious, I think
they they'll be rather straightforward, but I thought it would be best
to hear some opinions first.

What do you think?

-- 
Felipe Contreras
