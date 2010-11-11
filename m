From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 04:37:42 -0600
Message-ID: <20101111103742.GA16422@burratino>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 11:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGUXn-0000Sj-8A
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 11:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab0KKKiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 05:38:09 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48440 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0KKKiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 05:38:08 -0500
Received: by gxk23 with SMTP id 23so1050949gxk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 02:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mbTK+BC0p+04Azlphv4Yu9/cI9E9hq/clKUHsQkNYJU=;
        b=eQhLBpWTyUJc1o0wTqyNS952X/xDSFQkZBIi/4lURmCT+EpYAXDCZnRgT+lGuJ4nuN
         u+3eGuoDB7pga19bjW1EN1s295cCVJ3QmVv76/hyZiZCsYNTDScdQlvBeR9KnmRVgwm6
         i1EaEB2awVUuIeLTXrb3FpxZNI7FfOZAAFzHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LmbFY6wDVDu+jbqDuBO/dFTOcUPQrNpiLF4mIWnfViorWTp418PkjobfvLvW4LxfCj
         nGbs2ZsW0/irrlXEhvK6R/LKfo8EPzPabzcydQNPAuF2q8U7RRsjT7+2rf+8vtLCF7ah
         J0lAC1IuieUKlMaXuP7SddfDsSp04UwNwY804=
Received: by 10.150.144.19 with SMTP id r19mr1520809ybd.141.1289471887741;
        Thu, 11 Nov 2010 02:38:07 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q4sm2423427yba.2.2010.11.11.02.38.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 02:38:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161221>

Hi,

Dun Peal wrote:

>   $ python -c "import os; os.popen('git clone git@git.domain.com:repos/repo.git')"
>   [...]
>   $ cat repo/.git/config
>   [branch "master"]
>           remote = origin
>           merge = refs/heads/master

It looks like you've probably figured it out already, but for
completeness:

Most likely the clone is terminating when Python exits, perhaps due to
SIGPIPE.  It doesn't look like a bug to me; I suspect you meant to use
os.system(), which is synchronous, instead.  You might be able to get
a better sense of what happened with GIT_TRACE=1 or strace.

Hope that helps,
Jonathan
