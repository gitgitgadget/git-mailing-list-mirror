From: jidanni@jidanni.org
Subject: git-cache-meta -- simple file meta data caching and applying
Date: Fri, 09 Jan 2009 08:13:15 +0800
Message-ID: <87hc49jq04.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 01:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL51Q-000505-CD
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622AbZAIANU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755350AbZAIANU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:13:20 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:58981 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751877AbZAIANT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 19:13:19 -0500
Received: from jidanni.org (122-127-32-114.dynamic.hinet.net [122.127.32.114])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 97AEAC47D8
	for <git@vger.kernel.org>; Thu,  8 Jan 2009 16:13:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104971>

Gentlemen, I have whipped up this:

#!/bin/sh -e
#git-cache-meta -- simple file meta data caching and applying.
#Simpler than etckeeper, metastore, setgitperms, etc.
: ${GIT_CACHE_META_FILE=.git_cache_meta}
case $@ in
    --store|--stdout)
	case $1 in --store) exec > $GIT_CACHE_META_FILE; esac
	find $(git ls-files) \
	    \( -user ${USER?} -o -printf 'chowm %u %p\n' \) \
	    \( -group $USER -o -printf 'chgrp %g %p\n' \) \
	    \( \( -type l -o -perm 755 -o -perm 644 \) -o -printf 'chmod %#m %p\n' \);;
    --apply) sh -e $GIT_CACHE_META_FILE;;
    *) 1>&2 echo "Usage: $0 --store|--stdout|--apply"; exit 1;;
esac
