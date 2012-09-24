From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git pull transfers useless files
Date: Mon, 24 Sep 2012 19:51:20 +0200
Message-ID: <CAB9Jk9BcusbERNW0ZTsuq6xd7onOuggfTxJnf7D_USNv-uhC1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 19:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGCod-0001qC-8o
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 19:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab2IXRvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 13:51:21 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45713 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab2IXRvU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 13:51:20 -0400
Received: by vcbfo13 with SMTP id fo13so6624802vcb.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6eB9Pb/N8+XZi3nA+nBrdejbGs/P2t2GVIfNG901JkE=;
        b=x0Cv5rNEP9McdgXqO7SIAGhNZyBcKHU9MatooDQ055nnEUdjx2FR/OzcWaWfVVvBfS
         67OSNfgVYJZxkVjVPb/7q73AwTDw9Jd+jww2dogiDyVAwN1yFv1f4+KnDkTV/8SEhv29
         Fw5Vt8ZtGcL7XaishgmbmQQVERNO2I46NzfF/vcoWsfeFTRCyE5S0YPzGkoAgSGzBuTy
         01eF9M8ltoty/8sjaw40RKWGzuihEdOxeXOpl/n9dr1JcScicTVGPUltcGYWnQLgoiqd
         iL0KUHhvERpj9pmNL+U0ECTWsE8EsP1+cHr2d6ClfEzxt5vFhzSsQfS5c4Ti3CWD3YeS
         Zw4w==
Received: by 10.220.228.131 with SMTP id je3mr7791115vcb.73.1348509080056;
 Mon, 24 Sep 2012 10:51:20 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Mon, 24 Sep 2012 10:51:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206301>

Hello,

git pull transfers useless files when called with the --squash option
and merge=binary
attribute.
Consider the following example:

#!/bin/bash

set -v
cd remote
rm -rf * .git/
git init
echo '*.pdf -crlf -diff merge=binary' >.git/info/attributes

touch f1
git add f1
echo "aaa" >f1.pdf
git add f1.pdf
cp <very large pdf file, some 100 Mbytes>.pdf f2.pdf
git add f2.pdf
git commit -m A
cd ..

cd local
rm -rf * .git/
git init
echo '*.pdf -crlf -diff merge=binary' >.git/info/attributes
git remote add remote ../remote

touch f3
git add f3
git commit -m B
git checkout -b develop

echo "bbb" >f2.pdf
git add f2.pdf
git commit -m C
git pull -v --squash remote master

ls
cat <f2.pdf

set +v

Replace <very large pdf file, some 100 Mbytes>.pdf with the path of a pdf file
that is really large and run it.
When it executes the git pull it spends on my computer some 30 seconds,
obviously transferring the pdf file, that then it disregards because of the
merge=binary attribute.
When a commit contains many binary files, the command spends a lot of
time needlessly.

Is it possible to optimize it?

Thank you
-Angelo Borsotti
