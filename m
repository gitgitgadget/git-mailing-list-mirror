From: Johan Herland <johan@herland.net>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 19:22:47 +0100
Message-ID: <200801171922.48343.johan@herland.net>
References: <478E1FED.5010801@web.de> <16D4755D-EAEC-4F4A-B6B4-F262A6841F66@wincent.com> <7vfxwwjpv3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>,
	Pedro Melo <melo@simplicidade.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZfX-00032i-Ot
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbYAQSkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbYAQSkW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:40:22 -0500
Received: from sam.opera.com ([213.236.208.81]:48081 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbYAQSkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:40:21 -0500
X-Greylist: delayed 1024 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2008 13:40:20 EST
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m0HIMmZD014224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 17 Jan 2008 18:22:49 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <7vfxwwjpv3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/5491/Thu Jan 17 15:13:54 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70898>

On Thursday 17 January 2008, Junio C Hamano wrote:
> Wincent Colaiuta <win@wincent.com> writes:
> 
> > If this is really just a platform-specific hack, can we use platform- 
> > specific code to do the normalization?
> 
> Unfortunately, I do not think this can be a platform-specific
> hack.
> 
> If a project wants to be usable on both sane and insane
> filesystems, people on platforms whose filesystems treat "foo"
> and "Foo" as two distinct pathnames (and "Ma<UMLAUT>rchen" and
> "M<A-with-UMLAUT>rchen" as two distinct ones) need to be
> prevented from creating both in their tree objects at the same
> time.  Once you create two pathnames xt_connmark.c and
> xt_CONNMARK.c in the same tree object in your project, people on
> case insensitive filesystems cannot work with your project (you
> cannot check out the kernel source tree and work on it on vfat).

IMHO, support for insane filesystems should be split into two parts:

1. A git config setting (probably in .gitattributes) that is enabled
   by the project to prevent anyone from committing files that would
   cause problems on insane filesystems. This setting must be enabled
   for everybody in the project (which is why it cannot easily be
   solved by the current hooks infrastructure which is per-repo only).

2. A platform-specific hack that detects whenever you're about to
   check out a problematic filename on an insane filesystem.
   The hack should either warn or (probably better) FAIL to check out
   the problematic file(s) (with an appropriate error message
   pointing at the setting in (1)).

AFAICS, _both_ are needed in order to solve this problem properly.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
