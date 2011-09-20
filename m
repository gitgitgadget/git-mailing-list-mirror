From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Git 1.7.6: Sparse checkouts do not work with directory exclusions
Date: Tue, 20 Sep 2011 09:22:47 -0600
Message-ID: <4E78AFC7.4050102@workspacewhiz.com>
References: <4E77BC36.7060005@workspacewhiz.com> <CACsJy8CDtswtPJVt-T911_1y0WqShonvcCbXhFtWu2zjEqLa4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 17:22:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R629B-0001Ku-Q3
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 17:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976Ab1ITPWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 11:22:03 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:43647 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab1ITPWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 11:22:02 -0400
Received: (qmail 28841 invoked by uid 399); 20 Sep 2011 09:21:57 -0600
Received: from unknown (HELO ?192.168.1.11?) (jjensen@workspacewhiz.com@50.8.110.77)
  by hsmail.qwknetllc.com with ESMTPAM; 20 Sep 2011 09:21:57 -0600
X-Originating-IP: 50.8.110.77
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CACsJy8CDtswtPJVt-T911_1y0WqShonvcCbXhFtWu2zjEqLa4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181773>

----- Original Message -----
From: Nguyen Thai Ngoc Duy
Date: 9/20/2011 4:09 AM
> On Tue, Sep 20, 2011 at 8:03 AM, Joshua Jensen
> <jjensen@workspacewhiz.com>  wrote:
>> Sometime after Git 1.7.3.2, sparse checkouts stopped working for me.  My
>> sparse-checkout file looks something like:
>>
>> *
>> !DirA/
>> !DirB/
>> DirC/
> Confirmed. It got me wonder why the negated pattern tests did not
> catch this. Turns out this works:
>
> /*
> !DirA/
> !DirB/
> DirC
>
> This is my theory why yours does not work: negated patterns !DirA and
> !DirB excludes both directories, but git still descends in them
> because you may have other patterns that re-include parts of
> DirA/DirB, for example:
>
> DirA/DirD
> !DirA
>
> When it's in DirA/DirB, "*" tells git to match everything (equivalent
> "DirA/*" and "DirB/*"), so it matches all entries in DirA/DirB again,
> essentially reverting "!DirA" and "!DirB" effects.
>
> By using "/*" instead of "*", we tell git to just match entries at top
> level, not all levels.
>
> I think it makes sense, but it's a bit tricky.
I can confirm this fix works for me, but it is certainly tricky.  IMO, 
it should either be documented or some kind of fix should be added to a 
future version of Git to allow * by itself to work again.

>> and describe why those lines were removed?
> Quotes from 9e08273: "The commit provided a workaround for matching
> directories in index. But it is no longer needed."
Yeah, I saw that, but it made little sense to me, especially since it 
seems to break a behavior that worked before.

Thanks!

Josh
