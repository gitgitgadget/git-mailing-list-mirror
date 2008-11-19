From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Fix deletion of last character in levenshtein distance
Date: Wed, 19 Nov 2008 09:42:45 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-11-19-09-42-45+trackit+sam@rfc1149.net>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr> <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 09:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2ifB-0005Dk-PY
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 09:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYKSImb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 03:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbYKSIma
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 03:42:30 -0500
Received: from zoidberg.rfc1149.net ([91.121.19.179]:59562 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbYKSIm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 03:42:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id A171D10EAEB;
	Wed, 19 Nov 2008 09:42:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0vLKjOGHUUK; Wed, 19 Nov 2008 09:42:26 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 4C42310E9AB;
	Wed, 19 Nov 2008 09:42:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 96CE2C40BE;
	Wed, 19 Nov 2008 09:42:48 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ggRJ53enHWKD; Wed, 19 Nov 2008 09:42:47 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id CE461C40CA; Wed, 19 Nov 2008 09:42:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101317>

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [2008-11-19 01:53:45 +0100]

| Hi,
| 
| On Tue, 18 Nov 2008, Samuel Tardieu wrote:
| 
| > diff --git a/levenshtein.c b/levenshtein.c
| > index db52f2c..98fea72 100644
| > --- a/levenshtein.c
| > +++ b/levenshtein.c
| > @@ -25,7 +25,7 @@ int levenshtein(const char *string1, const char *string2,
| >  					row2[j + 1] > row0[j - 1] + w)
| >  				row2[j + 1] = row0[j - 1] + w;
| >  			/* deletion */
| > -			if (j + 1 < len2 && row2[j + 1] > row1[j + 1] + d)
| > +			if (row2[j + 1] > row1[j + 1] + d)
| 
| I do not understand: does row2 have more entries than len2?

Yes it does: int *row2 = xmalloc(sizeof(int) * (len2 + 1));

| In any case, you will _have_ to guard against accessing elements
| outside the reserved memory.

Why would that be needed? j belongs to [0, len2[, so j+1 is always
in [0, len2+1[ which is ok for both row2 and row1.
