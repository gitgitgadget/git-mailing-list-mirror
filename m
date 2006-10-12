From: Markus Amsler <markus.amsler@oribi.org>
Subject: [PATCH] git-imap-send: Strip smtp From_ header from imap message.
Date: Fri, 13 Oct 2006 00:19:35 +0200
Message-ID: <452EBF77.7040301@oribi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike McCormack <mike@codeweavers.com>
X-From: git-owner@vger.kernel.org Fri Oct 13 00:41:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8zU-0003j5-7F
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWJLWZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWJLWZV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:25:21 -0400
Received: from fix-cable-customer.128.177.162.195.yetnet.ch ([195.162.177.128]:17793
	"EHLO khufu") by vger.kernel.org with ESMTP id S1751216AbWJLWZU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:25:20 -0400
Received: from [192.168.67.232] (helo=[192.168.67.232])
	by khufu with esmtp (Exim 4.50)
	id 1GY8w8-0005Yd-38; Fri, 13 Oct 2006 00:21:56 +0200
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28812>

Cyrus imap refuses messages with a 'From ' Header.

Signed-off-by: Markus Amsler <markus.amsler@oribi.org>

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
