From: Junio C Hamano <junkio@cox.net>
Subject: Re: remove CR/LF from .gitignore
Date: Wed, 02 Nov 2005 12:27:06 -0800
Message-ID: <7v1x1yssmd.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511020505u1b6b7649l924e252d561b8e9e@mail.gmail.com>
	<Pine.LNX.4.64.0511020759500.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:29:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXPCV-0004fY-OV
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbVKBU1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVKBU1J
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:27:09 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:13720 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965223AbVKBU1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 15:27:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102202643.NIBE9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 15:26:43 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511020759500.27915@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 2 Nov 2005 08:02:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11036>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 2 Nov 2005, Alex Riesen wrote:
>>
>> For everyone cursed by dos/windows line endings (aka CRLF):
>
> Btw, it would be good if somebody verified that the .git/config file also 
> works with CR/LF. 
>
> I'm pretty sure "\" at the end of line will break, but I didn't care 
> enough. And maybe nobody does. Normal config files _should_ work, but 
> you can guess how eager I'm to test it ;)

Something like this?

---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
git diff
diff --git a/config.c b/config.c
index 519fecf..e89bab2 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,14 @@ static int get_next_char(void)
 	c = '\n';
 	if ((f = config_file) != NULL) {
 		c = fgetc(f);
+		if (c == '\r') {
+			/* DOS like systems */
+			c = fgetc(f);
+			if (c != '\n') {
+				ungetc(c, f);
+				c = '\r';
+			}
+		}
 		if (c == '\n')
 			config_linenr++;
 		if (c == EOF) {

Compilation finished at Wed Nov  2 12:24:27
