From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 22:40:37 +0200
Message-ID: <201007192240.38681.jnareb@gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com> <4C448879.4040202@workspacewhiz.com> <1279568744.3009.14.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 22:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oax8o-0006y3-7b
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 22:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966720Ab0GSUkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 16:40:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42859 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936513Ab0GSUkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 16:40:40 -0400
Received: by fxm14 with SMTP id 14so2411172fxm.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CflIcsO0kaKZDdy+VPIWQUmeV86QusvvtgdBEffRWcY=;
        b=NXwoXlZDjOLEODK9CFetFDOVi6496CihM7vBb/AwGJvjIrwxJ1eQyYjmV1HRPOlrCx
         rGkOfk8aAr/ZA/g7WPAyikQj9rOiACQemnSEgTT62IP09lkmqnAOfSvpqsEomrrYfsAG
         As9LaMuqrIjL58YTj0cJs8AhrEJZtoIdcD3Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wVSSfgxdZeVqkS1TJKNJl9TZNrPF5EAXsO7XQecuD0NgqbqN2NBtxBAUIOS60XiCAl
         hYqACG9Qq7RAYr5m9KRgEprWkdvkcpcvaRtEJE43eG3MES19LgpdiDbDK6bX6xghdOuX
         Zox9f3Ot3zvjVv37WNPhFWdp4FWA4vwLOlG/0=
Received: by 10.223.121.147 with SMTP id h19mr4330068far.76.1279572039104;
        Mon, 19 Jul 2010 13:40:39 -0700 (PDT)
Received: from [192.168.1.13] (abwh94.neoplus.adsl.tpnet.pl [83.8.231.94])
        by mx.google.com with ESMTPS id e20sm1581972fak.47.2010.07.19.13.40.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 13:40:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279568744.3009.14.camel@dreddbeard>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151278>

On Mon, 19 Jul 2010, Will Palmer wrote:
> On Mon, 2010-07-19 at 11:16 -0600, Joshua Jensen wrote:

> > My brain has become muddied with all the ~2 stuff.  Explain again why it 
> > can't be as simple as this?
> ...snip...
> > git checkout -b integration HEAD@{1}  (or 8000000)
> > 
> > -Josh
> 
> Because:
>  1) The HEAD reflog is the wrong place to stick things which weren't
> recently checked-out.
>  and 2) the previous tip is currently the easiest-to-recover part of a
> deleted branch. What's lost is all the reflog data: order of states, and
> how they were reached.
> 
> However, I /do/ think it's as simple as "don't delete the reflog right
> away when you delete a branch", and other edge-cases and niceties in
> terms of UI (such as ref renaming, resurrection of refs for tracking
> unrelated data, etc) can be taken care of later, if there's actually a
> need for them.

There are at least two issues, which are not niceties, but requirements:
1.) not deleting reflog for 'foo' when deleting 'foo' branch blocks
    creating reflog for 'foo/bar' branch because of D/F conflict.
2.) there is issue of 'git branch -m bar foo', i.e. renaming some other
    branch to 'foo', a branch which has its own reflog.

But you are right in that "moving reflog to attic" can be postponed till
needed.

-- 
Jakub Narebski
Poland
