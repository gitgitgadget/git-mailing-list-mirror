From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Significant performance waste in git-svn and friends
Date: Wed, 5 Sep 2007 22:19:41 -0400
Message-ID: <20070906021941.GF18160@spearce.org>
References: <20070905184710.GA3632@glandium.org> <7vd4wwj16d.fsf@gitster.siamese.dyndns.org> <85bqcghktl.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:19:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT6yG-0007In-BE
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbXIFCTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbXIFCTs
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:19:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35586 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbXIFCTr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:19:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT6xv-0005d7-NZ; Wed, 05 Sep 2007 22:19:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AE3DF20FBAE; Wed,  5 Sep 2007 22:19:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85bqcghktl.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57800>

David Kastrup <dak@gnu.org> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Mike Hommey <mh@glandium.org> writes:
> >
> >> The same things obviously apply to git-cvsimport and other scripts
> >> calling git-hash-object a lot.
> >
> > I wonder if letting fast-import handle the object creation is an
> > option, though.
> 
> I think it would be saner to give git-hash-object an operation mode
> that makes it usable as a pipe-controlled daemon, so that one needs
> not fork and exec for interning another object.  That way, porcelain
> commands could keep one bidirectional pipe (feed object type and
> source and whether to use -w into git-hash-project, receive object id)
> to git-hash-object around until they finish.

Aside from getting the hashes back from fast-import, that's what
fast-import is for.  I could also make it disable writing.  Hmm.
Junio and I were just talking about making fast-import send the
marks table back out on stdout.  This would make it easier for a
frontend process to stream a whole bunch of objects into the process,
then get back all of their SHA-1s.  Less context switches and more
parallel operation.

-- 
Shawn.
