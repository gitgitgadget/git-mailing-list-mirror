From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Mon, 16 Feb 2009 06:17:20 +0100
Message-ID: <200902160617.21122.robin.rosenberg.lists@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902151942.15055.robin.rosenberg.lists@dewire.com> <7vvdrbjwbt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:18:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYvsf-0000lg-4B
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 06:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbZBPFR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 00:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbZBPFR3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 00:17:29 -0500
Received: from mail.dewire.com ([83.140.172.130]:22088 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbZBPFR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 00:17:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F1CB6803211;
	Mon, 16 Feb 2009 06:17:24 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UWpjmMxBVqAs; Mon, 16 Feb 2009 06:17:24 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id C594B802872;
	Mon, 16 Feb 2009 06:17:23 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-11-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <7vvdrbjwbt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110140>

Junio C Hamano <gitster@pobox.com> wrote:

> If you were arguing for using a different but still non-zero exit status
> to signal the "you asked us to repack but I refused to do so because I
> couldn't move the in-use packs away; by the way I did not corrupt your
> repository because I successfully rolled back everything I did, so do not
> worry to much about it" case, I agree that such a change would be better
> than what we have.  It would allow an automated process to tell a more
> grave repository error and "I need to kill the git object server that is
> pinning some of the packfiles open and re-run the repack" situation apart.

I can live with that. So what are our exit codes then?

0 = successful, repack did what we wanted it to

1 = serious error, no idea really, user should investigate
	(now we know they don't anyway, but that's another problem).

2 = not too good, we didn't succeed in repacking, but we didn't destroy
	anything and the user does not necessarily have to do anything.
	GUI's should probably flag this differently from exit code 1.

This would simply introduce a new error code, but the drawback is that
they are "out of order", i.e. most severe does not have the highest code.

-- robin
