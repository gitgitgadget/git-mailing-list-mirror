From: jidanni@jidanni.org
Subject: Re: git-cache-meta -- simple file meta data caching and applying
Date: Fri, 09 Jan 2009 10:50:22 +0800
Message-ID: <878wpljiq9.fsf@jidanni.org>
References: <76718490901081628x62da43bcia5cdbb160b0ff24a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jaysoffian@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 09 03:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL7TS-0000gX-O0
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 03:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbZAICu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 21:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbZAICu0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 21:50:26 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:55703 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751951AbZAICu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 21:50:26 -0500
Received: from jidanni.org (122-127-32-114.dynamic.hinet.net [122.127.32.114])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 076AFC47E5;
	Thu,  8 Jan 2009 18:50:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104980>

Fixed. Manly the program aims to be tiny. Perhaps I should include a
full example of using it with git-bundle.

#!/bin/sh -e
#git-cache-meta -- file meta data caching for possible use with
#git-bundle, git-fast-export, git-archive, hooks, as a simple
#alternative to etckeeper, metastore, setgitperms. Requires GNU Find.
: ${GIT_CACHE_META_FILE=.git_cache_meta}
case $@ in
    --store|--stdout)
	case $1 in --store) exec > $GIT_CACHE_META_FILE; esac
	git ls-files|xargs -I{} find {} \
	    \( -user ${USER?} -o -printf 'chown %u "%p"\n' \) \
	    \( -group $USER   -o -printf 'chgrp %g "%p"\n' \) \
	    \( \( -type l -o -perm 755 -o -perm 644 \) \
			      -o -printf 'chmod %#m "%p"\n' \);;
    --apply) sh -e $GIT_CACHE_META_FILE;;
    *) 1>&2 echo "Usage: $0 --store|--stdout|--apply"; exit 1;;
esac
