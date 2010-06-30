From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Wed, 30 Jun 2010 08:12:30 +0200
Message-ID: <4C2AE04E.9090901@viscovery.net>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de> <7vy6dx90uk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 08:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTqXM-0002q9-S9
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 08:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab0F3GMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 02:12:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39589 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751009Ab0F3GMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 02:12:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OTqXB-0006v9-7I; Wed, 30 Jun 2010 08:12:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E5A7A1660F;
	Wed, 30 Jun 2010 08:12:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7vy6dx90uk.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149947>

Am 6/29/2010 19:59, schrieb Junio C Hamano:
> One possibility is to look at the timestamp of the directory itself
> instead.  Then we can safely gc otherwise-unused "thisimage" file when
> rerere is not in use.  I wonder if directory m_time timestamps are usable
> for this purpose on non-POSIX platforms?

I don't think that will work at all: We only use fopen() to write
thisimage, which only truncates the file, but doesn't modify mtime of the
directory. Nor do we create any other (temporary) directory entries that
would modify the mtime.

Would it be possible to update the timestamp of preimage every time it is
used (e.g., in rerere.c:merge()), and check for that?

-- Hannes
