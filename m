From: Ori Avtalion <ori@avtalion.name>
Subject: A few questions about git-reset's reflog messages
Date: Thu, 21 Jul 2011 22:28:30 +0300
Message-ID: <4E287DDE.8020108@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 21:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjyvL-0006Nd-Re
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 21:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab1GUT2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 15:28:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46247 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab1GUT2f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 15:28:35 -0400
Received: by wwe5 with SMTP id 5so1546743wwe.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=L976fLugGvHWtALgjL2XiyJOWi4JIGeBOCMOEmusC4I=;
        b=wUOx2EoSatGS4qsyE51nWwFBImEN8f5ADCC3Glh++7jozCgFiNTLN3X5PIb2fdAA4I
         7ztJYFefD6a9L5hOLupsjJR5YxCM1RTSJRQMrBKuPLq+AmtbUq3zzWqqW/rTMY4qLaCZ
         0JcoN8K3EVJ9+EdjIKqWMyLwTkgymr5o4yUoQ=
Received: by 10.216.60.207 with SMTP id u57mr499597wec.89.1311276514655;
        Thu, 21 Jul 2011 12:28:34 -0700 (PDT)
Received: from [192.168.1.55] ([109.67.20.81])
        by mx.google.com with ESMTPS id 53sm1068161wel.31.2011.07.21.12.28.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 12:28:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177616>

Hi,

I noticed an inconsistency with the reset command's reflog messages.

The command:
    g reset <tree-ish>

Prints this reflog message:

    <tree-ish>: updating HEAD

Usually, actual lines from "git reflog" are:
640a027 HEAD@{0}: HEAD~1: updating HEAD
0657539 HEAD@{1}: 0657539: updating HEAD

This feels redundant and not very informative.

Is there any reason to print the tree-ish in the command? The 'raw' sha1
is already recorded in the reflog.

Why does the message not mention 'reset' in the beginning like (most?)
other commands?

I dug into builtin/reset.c to try and improve it, and came across a few
odd things, that I'd appreciate if someone would clarify:

* There is code to set a "updating ORIG_HEAD" reflog message, but I
can't trigger it. What use-case causes it?

* The part of the reflog message before the colon is composed by
args_to_str() which prints all of the arguments after the opts. This
seems redundant as the only form of 'reset' that updates the reflog is
one with a single '<commit>' argument after the options. What is there
for args_to_str to loop over?

Thanks,
Ori
