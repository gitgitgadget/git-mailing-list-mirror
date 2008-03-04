From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] git-submodule: multiple-level modules definition
Date: Tue, 4 Mar 2008 21:27:25 +0800
Message-ID: <46dff0320803040527l681f8068n2455843b2bb23cc7@mail.gmail.com>
References: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 14:28:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWXBc-0004nW-Hc
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 14:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbYCDN11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 08:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbYCDN11
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 08:27:27 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:60167 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbYCDN10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 08:27:26 -0500
Received: by an-out-0708.google.com with SMTP id d31so153017and.103
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NZ/Vd+mG98/fEOcmIguSNW8NKEZevEjFNjanprHvWVQ=;
        b=nDtjutSFL2+kwfEPk84ZfkPjfRyk3Hl3ttX/AEO2+CUHKZjGobifFzXLhjQf9NH8+U0y+6B9jS+83AOJ5yMonb3KpUaQuxKjvZfRcwA/5FpMYPRIOHk5TPevuwOJJh5/O5+VwNyPOgm3qP728lVsXTpNA5aa9/ZhcsmeTCPhdZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C7Wti/Yyc815SZm+cT/K20AhOVj3/AsCjDuONB6/5eT+/Qvgnoihd2HGNsjeeukLaSdLcsU+VbvHnU0w7P0oVwYZa9kd+7BRBRHXKw059afSAORjLq9hvCIvVVpS1pkHZL/RRHZCOkQH4oQt57Zrg8/pyi+eHMUxD+MW3omfL4U=
Received: by 10.100.173.18 with SMTP id v18mr2862814ane.101.1204637245151;
        Tue, 04 Mar 2008 05:27:25 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Tue, 4 Mar 2008 05:27:25 -0800 (PST)
In-Reply-To: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76083>

On Mon, Mar 3, 2008 at 1:11 AM, Ping Yin <pkufranky@gmail.com> wrote:
> 1. .gitmodules supports multiple submodule level definition
>
>  This follows suggestions from Linus and and Sven Verdoolaege etc.
>  See "Let .git/config specify the url for submodules"
>  (http://article.gmane.org/gmane.comp.version-control.git/48939).
>
>  .gitmodules with with multiple level of indirection
>  ------------------------------------------------------
>  [submodule "service"]
>     submodule = crawler
>     submodule = search
>  [submodule "crawler"]
>     submodule = util
>     submodule = imcrawter
>  [submodule "search"]
>     submodule = util
>     submodule = imsearch
>  [submodule "util"]                      (1)
>     url = git://xyzzy/util.git
>  [submodule "imsearch"]
>     path = search/imsearch
>     url = git://xyzzy/imsearch.git
>  [submodule "imcrawler"]
>     path = crawler/imcrawter
>     url = git://xyzzy/imcrawter.git
>
>  (1): path default to submodule name
>  ------------------------------------------------------
>
>  To simplify the case, submodule sections with submodule attribute should
>  have neither path attribute nor url attribute (if have, should be ignored).
>
>  2. Designate modules by logical names instead of real path
>
>  "--name|-n" options is proposed with which modules are designated by logical
>  names instead of real paths as following example shows.
>
>  Identical commands forms with/without "--name"
>  ---------------------------------------------------
>  $ git submodule XXX util imcrawler              (1)
>  $ git submodule XXX -n crawler                  (2)
>  $ git submodule XXX util imcrawler imsearch     (3)
>  $ git submodule XXX -n service                  (4)
>  $ git submodule XXX -n crawler search           (5)
>
>  * XXX represent list, update or init, but not add
>  * (1) and (2) are idetical conditionally (explained below)
>  * (3), (4) and (5) are idetical conditionally
>  ---------------------------------------------------
>

Maybe i should introduce more about the background.

In my company we try to keep all the codes in a unique big environment
which consists of many sub projects (more than 30). These subprojects
are hierachily organized. There are different roles which need touch
different part of these sub projects. For example, crawler deveoper
should touch crawler-related projects, and search developer need touch
search-related projects. There are also some common modules which are
used by most of these roles. There are also many other roles.

So for easy use, we need define one logical name for each kind of role
and this name should correspond to all the role-related sub projects.
Filtering submodules by path is not so useful for us because
role-related projects may live in many different directories.

>From the management view of company,  all the roles should use the
same big environment. And we don't want to use different branch for
different roles. So all roles will get the same .gitmodules file. They
are not much familiar with git and can't afford to type git init path1
... pathn each time when they want to build their develop environment.
It's more friendly to them if they only need to remember a logical
name such as crawler or search.

And some people have multiple roles. Sometime they want to work on
search and sometimes on crawler. So logical name is very convenient to
them.

As a conclusion, my main point is
1. Multiple level module definition is very useful since it can help
us build hierachy of modules
2. Designating modules by logical name which corresponds to a group of
role-related modules is usefull since it can help role-based
development much.



-- 
Ping Yin
