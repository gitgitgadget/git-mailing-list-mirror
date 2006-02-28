From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Quick question: how to generate a patch?
Date: Mon, 27 Feb 2006 18:09:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602271802110.22647@g5.osdl.org>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com> 
 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org> 
 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com> 
 <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org> 
 <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com> 
 <44033241.6070001@op5.se>  <Pine.LNX.4.64.0602270923120.22647@g5.osdl.org>
 <6d6a94c50602271755v41e0d31ch25892192547003a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 03:09:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDuIz-0003Z0-MM
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 03:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWB1CJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 21:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWB1CJ2
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 21:09:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750974AbWB1CJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 21:09:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1S29LDZ025079
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 18:09:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1S29JR0022818;
	Mon, 27 Feb 2006 18:09:20 -0800
To: Aubrey <aubreylee@gmail.com>
In-Reply-To: <6d6a94c50602271755v41e0d31ch25892192547003a9@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16907>



On Tue, 28 Feb 2006, Aubrey wrote:
> 
> I'm using suse9.3. The filesystem is EXT3.

Ok, something else is going on. There's no way ext3 can get confused about 
times that I can see.

> I think I forgot one thing last night. When I changed the file, I
> compiled the package to verify my modification. It should be the
> reason. But should it really affect the result of "git diff"?

Nope. Something else is happening.

If you can re-create this at will, it would be interesting to see _what_ 
makes git think you've modified a file. A small mod to "read-cache.c" like 
the appended patch should give you (very very verbose) output that could 
help us figure this out.

		Linus

----
diff --git a/read-cache.c b/read-cache.c
index f97f92d..4946163 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -183,6 +183,8 @@ int ce_match_stat(struct cache_entry *ce
 	    index_file_timestamp <= ntohl(ce->ce_mtime.sec))
 		changed |= ce_modified_check_fs(ce, st);
 
+if (changed) error("changed: 0x%x %s", changed, ce->name);
+
 	return changed;
 }
 
