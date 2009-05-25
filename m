From: Charles Bailey <charles@hashpling.org>
Subject: Slightly obscure merge-file inconsistency
Date: Mon, 25 May 2009 01:21:12 +0100
Message-ID: <1243210874-18451-1-git-send-email-charles@hashpling.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 02:23:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ny1-0005dH-Ln
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 02:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbZEYAVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 20:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbZEYAVW
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 20:21:22 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:9370 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753381AbZEYAVV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 20:21:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAIiBGUrUnw6U/2dsb2JhbADMb4QLBQ
Received: from fhw-relay07.plus.net ([212.159.14.148])
  by relay.pcl-ipout02.plus.net with ESMTP; 25 May 2009 01:21:22 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1M8NwL-00036B-QK; Mon, 25 May 2009 01:21:17 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n4P0LLo2018490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 May 2009 01:21:21 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n4P0LLI6018489;
	Mon, 25 May 2009 01:21:21 +0100
X-Mailer: git-send-email 1.6.3.1.72.gbd1ec
X-Plusnet-Relay: e63da71c2385d789e1a1e113851372dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119879>

This was spotted by someone on stackoverflow.com.

It seems that git merge-file will wipe the merged file in the
degenerate case when all the inputs have identical contents. As
far as I can tell this is a bug, albeit one which will never be
triggered in practice because merge-file won't ever be called on
files that are identical in base, local and remote versions.

I think that the problem is just an overzealous null check in
xdl_merge. Certainly with the fix, the test suite still passes but
there may be some use cases of xdl_merge that I'm not aware of
that rely on the current behaviour.

http://stackoverflow.com/questions/903966/
