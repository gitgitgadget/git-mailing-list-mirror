From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH 0/6] more automation for cover letter generation
Date: Sat, 18 Apr 2009 18:16:15 +0200
Message-ID: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Cc: Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 18:18:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDFX-0000ZQ-3r
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbZDRQRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 12:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbZDRQQ6
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 12:16:58 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:42894 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbZDRQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 12:16:56 -0400
Received: from [212.117.84.81] (helo=fsst.voodoo.lan)
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDq-0007gG-Bg; Sat, 18 Apr 2009 18:16:54 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDL-0006YU-FX; Sat, 18 Apr 2009 18:16:23 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116837>

I like cover letters, in fact I like them enough to always want
--cover-letter to format-patch. The problem with that are patch "series"
that are only one patch long, where a cover letter would feel silly.

For now, I solved that by using a shell function that wrapped around
format-patch and did the trick for me.

With this series, format-patch can do it and do it better than my
wrapper could.

The following setup would suit me pretty well:

[format]
    coverletter = true
    coveronepatch = false
    overwritecoverletter = false


The series is based on master and doesn't seem to break anything
within the test suite. It could maybe use own tests, but I must admit
that I didn't look too closely at how git's test suite works and where
to put in tests for this.

Finally, this series does not change anything about format-patch's
default behaviour.

Regards, Frank


Frank Terbeck (6):
  format-patch: add cover{letter,onepatch} options

    The above makes it possible to *always* create cover letters
    without requesting it via --cover-letter. You can also suppress
    cover letters for patch series, that are just one patch long,
    where you'd probably put anything you have to say in addition
    between '---' and the diffstat.

  Add documentation for format-patch's --cover-one-patch
  Document format.coverletter and format.coveronepatch

  format-patch: introduce overwritecoverletter option

    When you're always generating cover letters, it can be a good idea
    to not overwrite an existing cover letter, especially if you're
    just refreshing your patch series, or added more commits to it -
    were comments you may have made in an existing cover letter might
    be valuable for the new patch series as well. Therefore setting
    overwritecoverletter to false protects you from overwriting an
    existing cover letter.

    I had hoped that this change would be possible without changes in so
    many places, but I didn't see a straight forward one.

  Add documentation for --cover-overwrite
  Document format.overwritecoverletter

 Documentation/config.txt           |   15 +++++++++++++
 Documentation/git-format-patch.txt |   11 +++++++++
 builtin-log.c                      |   40 +++++++++++++++++++++++++++++++----
 log-tree.c                         |    9 +++++--
 log-tree.h                         |    4 +-
 5 files changed, 69 insertions(+), 10 deletions(-)
