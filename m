From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rerere: use ll_merge() instead of using xdl_merge()
Date: Sun, 17 Jan 2010 21:40:13 +0100
Message-ID: <201001172140.13802.j6t@kdbg.org>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com> <201001171252.38826.j6t@kdbg.org> <7v4omk8sjg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 21:41:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWbw5-0007Ue-Qe
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 21:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab0AQUlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 15:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642Ab0AQUlS
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 15:41:18 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:10013 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754638Ab0AQUlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 15:41:15 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F009710012;
	Sun, 17 Jan 2010 21:41:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 21C5619F60D;
	Sun, 17 Jan 2010 21:40:14 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v4omk8sjg.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137318>

On Sonntag, 17. Januar 2010, Junio C Hamano wrote:
> So I didn't think using ll_merge() makes things worse, and that was the
> reason why I did it this way.

Thinking a bit more about it, the problematic point is not that a custom merge 
driver is used, but it is the way how conflicts are marked. For example, it 
seems a bit strange that an XML merge driver would mark-up conflicts using 
<<<<<<< and >>>>>>> in random points of XML text, when it knows that the 
result would be invalid XML (and subsequently an XML editor could fail to 
parse the result). It would be more apropriate when it used a different way 
to mark conflicts.

The conclusion is that your approach goes in the right direction. But since 
the result depends on the traditional conflict markers, it keeps rerere tied 
to the standard text merge driver. The capability that rerere will use custom 
merge drivers is of little use (unless the merge driver uses standard 
conflict markers); that it allows attributes for the standard text merge, is, 
of course, a plus.

-- Hannes
