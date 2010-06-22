From: Pascal Obry <pascal@obry.net>
Subject: git+ssh protocol regression
Date: Tue, 22 Jun 2010 11:22:10 +0200
Message-ID: <AANLkTilFMUJ8mcZaEeqgNF7QhUFVO7kiFUD2M5Vblo7h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 22 11:22:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQzgQ-0001QV-B1
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 11:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759038Ab0FVJWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 05:22:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57512 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab0FVJWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 05:22:10 -0400
Received: by gye5 with SMTP id 5so2769950gye.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 02:22:10 -0700 (PDT)
Received: by 10.101.143.5 with SMTP id v5mr4881592ann.178.1277198530140; Tue, 
	22 Jun 2010 02:22:10 -0700 (PDT)
Received: by 10.100.171.12 with HTTP; Tue, 22 Jun 2010 02:22:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149466>

With current git version doing:

   $ git clone git+ssh://server/path
   fatal: I don't handle protocol 'git ssh'

The '+' has been changed to ' '. This looks like the protocol in the URL
has been decoded (a + is an encoded space).

The culprit is:

<<
commit 9d2e942070b235e1f4a0b8dd4c55a6b3f0fe914a
Author: Jeff King <peff@peff.net>
Date:   Sun May 23 05:19:44 2010 -0400

    decode file:// and ssh:// URLs

    We generally treat these as equivalent to "/path/to/repo"
    and "host:path_to_repo" respectively. However, they are URLs
    and as such may be percent-encoded. The current code simply
    uses them as-is without any decoding.

    With this patch, we will now percent-decode any file:// or
    ssh:// url (or ssh+git, git+ssh, etc) at the transport
    layer. We continue to treat plain paths and "host:path"
    syntax literally.

    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>

I've not seen discussion about this regression. I don't think it is intended.

Patch will be sent in a followup message.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
