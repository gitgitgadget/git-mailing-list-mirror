From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: patch-2.7.3 no longer applies relative symbolic link patches
Date: Mon, 26 Jan 2015 11:29:07 -0500
Message-ID: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 26 17:29:16 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YFmXK-0004Pz-Jz
	for glk-linux-kernel-3@plane.gmane.org; Mon, 26 Jan 2015 17:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417AbbAZQ3K (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Jan 2015 11:29:10 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:44100 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602AbbAZQ3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2015 11:29:08 -0500
Received: by mail-oi0-f42.google.com with SMTP id i138so7943014oig.1;
        Mon, 26 Jan 2015 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=NEVOO0lgO73fWCTDqHgLutqhYFXof1ttfw0S4hvKTfo=;
        b=Xp8HfXvuCatQZahwtToy/56MICqLXIyUsbmEyToLMKCCDnaMwbv+X9CMii/WZgwn9Y
         B+6apAU8jl6maU3gdnpKYLDWkZGhW1kPA8Nua0hqxJDhXNJqvXjMH5vXFbNWSj/pEm0T
         7oZBLwQb3v7Z2ZCrACEnLwT7nhdF1QfrSvyE58xNv2lSxQwQMZdrMXXH3kFBTIHfp9sn
         y43XGXy9lewuYtkWsi5xEe/wspBYMg/lOiMZk0g9cx5yVxhwI8Od5EDmYLmjZ+RJfkHV
         zWRc7GlotjhQD8k/m9CR14XdIHJO+SVAv+0kSr4O0TVSGAc3pKFqmAzGObMZsT5XBMXJ
         deeA==
X-Received: by 10.182.71.73 with SMTP id s9mr13575132obu.15.1422289747157;
 Mon, 26 Jan 2015 08:29:07 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Mon, 26 Jan 2015 08:29:07 -0800 (PST)
X-Google-Sender-Auth: XQmQ7eriBYg5IOK0o-RyMQA4D8Y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263033>

Hi,

I went to do the Fedora 3.19-rc6 build this morning and it failed in
our buildsystem with:

+ '[' '!' -f /builddir/build/SOURCES/patch-3.19-rc6.xz ']'
+ case "$patch" in
+ unxz
+ patch -p1 -F1 -s
symbolic link target '../../../../../include/dt-bindings' is invalid
error: Bad exit status from /var/tmp/rpm-tmp.mWE3ZL (%prep)

That is coming from the hunk in patch-3.19-rc6.xz that creates the
symbolic link from arch/arm64/boot/dts/include/dt-bindings to
include/dt-bindings.  Oddly enough, patch-3.19-rc5.xz contains the
same hunk and it built fine last week.

Digging in, it seems that upstream patch has decided that relative
symlinks are forbidden now as part of a fix for CVE-2015-1196.  You
can find the relevant bugs here:

https://bugzilla.redhat.com/show_bug.cgi?id=1185928
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=775901#13

Aside from locally modifying patch-3.19-rc6.xz, I'm not sure what else
to do.  I thought I would send a heads up since anyone that is using
patch-2.7.3 is probably going to run into this issue.

josh
