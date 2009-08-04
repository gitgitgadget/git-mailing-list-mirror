From: Karl Wiberg <kha@virtutech.com>
Subject: Re: [PATCH] Work around performance bug in
	subprocess.Popen.communicate()
Date: Tue, 4 Aug 2009 10:51:25 +0200
Message-ID: <20090804085125.GB27452@lux.e.vtech>
References: <20090731093632.7018.24435.stgit@october.e.vtech> <b0943d9e0907310427r7e59aa5fi5e5ff5e3f3c03819@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mandolaerik@gmail.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 11:46:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYGbZ-0005rj-B4
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 11:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbZHDJql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 05:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbZHDJql
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 05:46:41 -0400
Received: from [62.20.90.206] ([62.20.90.206]:10947 "EHLO lux.e.vtech"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932692AbZHDJql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 05:46:41 -0400
X-Greylist: delayed 3308 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2009 05:46:40 EDT
Received: from lux.e.vtech (lux.hq.vtech [127.0.0.1])
	by lux.e.vtech (8.14.2/8.14.2) with ESMTP id n748pPiI027732;
	Tue, 4 Aug 2009 10:51:25 +0200
Received: (from kha@localhost)
	by lux.e.vtech (8.14.2/8.14.2/Submit) id n748pPnG027730;
	Tue, 4 Aug 2009 10:51:25 +0200
X-Authentication-Warning: lux.e.vtech: kha set sender to kha@virtutech.com using -f
Content-Disposition: inline
In-Reply-To: <b0943d9e0907310427r7e59aa5fi5e5ff5e3f3c03819@mail.gmail.com>
X-Manual-Spam-Check: kha@virtutech.com, clean
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124776>

On 2009-07-31 12:27:53 +0100, Catalin Marinas wrote:

> But can this not lead to a deadlock if the __indata is big? The
> stdout of the created process is only processed once the whole
> __indata is written. I thought communicate() was created to avoid
> this issue.

I don't think there's a problem. write() isn't supposed to have a
limit on the amount of data it will accept in one call, as far as I'm
aware. Plus, it works just fine with Erik's test case---which in my
case was about 7 MB. If it can handle 7 MB, I doubt there's a limit
we'll hit anytime soon.

Oh, and we still call communicate()---we just don't pass it any
additional bytes to write to stdin.

-- 
Karl Wiberg, Virtutech
