From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in gitweb (20 Sep 2008)
Date: Mon, 22 Sep 2008 14:43:37 +0200
Message-ID: <200809221443.38689.jnareb@gmail.com>
References: <200809210138.01874.jnareb@gmail.com> <cb7bb73a0809211322q5aa6d8ex88651aa33a6c2688@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Lea Wiemann" <lewiemann@gmail.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 14:45:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khkmj-0001KS-UQ
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 14:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbYIVMnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 08:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYIVMnw
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 08:43:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:10812 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYIVMnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 08:43:52 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1352746ugf.37
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Hjf4D6rqs1u7436Whhm8apCq18JuJBJMg5FGpzYabyE=;
        b=tkgQiCDm54Ow02bMKhKB9KG37725dMeYjuNQK3ei2s7Ul5OdGs7GTBPjKnX+EtiM7L
         VlW2MVLgXdzD8l10Y3snqyvSFmxlvFi3r6u1rmymNWDvSitiOAGPSfltDwM5hooyUFXU
         bj6K3YOh9/z65PqTHQEgAAtaYSOFobm8Mosag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Evetv/WQNO5Lh+f1i9WOi6xQs+NvPvxQy+75VM3O5EhoqizNamWEFVvMfbF8GBObUy
         MevZnxYOsw87U1x4D2vUp58bFgtWbeMULArGkzi0RkO+nnGehIy8aLtzl2mxHqOARP4P
         nXZ8lte9MKs6f9f6y5pVmEE0/AGFb3G+3m9bA=
Received: by 10.67.27.3 with SMTP id e3mr3624352ugj.74.1222087428652;
        Mon, 22 Sep 2008 05:43:48 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.206.218])
        by mx.google.com with ESMTPS id b39sm8861290ugf.48.2008.09.22.05.43.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 05:43:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809211322q5aa6d8ex88651aa33a6c2688@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96478>

Giuseppe Bilotta wrote:

> > 1. "gitweb pathinfo improvements" by Giuseppe Bilotta
[...]
> >   Need some refinement, especially with respect to _generating_
> >   path_info URLs inside gitweb.  Some patches (2 and 5) does not
> >   need correction, and probably should be sent as separate series.
> >   Author promised to resend series, if I remember correctly.
> 
> I'll resend the whole series (plus an additional patch to fix an
> aesthetical issue I found recently) as soon as I fix the url
> generation for the dotted filename corner case (which by re-reading
> the past emails seemed to be the only significant issue, correct?).

I think it was the only significant issue (besides the fact that
two mentioned patches could be in separate series).  To be more
exact the issue was with generating gitweb URLs for sets of
parameters which cannot be represented as path_info URL.  One
example was filename with '..' in it, which cannot be used in
the following path_info form:
  $hash_parent_base:$file_parent..$hash_base:$filename
but it can be used in 'no name change' form
  $hash_parent_base..$hash_base:$filename
This requires fallback to 'query' form URL.

Other example was branch name with the same name as one of gitweb
actions, which require action to be stated explicitly even if it
is default action and otherwise could be omitted.

> Should be shortly.

I see that it is now. Thanks.

> > 2. "[PATCH] gitweb: shortlog now also obeys $hash_parent"
> > by Giuseppe Bilotta 
[...]
> > More important fact is that I'd very much like for _all_ log-like
> > views (perhaps with exception of feeds: Atom and RSS) to implement
> > this feature.  This could be done by either doing it all in the same
> > commit, doing commit series changing 'shortlog', 'log' and 'history'
> > separately, or what I would prefer actually, to refactor generation
> > of log-like views to use single worker/engine subroutine.
> 
> I agree that refactoring is probably the best idea. It will also take
> me some more time ;)

But it has the advantage of making it easier to add more log-like
views, like 'log' like view for the 'history' view, i.e. --pretty=full
like view with path limiting.

I have thought about doing the refactoring (it is/was on my long-term
TODO list for gitweb), but I haven't even found good way to code it,
to be flexible but not too generalized.  Callbacks, perhaps?
 
> BTW, I haven't heard from Lea, so can I just assume that my patches
> don't touch any of her caching improvements?

-- 
Jakub Narebski
Poland
