From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 0/6] Runaway process and commit selection fixes
Date: Sun, 27 Jul 2008 10:17:22 +0400
Organization: TEPKOM
Message-ID: <200807271017.23272.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 08:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzaV-0002qw-3W
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbYG0GRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbYG0GRf
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:17:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:55052 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbYG0GRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:17:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1893079fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-disposition:from
         :organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=3a00DEE+8L5w2J+LAaG81yggvm/1D1na+mXQEC9ZGmY=;
        b=LE9Muo11lRljzV5xSRyKeGAjaOiCmRIoY7xCnmsMCwlJji3xDQytLewdXHrQhllHtY
         IG1Ja++p0uc32GAJavtEXydTExrNvP8q+IwosMNjaqn93M5xLZA7sZZZbistks/VgT1N
         7UZjfMywBECwxawyyOe6iALpgVpYF9SdhYn4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-disposition:from:organization:to:subject:date:user-agent:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=eX/9VsItaV6VQoAP6MtIDtjQyVGhmJdDDqySwa4xGKLhTnGYIPdiU5uHpu4r6T4qyV
         kTYOIhuglxIT2G0ZnzT/VNDs5WHaTAmn7H0Qnfp809NqXdvrm0ItOlyCJtzf4a3p9opK
         PkJLN/+Eql6mBy9Q8VrNUqW1WT1EE1Q70kelE=
Received: by 10.86.60.15 with SMTP id i15mr1401771fga.43.1217139452637;
        Sat, 26 Jul 2008 23:17:32 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id d6sm9585846fga.2.2008.07.26.23.17.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 23:17:32 -0700 (PDT)
Content-Disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90313>

This series includes three patches that I sent 8 days ago,
because I haven't received any reply so far.

These patches address the following problems:

1) Runaway processes (resend)

	As in the 'git gui blame' case, gitk back-end processes can sometimes
	run for a while without producing any output, e.g. diff-files on a slow
	filesystem.

	These patches make gitk explicitly kill its back-end processes.

2) Gitk stopping showing any diffs under random conditions.

3) Broken commit selection on view reload: gitk tried to preserve
  the selected commit, but usually failed because of code rot.

	I added selection preservation on Reload and Edit View.
	Update still should reset the selection to HEAD if anything changed.

	Also, if the previously selected commit was not found in the new view,
	gitk should fall back to selecting HEAD.


Alexander Gavrilov (6):
      gitk: Kill back-end processes on window close.
      gitk: Register diff-files & diff-index in commfd, to ensure kill.
      gitk: On Windows use a Cygwin-specific flag for kill.

      gitk: Fixed broken exception handling in diff.
      gitk: Fixed automatic row selection during load.
      gitk: Fallback to selecting the head commit upon load.

 gitk |  148 +++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 97 insertions(+), 51 deletions(-)
