From: Pierre Habouzit <madcoder@debian.org>
Subject: ph/parseopt-sh reloaded
Date: Sun,  4 Nov 2007 11:30:52 +0100
Message-ID: <1194172262-1563-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 04 11:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoclF-0001ha-F0
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 11:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbXKDKbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 05:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbXKDKbF
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:31:05 -0500
Received: from pan.madism.org ([88.191.52.104]:42906 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201AbXKDKbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:31:04 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 371FE26482;
	Sun,  4 Nov 2007 11:31:03 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5CB5A1E45D; Sun,  4 Nov 2007 11:31:02 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1498.g0c64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63376>

Okay here is a fixed series wrt the security issue Junio raised.
Instead of the old PARSEOPT_OPTS variable, I now only have
OPTIONS_KEEPDASHDASH to be set to non empty if you want to add
--keep-dashdash. The reason for that is that I dislike that every single
git-rev-parse --parseopt user had to do a `PASREOPT_OPTS=` at the
begining of each script, it's error prone, and ugly.

PARSEOPT_OPTS was an overkill as it wasn't really used for anything else
than OPTIONS_KEEPDASHDASH, and if it has to be used for more, it'll be
easy to extend the specification parser to take options on stdin rather
than through parameters.

I also removed the PARSEOPT_OPTS from git-clone.sh as it was a spurious
use, I don't intend users to override this variable, it's indeed an
internal that changes git-rev-parse --parseopt behaviour in a
incompatible way for the scripts that uses it, it should not be
user-tweakable anyway.

The 10 patch series (and not 11, I forgot about 7 when I incrementally
sent the previous one) is fetcheable from my repository:

  git://git.madism.org/git.git on branch ph/parseopt-sh

(ph/parseopt has the remaining patches that are problematic right now
either because of the small change -h vs. -H or the patches that
conflicts with git-fetch series right now, but in the spirit this is
definitely a ph/parseopt series).

Cheers,
