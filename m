From: David Turner <dturner@twopensource.com>
Subject: RFC: optionally reject case-clone branch names
Date: Tue, 27 May 2014 18:56:08 -0400
Organization: Twitter
Message-ID: <1401231368.18134.63.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 28 00:56:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpQIC-00037l-1m
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 00:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaE0W4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 18:56:20 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:60423 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbaE0W4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 18:56:19 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so15192540qgf.21
        for <git@vger.kernel.org>; Tue, 27 May 2014 15:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:content-transfer-encoding:mime-version;
        bh=xW0FqvHj1MO3zY4ehISIU+XYKL66pdnkBmEc+ZwGDMA=;
        b=hNjjoKrhRWNogHAD/GLYN4CWLRC3bOta1ZofLu2kABjBkzdXSKMbK13lAMwVrDWQ3o
         QpB56Kjv3PMOpYo4yISmcLIMno3RfeIzZIinNYJ+HUIa4ZkdkwU8D9c5lWUJzyEl3/1+
         pZbeVIXyBn5/SI8f4cYXkn1eNQjP6lsKcNK5clZlFxprd4uVCPK5bhoZQ4foRTZUsI47
         WANM3Z6qoS0aq1fVgxNgVH8g0IP2MmioOHJssuLxRJK2jhMoxvx7gSUbgMxfrpxhtwmq
         H9WPNmYaoLH66GyBdeeWSs2JowqkSQT2Cq1QMYFvLqYEp5ibw6ANt1kfXqGbrlXnA88a
         BM7g==
X-Gm-Message-State: ALoCoQmKGtKRUKpVJOsdM5hNb7nQsKFHOurSX7DbfMgAShGqxdvdpYxzTv6XX3aQfZi2Kf9RKo2b
X-Received: by 10.140.96.51 with SMTP id j48mr44375186qge.24.1401231378615;
        Tue, 27 May 2014 15:56:18 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id j7sm27325707qab.27.2014.05.27.15.56.17
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 15:56:17 -0700 (PDT)
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250246>

At present, it is possible to have two branches which are the same but
for case.  This works great on the case-sensitive filesystems, but not
so well on case-insensitive filesystems.  It is fairly typical to have
case-insensitive clients (Macs, say) with a case-sensitive server
(GNU/Linux).  

Should you attempt to pull on a Mac when you have case-clone branches
with differing contents, you'll get an error message containing
something like "Ref refs/remotes/origin/lower is at
[sha-of-lowercase-branch] but expected [sha-of-uppercase-branch]....
(unable to update local ref)"

Fortunately, nobody uses Macs for git servers, because on a Mac server,
if you push a branch called capital-M Master (that differs from
lowercase-m-master), nobody else can push to (lowercase-m) master until
the branch is removed.  Once the branch has been removed, it can no
longer be recreated.

I think a git client that used only packed-refs would not have any
problems with case-sensitivity of branch names, but I assume that there
are good reasons this hasn't yet been done.  At any rate, there are
plenty of older clients out there.

RFC follows:

1. On a case-insensitive server, git receive-pack ought to always reject
branches which are same-but-for-case of existing branches.
2. On a case-sensitive server, the same rule by default, with an option
to allow the old behavior.

Let me know if, should I write these patches, they would be likely to be
accepted.
