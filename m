From: Per Cederqvist <cederp@opera.com>
Subject: git log: invert --author and --committer
Date: Mon, 23 May 2016 11:54:45 +0200
Message-ID: <CAP=KgsSdX3pCRzeUVobrFWVGOGGSrwkO0MjFhUWruiajAxn38Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 11:54:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4mZY-0005jl-CZ
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 11:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbcEWJyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 05:54:47 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36691 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcEWJyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 05:54:47 -0400
Received: by mail-qk0-f171.google.com with SMTP id x7so103948962qkd.3
        for <git@vger.kernel.org>; Mon, 23 May 2016 02:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to;
        bh=rxZQhPsivbAnRLapd6vhnXtHlOlwuzu2jhxU70aiods=;
        b=sANzaV2hQBfbh+9kWR3RVi0RwqajSnIDL37fAettSQs79DjGLseVfrpQF5ExE0mdeE
         GEO7ibWbQVKMAvCVFdJ1uyviZ2/bnTQ9ARVWetPNFeGz3JyjA4D1ukavRXHwujUGIOMs
         93GVBo7Zm428ToKBhLYSIDnMEOiFI2gmqMp1ejJI5Cnh9ClkXOzTimlDqMGEsPK5r9wC
         ON2ut/2W2EJB0rX+LAgTk2LKVAHlIGdW8XzG+g3x2PrYhNo48Mj34gmgpbUOgjA8aUHY
         syqDi2ZlhCMgXDRxxYhkY/FBH/OT4rJHsPes7V4HWJP8PuxjNDg6YGRuPdJT/EaNPlSX
         YMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rxZQhPsivbAnRLapd6vhnXtHlOlwuzu2jhxU70aiods=;
        b=VSQEBuXqwOJHwSGa/u4fvmUHGsvG8wi+OMtLH6/YBpYuYrte6UWUx4/uSDFyT42X5H
         XKbMyKioWQo0XwPT9GJd4rbabL7pFklVlbAxEVQ/dyvQ9Q+foLgucEuUS8YJHPk2GWSO
         mXsJJia/rfav5RtYrVnUupzQWumHqS7zBRb2gmO3Uc6gdyQFtjAlqrFjDlPV66oXc2oG
         hbw1PrZuPLC/K7gZBNbXpydYgLbWRvbeq+FBn9l/CEnNNMiBtCH6fqCanruFBzVcVgB4
         3IFUaSKAyIKal9XAEyjmmRfLYOqEqp9VNI8vi6N9N2G5eiybSugTERi1I8wvIeONIbrL
         /G8g==
X-Gm-Message-State: ALyK8tIraO7om25dni6Os/mqzz7y2vIYRZsFKqVoV6SSTBzdtqDHBSZ+BjJCIl/GiMumbMk5oGi/Z0gYFoJqp/dI
X-Received: by 10.55.146.71 with SMTP id u68mr9127561qkd.30.1463997285864;
 Mon, 23 May 2016 02:54:45 -0700 (PDT)
Received: by 10.55.184.70 with HTTP; Mon, 23 May 2016 02:54:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295315>

We have a repository that mostly contains configuration data.
This is updated by our continuous integration build system, but
every once in a while there are also more interesting commits
made by humans.

For several years I have suffered in silence, wishing for a way
to do something like

    git log --author-not cibot

Today a friend told me that you can actually list all commits
except those made by cibot with this commandline:

    git log --invert-grep --author cibot

The documentation for --invert-grep should mention that it
also inverts the meaning of --author and --committer.  Perphaps
something like this would make sense?

    /ceder

diff --git a/Documentation/rev-list-options.txt
b/Documentation/rev-list-options.txt
index 4f009d4..ae12687 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -70,7 +70,8 @@ endif::git-rev-list[]

 --invert-grep::
  Limit the commits output to ones with log message that do not
- match the pattern specified with `--grep=<pattern>`.
+ match the pattern specified with `--grep=<pattern>`.  Also
+ affects `--author=<pattern>` and `--committer=<pattern>`.

 -i::
 --regexp-ignore-case::
