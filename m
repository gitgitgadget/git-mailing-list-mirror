From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 20:47:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708072045260.25146@woody.linux-foundation.org>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site>
 <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>
 <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>
 <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
 <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
 <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
 <alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org>
 <7vejif56a2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 05:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIcWm-0006NS-Gk
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 05:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762817AbXHHDsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 23:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761883AbXHHDsD
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 23:48:03 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39904 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761114AbXHHDsA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 23:48:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l783lU3I009142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Aug 2007 20:47:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l783lOND019290;
	Tue, 7 Aug 2007 20:47:24 -0700
In-Reply-To: <7vejif56a2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55297>



On Tue, 7 Aug 2007, Junio C Hamano wrote:
> 
> > @@ -2023,6 +2027,12 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
> > ...
> > +static void close_or_die(int fd, const char *file)
> > +{
> > +	if (close(fd))
> > +		die("unable to close %s (%s)", file, strerror(errno));
> > +}
> > +
> 
> And I like this even better ;-).

Gaah, that was unintentional. Just random noise I had in my tree, and 
didn't even realize made it into the patch.

That "close_or_die()" was because I saw somebody report a write error 
without the error string, apparently because the error only got reported 
on the close (probably NFS). This way you see if the reason the close 
failed was due to out of diskspace or whatever.

But I should have split them up properly - the close_or_die() part 
obviously had nothing to do with the O_BINARY part. Feel free to take it 
regardless, or split it yourself.

		Linus
