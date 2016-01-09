From: Bryan Turner <bturner@atlassian.com>
Subject: for-each-ref output order change in 2.7.0
Date: Fri, 8 Jan 2016 18:07:37 -0700
Message-ID: <CAGyf7-FSP3Z7HO=LpoQck8q9sSj3fGYCx1=gNa6fXEkovxAxHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:07:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHi0N-0003LS-FT
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 02:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbcAIBHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 20:07:39 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35697 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbcAIBHi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 20:07:38 -0500
Received: by mail-wm0-f45.google.com with SMTP id f206so153792517wmf.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 17:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=w/4TrNWuHB+g1h9AdOrFnN7DmdVo+aGvGDDUL3X8RYE=;
        b=EwoR1lQ7o9IXQdbliIdUVs/EEUSAFJv/8RKgC0uceu8tt+CJwp5bIHHI0/GWBVtLws
         2YtsbtvKGpsKXQwwgFnbUIZw4QvBBZ+Nfgl0gut43nbUSy7XucJfienjYujm5LU8rN4t
         AEt3WUfbIL0MDTlhLXYa4g/7D5G1BqJRqiPPDCzGRwB+nogjxQdqaINTul/SQiSMCen6
         9DeMFtgwUpu+ERaQdWced1hmXmcBh4uleFbxPJ0T874DXXrRw3meYsxJE6ZfaR4CAqDx
         xCHBoRqLZXV2VApHb/uaSb9o4EH6n/VeiITNdwKgRfmf4TZPu8krCsZMNqoNtLZ5fz1N
         tEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=w/4TrNWuHB+g1h9AdOrFnN7DmdVo+aGvGDDUL3X8RYE=;
        b=hW37eePcvmF60Shc9TjSr6zRSjkO3rqz0Or7yD84jI0jT6otaFDysyoq9JhJeJJNwX
         NBYreZmeWLBwCGMmy/16Zpa+AulgjjnffD/uzxzzHaqAQ7kSa83qKG4oJB3yze6uMIQe
         t6RQFMcnYHQFcALKB64xgeNPI6LePMYe16PtQMPrL3W8jaGq0YYsqiqIFiml1fip0pta
         pAq6+ZHYCNzhJ6GXp2hg3y2/fUrBVE7hM6WAF1Tqj61DBnosPrKfrszF11Z6l/S39O5N
         Y7ezYb8rnmZM4rcKV6i5hTS9ev4y3o5ZHs7h0JXHBpt5mh49tiptk08E3AxvnABEU/AA
         WsKw==
X-Gm-Message-State: ALoCoQkJr/2HTG8p/A0Ul432un3D3y9yPTreDTiKjCPbnKVNIDkt8w4K8v3fFTnfDXlyYrqZs4cVFxaupwg8Eu/XlhGiY8enyiZ+FcTOfnKjBfMLsyIsR/M=
X-Received: by 10.28.175.209 with SMTP id y200mr1564870wme.70.1452301657556;
 Fri, 08 Jan 2016 17:07:37 -0800 (PST)
Received: by 10.28.137.2 with HTTP; Fri, 8 Jan 2016 17:07:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283594>

In one of our tests, we have a set of branches whose names are all
special characters (%, @, etc). Most of them branches have identical
tip commits and just have different names. In 2.7.0, when ordering by
-committerdate, the branches are now returned in a different order. I
don't think this is a bug, based on the commit it bisects to, but I'm
wondering if someone can confirm.

2.6.5 and prior (tested all the way back to 1.7.6, so this was
consistent for a long time):

refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/@#$% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100

2.7.0:

refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/@#$% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100

I've bisected this back to:

bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
9e468334b41c1d1fc715de177ef1f61a36c1cf01 is the first bad commit
commit 9e468334b41c1d1fc715de177ef1f61a36c1cf01
Author: Karthik Nayak <karthik.188@gmail.com>
Date:   Fri Oct 30 14:15:28 2015 +0530

    ref-filter: fallback on alphabetical comparison

The message for that commit indicates that sorting numerics (which I
assume is the implementation for committerdate) now falls back on
alphabetical for identical values, suggesting this order change is
actually intentional and correct. Is that right?

(Note: The alphabetical-ness of the branch names is reversed, which
seems logical given my original sort was -committerdate. A
--sort=refname looks like this.

refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/@#$% - >Tue Jan 3 17:00:51 2012 +1100
refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100

That's probably more correct too.)

Best regards,
Bryan Turner
