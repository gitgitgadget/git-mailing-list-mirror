From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/2] Re: fast-import: fix ls command with empty path
Date: Thu, 8 Mar 2012 14:27:21 -0600
Message-ID: <20120308202721.GA8992@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5jw1-0005qa-Ps
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 21:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab2CHU1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 15:27:33 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36178 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab2CHU1c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 15:27:32 -0500
Received: by gghe5 with SMTP id e5so510708ggh.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qku7nAK/1S+xRK28vxFk+Hn8w0V3iW6F0kUPE98c36k=;
        b=V4F/08mwSORC4J5aRhMaAWiJVpH8sXGFOz1HLvKTqYzwdfHbUaVYtDKjrzFATOfDpx
         ZmxmPmgZGtUxTuRbrD2N2XXOUDfk9rZYixrzxRCDTDdK6jxDGnjdtrRrm+/KV9k3xTlm
         C8VFvrvwl2aaIFm33iol4GKeyc49me+1MNi7pE7V4ZI30ZVND3u25rhUOptnVQcKCY92
         spZEodCFEqIO8jBQ97upxKiN4N+XWQPm4P3rNCFyFV4BD5nkmEL5s8aD9XFFpHC8gBl4
         o1GegqG0Hw2Ph9KKy0zFdHoOO18SBZvqjwSEKs/hkeW9TbN9HN3AV8UC8rr2PoIja7u1
         XtLA==
Received: by 10.60.12.231 with SMTP id b7mr3146014oec.38.1331238451710;
        Thu, 08 Mar 2012 12:27:31 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a18sm3965590obu.15.2012.03.08.12.27.30
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 12:27:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1331184656-98629-1-git-send-email-davidbarr@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192643>

David Barr wrote:

> When the following command is sent to fast-import:
>
>  'ls' SP ':1' SP LF
>
> The expected output is:
>
>  '040000' SP 'tree' SP <dataref> HT LF
>
> The actual output is:
>
>  'missing' SP LF
>
> This is because tree_content_get() is called but expects a non-empty
> path. Instead, copy the root entry and force the mode to S_IFDIR.

Thanks again for your help.  I've pushed the following changes to

  git://repo.or.cz/git/jrn.git fast-import-pu

Testing, review, and improvements welcome.

David Barr (1):
  fast-import: teach ls command to accept empty path

Jonathan Nieder (1):
  fast-import: plug leak of dirty trees in 'ls' command

 fast-import.c          |   19 +++++++++-
 t/t9300-fast-import.sh |   95 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)
