From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: GIT push to sftp (feature request)
Date: Mon, 6 Aug 2007 09:12:41 +1200
Message-ID: <46a038f90708051412p722aa906v73e986a805f1558b@mail.gmail.com>
References: <200708051105.44376.pavlix@pavlix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pavlix <pavlix@pavlix.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 23:12:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHnP4-0000aO-D0
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 23:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbXHEVMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 17:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXHEVMn
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 17:12:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:56003 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbXHEVMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 17:12:42 -0400
Received: by wr-out-0506.google.com with SMTP id 36so387642wra
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 14:12:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HXwoviZcAAz2L7qQPTBRtzete8ZT9N4ommt2uysa22gRas25p+HIa/ic2R1NB/N+u4VEbSQ70AHJdIXOw4yQNiVlQJG+/AqI2EKsh7MeWORJ2dc9vIXJouTQT6GggFkvrbqB44QYsVZ2IZ4u4GE5Nx5ksq+ARrb6TzKC5GPu9qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hFyVicdf2xBi3DS8BIF6bfGjLgXUujYeZZlkiMY4hTw6fizCotGBU26bwpj/rbaT4KGoGXLsX8kjNbT+4BW+Bcnsa3HEAUphDBkIqf9xKaN7LPggLx9XBmN4rB+HNbeRMB1nT5EtUIGt6pfSeWqTuB55BvpDdTV3cviDV6YoeHo=
Received: by 10.90.27.13 with SMTP id a13mr4183495aga.1186348361084;
        Sun, 05 Aug 2007 14:12:41 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Sun, 5 Aug 2007 14:12:41 -0700 (PDT)
In-Reply-To: <200708051105.44376.pavlix@pavlix.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55072>

On 8/5/07, pavlix <pavlix@pavlix.net> wrote:
> Did I miss something?


Unfortunately, git does not "push" over protocols that cannot execute
git on the remote server. We call them "dumb protocols" and if you
search this list for that name, you'll find lots.

Git tries to be smart in at least 2 ways that don't work with dump
protocols: it works locklessly (yet it performs atomic updates) and it
sends only the objects needed over the wire (saving a lot of
bandwidth).

Using dumb protocols it's impossible to do either. And these days it's
not that hard to setup git (or any other binary) to execute at the
remote end.

Bazaar-NG and others do support dumb protocols, and (I think) they do
it by using one big lock over the repo. But the lock is not safe, and
things can (and do) go wrong with weak locking schemes.

git used to support rsync -- but I don't think that works anymore for
pushes. Other than git over ssh, perhaps you can try the apache module
that implements git over http?

hope that helps,



martin
