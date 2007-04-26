From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use PATH_MAX rather than a hardwired constant maximum length.
Date: Thu, 26 Apr 2007 14:14:51 +0200
Message-ID: <81b0412b0704260514k1eeec53ex97df3be600244305@mail.gmail.com>
References: <20070425232829.GA15930@midwinter.com>
	 <81b0412b0704260120mda8a2abhe343f5c127945939@mail.gmail.com>
	 <46306A29.4010608@midwinter.com>
	 <20070426091254.GA23586@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "koreth@midwinter.com" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 14:14:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh2sD-0003Pz-3i
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 14:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbXDZMOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 08:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031194AbXDZMOx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 08:14:53 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:51582 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030490AbXDZMOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 08:14:52 -0400
Received: by an-out-0708.google.com with SMTP id b33so197114ana
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 05:14:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e2cU8BMwbyA10rvNG8BBabagAlHew7ifSuF6NeJjFMxFwUgliOJ1TytjKAd9sloMVBlbvxubAa0+ssFyrqVL5qCorP5n8NvOc0QcrSJjiD6aiW6Q8rYnvmQjOMS5SUSVu3pw46hJSFtxM0OVTNUozjqy03n3PgqzcDMn9asDJkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EE+4akkhUo5DcMWf6za/qzCYic15sdNOnuPFRkdaU94HwSQ0/LTHF0dyXsQbBrMUGpPKhwkxkgO5Tt/gYVv3BBb1062Zs1YsyopJyvJpGA5QHiZcpDW36l+fgahxr6lhvPO2mgG3w5ND+U3GOaVFMo9BIB7Qil23Fb/bS2zhP/M=
Received: by 10.100.9.19 with SMTP id 19mr1022686ani.1177589691728;
        Thu, 26 Apr 2007 05:14:51 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 26 Apr 2007 05:14:51 -0700 (PDT)
In-Reply-To: <20070426091254.GA23586@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45633>

On 4/26/07, koreth@midwinter.com <koreth@midwinter.com> wrote:
> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> ---
>
> Is the +1 really needed? The existing code is doing this in other places

No, not according SUSv3, where PATH_MAX is defined as
"Maximum number of bytes in a pathname, including the terminating null
character."
http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html#tag_13_24

getcwd expects the size of the buffer, so it can store the cwd _and_ NUL.
See ERANGE in in SUSv3:
http://www.opengroup.org/onlinepubs/009695399/functions/getcwd.html

> but I'm not sure it's necessary since we're also doing sizeof(buffer)-1

The -1 is wrong too.

> in the getcwd() call. I figured it was best to be consistent with the
> existing code, e.g. setup_git_directory_gently().

setup_git_directory_gently is wrong. But it does not really
matter in practice.
