From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 00:23:39 +0100
Message-ID: <4769A7FB.1070904@lsrfire.ath.cx>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>	 <20071219184457.GC3015@steel.home> <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J58H9-00032e-Gy
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 00:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbXLSXX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 18:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbXLSXX5
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 18:23:57 -0500
Received: from india601.server4you.de ([85.25.151.105]:40677 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbXLSXX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 18:23:56 -0500
Received: from [10.0.1.201] (p57B7E072.dip.t-dialin.net [87.183.224.114])
	by india601.server4you.de (Postfix) with ESMTP id 5FF642F8072;
	Thu, 20 Dec 2007 00:23:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68957>

Jonathan del Strother schrieb:
> On Dec 19, 2007 6:44 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>> Could you try
>>
>>     git cat-file 18d2480ab689b483ef1ebbdb3f7420904049ba0b
>>
>> (or any other problematic commit) and post its output here?
> 
> You mean git cat-file commit ... ?
> I get the normal output, but the problematic commits don't show a
> newline character at the end of the cat-file output.

Just a shot in the dark: does this patch on top of master make a difference?

diff --git a/pretty.c b/pretty.c
index 9db75b4..5f95a59 100644
--- a/pretty.c
+++ b/pretty.c
@@ -412,7 +412,7 @@ static void parse_commit_header(struct format_commit_context *context)
 		if (i == eol) {
 			state++;
 			/* strip empty lines */
-			while (msg[eol + 1] == '\n')
+			while (msg[eol] == '\n' && msg[eol + 1] == '\n')
 				eol++;
 		} else if (!prefixcmp(msg + i, "author ")) {
 			context->author.off = i + 7;
