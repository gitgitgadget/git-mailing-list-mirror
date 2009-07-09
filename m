From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Thu, 09 Jul 2009 10:51:20 +0200
Message-ID: <4A55AF88.3090205@viscovery.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <200907081801.36901.johan@herland.net> <7vws6j6qed.fsf@alter.siamese.dyndns.org> <200907091043.03263.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpLn-0005NE-Qr
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbZGIIv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbZGIIv0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:51:26 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:15128 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZGIIvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 04:51:25 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOpLc-0000x1-TY; Thu, 09 Jul 2009 10:51:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9183E6B7; Thu,  9 Jul 2009 10:51:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200907091043.03263.johan@herland.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122951>

Johan Herland schrieb:
> Does anybody with Windows/MSYS experience know how this scenario (write() to 
> a terminated process, followed by close()) would play out in msysGit?

The first write() sometimes fails with EPIPE, otherwise it fails with
EINVAL. All subsequent write()s fail with EINVAL. The setting of SIGPIPE
is irrelevant because it is unknown to Windows.

There's precedent already in write_or_die.c. You should not write the
error message for both EPIPE and EINVAL.

-- Hannes
