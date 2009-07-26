From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 10/10] gitweb: Create links leading to 'blame_incremental' using JavaScript
Date: Sun, 26 Jul 2009 12:06:11 +0200
Message-ID: <200907261206.15646.jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com> <1248475450-5668-11-git-send-email-jnareb@gmail.com> <20090725104622.GA7337@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun Jul 26 12:07:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV0dL-0007tD-Gm
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 12:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbZGZKGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 06:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZGZKGZ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 06:06:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:45516 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbZGZKGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 06:06:24 -0400
Received: by fg-out-1718.google.com with SMTP id e21so666616fga.17
        for <git@vger.kernel.org>; Sun, 26 Jul 2009 03:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=30DLinEwhQ8lQuZGg6mqtUNpdwsKpwZ6/sp29riKyO4=;
        b=nwKPOGSwVGeuLcyA/BZfZZUqcwfEFqK0Z5GfClE+COL2YHi98GdnRQmul+4SHYsbla
         VsmozqRq0OnDgUrQWLq7gYKgJcHLzNMYgiLaONhRUaEaCwITm9857vbyXnk94Jx/QNd0
         ZHf3bs6Yu3yYCUpPJf2EBh3L+koMlm5u0hBOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CfaLVkLM0da+UJoU6IQuBgZQf40MfqtYjVn9DnDx3SCX6dK+SqaB3vzLgNeqlPAQwf
         IckAtcwA9Glz3/8ghd1U9I4ryfkVaGiwMEq2TED8U1PtrpVA2myeRYd/91SvlLv7g2RZ
         9hJbXLgOKWxLDWExiKIZy0DfQn78Yk2haYVcc=
Received: by 10.86.68.7 with SMTP id q7mr1472678fga.3.1248602783111;
        Sun, 26 Jul 2009 03:06:23 -0700 (PDT)
Received: from ?192.168.1.13? (abvh124.neoplus.adsl.tpnet.pl [83.8.205.124])
        by mx.google.com with ESMTPS id 3sm13819929fge.3.2009.07.26.03.06.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Jul 2009 03:06:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090725104622.GA7337@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124115>

On Sat, 25 Jul 2009, Martin Koegler wrote:
> On Sat, Jul 25, 2009 at 12:44:10AM +0200, Jakub Narebski wrote:

> > TODO list:
> > * Perhaps put fixLinks() function in separate file gitweb.js.
> >   Should gitweb use single JavaScript file, or should it be split into
> >   more than one file?
> 
> The same question can be asked for gitweb itself:

Well, there is one important difference: gitweb itself is not send
over network to client.  JavaScript is.  (Although I'm not sure how
great it is of an issue, with browsers caching JavaScript.  Perhaps
one single file would be better idea.)

> 
> Why is it a single perl file and not splited in many different
> modules?

There are a few causes.

1. Gitweb (then gitweb.cgi) started as single file.  There is a bit
   of resistance to changing this, especially that splitting it might
   make it harder to interate changes from other people who still use
   single file gitweb (see for example gitweb fork at git.kernel.org
   history).

2. Having it all in single file make its easy to install and update.
   Well, it made more sense when only way to configure gitweb was to
   edit gitweb.cgi.  Now building gitweb.cgi is the task for build
   system, and the only thing left is to copy files in correct place
   (I think that there are distribution specific packages which makes
   installing gitweb as easy as "xxx install gitweb").

3. You would have to decide _how_ to split it into many different 
   modules.  Do you know any good examples?

-- 
Jakub Narebski
Poland
