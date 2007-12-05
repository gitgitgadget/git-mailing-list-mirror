From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: builtin command's prefix question
Date: Wed, 5 Dec 2007 23:56:50 +0700
Message-ID: <fcaeb9bf0712050856t5d730779q82783fdb9876f41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzxYf-0004PB-LE
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 17:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbXLEQ4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 11:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXLEQ4w
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 11:56:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:29248 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbXLEQ4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 11:56:52 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3176374nfb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 08:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=rslfEc97ZwO8NMUXSyCK95rHdSY32YN8WXnQdg3vaF4=;
        b=qdiWoPfVR79NMv/5FfxbEcjbbc2dQn5em3JN6KqBX4RcEvVCKBUuI1YNan70r6AmpVWAmciS/rjLD5vj+U6e2VmsPLof/FqB3wFLQzO5IoD0xTWopNvjegqNAk39SkjfRRu87DUKjiGuWTaYUPyLUUk7VTFieZpr5nyCc4aJC5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J1qlPVLp4KgMGrXNr8vjpz5cvNEuYvYgnTn66MXXUc6bK/eE31r9g122V8CXJZ4li7Dks/vaCSxqOYp1sIJSOVeWVPlu1gNO8eyUtEZQArAFfvZ4w9ZNiSXguH/8B2M/Rqt1HlCVL/sRfukEaE9HXiCi6qNhkfuXj3AJuzm8VRw=
Received: by 10.86.4.2 with SMTP id 2mr687688fgd.1196873810513;
        Wed, 05 Dec 2007 08:56:50 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Wed, 5 Dec 2007 08:56:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67168>

Hi,

I have been looking at setup_git_directory_gently() lately. From my
understanding, setup_git_directory* will return a string called
"prefix" that is passed to builtin commands. What is the exact meaning
of this prefix? Correct me if I'm wrong. In early (read: no worktree)
days, cwd was moved to working root directory and prefix contained
relative path from working root directory to the original cwd. So it
had a few implications:
 1. A non-empty prefix indicates cwd has been moved
 2. If cwd is moved, it is moved to working root directory
 3. cwd+prefix should point to the current directory at the time the
command was issued (let's call it "user cwd")

Things change a bit since the rise of worktree:
 - If GIT_DIR is set and GIT_WORK_TREE is not, prefix is relative to
the to-be-set-up worktree, but cwd is not changed, so point 3 is gone.
 - If GIT_DIR is not set and GiT_WORK_TREE is,
  - and it is found that user cwd is inside a gitdir (bare repo), cwd
has been moved and prefix is empty, cwd+prefix no longer point to user
cwd
  - for other cases, cwd may not be worktree (the real worktree will
be setup in setup_work_tree or setup_git_directory)

Now that setup_work_tree can move cwd, it should also change prefix to
meet point 3. But it does not.

I feel dizzy now. Were my assumptions wrong? What is expected behavior
of setup_git_directory_gently()?
-- 
Duy
