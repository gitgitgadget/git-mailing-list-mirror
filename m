From: Mark Lodato <lodatom@gmail.com>
Subject: [BUG] bare repository detection does not work with aliases
Date: Thu, 7 Mar 2013 17:47:45 -0500
Message-ID: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 07 23:48:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDjc3-0005ZV-OC
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 23:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab3CGWsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 17:48:08 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:59471 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab3CGWsH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 17:48:07 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so802051obc.20
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 14:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=7vh5U9SeUgOxk+sMBb39oaoHzLUFMS/XkHvVRbT32ko=;
        b=xJdhb+gJ9MQ1yJkZsUQ0XuRzjVU4ONOah+e9XQ9WUKDV7lLNfS8op5mdOW8Z68bHMy
         q5l8/dzhHqmju7aRQeyWiqliJ+tdluF9AKSr17JRMZHjwyVMk9k57fniDqmqL9daRtCG
         N7TDi3Fhnu/tZMUzL/xiIA7UuUJAOfHcCyodG99ooVMFFX5bMDkTjRi1MLWkSYSnOEgr
         gm+AFWQyMJQvf332cJqWwx7KBRXDwnkB926jmbMt06ZBMLmnb03xo1rORVZQj2m1WMYO
         X2JpMRPkh3nX2KNbQunZbYhh303EJttTVEB7hbdzgVp3Y3M5cdNo3eh+6bq340VwLLuJ
         vcbA==
X-Received: by 10.60.22.69 with SMTP id b5mr18078oef.38.1362696485707; Thu, 07
 Mar 2013 14:48:05 -0800 (PST)
Received: by 10.182.112.103 with HTTP; Thu, 7 Mar 2013 14:47:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217624>

It seems that the fallback bare repository detection in the absence of
core.bare fails for aliases.

$ git init --bare foo
$ cd foo
$ git config alias.s 'status -sb'
$ git s
fatal: This operation must be run in a work tree
$ sed -i -e '/bare =/d' config
$ git s
## Initial commit on master
?? HEAD
?? config
?? description
?? hooks
?? info/
$ git status -sb
fatal: This operation must be run in a work tree

The reason I am using the fallback is to use a single bare repository
with multiple working directories (via git-new-workdir) as suggested
in 8fa0ee3b [1].

[1] https://github.com/git/git/commit/8fa0ee3b50736eb869a3e13375bb041c1bf5aa12
