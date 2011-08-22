From: Elijah Newren <newren@gmail.com>
Subject: Is there a scriptable way to update the stat-info in the index
 without having git open and read those files?
Date: Mon, 22 Aug 2011 16:28:26 -0600
Message-ID: <CABPp-BEiN7ffNmvLCvEfz056M_F36j+gV9t6J9-x_=H9q0rZFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 00:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvcyv-0006hi-3W
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 00:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab1HVW22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 18:28:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39192 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab1HVW21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 18:28:27 -0400
Received: by fxh19 with SMTP id 19so3561289fxh.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KXVRhXAQ9mLF8vqniWE3TbRGPO7e9JcEtGfxmQhZsH8=;
        b=x2bE6qmxreLlsbVRNCcqoTdhuCIM1d8lrKKfG0yxX4aPIXUpKEqifj+ActZokAdH8d
         pukfH4kPf3fHYQmPhMVo+lObECiFOC7YONvUMgUSXxzs1kxB6ORhggqsRa6TFqczkuMq
         oFh6zySUQsVVrNd4pTqcr/pO7bW+vnlgLE9Ms=
Received: by 10.223.28.10 with SMTP id k10mr4314942fac.128.1314052106670; Mon,
 22 Aug 2011 15:28:26 -0700 (PDT)
Received: by 10.223.134.84 with HTTP; Mon, 22 Aug 2011 15:28:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179897>

Hi,

I want to do something really close to
  git update-index -q --refresh
However, I want it to assume the files in the working tree are
unmodified from the index (i.e. don't waste time opening and reading
the file) and simply update the stat information in the index to match
the current files on disk.

Yes, I know that would be unsafe if the files don't have the
appropriate contents; I'm promising that they do have the appropriate
contents and don't want to pay the performance penalty for git to
verify.  Is that possible?


A little more detail, for the curious: I have a script that is, among
other things, renaming large numbers of files.  Calling 'git mv <old>
<new>' on each pair took forever.  So I switched to manually renaming
the files in the working copy myself, and using git update-index
--index-info to do the renames in the index.  The result was _much_
faster, but of course that method blows away all the stat information
for the relevant files and causes any subsequent git operation (after
my script is done) to be slow.  I inserted a 'git update-index -q
--refresh' at the end of my script to fix that, but that is much
slower than I want since it has to re-read all the affected files to
ensure they haven't been modified (however, it isn't as slow as
forking many git-mv processes).  I've tried to look for a way to speed
up this update, but haven't found one.  Did I miss it?

Thanks,
Elijah
