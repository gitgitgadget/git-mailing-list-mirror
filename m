From: Brad Hein <linuxbrad@gmail.com>
Subject: git fails: segfault at 0 ip 00000000004076d5 sp 00007fff7806ebc0
Date: Fri, 12 Oct 2012 00:58:21 -0400
Message-ID: <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com>
References: <CAJa+X0OkzAX9E2SnDmU=on0yzzVZ9OMa2dJZgKMK=gQu2Rhf_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 06:58:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMXKb-0000M6-7f
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 06:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab2JLE6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 00:58:24 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:48194 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab2JLE6X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 00:58:23 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1748155lag.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 21:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=PPN2e6QpmsbogjJz0BO0rq1xX/cyHDWA9YTJm17i84c=;
        b=HKNQWNMH7aFv3YyLQCyL9i9iTDJy4zdFJJm8FbfO5bLZNjiaGV160rQII5jEtXkhCb
         ezBAaxAdWPOBDFVbe/7ES5z0Ty84wILnvapa/6AQzEehmIbJiUsdU5ZrkqJ3xZc3VG8c
         67FAjyQiPXL34Gz2tnEdMt3BJ4265gIaK8XVQY+QaSUB3bmIkjEfDnf39IvfggTjH3Bn
         g2tcsEpJQ3qqT81jXFNypAwV3ncg86IaqxvCDbBadJvXa7D7xXrsAFwseRZk5qQ5IiRY
         e5RTt5PYrjI9KkG2v5NUKEqzpQOWvKoAi029+63BIymhRqFvftmAsFHV4Amm9WW2UoxO
         kCSg==
Received: by 10.152.122.11 with SMTP id lo11mr2881957lab.3.1350017901965; Thu,
 11 Oct 2012 21:58:21 -0700 (PDT)
Received: by 10.112.112.38 with HTTP; Thu, 11 Oct 2012 21:58:21 -0700 (PDT)
In-Reply-To: <CAJa+X0OkzAX9E2SnDmU=on0yzzVZ9OMa2dJZgKMK=gQu2Rhf_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207528>

In Fedora 17
With git-1.7.11.7-1.fc17.x86_64 (rpm)

I try to clone a particular repository but git just returns, having
not cloned the repo. Seems like a bug. Details follow:
  $ git clone http://gnuradio.org/git/gnuradio.git

While the command fails a message is logged to syslog. Repeated
attempts to clone the repo yield the same result:
  Oct 11 21:38:25 localhost kernel: [662703.442645]
git-remote-http[25796]: segfault at 0 ip 00000000004076d5 sp
00007fff7806ebc0 error 4 in git-remote-http[400000+96000]
  Oct 11 21:39:00 localhost kernel: [662737.899829]
git-remote-http[25837]: segfault at 0 ip 00000000004076d5 sp
00007fff37c5ef20 error 4 in git-remote-http[400000+96000]
  Oct 11 21:39:25 localhost kernel: [662763.341248]
git-remote-http[25873]: segfault at 0 ip 00000000004076d5 sp
00007fff6310d470 error 4 in git-remote-http[400000+96000]

A tcpdump reveals that the last thing the client does is requests a
file that doesn't exist on the server (404). Details are in my post on
FedoraForums: http://forums.fedoraforum.org/showthread.php?p=1607891&posted=1#post1607891

Problem mitigated by downgrade to "git-1.7.10.1-1.fc17.x86_64" or
"git-1.7.11.4-3.fc17.x86_64" or try to clone a different repository.
