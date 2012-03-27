From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH/RFC v2 0/4] Fix fetch-pack command line overflow during clone
Date: Tue, 27 Mar 2012 08:23:51 +0200
Message-ID: <4F715CF7.5070903@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPoW-0000Kr-2c
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab2C0GXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:23:23 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:51332 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755868Ab2C0GXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:23:23 -0400
Received: (qmail invoked by alias); 27 Mar 2012 06:23:21 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.160.201]
  by mail.gmx.net (mp069) with SMTP; 27 Mar 2012 08:23:21 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX19PHEpmTClP6O5/U7724tCstIHjvUiUiHwptAToAr
	63Zfs3UFSRBYO6
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120321171423.GA13140@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194017>

This patch series is against the latest "maint" branch. Please let me
know if I need to rebase this on top of some other branch.

The problem we are fixing is described in the first patch in the series.


Changes since the original patch:

* add test cases
* add full commit messages
* fix formatting problem in --stdin doc
* split overly long fetch_pack_usage line
* use strbuf_getline() instead of fgets() for reading refs from stdin
* minor optimization of the pkt-line reading loop, it was using xstrdup()
  even though the string length was already known, use xmemdupz() instead
* rework the remote-curl.c patch to not add new parameters to rpc_service(),
  instead add a new strbuf member to rpc_state to pass the info around


Ivan Todoroski (4):
  fetch-pack: new --stdin option to read refs from stdin
  remote-curl: send the refs to fetch-pack on stdin
  fetch-pack: test cases for the new --stdin option
  remote-curl: main test case for the OS command line overflow

 Documentation/git-fetch-pack.txt |   10 ++++
 builtin/fetch-pack.c             |   45 ++++++++++++++++-
 fetch-pack.h                     |    3 +-
 remote-curl.c                    |   15 +++++-
 t/t5500-fetch-pack.sh            |  100 ++++++++++++++++++++++++++++++++++++++
 t/t5551-http-fetch.sh            |   32 ++++++++++++
 6 files changed, 201 insertions(+), 4 deletions(-)

-- 
1.7.9.5.4.g4f508
