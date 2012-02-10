From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in fill_project_list_info
Date: Fri, 10 Feb 2012 23:07:01 +0100
Message-ID: <201202102307.02055.jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com> <201202102230.13193.jnareb@gmail.com> <7vobt6nz31.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 23:07:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvycj-0001aB-BN
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 23:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759185Ab2BJWHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 17:07:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37194 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540Ab2BJWHD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 17:07:03 -0500
Received: by eekc14 with SMTP id c14so1105356eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 14:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=86p0pY32/VQ9GOrZo2nbDAXNpBx53JKH9rmdJcOxMi4=;
        b=G6YWLShH5RrYW5OBNCaulJKCorcEgu728pHPNdJw9rb82k6MLg+uejaoKlurofLZtw
         aZQTEHC8kUxb8GGqN2AfCardxHBKAW3g7mNlfH9aU6gRPq4v+3iLZI4HTXiIARX8EZh9
         nAfA/gzLTyADPRuKZFzlsG3/l+Ogba1/R0YZk=
Received: by 10.14.45.75 with SMTP id o51mr2592579eeb.20.1328911622122;
        Fri, 10 Feb 2012 14:07:02 -0800 (PST)
Received: from [192.168.1.13] (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id v51sm27086172eef.2.2012.02.10.14.07.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 14:07:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vobt6nz31.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190467>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> Exactly.  Why do you need @fill_only at all?  If you are interested in
>>> ctags and you want to make sure ctags is available, the question you want
>>> to ask the helper function is "Does the project structure already have
>>> ctags field?".  Why does the helper function needs to know anything else?
>>
>> It is to support incremental filling of project info.  The code is to
>> go like this:
>>
>>   create
>>   filter
>>   fill part
>>   filter
>>   fill rest
>>
>> We need @fill_only for the "fill part".
> 
> Again, why?

So fill_project_list_info() knows what needs to be filled (notice: not
"what to fill"), as filter might need different fields in project info
to do its work.
 
> > As filling project info is
> > potentially expensive (especially the 'age' field),
> 
> So you wouldn't say "I am interested in 'age' field" but show interest in,
> and fill, cheaper fields in the earlier "fill" calls, and then...

It is not about cheaper, it is about required by filter.  It happens that
it is cheaper.

> > doing it on narrowed
> > (filtered) list of project is a performance win.
> 
> ... you drop uninteresting projects by using the partially filled
> information, and show interest in more expensive 'age' in the later round
> for surviving projects.
> 
> It still does not explain why you need @fill_only.

So I can use single subroutine fill_project_list_info() to fill what is
required, and to fill the rest of info.

   create
   filter
   fill part('path', 'descr')
   filter('path', 'descr')
   fill rest

or

   create
   filter
   fill part('ctags')
   filter('ctags')
   fill rest

Am I clear?
-- 
Jakub Narebski
Poland
