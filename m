From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 17:18:39 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2009-01-14-17-18-40+trackit+sam@rfc1149.net>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at>
	<1231944876-29930-2-git-send-email-drizzd@aon.at>
	<1231944876-29930-3-git-send-email-drizzd@aon.at>
	<1231944876-29930-4-git-send-email-drizzd@aon.at>
	<alpine.DEB.1.00.0901141641500.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	johannes@familieschneider.info
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 17:29:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN8cD-0006Yg-2z
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325AbZANQ1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 11:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbZANQ1s
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:27:48 -0500
Received: from zoidberg.rfc1149.net ([91.121.19.179]:35231 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbZANQ1r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 11:27:47 -0500
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2009 11:27:46 EST
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id A774410FB92;
	Wed, 14 Jan 2009 17:18:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksFmUBNdu7Bu; Wed, 14 Jan 2009 17:18:40 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (not verified))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 98C1710E6EA;
	Wed, 14 Jan 2009 17:18:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 52F4BC409D;
	Wed, 14 Jan 2009 17:18:40 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i4J9omLPy8nG; Wed, 14 Jan 2009 17:18:40 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 1DBB4C409E; Wed, 14 Jan 2009 17:18:40 +0100 (CET)
In-Reply-To: <alpine.DEB.1.00.0901141641500.3586@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Wed\, 14 Jan 2009 16\:44\:36 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105654>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Dscho> I would prefer something like this:

My taste would favor:

  static int has_special(const char *p)
  {
    for (; *p; p++)
      if (isspecial(*p))
        return 1;
    return 0;
  }

as it underlines the intent (loop over "p" characters and stop no
later than the end of the string) while avoiding using side effects in
the body to increment the pointer. This habit comes from Ada, where
loop indices are considered read-only in the loop body.

It also eases further extensions such as

  static int has_special(const char *p)
  {
    for (; *p; p++)
      if (isspecial(*p) || isveryspecial(*p))
        return 1;
    return 0;
  }

without having to move the "++" somewhere else.

Dscho> but that is probably a matter of taste.

Agreed.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
