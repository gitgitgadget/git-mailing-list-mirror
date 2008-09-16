From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 09:09:04 +0200
Message-ID: <48CF5B90.5050800@viscovery.net>
References: <loom.20080915T222909-709@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 09:10:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfUhX-0004IY-OQ
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 09:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbYIPHJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 03:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbYIPHJL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 03:09:11 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45750 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYIPHJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 03:09:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KfUgL-0000bW-97; Tue, 16 Sep 2008 09:09:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 01EF06EF; Tue, 16 Sep 2008 09:09:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <loom.20080915T222909-709@post.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95982>

Sergio Callegari schrieb:
> if [ $# = 0 ] ; then
>     tmpcopy=$(mktemp rezip.zip.XXXXXX)
>     cat > $tmpcopy
>     filename="$tmpcopy"
> else
>     tmpcopy=""
>     filename="$1"
> fi
> 
> workdir=$(mktemp -d -t rezip.workdir.XXXXXX)
> curdir=$(pwd)
> 
> cd $workdir
> unzip $UNZIP_OPTS "$curdir/$filename"
> zip $ZIP_OPTS "$curdir/$filename" .
> cd $curdir
> rm -fr $workdir
> if [ ! -z "$tmpcopy" ] ; then
>   cat $filename
>   rm $tmpcopy
> fi

You don't need a temporay zip filename in filter mode:

  unzip $UNZIP_OPTS /dev/stdin  # works for me, but not 100% portable
  zip $ZIP_OPTS - .             # writes to stdout

> then put in your .git/config something like
> 
> [filter "opendocument"]
>         clean = "rezip -p ODF_UNCOMPRESS"
>         smudge = "rezip -p ODF_COMPRESS"

Is the smudge filter really necessary? Can't OOo work with files at
compression level 0?

-- Hannes
