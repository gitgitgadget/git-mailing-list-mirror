From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Mon, 12 May 2008 01:51:19 +0200
Message-ID: <200805120151.20741.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <200805110032.39729.jnareb@gmail.com> <1210485210.11526.145.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon May 12 01:52:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvLL0-00026o-Vg
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 01:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998AbYEKXv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 19:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755989AbYEKXv1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 19:51:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:23631 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbYEKXv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 19:51:26 -0400
Received: by ug-out-1314.google.com with SMTP id h2so582197ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=wZxjV/zie9fzz7X968NlOR/rQgf7WCXksxFet7gi17U=;
        b=wb/dYqoF5fAfLrFPnHgmOUOVMtM0mPbIA1lpXkyAsvGTFhPVNQQ4RP9/uATk/ieWtejNvgOSJd4ncTnbjxdNAKckLw6jXFaPHuh01m2H72nJm/9uglo1aqU6Ie3q0NVn8dBE8nDrKzmVGRSKWDit9UMGoLi+Ymg11wfUE0XJPiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OV6MYmMievRQGL7bO1S6uLW9WO/CvfzY0IKCrR4P5ghrENQ9DE8+0AJyIlyy7RkxZ6JZRuMGJ0EPLpXxjeV2nDbVt5v1crIsEp+yzz3mhgR07uMXXUPVQyLJXAJnklX90bNAWOJYLoqh66dByJ2/7tpSgFBYkPERt7taMBfZq5k=
Received: by 10.67.102.6 with SMTP id e6mr4761841ugm.25.1210549885036;
        Sun, 11 May 2008 16:51:25 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.242.178])
        by mx.google.com with ESMTPS id b36sm3612680ika.5.2008.05.11.16.51.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 16:51:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1210485210.11526.145.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81824>

On Sun, 11 May 2008, J.H. wrote:
> 
> On Sun, 2008-05-11 at 00:32 +0200, Jakub Narebski wrote:
>> On Sun, 10 May 2008, J.H. <warthog19@eaglescrag.net> wrote:
>>
>> BTW. why do you think that kernel.org would be better to have project
>> list pagination turned off?
> 
> If we have caching on I'd rather leave it as a single page, much easier
> to search on and with firefox /<project or name> then <ctrl>+g a couple
> of times is really fast to find what I need.  Also means less to cache
> (good for us) and faster access for most.  I'm going to guess leaving it
> as a single page, unless it gets *very* unwieldy, will be how we leave
> it.

First, you can cache individual pages of projects list output with
small overhead if number of projects per page is large enough.  Second,
see my earlier patch adding project search capability to gitweb
(it is server-side search, though).  Searching needs caching data, not
output, while pagination only can be done with both.


As to single-page projects list being being unwieldy...  You should
take into account how large the page is (having page size in megabytes
isn't too good), how much time it takes to download (and not only
generate), and how much time it takes for web browser to render it.

How many repositories is "too many", that I'm not sure about...

>>> It might also be advantageous to generate the entire list and stash that
>>> somewhere, (session on the host side?) and run the pagination out of
>>> that.
>> 
>> First, when using $projectslist file with new (second patch in series,
>> "gitweb: Allow project description in project_index file" most of data
>> (well, all except age) would be filled by parsing single file.
>> 
>> Second, the idea is to cache results of filled in @$projlist e.g. using
>> Storable, i.e. cache Perl data and not final HTML output.
> 
> I approve of that plan, caching all the html is kinda expensive *hides
> the 20G of gitweb cache he has*

Caching output (HTML) has the advantage of being simple, and avoiding
time to generate page.  Caching data has the advantage of taking less
disk space due to being able to reuse the same data for different pages.
 
-- 
Jakub Narebski
Poland
