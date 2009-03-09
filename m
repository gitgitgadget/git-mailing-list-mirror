From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Generalised bisection
Date: Mon, 9 Mar 2009 01:40:08 +0000
Message-ID: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgUVF-0008SR-4h
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbZCIBkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2009 21:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201AbZCIBkO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:40:14 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:45912 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbZCIBkM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2009 21:40:12 -0400
Received: by fxm24 with SMTP id 24so1068368fxm.37
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 18:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=KESUDmBqUffIBoJJ31K00yOUqj5h0V1ERw3lDVSpLSo=;
        b=qBf92VULnjrzmQvu7D9UywP7z4wdYM8msbB1TZNCG0jn9MfVLVrICRxvoe9dU7Jnyv
         CHi5kKd28flTmj+ZwGIA097RDI9qBbeIVbMoV3G2GR5zLSd1w6gZohFziGxvgrydVKRa
         HoRtzghPSyGZxDVQWolf6KgzNfD+TPbDagC+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=aeBmqA+K46zFgKqJsg6wS0SHeEH3+/Jqy1oFDUF/uwOZzRK3OJg428IGcWqVQPzaN2
         eF2Md/vG9g187z2FNI6d5+9C3PXFWBUZRakMOdIQN3rOeyvesHOkXfkff7qvzP2DT+oW
         ZNve6a3DaCT1whMnPVi92yjOO6m1jXl8zUaVY=
Received: by 10.181.148.2 with SMTP id a2mr1837478bko.117.1236562808452; Sun, 
	08 Mar 2009 18:40:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112668>

[whoops, mail server does not like html. trying again...]

Hi,

I have developed a generalised bisection algorithm, for the case where
a bug is intermittent. The code may be found at
git://github.com/Ealdwulf/bbchop.git. It should be considered
experimental.

This should cover the use cases requested by Ingo
(http://article.gmane.org/gmane.comp.version-control.git/108565) and
John=A0 (http://article.gmane.org/gmane.comp.version-control.git/112280=
),
although it does not work in the same way as your proposed solutions -
it is intended to be more general, working when the bug is not
almost-deterministic. It is based on Bayesian Search Theory
(http://en.wikipedia.org/wiki/Bayesian_search_theory, although that
description is a bit simplistic) which is usually used to find
submarines, or people lost on mountains.

To try it out, you need python and mpmath (from
http://code.google.com/p/mpmath/ or your distribution).
Once your have obtained the source, you can immediately run BBChop/sour=
ce/bbchop
which is the main driver program.

It is not currently integrated into git, although doing so should only
involve minor scriptery.

The simplest way to try it out to is run it in manual mode:


>=A0=A0 bbchop -l 10 -c 0.9

This means, search in a linear history of 10 revisions, numbered 0 to
9, until bbchop thinks it has found
the faulty location with probability at least 0.9. It will start
asking questions:

] Most likely location is 0 (probability 0.100000).
] Please test at location 3.
] Target detected at 3? Y/N/S(kip)

Eventually the search will terminate and BBChop will print out its
conclusion, with evidence, eg:

] Search complete.=A0 Most likely location is 3 (probability 0.919614).
] Number of tests at 3: 3 of which 1 detected
] Number of tests at parents of 3:
]=A0 =A0=A0=A0=A0=A0=A0 At 2, 5 of which 0 detected

More information canbe found in the readme file.

=46eel free to reply with any comments, questions, etc. If anyone tries
it out on a real bug, please let me know how it goes.

regards,

Ealdwulf
