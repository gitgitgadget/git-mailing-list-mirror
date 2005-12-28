From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-inject-tarball
Date: Wed, 28 Dec 2005 12:42:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512281230070.15184@wbgn013.biozentrum.uni-wuerzburg.de>
References: <pan.2005.12.28.02.40.14.577883@progsoc.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 12:42:36 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErZhR-0007h0-NO
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 12:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVL1Lmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 06:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVL1Lmb
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 06:42:31 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32164 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964792AbVL1Lma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2005 06:42:30 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 220421415D9; Wed, 28 Dec 2005 12:42:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 1310415DA;
	Wed, 28 Dec 2005 12:42:27 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id E9D8A1547;
	Wed, 28 Dec 2005 12:42:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 688451415D9; Wed, 28 Dec 2005 12:42:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Anand Kumria <wildfire@progsoc.org>
In-Reply-To: <pan.2005.12.28.02.40.14.577883@progsoc.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14098>

Hi,

On Wed, 28 Dec 2005, Anand Kumria wrote:

> 
> Hi,
> 
> In the Everyday commands[1], there is an example of of extracting a
> tarball and then working with it.  I'm finding that I'm doing this fairly
> often -- I was just wondering if anyone had anything like a
> 'git-inject-tarball' script they'd written up.

Something like this?

-- snip --
#!/bin/sh

TARFILE="$1"
test -z "$TARFILE" && TARFILE=-

git-ls-files -z | xargs -0 rm
tar xvf "$TARFILE" | xargs git add
git-update-index --remove $(git-ls-files)
-- snap --

Notes:
	- this updates the index to match the given tarfile, you still 
	  have to commit yourself
	- it does not handle compressed tarfiles (you have to do something
	  like "cat bla.tar.gz | gzip -d | sh git-untar.sh")
	- it does not remove empty directories (i.e. if the current index 
	  contains a file "a/b", and the tarfile does not, and the
	  directory "a" is now empty, this is not handled)
	- usually, tarfiles contain files inside a subdirectory. There is
	  no facility to strip the subdirectory

Hth,
Dscho
