From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: cygwin: push/pull takes very long time
Date: Thu, 2 Mar 2006 14:26:06 +0100
Message-ID: <81b0412b0603020526w7db41994v54a96895c1a6e960@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Mar 02 14:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEnov-00064g-T2
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 14:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWCBN0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 08:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCBN0K
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 08:26:10 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:31951 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751458AbWCBN0J convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 08:26:09 -0500
Received: by nproxy.gmail.com with SMTP id n29so273375nfc
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 05:26:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BcjC/Q8tUAYiS+9MgtyDUnTNoV8A8p68zZyzk0YClMpj3qWATbPEQoSng1eS/VtmlfGXlxwRFShsNYNq64KJHQ95UzEWF1Mjz2lyJlw8Fsr5avMInx9gCPx+Qu0gwd97OhkLvZH6skbor2lx5U3ERe6mFteNUEV6MYCFqziwUkA=
Received: by 10.48.244.5 with SMTP id r5mr183521nfh;
        Thu, 02 Mar 2006 05:26:06 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 05:26:06 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17068>

Hi,

I didn't really notice when it happened, but since some time
push and pull takes *very* long. git-pack-objects appears to
be the major offender:
$ git pull ../src march:march
Generating pack...
Done counting 20238 objects.
Result has 12 objects.
Deltifying 12 objects.
   8% (1/12) done

It's still working, half an hour since it was started.
It can be seen that it is constantly growing and shrinking
(for about 20k,50k,80k,100k back and forth).

I did a small instrumentation to figure out how much
and how often is allocated, but it's waiting for the
git-pack-objects to finish. "Counting objects" was
slow too, with git-rev-list "pulsating" in a similar
way (most commonly allocated objects in the size
range from 16 to 256).

I continue looking for the problem (I didn't do bisect yet,
want to wait for mem profile first), but any ideas on how
to fix that are very welcome.
