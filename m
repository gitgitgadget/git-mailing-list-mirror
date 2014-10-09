From: Derek Moore <derek.p.moore@gmail.com>
Subject: Some PRETTY FORMATS format:<string> options don't work with
 git-archive export-subst $Format:$
Date: Thu, 9 Oct 2014 10:56:19 -0500
Message-ID: <CAMsgyKb_-Xm0DH1-xVZa0XHs59nZsOxGwwLWKx-YiTmsJtrFHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 17:56:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcG4m-0002e3-Fx
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 17:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbaJIP4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 11:56:21 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:65472 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaJIP4U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 11:56:20 -0400
Received: by mail-oi0-f52.google.com with SMTP id a3so3452627oib.11
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ussu4+d5mdCMl88Ld/WdH9XTaUzV648Wb9Pn7PrWQCg=;
        b=wwRGnXPkGA7RWT1skCuzq5fWelAZ8a5C0EebFv0l1AJKCJKlFK2aGHVmKFDaIXSf8r
         EBh4jeYV0afw1ST9TYOK5RWkHXXEKMfP6PImzfyKZUAe+YQZBhon6vZ3t+wuQZjw4qWU
         c3mz7tt5abOOdK3JGZJuDLnBITFI2qMyQjDkMQ6uXFVmQZtitqe9nav8G0/bbQaWEthC
         wjT96DNgVKU97BQz4t6rzYmar9xt2kKHnYIg787KWEMFL/8/Zmy/oaqTxwPHY8eddfOR
         4QiL5hJfSGXVUmnKmaWFnS60VWhHI/inZHE9/XJTFgbH6dR3/NhOaomDtDmYFxMaqPmd
         loQg==
X-Received: by 10.182.74.165 with SMTP id u5mr24417822obv.65.1412870179511;
 Thu, 09 Oct 2014 08:56:19 -0700 (PDT)
Received: by 10.76.33.68 with HTTP; Thu, 9 Oct 2014 08:56:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I first noticed this using the system git provided in Fedora 21, so I
cloned the official git repo, built from source, and it would appear
there are even more options that don't work with export-subst in the
latest code.

I tested this under commit 63a45136a329bab550425c3142db6071434d935e
(HEAD, origin/master, origin/HEAD, master).

Take, for example, the following script:

FILE=Foo.pm
DIR=$(mktemp -d /tmp/git.XXXXXX)
cd $DIR
git init
echo '*.pm export-subst ident' >> .gitattributes
echo '#   Last Author    : $Author: $Format:%an$ $' > $FILE
echo '#   Last Date      : $Date: $Format:%ai (%ad)% $' >> $FILE
echo '#   Last Version   : $Revision: $Format:%d$ $' >> $FILE
echo '#   Last Version v2: $Revision: $Format:%D$ $' >> $FILE
echo '#   Last Commit    : $Commit: $Format:%H$ $' >> $FILE
echo '#   This File      : $Id$' >> $FILE
echo 'our $VERSION = (qw($Format:%N$))[1];' >> $FILE
git add .
git commit -a -m "Initial commit."
git notes add -f -m '$Release: 0048 $'
git tag -f releases/R0048
git archive HEAD $FILE | tar xf - --to-stdout
rm $FILE
git checkout -- $FILE
cat $FILE
git log --format='%N' -1


You can tell I'm attempting to recreate CVS keywords (bwahahaa!) for a
project that is insisting they need them.

I'd be happy to write a bunch of unit tests for export-subst and all
PRETTY FORMATS format:<string> options, if that would be desirable. I
see the t/ directory, and the t/test-lib.sh stuff looks simple enough
(TAP in bash, hmm).

Thanks,

Derek
