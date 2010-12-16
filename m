From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to unpack recent objects?
Date: Thu, 16 Dec 2010 14:40:59 -0600
Message-ID: <20101216204059.GA3830@burratino>
References: <4D0A77A7.9080702@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 21:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTKdg-00087O-98
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 21:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844Ab0LPUlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 15:41:19 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:51685 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637Ab0LPUlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 15:41:18 -0500
Received: by eyg5 with SMTP id 5so2295497eyg.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 12:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5cX3BIs6+hL1nWjdGrwSsRWfE6BcV7Ggj+b8gO3I/qw=;
        b=CUBEi2EmVDtG1iLHoC0fVmGo+V/R1KX6SkS1JUNA0HcMnZZyc5m8ZrhU92R+KxMZe3
         1R3r9F72dyldiAim9sQcYiB02PfzddW6CUHO3LY2EjwOVDuRLcl9c/iX1deL+/kudWS0
         VTYx1VMtn2IQtjbRrzO+A2SsXHDStTN6/otEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LCj6rqUIFxbgVWXKLn3ctIXazu+PE5FKN2uQtYjU5NcipeeLv64b3jeemtz5HnVtLo
         dyQbdAOwpmDuk5hB6aGH2pOXiu7HMjNsUa5og8lQF6mBIHz/5Vk8rLOSyryOReXgc3rb
         V5/dewRgKhm5BHTr9rdSu31t3m+J9A0RdYe7U=
Received: by 10.216.165.85 with SMTP id d63mr159338wel.12.1292532077473;
        Thu, 16 Dec 2010 12:41:17 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id j58sm263214wes.21.2010.12.16.12.41.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 12:41:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D0A77A7.9080702@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163812>

Hi Phillip,

Phillip Susi wrote:

> It looks like you can use git-unpack-objects to unpack ALL objects, but
> how can you unpack only recent ones that you are likely to use while
> leaving the ancient stuff packed?  Ideally I want to unpack all file
> objects from the current commit, and a reasonable number of commit
> objects going back into the history so accessing them with checkout,
> diff, log, etc will be fast.

Have you tried the experiment?  You can pack all objects and then make
a few commits that do not reuse any blobs from before on top of that;
then "cp -a" the repository and use "git gc --aggressive" to get one
big pack as a control.  Then it should be possible to time checkout,
diff, log, etc[1].

It would also be interesting to know what the nature of these objects
are, in case it is possible to speed things up some other way.

Jonathan

[1] My uninformed guess is that the packed version will be faster,
because of cache effects among other reasons.  The point of loose
objects is to speed up writing objects rather than reading them.
But I'd be happy to be surprised.
