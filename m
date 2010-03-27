From: Chris Webb <chris@arachsys.com>
Subject: [RFC 0/1] diff --check for indent-with-spaces style
Date: Sat, 27 Mar 2010 14:08:00 +0000
Message-ID: <1269698881-26443-1-git-send-email-chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 27 15:13:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvWlK-0003hh-2W
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 15:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab0C0ONN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 10:13:13 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:56567 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0C0ONM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 10:13:12 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Mar 2010 10:13:12 EDT
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NvWgD-0002QR-RG
	for git@vger.kernel.org; Sat, 27 Mar 2010 14:08:02 +0000
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143332>

I've been preparing some patches against a project (qemu) which has an indent
style of only spaces, i.e. tabs forbidden. I usually use diff --check to make
sure I catch stray spaces when I'm working on tab-indented code, and although
core.whitespace can be set to indent-with-non-tab to enforce the use of tabs,
there's no corresponding 'indent-with-tab' rule to forbid them. The asymmetry
bothered me, so I've added support for this to ws.c in the following small
patch.

Would this rule be more clearly described as indent-with-non-space instead?

For completeness, I'd also like to support core.whitespace = indent-with-tab
in git apply --whitespace=fix (although I don't use this myself). It's trivial
to expand the tabs in ws_fix_copy(), but this would violate the assumption in
the calling code that whitespace cleanup doesn't result in a dst string longer
than src. I think the only sane way I can deal with this correctly is to
properly replumb ws_fix_copy() and its callers to use a strbuf instead of a
char *dst?

 cache.h |    1 +
 ws.c    |   26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)
