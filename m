From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Confusing error message due to Git trusting is_bare_repository()
Date: Fri, 25 Mar 2011 11:56:20 +0100
Message-ID: <AANLkTi=9CpMU9aZs2zuvRyv3rpECkRAvYA0Srnc61whg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 25 11:56:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q34gu-0000yk-Fy
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 11:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934405Ab1CYK4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 06:56:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44375 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab1CYK4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 06:56:21 -0400
Received: by fxm17 with SMTP id 17so1039855fxm.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=rkQ8OzE7s6tR6heuFQ9311WERGz1ddEMWPe4DjSuTdo=;
        b=hiQOlW5Yebq0Yb82+ODPFD6j/D2jH0JrG5IMCGZIn+n1QlNL3YrsnYXMGzRd0p4cHt
         hwxQli/MKmMwXQ8e0XM0RCCy0KqTGvLKdTQSDwrrKP0o6N6zcm2ZCGk0jiUBV17aFNNZ
         31dE6yXK/wQt+XmIPgctHmjtu0ahy5c05rm64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cTMXuc34tcS8mDsDgeOW8FttJEu72c/qf8dWRc1zeOv1FYanKdGzrHEdwZACfQF1pn
         /obR28o8Q1clISS2alOGaXDC7tNNbn1+SQUQrOFDiNs8Ihh2UZzsDJoQt+P4i8Rzu9D+
         n75BuqfocMnEaq4fgNoqY8ZVTIvB4XrdW8AlA=
Received: by 10.223.77.71 with SMTP id f7mr692337fak.141.1301050580641; Fri,
 25 Mar 2011 03:56:20 -0700 (PDT)
Received: by 10.223.93.196 with HTTP; Fri, 25 Mar 2011 03:56:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169980>

I had a co-worker git this well-known error message:

    error: refusing to update checked out branch: refs/heads/master
    error: By default, updating the current branch in a non-bare repository
    error: is denied, because it will make the index and work tree inconsistent
    error: with what you pushed, and will require 'git reset --hard' to match
    error: the work tree to HEAD.

It *was* a bare repo, but the config file had bare=false because
someone had simply copied a .git tree from a non-bare repo to make it.

The issue is that we just use this:

    int is_bare_repository(void)
    {
        /* if core.bare is not 'false', let's see if there is a work tree */
        return is_bare_repository_cfg && !get_git_work_tree();
    }

For the purposes of the error message it would be helpful if we also
detected whether something didn't have a working tree, but was set to
bare=false, and tell the user to updatet he bare=false to bare=true
for his almost-bare repository.
