From: Jim Meyering <jim@meyering.net>
Subject: git-clean fails to remove a file whose name contains \\, ", or \n, TAB, etc.
Date: Tue, 08 May 2007 22:32:50 +0200
Message-ID: <87ps5bhx8t.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 22:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlWMk-0004Ur-29
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933354AbXEHUcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933666AbXEHUcw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:32:52 -0400
Received: from mx.meyering.net ([82.230.74.64]:34900 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933354AbXEHUcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:32:51 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4E3AB55218; Tue,  8 May 2007 22:32:50 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46620>

Not that it matters (or maybe this is a feature :-), because people
who create such files in their working directory deserve what they
get, Eh? :-)

But if leaving it, then perhaps git-clean should at least warn
that it's not doing its job (i.e. remove the uses of rm's "-f").

To reproduce, run these commands:

nl='
'
git-init > /dev/null && touch "x\\n\"$nl" && git-clean && ls -b

Here's the output I get:

    Removing "x\\n\"\n"
    .git/  x\\n"\n

git-clean.sh needs to strip off leading and trailing double quotes (easy)
as well as convert escapees back to originals (not easy as you might
think, in sh) before running rm.  Good excuse to rewrite it in perl.
