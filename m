From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: offtopic: ppg design decisions - encapsulation
Date: Mon, 6 May 2013 11:34:28 -0400
Message-ID: <CACPiFCL+cd1vmqj6JEj84L5rDvHGxDgo+zGw5__ard6-sumipA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 06 17:35:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZNRJ-00026I-DR
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab3EFPex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:34:53 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:37950 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab3EFPew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:34:52 -0400
Received: by mail-qa0-f52.google.com with SMTP id g10so1359107qah.18
        for <git@vger.kernel.org>; Mon, 06 May 2013 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=i2QVDAKN6Alq+O9W47RZeMTSZTWZ0Vixprp0ODaS41I=;
        b=CPuBpR1Pby2JhxXVZLww/dMn96mwYMGLwXHJuLgV5vEuYqcz85pOQT2diXZrv4q1k9
         IzDAwpJfcSXHTJ37v8MO770g+AvHYiuu0mn6RXTUV10x5OLrqb2k8ISWDvk9xHSi7JJR
         Nf+gHiVWi0H/rV4tY/C5h2T1SqYO2OJ9Jt6VANJ365fX5zQhkfU4MlcT7tHzP/g2WkPU
         PgpDySsScMzIWLOcz9ZTRCN9ukpb3zkR4IJbAJx8LzBL4laVyM0HnrZpY4OaGr0urX1q
         imbCZ+CiKEMh6sfznCWWUjOdRChDnwm6TPvS8z1tZymuoXPlW39+31bNsSHgT40Fh/mR
         klvw==
X-Received: by 10.224.164.205 with SMTP id f13mr24056216qay.16.1367854491845;
 Mon, 06 May 2013 08:34:51 -0700 (PDT)
Received: by 10.49.87.165 with HTTP; Mon, 6 May 2013 08:34:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223462>

[ Unashamedly offtopic... asking here because I like git design and
coding style, and ppg is drawing plenty of inspiration from the old
git shell scripts. Please kindly flame me privately... ]

ppg is a wrapper around git to maintain and distribute Puppet configs,
adding a few niceties.

Now, ppg will actuall manage two git repositories -- one for the
puppet configs, the second one for ferrying back the puppet run
results to the originating repo (were they get loaded in a puppet
dashboard server for cute webbased reporting). The puppet config repo
is a normally-behaved git repo. The "reports" repo is a bit of a hack
-- never used directly by the user, it will follow a store-and-forward
scheme, where I should trim old history or just use something other
than git.

So I see two possible repo layouts:

- "Transparent, nested"
 .git/ # holding puppet configs, allows direct use of git commands
 .git/reports.git # nested inside puppet configs repo

- "Mediated, parallel"
 .ppg/puppet.git # all git commands must be wrapped
 .ppg/reports.git

My laziness and laisses-faire take on things drives to to use the
transparent&nested approach. Let the user do anything in there
directly with git.

OTOH, the mediated approach allows for more complete support,
including sanity checks on commands that don't have hooks available. I
already have a /usr/bin/ppg wrapper, which I could use to wrap all git
commands, setting GIT_DIR=.ppg/puppet.git for all ops. It would force
ops to be from the top of the tree (unless I write explicit support)
and I would have to implement explicit. And it would break related
tools that are not mediated via /usr/bin/git (gitk!).

Written this way, it seems to be a minimal lazy approach vs DTRT.

Am I missing any important aspect or option? Thoughts?

cheers,



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
