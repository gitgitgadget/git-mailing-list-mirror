From: "=?ISO-8859-1?Q?Johan_S=F8rensen?=" <johan@johansorensen.com>
Subject: git-daemon hangs in futex()
Date: Thu, 28 Feb 2008 23:41:41 +0100
Message-ID: <9e0f31700802281441i33120d70s43ca9f4eced6b5c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 23:42:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUrSK-0004gU-Hq
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 23:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbYB1Wlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 17:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbYB1Wlp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 17:41:45 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:16821 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbYB1Wlo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 17:41:44 -0500
Received: by ti-out-0910.google.com with SMTP id 28so3272869tif.23
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 14:41:43 -0800 (PST)
Received: by 10.151.44.18 with SMTP id w18mr3045898ybj.184.1204238501682;
        Thu, 28 Feb 2008 14:41:41 -0800 (PST)
Received: by 10.150.97.16 with HTTP; Thu, 28 Feb 2008 14:41:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75471>

Hi,

I'm having an issue with my git-daemon (1.5.4.3 on ubuntu gutsy), it
works fine for a few minutes, then it hangs (eg, "git clone git://"
never comes past "initialized empty git repo" adnd just sits and
waits) and strace on the git-daemon says:
$ strace -Ff -p 27453
Process 27453 attached - interrupt to quit
futex(0x2b270fb50980, FUTEX_WAIT, 2, NULL) = -1 EINTR (Interrupted system call)

.. and nothing more. But, if I attach to the git-daemon process with
strace before that happens, git-daemon keeps on working fine, so I can
change the outcome by observing it which is always nice, but not too
helpful.
I don't think this is related to Wincents problem some time ago[1],
because I can reproduce this when running dashed/dashless and
with/without --detach regardless of my env. Here's my git-daemon args:
/usr/local/bin/git --exec-path=/usr/local/bin daemon
--base-path=/home/git/repositories --verbose --export-all
--pid-file=/home/git/run/git-daemon.pid --detach

I'm not even sure if this is directly related to git or if it's some
other library causing the futex wait, any hints would be greatly
appreciated.

[1]: http://kerneltrap.org/mailarchive/git/2008/2/5/732214

Thanks
JS
