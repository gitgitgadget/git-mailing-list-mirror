From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PULL svn-fe] Re: Portability: returning void
Date: Tue, 29 Mar 2011 23:41:16 -0500
Message-ID: <20110330044116.GB2793@elie>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie>
 <20110330033017.GA18157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 06:41:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4nDj-00084x-Rz
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 06:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044Ab1C3ElW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 00:41:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62599 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1C3ElV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 00:41:21 -0400
Received: by yxs7 with SMTP id 7so378445yxs.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 21:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Imj8tKXFR2fwRGutHlVt49vexXJT5E4JEgfy9h4IRds=;
        b=M5EtdkR3/Dg7BYYDGQZmGggyHrvFV62qh30uLQ7iM+9mzjWS5UjibcOIjxxYfV0wh+
         VvAsvZcYLG//66kjsaV/y2p6bBT6O5x7/s+Mp7hNVdZtAn5UVrLtxD9pnTEYawFj7mku
         NjA3Hl/C29bHtv8zFjpxpYZeI9BaBFmPt611E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HI3SQ7R9qKagxQ5PXFtVzL+YMOUzikGTFvcj1jSB0bLm4kIFoO8T7jyMbklQjBTdsg
         FS2C41ljm2poUx+gfOCJGj6UYSXkZzn+LyI+EUkkwoSP7TsIBx+wPSKxBbKWoTqSCltx
         wCAVnBD6hjleSEHKWd/ed7h3qeCZeFcj5qrCo=
Received: by 10.236.180.232 with SMTP id j68mr1028612yhm.353.1301460080771;
        Tue, 29 Mar 2011 21:41:20 -0700 (PDT)
Received: from elie (adsl-68-255-111-103.dsl.chcgil.ameritech.net [68.255.111.103])
        by mx.google.com with ESMTPS id h44sm2851709yhm.62.2011.03.29.21.41.18
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 21:41:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110330033017.GA18157@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170354>

Jeff King wrote:

> After thinking on it more, I figured out an elegant fix.

All right, thanks again for this.

I really do want to address your "while at it".  I'm pretty
uncomfortable with the "sleep 100" --- it might be better to do "exec
perl -e sleep" so there is no chance that some incredibly slow system
won't make the race.  Or a failure mode that does not involve a long
hang would be even better.

Anyway, to make others' life better quickly I've pushed out the easy
part of your fix.  It sits with the fixes to other embarrasing bugs.

  git://repo.or.cz/git/jrn.git svn-fe

Jeff King (1):
      tests: kill backgrounded processes more robustly

Jonathan Nieder (2):
      vcs-svn: add missing cast to printf argument
      tests: make sure input to sed is newline terminated

Michael Witten (1):
      vcs-svn: a void function shouldn't try to return something

 t/t0081-line-buffer.sh |   12 ++++++------
 t/t9010-svn-fe.sh      |    8 ++++++--
 vcs-svn/fast_export.c  |    3 ++-
 vcs-svn/svndump.c      |    3 ++-
 4 files changed, 16 insertions(+), 10 deletions(-)
