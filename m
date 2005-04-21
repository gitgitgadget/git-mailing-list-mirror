From: tony.luck@intel.com
Subject: Re: [3/5] Add http-pull
Date: Thu, 21 Apr 2005 15:05:19 -0700
Message-ID: <200504212205.j3LM5J005103@unix-os.sc.intel.com>
References: <Pine.LNX.4.44.0504202026180.2625-100000@bellevue.puremagic.com>
Cc: Brad Roberts <braddr@puremagic.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:03:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOjl3-0004js-O6
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVDUWHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDUWHM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:07:12 -0400
Received: from fmr23.intel.com ([143.183.121.15]:51631 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261377AbVDUWHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 18:07:07 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3LM5KBw009774;
	Thu, 21 Apr 2005 22:05:20 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3LM6ioY026781;
	Thu, 21 Apr 2005 22:06:44 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3LM5J005103;
	Thu, 21 Apr 2005 15:05:19 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0504210007410.30848-100000@iabervon.org>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Brad Roberts wrote:
> How about fetching in the inverse order.  Ie, deepest parents up towards
> current.  With that method the repository is always self consistent, even
> if not yet current.

Daniel Barkalow replied:
> You don't know the deepest parents to fetch until you've read everything
> more recent, since the history you'd have to walk is the history you're
> downloading.

You "just" need to defer adding tree/commit objects to the repository until
after you have inserted all objects on which they depend.  That's what my
"wget" based version does ... it's very crude, in that it loads all tree
& commit objects into a temporary repository (.gittmp) ... since you can
only use "cat-file" and "ls-tree" on things if they live in objects/xx/xxx..xxx
The blobs can go directly into the real repo (but to be really safe you'd
have to ensure that the whole blob had been pulled from the network before
inserting it ... it's probably a good move to validate everything that you
pull from the outside world too).

-Tony
