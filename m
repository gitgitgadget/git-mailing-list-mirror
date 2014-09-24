From: Daniel Brockman <daniel@brockman.se>
Subject: Re: Passing tar(1) options via git-archive(1)
Date: Wed, 24 Sep 2014 03:26:22 +0200
Message-ID: <87k34tizb5.fsf@brockman.se>
References: <87bnq6jhbk.fsf@brockman.se> <5421EAE4.30704@virtuell-zuhause.de>
	<20140924001522.GB6920@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 03:26:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWbLg-0004DZ-Ui
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 03:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbaIXB0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 21:26:25 -0400
Received: from brockman.se ([188.226.237.105]:33020 "EHLO brockman.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbaIXB0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 21:26:24 -0400
Received: from brockman.se (localhost [127.0.0.1])
	by brockman.se (Postfix) with ESMTPS id 5293E120A0E;
	Wed, 24 Sep 2014 03:26:23 +0200 (CEST)
In-Reply-To: <20140924001522.GB6920@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 24 Sep 2014 00:15:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257450>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Git does not invoke tar(1).  It has its own tar (actually, pax)
> implementation, so any options would have to be implemented in Git.
> We'd probably want to make such a change effective in the zip format
> as well.

Ah, I see...

Well, I guess in the meantime I'll just do this:

   git commit -m dummy --allow-empty --date=1970-01-01T00:00:00Z
   git archive HEAD | docker build -
   git reset HEAD~

Or even (slightly more atomically) this:

   git archive HEAD | { tmpdir=`mktemp -d` && tar x -C"$tmpdir" &&
     tar c -C"$tmpdir" --mtime=1970-01-01T00:00:00Z . &&
     rm -r "$tmpdir"; } | docker build -
