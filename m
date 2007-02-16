From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] builtin-update-index.c (add_file_to_cache): Don't leak
 a cache entry.
Date: Fri, 16 Feb 2007 09:00:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702160858190.20368@woody.linux-foundation.org>
References: <87mz3e327y.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 18:00:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI6Rv-0002Td-AU
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 18:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbXBPRAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 12:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbXBPRAj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 12:00:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:52892 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964883AbXBPRAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 12:00:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1GH0ZhB031518
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Feb 2007 09:00:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1GH0Yul003872;
	Fri, 16 Feb 2007 09:00:35 -0800
In-Reply-To: <87mz3e327y.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-2.435 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39931>



On Fri, 16 Feb 2007, Jim Meyering wrote:
> 
> -	if (index_path(ce->sha1, path, &st, !info_only))
> +	if (index_path(ce->sha1, path, &st, !info_only)) {
> +		free(ce);
>  		return -1;
> +	}

Well, the only user of this does:

	if (add_file_to_cache(p))
		die("Unable to process file %s", path);

so the leak is very shortlived ;)

		Linus
