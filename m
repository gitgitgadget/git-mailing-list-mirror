From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: allow access to forks with strict_export
Date: Sat, 13 Dec 2008 23:51:33 +0100
Message-ID: <200812132351.37420.jnareb@gmail.com>
References: <1229203014.31181.7.camel@mattlaptop2.local> <m3prjvg2st.fsf@localhost.localdomain> <7vr64b4sib.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 23:53:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBdM5-0006se-Sd
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 23:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbYLMWvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 17:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbYLMWvn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 17:51:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:19912 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbYLMWvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 17:51:43 -0500
Received: by nf-out-0910.google.com with SMTP id d3so327185nfc.21
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uSqYQlkedt1dyLyS4tedxiOhisaltC7/sy4sLcfiEO8=;
        b=r1kuA702X3bZ9vQUir8FI0puIPum346pVJ5HFICNXAq2+zxikn5rNkcy5tPAeQ8Akr
         SxIlVuekjiLDKdzUEDoPH2thCmWPmSvKJOrcrzJO4EPqd8E681wnb+vdabPV8kp4I8Bh
         xJgYYJKvBezKY2QizDhtQ8rmpV27aSBoGCO9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sgF7fq+kw9fM+/dZFrJ/UsR/khHLx2kHXcGVRUHDIldkUwO9Q1pTll9FrddE9iSFKy
         2Hu5P0cPm7gQ0qVvf58PoLANJ8GDQNrIQbroiyCYN3tn+Ywc6xgQODdWjiKJLpXaYUkT
         Q09igDY5yeW8oeKWk/AkydW62rjqBM0bn6F0k=
Received: by 10.67.89.15 with SMTP id r15mr795323ugl.59.1229208701046;
        Sat, 13 Dec 2008 14:51:41 -0800 (PST)
Received: from ?192.168.1.11? (abvz56.neoplus.adsl.tpnet.pl [83.8.223.56])
        by mx.google.com with ESMTPS id 19sm2395243ugl.12.2008.12.13.14.51.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 14:51:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr64b4sib.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103033>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > Matt McCutchen <matt@mattmccutchen.net> writes:
>>
>> CC-ed Petr Baudis, author of forks support in gitweb.
>>
>>> git_get_projects_list excludes forks in order to unclutter the main
>>> project list, but this caused the strict_export check, which also relies
>>> on git_get_project_list, to incorrectly fail for forks.  This patch adds
>>> an argument so git_get_projects_list knows when it is being called for a
>>> strict_export check (as opposed to a user-visible project list) and
>>> doesn't exclude the forks.
>>>
>>> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
>>
>> Looks good for me.
> 
> That sounds like a broken API to me.
> 
> At least, please have the decency to not call the extra parameter "for
> strict export".  I would understand it if the extra parameter is called
> "toplevel_only" (or its negation, "include_forks").
> 
> IOW, don't name a parameter after the name of one caller that happens to
> want an unspecified special semantics, without saying what that special
> semantics is.  Instead, name it after the special semantics that the
> argument triggers.
 
Ahhh... true. 

"no_hide" (currently "include_forks") allows us to _not_ passing this
parameter in other places than project_in_list(); undef is falsy.

By the way, doesn't git_project_index and perhaps git_opml also need
this parameter passed to git_get_projects_list?

Then patch subject would change...
-- 
Jakub Narebski
Poland
