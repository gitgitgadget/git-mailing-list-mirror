From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git diff --check always shows line 1 for blank at EOF for new
 files
Date: Thu, 7 Oct 2010 04:32:58 -0500
Message-ID: <20101007093258.GA10941@burratino>
References: <4CAC411E.3010204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Mallon <christoph.mallon@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 07 11:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3mtn-0005DT-2m
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 11:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760135Ab0JGJgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 05:36:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43851 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab0JGJgI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 05:36:08 -0400
Received: by yxp4 with SMTP id 4so200821yxp.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iHgUxwesm2xOc3U1uIFS66RosNecCfWVctYxCpqUt0I=;
        b=DfS7BkDIyhxPR6zH+IrnsgEmrOnygkVQfMBUfvuwpqm2IuYWSft4Nq0VdMqftdTvAS
         2ohYHvc20PmzDqQ7Y0sgDx3C3Ag7PSv35g3pKdThA3g3bJEne4b5wzruwXyU2hg51qEu
         Uvqr6ObPQSTHuFFr6hBi/oLlYzyD3/GXK/5TA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RNVLr7NcGG4cOXPmtJ2zVV2LHbgxu6Eb7a07k7jvgoUs6nzbk7RlVyrMVkI6WG+Onk
         TnyXWex+SRnhrQ2gojkwIZ5rx28qyrFbyO67rsKs9yELq/RyinJaiNUV6SYFBEnHuMVS
         wl8WHbF2r7OIsvDFPfR4ZjB1t2vOQFc2Ri0R4=
Received: by 10.42.115.5 with SMTP id i5mr402904icq.121.1286444167365;
        Thu, 07 Oct 2010 02:36:07 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d13sm2024152ibb.8.2010.10.07.02.36.06
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 02:36:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CAC411E.3010204@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158388>

Hi Christoph,

Christoph Mallon wrote:

>   git init test
>   cd test
>   printf 'a\nb\nc\n\n' > file
>   git add -AN
>   git diff --check
> 
> The last command will show "file:1: new blank line at EOF.".
> 
> It works fine, if the diff is not against /dev/null, e.g.:
>   git init test
>   cd test
>   printf 'a\nb\nc\n' > file
>   git add -A
>   echo >> file
>   git diff --check
> 
> This correctly shows "file:4: new blank line at EOF.".

Try this:

    git init test
    cd test
    printf 'a\nb\nc\n' > file
    git add -A
    echo hello >> file
    echo >> file
    git diff --check

As you can see, it still returns line 4, which is the beginning of the
hunk that adds the blank line.

A change to make it print the line number of the blank line itself
does not sound so bad, though.
