From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-cache-meta -- simple file meta data caching and applying
Date: Thu, 8 Jan 2009 19:22:25 -0500
Message-ID: <76718490901081622q618c43d0t333882cbe44f6b30@mail.gmail.com>
References: <87hc49jq04.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Jan 09 01:23:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL5AE-0007om-KV
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbZAIAW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813AbZAIAW1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:22:27 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:12057 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648AbZAIAW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 19:22:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8653004rvb.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 16:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iBx2MMWWNcjjk28Sg7conLMTSXGWpJ1iyRfeO/jLTdE=;
        b=j0yryHZvYVaniT5RHDaMjhpCryWSMP9cZG7BDG9igvsOl6Mlu/ltzPb+++aY2cIFRb
         X/ka/19nLI4nCc2CIfrcduK4y2dLAAwZh4OfjR2qbPIaHR/+2fIV0O8YOEhKKH7Nw60b
         oS16KivzoFFN0ngvrmeZCPNBFUomApBJXlf78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=is0umvhbiN7z7BNv2thDLX0wwKWlAjVmOfOv4e4PBC/L3zdQBgXTMWx+dTpP62McHD
         3vSKtkmsfJor6ifcnpzqJfC1CeUDrJM7uOpI9XT7NAvAPwoK5ectpGhAxrkuPoL49K2N
         dmiL6kDsUj+W7k8JRRYWnYhjwHE2FBEmoFJLM=
Received: by 10.140.136.6 with SMTP id j6mr12404188rvd.126.1231460545532;
        Thu, 08 Jan 2009 16:22:25 -0800 (PST)
Received: by 10.140.135.1 with HTTP; Thu, 8 Jan 2009 16:22:25 -0800 (PST)
In-Reply-To: <87hc49jq04.fsf@jidanni.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104974>

On Thu, Jan 8, 2009 at 7:13 PM,  <jidanni@jidanni.org> wrote:
> Gentlemen, I have whipped up this:
>
> #!/bin/sh -e
> #git-cache-meta -- simple file meta data caching and applying.
> #Simpler than etckeeper, metastore, setgitperms, etc.
> : ${GIT_CACHE_META_FILE=.git_cache_meta}
> case $@ in
>    --store|--stdout)
>        case $1 in --store) exec > $GIT_CACHE_META_FILE; esac
>        find $(git ls-files) \
>            \( -user ${USER?} -o -printf 'chowm %u %p\n' \) \
>            \( -group $USER -o -printf 'chgrp %g %p\n' \) \
>            \( \( -type l -o -perm 755 -o -perm 644 \) -o -printf 'chmod %#m %p\n' \);;
>    --apply) sh -e $GIT_CACHE_META_FILE;;
>    *) 1>&2 echo "Usage: $0 --store|--stdout|--apply"; exit 1;;
> esac

It doesn't handle paths which contain white-space. "chown" is typo'd
as "chowm". To be useful, the contribution might also include
instructions on how it should be used with git, and perhaps also
reasoning for why someone would want to use it in place of etckeeper,
metastore, setgitperms, etc.

j.
