From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Fri, 27 Jun 2008 10:31:53 -0700 (PDT)
Message-ID: <m3lk0qiy2i.fsf@localhost.localdomain>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
	<20080626112233.GA17625@cuci.nl>
	<32541b130806271001t35eb97d2gb841e194b54f214@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:33:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHoi-0005rU-3P
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758263AbYF0RcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761789AbYF0RcD
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:32:03 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:61284 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761785AbYF0RcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:32:00 -0400
Received: by fk-out-0910.google.com with SMTP id 18so530044fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=aIzt55jez4VbGsyMrIONvzhlhbsQQAZ2lFMSCHL4Xhc=;
        b=NmBFoK+g8iDVgyhFixtRZWGubYTaO9ETnAvo5mKPr3N0kFo+yNYvj1qMJKddwTV+Xd
         nqqfsHWTqC1OyTPNM9IdxQXknDRXf9eIoy5iswixfCWdStoQyV78ONJp827Fefv6i6si
         udnrYMbeVgoGB6S80kx0u7PiLgpFgZ9rlr0eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=MJN/LCInB1VzQvvSChPCGENHCnhtn4QvkBuyZOGElI9PpXsyXpU5R/oKqMCZiwL0JI
         jKiT2TOZrip6ejoUViDEP4BMLPPE+tq99vpddT16CYkRwnnJ4s26JX3ITIaXWqbFX+3x
         W/jT1qwQ8GM5cj+HpLN5GFsfp8DUEmDJ1+hFU=
Received: by 10.78.192.20 with SMTP id p20mr537864huf.16.1214587914794;
        Fri, 27 Jun 2008 10:31:54 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.205.161])
        by mx.google.com with ESMTPS id y1sm729499hua.41.2008.06.27.10.31.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 10:31:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5RHVpZb031519;
	Fri, 27 Jun 2008 19:31:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5RHVoNJ031515;
	Fri, 27 Jun 2008 19:31:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <32541b130806271001t35eb97d2gb841e194b54f214@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86607>

"Avery Pennarun" <apenwarr@gmail.com> writes:
> On 6/26/08, Stephen R. van den Berg <srb@cuci.nl> wrote:
>> Avery Pennarun wrote:
>>>
>>> 1) What's a sensible way to tell git to *not* opendir() specific
>>> directories to look for unexpected files in "git status"?  (I don't
>>> think I know enough to implement this myself.)
>>
>> Would checking the mtime on the directory itself help?
> 
> I'm guessing it would help somewhat (although not as much as not
> checking anything at all).  However, we'd still have to check the
> mtime *against* something, and I don't think the index stores
> information about directories themselves.

By the way, from time to time there on this mailing list is idea
to add entries for directories in the index.  This could help situation
like yours, tracking emty directories, faster operations when some trees
are unchanged, subtree <-> subproject changes.

But it always comes back to: 1.) no proposed implementation, 2.) "git
tracks contents"...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
