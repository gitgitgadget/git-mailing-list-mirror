From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/2] chmod cleanup (Was: [BUG?] How to make a shared/restricted repo?)
Date: Thu, 26 Mar 2009 16:02:37 +0100
Message-ID: <200903261602.37857.johan@herland.net>
References: <200903250105.05808.johan@herland.net> <200903261044.58140.johan@herland.net> <49CB51E2.9010903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 16:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmrLH-0000mh-L7
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbZCZPQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 11:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZCZPQR
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:16:17 -0400
Received: from sam.opera.com ([213.236.208.81]:48497 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbZCZPQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 11:16:16 -0400
X-Greylist: delayed 784 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2009 11:16:16 EDT
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n2QF2cfL008417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Mar 2009 15:02:47 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <49CB51E2.9010903@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114787>

On Thursday 26 March 2009, Johannes Sixt wrote:
> Johan Herland schrieb:
> > In the above patch, I've passed mode == -1 to finalize_temp_file()
> > from all callsites where there was no corresponding (f)chmod(foo,
> > 0444). However, after looking at the context (these are all either
> > packs or loose objects), I'm wondering if we shouldn't pass mode ==
> > 0444 for all of these. At which point we could replace the above
> > patch with this much simpler version:
>
> Indeed!
>
> > (We could also add an optional "mode" argument to
> > adjust_shared_perm(), to get rid of the double chmod().)
>
> And I think you should do that, otherwise you have a short time
> window where the permissions of a pack or loose object is less
> restrictive than you want.

Ok, here's a cleaned-up series on top of Junio's patch. It should resolve
the chmod()-after-adjust_shared_perm() issue in Junio's patch, as well as
the rename-after-chmod Windows issue reported by Hannes.

The first patch is the second alternative I sent in an earlier mail.
The second patch resolves the double chmod() left by the first patch.


Johan Herland (2):
  Move chmod(foo, 0444) into move_temp_to_file()
  Resolve double chmod() in move_temp_to_file()

 cache.h       |    1 +
 fast-import.c |    3 ---
 http-push.c   |    1 -
 http-walker.c |    1 -
 index-pack.c  |    7 +++----
 path.c        |   26 +++++++++++++++++++-------
 sha1_file.c   |    3 +--
 7 files changed, 24 insertions(+), 18 deletions(-)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
