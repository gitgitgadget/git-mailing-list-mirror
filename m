From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Should git-remote-hg/bzr be part of the core?
Date: Sun, 11 May 2014 18:34:08 -0500
Message-ID: <537008f06ceb8_8e47492f89f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>,
	Torsten =?UTF-8?B?QsO2Z2Vyc2hhdXNlbg==?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org, git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Mon May 12 01:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjdGy-0002in-US
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 01:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228AbaEKXfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 19:35:07 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:45465 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096AbaEKXeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 19:34:18 -0400
Received: by mail-oa0-f44.google.com with SMTP id o6so440017oag.31
        for <git@vger.kernel.org>; Sun, 11 May 2014 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=uHxY1uS7le4p8vyR/EDwcJ4nwzbZ8ALjCPyYVupl/ec=;
        b=xPdRM7Je2e+KoBgnZQL02FsBF19OcSDQhmMQ4V15PU7CuabP9AL3XsXQkNo8GtD7Kd
         IzNdmkhuMDrPKbWZClZ1nNTEc+z2S2PSQ1X/C3iZd0vLdfRL4g9q2u09gHLHmCJJXLU2
         Hg8nyHcbQilAqdNnXJBqjL2UH1sIs8Q4Qux3ci8tTMrKvyWX5jP5iMneip3Il7yMnLTS
         ztoOebOz7Tn+6/KgiO7SO4KvAWSubw9+MOEW///ntJoL7BJnG5xdLyhhA6bpe7h0Xzni
         OuI0XP7KJM4Iif9okW0uTIsVJ7BxAotgEThRnAbo1cyWtkAwcPiHD0ZfUdiWtjli76q5
         Wy+Q==
X-Received: by 10.182.249.18 with SMTP id yq18mr10263303obc.37.1399851257107;
        Sun, 11 May 2014 16:34:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm42718056oeb.3.2014.05.11.16.34.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 May 2014 16:34:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248685>

Hi,

Recently Junio said he was willing to hear the opinion of other people
regarding the move from contrib to the core[1]. This move is already
under way, but suddenly Junio changed his mind.

I have repeatedly asked him to clarify what argument changed his mind,
but he hasn't done so. Hopefully he will do that in this thread, but
I'll jump ahead and assume it's this one by John Keeping[2]:

  I do not want to end up in a situation where an update to Git is
  blocked by a distribution because git-remote-hg is not updated to
  support newer versions of Mercurial sufficiently quickly; this
  previously happened in Gentoo due to git-svn and meant that was stuck
  on 1.7.8 until 1.7.13 was released [X].

Now, I feel I addressed this argument at length, specially in this
thread [3], but I'll try to provide a summary of the strongest arguments
against:

 1) We can make the tests optional, say 't/optional'. So if they don't
    pass, the build of Git is not broken. Additionally, distributions
    might prefer to run test-essential if they don't want to run these
    optional tests.
 
 2) There's already continuous integration builds[4] to make sure all
    the possible incoming changes in Mercurial are detected early on.

 3) There has been a *single* case where a new Mercurial (3.0) broke
    things. This is due to the fact of how I implemented certain
    functionality due to limitations in Mercurial's API. Mercurial
    authors can be contacted to improve the API and minimize the
    possibility of it happening again.

Given these arguments, I don't see how moving git-remote-hg to the core
could possibly cause any problems, and I don't understand why Junio
would think otherwise. Even if such a breakage causes a problem to the
whole Git, it would make sense to demote these tools *when* such a
problem comes (which I argue it won't). Does it make sense to you that
you get thrown in jail for a crime you haven't committed merely because
someone thinks it's likely you will?

Given the huge amount of work I've put in these remote helpers, and the
fact that Junio said since day 1 he wanted these in the core[5] (and I
was operating under that assumption), I think the demotion back to the
contrib area (and therefore out-of-tree) should be made carefully, and
not from one day to he next as it happened.

Thoughts?

[1] http://article.gmane.org/gmane.comp.version-control.git/248676
[2] http://article.gmane.org/gmane.comp.version-control.git/248167
[3] http://article.gmane.org/gmane.comp.version-control.git/248683
[4] https://travis-ci.org/felipec/git
[5] http://article.gmane.org/gmane.comp.version-control.git/220277

-- 
Felipe Contreras
