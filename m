From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/6] GITWEB - Makefile changes
Date: Fri, 11 Dec 2009 17:41:51 +0100
Message-ID: <200912111741.51760.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <m3pr6ld1p2.fsf@localhost.localdomain> <4B2271B4.2010301@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 17:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ8Xn-000286-5F
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 17:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZLKQk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 11:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbZLKQk0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 11:40:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:7691 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZLKQk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 11:40:26 -0500
Received: by fg-out-1718.google.com with SMTP id 16so247830fgg.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eOWLjefI7KmNC7ZLQoKnZBHTSqM2bzLsSzXrYhMqBJU=;
        b=Fbq6xfp8nMBGa397KJUyTOavpu75uJi+MBscIUZupljMIOgvEtyYns2WniXLeAyrst
         /QtgXw+7KX/kdnXjj9hrerNgreFYhZi9Zv1o9mpj/zKn2bs+zmUGbbN9snr242sxZF95
         +6zs29ddXyIA5S9SSVvnD/2xDL+S2N3utd3FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=r5bu4AQZVnIMaVu9+E/JnxgoBWtO19hf8RPzQ/d0nvQprt3z3hLkIE0EveUBJKnldD
         VouKagQdK1dl2MFydyEhwFUoJ8Ajlh8KZggGntMeHZkDusc9l8EySd+M82AJoOVZKWQQ
         0Vfxesa6SoWG0V/Dy7LTaq3e/I6kIBtG6a8Q4=
Received: by 10.86.254.17 with SMTP id b17mr2025630fgi.65.1260549631733;
        Fri, 11 Dec 2009 08:40:31 -0800 (PST)
Received: from ?192.168.1.13? (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id d4sm4591755fga.16.2009.12.11.08.40.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 08:40:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B2271B4.2010301@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135096>

On Fri, 11 Dec 2009, J.H. wrote:

>> IMPORTANT!
>> 
>> A note about this change: I think it would be better to move creating
>> gitweb.cgi (and optionally gitweb.min.js) to gitweb/Makefile, and make
>> main Makefile call gitweb/Makefile, and not vice versa like in your
>> solution.
>> 
>> If it is possible.
> 
> It's quite possible, and I'm fine with doing that.  If no one has any 
> objections I can re-work those with the understanding that the build 
> process for gitweb shift to the gitweb/ directory instead of the main 
> Makefile.

In my opinion it would be better solution because it would reduce size
of main (master) Makefile, and not be much larger than this solution.
 
git-gui/, Documentation/, perl/ all have their own makefiles, which do
the work, and are called from main (master) Makefile.

>>> diff --git a/Makefile b/Makefile
>>> index 4a1e5bc..8db9d01 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1509,6 +1509,8 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
>>>  	chmod +x $@+ && \
>>>  	mv $@+ $@
>>>  
>>> +.PHONY: gitweb
>> 
>> Why it is here, and not with the .PHONY block at line 1924 of
>> Makefile?  It would be nice to have comment supporting this choice in
>> email with this patch (or in commit message).
> 
> There are 6 other instances of .PHONY in the makefile, having the .PHONY 
> localized seemed to make it the most obvious since it was right next to 
> the actual target.

I was thinking here about this large block of .PHONY declarations,
the one which is not inside conditional.
 
>>> +gitweb: gitweb/gitweb.cgi
>>>  ifdef JSMIN
>>>  OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
>>>  gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
>>> @@ -1537,7 +1539,7 @@ endif
>>>  	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
>>>  	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
>>>  	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
>>> -	    $< >$@+ && \
>>> +	    $(patsubst %.cgi,%.perl,$@) >$@+ && \
>> 
>> Why this change?
> 
> Preparation for a later change.  The change could happen all at the same 
> time if it makes more logical sense.

Please at least describe this change in commit message.

But I think it could be moved to other patch, or put in separate patch.
This change has nothing to do with easier gitweb generation.
 
>>>  	chmod +x $@+ && \
>>>  	mv $@+ $@
>>>  
>>> diff --git a/gitweb/Makefile b/gitweb/Makefile
>>> new file mode 100644
>>> index 0000000..8d318b3
>>> --- /dev/null
>>> +++ b/gitweb/Makefile
>>> @@ -0,0 +1,14 @@
>>> +SHELL = /bin/bash
>> 
>> Why is this needed?

Why do you need to define SHELL?
 
>>> +
>>> +FILES = gitweb.cgi
>>> +
>>> +.PHONY: $(FILES)
>> 
>> Why .PHONY?  $(FILES) are created.
> 
>  From this makefile I wanted to explicitly call up to the main makefile 
> no matter what, the main makefile doesn't consider the targets .PHONY 
> and it has all the dependencies that it would expect.

What is the reason of this phony .PHONY?  If gitweb.cgi is newer than
gitweb.perl (and other sources), then without .PHONY it wouldn't be 
regenerated.  With .PHONY it would call master Makefile... which would
notice that gitweb.cgi is newer than gitweb.perl and do not regenerate.
 
So what this .PHONY does is unnecessary call make on master Makefile...



But I guess this issue would be moot if it was the other way around,
i.e. master Makefile calling gitweb/Makefile.

-- 
Jakub Narebski
Poland
