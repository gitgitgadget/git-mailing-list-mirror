From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH 0/5] Replacing strbuf_getline_lf() by strbuf_getline() on
 trimmed input
Date: Sat, 30 Jan 2016 18:51:39 +0100
Message-ID: <56ACF82B.2030005@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 18:51:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPZgX-0002gj-JD
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 18:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbcA3Rvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 12:51:41 -0500
Received: from moritzneeb.de ([78.47.1.106]:48350 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932346AbcA3Rvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 12:51:41 -0500
Received: from [192.168.1.11] (x4db33e5e.dyn.telefonica.de [77.179.62.94])
	by moritzneeb.de (Postfix) with ESMTPSA id CE0881C02A
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 18:51:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1454176299;
	bh=ZP3cRCjZPBYmtKWqTmyw1sATmiMrGfHS8Yv1GqQNKcM=;
	h=From:Subject:To:Date:From;
	b=DA7/afHdKsmLPx5canZqui/52PFudwr1p+LsuNbiIMOg6toO3wqhUEDVpv2lMEyvy
	 /6gBi7St8fuMMDeBKPayU7rc8+CejPPn+3q9/zt7mqeH+FQH+fBC4c8OzZ4R8kTqen
	 BhBZhInaawRA2eQL54U/V9xLQdIF4DOcJ9Rw/kQI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285118>

This series deals with strbuf_getline_lf() in certain codepaths:
Those, where the input that is read, is trimmed before doing anything that
could possibly expect a CR character. As the codepath after trimming can not
in any way expect a CR at the end of the line, because trim dropped it before
the change, this can be safely done.

The series is an idea out of [1], where Junio proposed to replace the calls
to strbuf_getline_lf() because it 'would [be] a good way to document them as
dealing with "text"'. 
Apart from a general review, I would be happy about comments how I can improve
this (and future) patches, as this is my first one. Especially I am not sure
about how many arguments from the discussion on the mailing list should be put
into the commits.

-Moritz

[1] http://thread.gmane.org/gmane.comp.version-control.git/284104


Moritz Neeb (5):
  bisect: read bisect paths with strbuf_getline()
  clean: read user input with strbuf_getline()
  notes: read copied notes with strbuf_getline()
  remote: read $GIT_DIR/branches/* with strbuf_getline()
  wt-status: read rebase todolist with strbuf_getline()

 bisect.c        | 2 +-
 builtin/clean.c | 6 +++---
 builtin/notes.c | 2 +-
 remote.c        | 2 +-
 wt-status.c     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.4.3
