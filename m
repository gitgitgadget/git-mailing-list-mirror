From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Thu, 6 Mar 2008 09:54:58 +0800
Message-ID: <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
	 <7vd4q8kbey.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 02:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX5Kc-0002PF-Q8
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 02:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758944AbYCFBzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 20:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759515AbYCFBzA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 20:55:00 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:65102 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbYCFBy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 20:54:59 -0500
Received: by an-out-0708.google.com with SMTP id d31so348929and.103
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 17:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dVVwIMz7D4nUWQBN5MpVkRxYvig5x4bEqBWNbcs7dho=;
        b=gmw0cQsIZVKOPc7H4vgTYtlseS3OtyAsGV9eE8f2nOghMgR2Dz5yKxdxUCfK56JR/b3YQWILr/P0J/QtRR0ZsRLzVuNNhgo3vl3w1ksSAZM/JPrZzI93ao+7bLi7lvGlQrxVpk4MG77HWSXIaCyeb5uIk8ZjPVcb7zPaE42JDoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BchKq0VJDIag7BAkvcPD5nQKY/dH74YQHnoNUWkON8q6tzg1yYuoO1vf0i6EHjoUk9KB4Th3Ty0jjxUYp8GUnERQSUSZJOFOj6Zbl0jgnPO4x9ToWYTBVNTn8/FAZso6eBXAwGSWbnV0+1JbYlJUBES/5jlcxbfsQ6VMG9E/WcA=
Received: by 10.100.31.3 with SMTP id e3mr8560094ane.15.1204768498164;
        Wed, 05 Mar 2008 17:54:58 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Wed, 5 Mar 2008 17:54:58 -0800 (PST)
In-Reply-To: <7vd4q8kbey.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76306>

On Thu, Mar 6, 2008 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > This patch allows multi-level module definition in .gitmodules as
>  > Linus and Sven Verdoolaege etc. have suggested in mails
>  > "Let .git/config specify the url for submodules"
>  > (http://article.gmane.org/gmane.comp.version-control.git/48939).
>  >
>  > Following shows an example of such a .gitmodules.
>  >
>  > .gitmodules with with multiple level of indirection
>  > ------------------------------------------------------
>  > [submodule "service"]
>  >    submodule = crawler
>  >    submodule = search
>  > ...
>
> > [submodule "util"]
>  >    url = git://xyzzy/util.git
>  > [submodule "imsearch"]
>  >    path = search/imsearch
>  >    url = git://xyzzy/imsearch.git
>  > [submodule "imcrawler"]
>  >    path = crawler/imcrawter
>  >    url = git://xyzzy/imcrawter.git
>  > ------------------------------------------------------
>
>  I would agree that allowing the user to use a short-hand to name a group
>  of modules the user is interested in would be a good idea, but I think
>  .gitmodules is a wrong place to do so.  The grouping is a user preference,
>  isn't it?
>
>  The place the owner of the repository (not the project) expresses which
>  modules are of interest, what transports she wants to use to access it,
>  etc. is $GIT_DIR/config, and .gitmodules is a vehicle to supply hints to
>  be used when the user populates that information.
>
Not always the case. In my company environment, we have many
submodules and have a unified hierachy of modules, and we use the same
transports ssh. So after top maintainer give the basic module hierachy
config in .gitmodules, other people needn't and even shouldn't
consider changing these common config. If other people have special
needs, they can of course edit .git/config to add new hierachy or
override existing ones in .gitmodules. However, it's better to put the
common config in .gitmodules to pass to every one.

I think this may not be a special requirement for my company, so
letting .gitmodule record the common module hierachy should be a
common requirement in a company environment.


-- 
Ping Yin
