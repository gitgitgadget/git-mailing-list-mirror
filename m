From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: rebase planning: determining blobs changed by multiple branches
Date: Mon, 07 Feb 2011 19:27:54 -0600
Message-ID: <4D509C1A.50801@gmail.com>
References: <iiq3kb$aiv$1@dough.gmane.org> <1297126350-sup-6606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 08 02:30:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmcPJ-0008U3-Mf
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 02:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab1BHBaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 20:30:10 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42014 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab1BHBaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 20:30:09 -0500
Received: by gyb11 with SMTP id 11so2004883gyb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 17:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nDHdngZ4JHtN29rHptdBJygXNyCKo7LLS93/cxyXRrs=;
        b=Wior0z//Cm7JsGZjmm7hjjASTtpiimVc9QSc0UadFUGmK/FQnqs3rwR0MiJhvPYN8v
         MCJ47HaRvYbqvMP5cpUILDojwD7dZkt30dkkzPgbHENFLxRwzEjmPAGSyDN6eH+u3fqv
         bZYi6VWxw6ZY1iDQ+qKlAW7Gmpq3cyyk9e1fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=D8F5n3zydd8veF7utWrjEk3tPNrrLAtvOf4SkkvfFBU+a0RAXUqdEWguxUq0CXr1Y2
         fhLKYnYFcvZxSbAYNKnJA8mC8JTbQhs45H08EbRttS0kIpBfjhT6k0pthUGBlWea8ThH
         7mZjNPh1AAOu+aFrEw8q9B+ccqyaTCSrxr9eI=
Received: by 10.90.63.6 with SMTP id l6mr20146412aga.125.1297128608732;
        Mon, 07 Feb 2011 17:30:08 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id c39sm6346654anc.7.2011.02.07.17.30.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 17:30:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1297126350-sup-6606@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166326>

On 2/7/2011 6:59 PM, Marc Weber wrote:
> Hi Neal,
>
> I'm not quite sure what you want to do?
> rebase all branches on top of commit l so that they are up to date?
>
> Why do you want to find common blobs?
> If the same conflict happens you could use gitrere and reuse a conflict
> resolution.
>
> git ls-files --with $HASH
> gives you a list of files
>
> git diff --name-only
> should  give you a nice list of modified files.
>
> So using the intersection of  ls-files of branch and tip should give you
> common files. Substracting changed files using --name-only should yield
> the files which were not modified.
> Maybe there are nicer solutions though.
>
> Rebasing is always bad. Have you considered using top-git?
> This way you can merge with tip and create the rebased patches using the
> export function.

Our master represents our new system and we want to have a linear 
history so we use rebase.  Each branch is a project.  If a project does 
not have any merges with other projects then it can rebase with little 
impact.  If projects are changing alot of the same blobs then they will 
have alot of merged blobs and can be rebased on eachother in 
throw-away-integration branches.  In this way the branches can be 
grouped into appropriate rebase groups so the merge-conflict resolutions 
of these groups can be resolved simultaneously in different integration 
repos.  So lets say you have 5 groups, then you can rebase those 5 
integration-branches onto master one-by-one instead of doing 15 project 
branches one-by-one.  I thought maybe git had a cool command for 
analyzing this in one fell swoop.

v/r,
Neal
