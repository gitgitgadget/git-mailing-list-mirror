From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: PATCH/RFC] gitweb.js: Workaround for IE8 bug
Date: Tue, 8 Dec 2009 23:24:48 +0100
Message-ID: <200912082324.49825.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200912081729.11890.jnareb@gmail.com> <1260309382.5658.41.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 23:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI8UU-0002hR-UD
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 23:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389AbZLHWYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 17:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756382AbZLHWYx
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 17:24:53 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55684 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364AbZLHWYw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 17:24:52 -0500
Received: by bwz27 with SMTP id 27so4794131bwz.21
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 14:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7PIdwWYs10u7ryvFWRdir00o+ajufTKoiyYI+6jqonY=;
        b=Uckq4zglxyCYnqXrb/kqXOzWUTm/XYgImGgb4KRwhC8daQv8G8hYukMvyqHf6ymxpf
         2T0EIKocA3TgKXTv9SuTNG6d4ZtstuDey0RriqBvGx3RgDzeGT70JTHunzEO4wopQlGp
         IJ3ahbyMptUfLkZ9XEHnxqUBYSoYb7aOuBqRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xYxQ9b3gjq3r8Mt+4XYYBet4Q82FpQ94qmHdkTMZFAV76YZNu+2aNTaueXNsDBMVDd
         K18SLOvGlm69ocxg8fLGuqFt+eelw8Jl95IGUORBG3tqSUHqHSMm+MlwGebo93QE+jXP
         Az80D97V7xRnDiCL4Q+rr91B7cglDhv5+P0mE=
Received: by 10.204.24.20 with SMTP id t20mr208607bkb.141.1260311096197;
        Tue, 08 Dec 2009 14:24:56 -0800 (PST)
Received: from ?192.168.1.13? (abwp196.neoplus.adsl.tpnet.pl [83.8.239.196])
        by mx.google.com with ESMTPS id 1sm5251361fkt.3.2009.12.08.14.24.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 14:24:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1260309382.5658.41.camel@swboyd-laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134917>

On Tue, 8 Dec 2009, Stephen Boyd wrote:
> On Tue, 2009-12-08 at 17:29 +0100, Jakub Narebski wrote: 
> > 
> > Does the following fixes the issue for IE8 for you (it works for me)?
> > 
> 
> Yes, there is no longer an error but IE8 still locks up and takes about
> 30 seconds. It doesn't seem to be any more responsive. Isn't putting the
> error in a try-catch just papering over the issue?

Well, I wrote it is *workaround* for IE8 bug, didn't I?

There are actually two separate issues.  First is 'blame_incremental'
freezing browser (making it non responsive), second is proper solution
to this bug.

The problem with 'blame_incremental' freezing is that JavaScript is
single-threaded, and that modifying DOM is not lightweight.  gitweb.js
should then use technique described in
  http://www.nczonline.net/blog/2009/08/11/timed-array-processing-in-javascript/
to avoid freezing browser, and perhaps also some technique to avoid
reflowing (if possible).

The proper solution for IE8 bug would be to use 'progress', 'error'
and 'load' events of XHR 2.0 (XMLHttpRequest specification level 2)
if they are available, instead of mucking with underspecified 
'readystatechange' event from XHR 1.0 and timer.  But it is a more
complicated solution.

-- 
Jakub Narebski
Poland
