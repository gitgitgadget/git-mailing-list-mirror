From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-imap-send: Strip smtp From_ header from imap message.
Date: Tue, 17 Oct 2006 23:04:43 -0700
Message-ID: <7vlknegnwk.fsf@assigned-by-dhcp.cox.net>
References: <452EBF77.7040301@oribi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike McCormack <mike@codeweavers.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 08:07:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga4a3-0003uH-5l
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 08:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWJRGEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 02:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWJRGEu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 02:04:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28112 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751439AbWJRGEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 02:04:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018060448.SWVR2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Oct 2006 02:04:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bi4b1V00C1kojtg0000000
	Wed, 18 Oct 2006 02:04:35 -0400
To: Markus Amsler <markus.amsler@oribi.org>
In-Reply-To: <452EBF77.7040301@oribi.org> (Markus Amsler's message of "Fri, 13
	Oct 2006 00:19:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29192>

Markus Amsler <markus.amsler@oribi.org> writes:

> Cyrus imap refuses messages with a 'From ' Header.
>
> Signed-off-by: Markus Amsler <markus.amsler@oribi.org>

Do you know if this change does not upset other implementations
of imap servers?

Mike, are you Ok with this change?

---
  imap-send.c |    8 ++++++++
  1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 362e474..16804ab 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1226,6 +1226,14 @@ split_msg( msg_data_t *all_msgs, msg_dat
 	if (msg->len < 5 || strncmp( data, "From ", 5 ))
 		return 0;

+	p = strchr( data, '\n' );
+	if (p) {
+		p = &p[1];
+		msg->len -= p-data;
+		*ofs += p-data;
+		data = p;
+	}
+
 	p = strstr( data, "\nFrom " );
 	if (p)
 		msg->len = &p[1] - data;
