From: "Tim Abell" <tim@timwise.co.uk>
Subject: Re: [PATCH] Handle rename of case only, for Windows
Date: Sun, 30 Jan 2011 16:53:55 +0000
Message-ID: <1296406435.8170.1418006125@webmail.messagingengine.com>
References: <1296344717.25999.1417928123@webmail.messagingengine.com>
 <4D44CB60.8000506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 30 17:54:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjaXQ-0007H9-EZ
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 17:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab1A3Qx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 11:53:57 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53138 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750832Ab1A3Qx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 11:53:56 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BC5B3203E3;
	Sun, 30 Jan 2011 11:53:55 -0500 (EST)
Received: from web2.messagingengine.com ([10.202.2.212])
  by compute3.internal (MEProxy); Sun, 30 Jan 2011 11:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=EnLOsNrUtS9nFE6MjTcuPbkUzHs=; b=Ekt1tjqVXJUQh6VC2OFEtjAJMca46J4OWmtRdhoVnnkOwRxiTyzAtS52KVBL4rHD6qt9fYTKZZtBKYIVvDe6RwgOB4dZ4LJAes1hO1PhbxTvsnOoU2O1+JrAwKf1/pRlF8PeHEdkHesqVbmnfW0EMdWmcLbdRA4p9uUaVSDpuCs=
Received: by web2.messagingengine.com (Postfix, from userid 99)
	id 9C407B013D7; Sun, 30 Jan 2011 11:53:55 -0500 (EST)
X-Sasl-Enc: OYO3norwtJnI33udZxu1VXimqwHW7MPeTPeYoPAIRDAO 1296406435
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <4D44CB60.8000506@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165689>

> +			struct stat src_st;
> +			lstat(src, &src_st);

Shouldn't you check the return value of this call?  OK, the source
probably always exists, but still.  Oh, we actually know that because
that's the first lstat() call in this for loop.  You can reuse its
result instead of calling the function again.

Thanks for your feedback, you are undoubtedly right about checking the return value, I hadn't though of that. Just out of interest I tried moving a file with git mv that i'd removed from the filesystem. Here's the result, so at least it's not dying horribly:

  $ rm foo.txt

  $ git status
  # On branch master
  # Changed but not updated:
  #   (use "git add/rm <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #       deleted:    foo.txt
  #
  no changes added to commit (use "git add" and/or "git commit -a")

  $ git mv foo.txt bar.txt
  fatal: bad source, source=foo.txt, destination=bar.txt

--

What do I need to do from here to make my patch acceptable/useful to git's maintainers?

Thanks

Tim Abell
