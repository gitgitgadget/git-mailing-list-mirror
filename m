From: Johan Herland <johan@herland.net>
Subject: Re: [RFC 06/11] Add support for mark references as path names
Date: Mon, 27 Jul 2009 20:26:45 +0200
Message-ID: <200907272026.46150.johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net> <1248656659-21415-7-git-send-email-johan@herland.net> <20090727141200.GJ11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVUuo-0005LO-QH
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbZG0S1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 14:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbZG0S1F
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:27:05 -0400
Received: from sam.opera.com ([213.236.208.81]:60391 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbZG0S1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 14:27:04 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n6RIQkEb007088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Jul 2009 18:26:51 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20090727141200.GJ11191@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124180>

On Monday 27 July 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > When using a mark reference as a path name, the mark reference will
> > be expanded to the 40-byte hex version of the object name
> > associated with the mark. This is useful e.g. when importing notes
> > objects (where the filenames in a notes tree are the object names
> > of the annotated objects).
> >
> > [...cut...]
>
> I'm worried about changing the path rules here.  Previously writing
> a path as :1 was legal and produced a file named ":1" in the top
> level directory of the repository.  Now it will create a file that
> matches a mark.
>
> I think you need to find another back door, something that the
> language wouldn't have considered as valid previously.

Ok. One (moderately hideous) option is to introduce new commands m/d/r/c 
that works just like M/D/R/C, except that they also expand mark 
references (leaving M/D/R/C with the old behaviour). I don't know how 
you'd feel about that...

However, I'm also pondering Dscho's idea of organizing note trees into 
hierarchies (to limit #entries in tree objects), and (although I have 
yet to try to implement this) it feels like this transformation should 
be done in the notes.c code, which means that it must happen on 
the "git side" of fast-import (at least the transformation should not 
happen on the "external side" of fast-import). This ultimately means 
that we cannot handle notes as "regular" trees and commits (which is 
what I'm trying to do with the help of this patch), and suggests that 
instead of using 'commit' with 'M' for adding notes, we should probably 
have a dedicated 'note' fast-import command that collects note objects, 
and does the tree transformation and subsequent commit upon 
checkpoint/exit.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
