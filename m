From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 13:28:22 -0700 (PDT)
Message-ID: <5193efe6.c42ab60a.0319.5f2c@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 15 22:28:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UciJI-0006uQ-Ov
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 22:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444Ab3EOU2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 16:28:24 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40127 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab3EOU2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 16:28:24 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so2522200obb.2
        for <git@vger.kernel.org>; Wed, 15 May 2013 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:to:subject;
        bh=w56Ay/HIfIxTDL2/ZV/vsMRu5T8vv5QU2vRrlwY4UZs=;
        b=P9MRiTvNVUkZ708vNyoBSCvXHM/huIL2I3D6Fr6/BMw0dJV1MfhJ4IWgTHycIv/sQz
         /xd0YGTNUmoCEQjcf8pajxhsHnWUuSQqlqxdwn974MvZxbgET+Y6WnKApDb5WDlo1n/8
         PsKGBSpJrCsgroH1qRDiL6SR9kPpdtqclQzPhHAoVgCqaMfUKQ6uuo+vVBcnm0HlZLSN
         fI8eZCC8aV/cy3MusuW3PBwaf/unzlmHXTs9ZxzKlC+beU2FtHv16MF185QHBkyRK4o/
         TOZwtURcvLXvKDy8NrUKoEmpIk7iEjb6OkZU+iTcxtOuv6GXxOsh+SOCNxadzpgH4WWf
         zUgg==
X-Received: by 10.182.97.40 with SMTP id dx8mr17891859obb.54.1368649703624;
        Wed, 15 May 2013 13:28:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm4474209obl.1.2013.05.15.13.28.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 13:28:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224448>

Hi,

I've been using Git from the start, but only lately have I forced myself to
configure upstream branches for all my branches, and I've found a few things
more convenient, but others completely contrary to what I expected.

Inconvenient:

Before, I used to do 'git fetch' to simply fetch from 'origin', but now, it
depends on where 'upstream' is set to.

Convinient:

Now, I can just do 'git rebase --interactive' and I don't have to specify the
starting point, which is particularily useful when there's a lot of branches
one depending on another.

I think I'm using 'upstream' for something it was not intended to, and I think
the current 'upstream' behavior should be split into 'upstream' and 'base'.

== base ==

The 'base' branch will be set each time you create a branch from another;
'git checkout -b foobar master' sets 'master' as the 'base' of 'foobar'.

Then you can do 'git rebase foobar@{base}' or simply 'git rebase', and Git will
pick the right branch to rebase unto, even if you have no 'upstream'
configured.

This way 'git fetch' will keep picking 'origin', and other commands that make
use of 'upstrem' would be undisturbed.

If both 'base' and 'upstream' are defined, I think 'git rebase' should use
'base', but since that would break old behavior, perhaps there should be a
configuration variable to enable a different behavior.

I already started writting the patches, and although tedious, I think they
they'll be rather straightforward, but I thought it would be best to hear some
opinions first.

What do you think?

Cheers.

-- 
Felipe Contreras
