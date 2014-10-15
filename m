From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Custom hunk-header with ignore case setting
Date: Wed, 15 Oct 2014 14:52:51 +0200
Message-ID: <543E6E23.5030708@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 14:53:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeO4a-0003ON-2l
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 14:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbaJOMw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 08:52:56 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:49492 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751584AbaJOMw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 08:52:56 -0400
Received: from p5ddc1cb8.dip0.t-ipconnect.de ([93.220.28.184] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XeO4U-0000wv-9s; Wed, 15 Oct 2014 14:52:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1413377575;1973b026;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm working with a proprietary programming language which ignores case.
I now started to write a custom version of
diff.*.xfuncname and it is kind of ugly to always spell out all cases like
[Ff][Uu][Nn][cC][Tt][Ii][oO][Nn].

I've seen that the builtin diff patterns in userdiff.c can be specified ignoring case using the IPATTERN macro.

One of the possible solutions would be to patch userdiff.c
(patch courtesy of Johannes Schindelin):

-- snip --
diff --git a/userdiff.c b/userdiff.c
index fad52d6..f089e50 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -228,6 +228,9 @@ int userdiff_config(const char *k, const char *v)
 		return parse_funcname(&drv->funcname, k, v, 0);
 	if (!strcmp(type, "xfuncname"))
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
+	if (!strcmp(type, "ixfuncname"))
+		return parse_funcname(&drv->funcname, k, v,
+				REG_EXTENDED | REG_ICASE);
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
-- snap -

With a patch like that I would, of course, supply documentation and tests.

Is that something worth a try from my side?

An alternative solution would be to add something like pxfuncname which
understands PCREs which we we already support in git grep.

And yet another alternative would be that I send a patch enhancing userdiff.c
with a reasonable pattern for the programming language. But its community,
and especially intersected with git users, is not that large.

Thanks,
Thomas
