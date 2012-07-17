From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Tue, 17 Jul 2012 11:54:57 +0200
Message-ID: <1948960.GdZ6fLVixa@flobuntu>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <11883284.WI8IR4K6qp@flobuntu> <20120717032725.GC3071@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 11:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr4Ut-0000jw-8e
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 11:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab2GQJzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 05:55:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49096 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab2GQJzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 05:55:08 -0400
Received: by bkwj10 with SMTP id j10so156508bkw.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=M/HSHCFRpvOtj0eu2rqBNByh66FWEbMBVMLhmiIdZh8=;
        b=hGrdyf/+qoprkq2+WO5/KjW1Vt49zYjIp7hbgfFMN2kkN2XZ3ARyorwjaDlNUZxssv
         8xBGTv1sGYF/5eQy8ruDKokTh4WHOPrE9Ki7CpQz8TKvHE0oMfh43B2RVJSmBtE8GXa4
         KecYYXa/ePjltt9RYKal+ngtWb5D+p/Nr7xQXMc5O4Qr84cFlLJmKV6dX9jU5caq50uX
         QlnUkP8U9QeloRjdkEch5tfNbXvQErRw7j642vUgiOicXeJ8XMqsg/gTRZVpxrTNR8Je
         HoHPBHGVzlwN4WAJpfrW6tel7H1RcB8sT0vyCGWNbZa6UuAhSNAaWzQIArwdfAWHBq+E
         fuag==
Received: by 10.204.157.151 with SMTP id b23mr679300bkx.96.1342518906942;
        Tue, 17 Jul 2012 02:55:06 -0700 (PDT)
Received: from flobuntu.localnet (91-115-94-188.adsl.highway.telekom.at. [91.115.94.188])
        by mx.google.com with ESMTPS id u8sm9527105bks.0.2012.07.17.02.55.04
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 02:55:05 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120717032725.GC3071@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201597>

On Monday 16 July 2012 22:27:25 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> > When it does advertise refspec like:
> > Debug: Remote helper: <- refspec
> > refs/heads/master:refs/remotes/svnfile/master it all works. Unfortunatly
> > I didn't understand that a day ago.
> 
> Hm, that still doesn't look right.  The RHS of the refspec is supposed to
> be a _private_ namespace for the remote helper, and refs/remotes/ is
> not private.
> 
> Would something like
> 
> 	refspec refs/heads/*:refs/svn/<name of remote>/*
> 
> work?

remote-svn now uses get_fetch_map to retrieve the local refs. So it respects 
the fetch refspec in the config.

If I change the default fetch refspec in .git/config to 
'fetch = +refs/heads/*:refs/svn/svnfile/*' it works.

If the remote-helper only advertises the private refspec, but the config and 
remote->fetch is unchanged, it works also as long as the import target is 
consistent (of course).

So we do not want helpers to import to remotes/ but to their private svn/ in 
this case? (ignoring the config?)

> 
> [...]
> 
> > If yes, it makes sense now! A little comment in the sources would help a
> > lot.
> Now that you know what the reader of this code needs to know, a patch
> would be very welcome.
> 
> "git blame" or "git log -S" can be useful to find what the authors
> were thinking when they wrote that line, or to find wording to steal
> for a comment. :)

coming ..

> 
> Hope that helps,
> Jonathan

Florian
