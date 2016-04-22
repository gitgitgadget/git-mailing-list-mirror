From: Gennaro Torre <gtorre@tumblr.com>
Subject: issue upgrading git from 1.8.2.1 to 2.8.0
Date: Fri, 22 Apr 2016 18:44:02 -0400
Message-ID: <CA+UAp04e9-CcUJ+2fheHGw1q6MS6smyHhvyw34NeoT7HbKgnnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:44:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjo2-00048Q-KD
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbcDVWoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:44:05 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38409 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbcDVWoD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 18:44:03 -0400
Received: by mail-wm0-f44.google.com with SMTP id u206so46598746wme.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tumblr.com; s=google;
        h=mime-version:date:message-id:subject:from:to;
        bh=qxSt4hALUGM4jhweM1Lt9LRQMnYC6tWO4HkUXLY6Ko0=;
        b=ODwsZZuq9KWhX2CuOrT/a3ML01mSE5j81Y3JmjX3kpv7B6Ktaa+Ke0HGiD/LIJpJUx
         eT8SfbYjmSc6/kYiHrMPfZgvkwWHLyAFmarhjrPayJpQspIOkx4tLDwNACLs2THVlxAr
         BPSmDo1VGIqm7aJzzZmSsZJE574PyBL4vX9Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qxSt4hALUGM4jhweM1Lt9LRQMnYC6tWO4HkUXLY6Ko0=;
        b=FmvX3IpkrCV4Y3V+ZYKiJHmY5saBy6dnmFHTfXBxuFfrpg0dkn37Dfdja/JIwr5m0r
         Lh8pYvkG5RsW7sdAplFTkedtPiM3dJAe6i2UGhJBru7pKZ/9QQ6eNThO2rx96tsdmA2y
         WBgelnf7BFZpqChNUr1rQQ3NGlZ/wUlRj3ZEgO2Nt0FdsBCU3Scbc+QfsTARHUC6tYy9
         oOywlig0VG0YQotW2OFuQJRgE3DF/IFRUe3974hB0iqr0A0HAHNO5tfs+8Wsuw/AMKNj
         geIepRVJ7HTLx2d8s8OlAuAUknXPfWgd+ndiSgeUPmhqnwEdCUnNiC/Tk/qDd68THVyr
         o2Sg==
X-Gm-Message-State: AOPr4FUFn6QNDjESZzswQvGc7W2pwXVP6pfmucg9ut7sMgmyTmC47xi3Mk//TfnJQu70eDc7OmH+r40wI1YgippA
X-Received: by 10.194.16.8 with SMTP id b8mr22254593wjd.51.1461365042293; Fri,
 22 Apr 2016 15:44:02 -0700 (PDT)
Received: by 10.28.167.129 with HTTP; Fri, 22 Apr 2016 15:44:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292286>

Hi,

Last week we upgraded git from 1.8.2.1 to 2.8.0. We saw some very
weird behavior where git clones and pushes were working, but git fetch
was not.

Here is our setup:

We have 10+ nodes caching a few repositories, the repos were
originally cloned via git 1.8.2.1 with `git clone --mirror <repo>`

We have 3000+ nodes that take deploys using the git protocol, via `git
fetch`, the existing repositories were also cloned via git 1.8.2.1
from the caching nodes.

When we upgraded to 2.8.0, all nodes received the upgrade.

We observed that when we tried to deploy code to the nodes (they run
`git fetch` to update the repository) this would fail.

The fix: we deleted the repositories originally cloned via git
1.8.2.1, and did a `git clone <repo>` dropping a fresh repository that
was cloned using git 2.8.0. Everything started working correctly. Our
running theory here is that there was some incompatibility with the
repositories cloned with the old version of git, and trying to run
`git fetch` with the newest version of git.

Thanks,
Gennaro
