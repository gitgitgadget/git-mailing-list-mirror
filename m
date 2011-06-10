From: Fabrizio Chiarello <fabrizio.chiarello@ieee.org>
Subject: Re: Reverting/cheout files with old modification date
Date: Fri, 10 Jun 2011 09:17:07 +0200
Message-ID: <20110610071707.GA4715@hydrogen.black.hole>
References: <loom.20110609T090306-164@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Pientka <p.pientka@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 09:26:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUw6i-000729-GU
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 09:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492Ab1FJH0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 03:26:12 -0400
Received: from mail1.dei.unipd.it ([147.162.2.111]:59360 "HELO
	mail.dei.unipd.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752870Ab1FJH0L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 03:26:11 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jun 2011 03:26:11 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.dei.unipd.it (Postfix) with ESMTP id F0288169A6D7;
	Fri, 10 Jun 2011 09:17:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dei.unipd.it
Received: from mail.dei.unipd.it ([127.0.0.1])
	by localhost (mail1.dei.unipd.it [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 4yM2HX3VEN7d; Fri, 10 Jun 2011 09:17:07 +0200 (CEST)
Received: from localhost (unknown [172.20.0.160])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.dei.unipd.it (Postfix) with ESMTPSA id 9C4DE169A6D3;
	Fri, 10 Jun 2011 09:17:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20110609T090306-164@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175598>

On Thu, Jun 09, 2011 at 07:09:47AM +0000, Peter Pientka wrote:
> Hi,
> Is any way to revert/checkout some files from reposotory with old modification
> date(file parameter). Now, while I revert/checkout some file, modification date
> of file is set to current date and time.
> 

I use this hook. On checkout it sets the mtime of all the files to
the date of the last commit touching them.

===== .git/hooks/post-checkout

#!/bin/sh

for f in `git ls-tree --name-only -r HEAD`; do
    mtime=`git log -n1 --date=iso --pretty=%ai -- $f`
    touch -m -d "$mtime" $f
done

=====


-- 
Fabrizio Chiarello <fabrizio.chiarello@ieee.org>

You ask: what is the meaning or purpose of life? I can only answer with
another question: do you think we are wise enough to read God's mind?
  -- Freeman Dyson
