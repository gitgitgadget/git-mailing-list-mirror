From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: Re: [PATCH] fully resolve symlinks when creating lockfiles
Date: Fri, 27 Jul 2007 12:50:23 -0400
Message-ID: <f158199e0707270950m638f6863t8272ca50430c304c@mail.gmail.com>
References: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
	 <11854712542350-git-send-email-bradford.carl.smith@gmail.com>
	 <118833cc0707261234u59e30bchc274ae29569d8500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Morten Welinder" <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 18:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IET1R-0004WA-F8
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 18:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbXG0Qu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbXG0Qu0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 12:50:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:23834 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbXG0QuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 12:50:25 -0400
Received: by ug-out-1314.google.com with SMTP id j3so739121ugf
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 09:50:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ugx63OZxitPhyNWpNqaoeuGiqAQfNQe6VqgCAh4aBtBBJv/+f17XKjfshf0ckrDOi1JnBAjYUwKET/Tsw2RFZ5Z7lNR3GDn+ATlVcZiGrEstywDzuIxaAcHQb2oQMuro/uyb19y8268+pN8ohjH6ArcP9tdldb7bjjI1xPUrsNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NxlXsbaFm/qTDHfqNvgCPDb7hapEwqu2oypNg39Hzyjdyo3GL5lQtcwFthMCvE+Vt5ndSPvFjscRP/pmsml1SGJLk67puFA4zUsaqJsTCPlfPrPusqwkIlcHj4VQj2UJZAoZAk41WCvoVdipF3AgCfO6ijY/njzHUfS2F2668Ns=
Received: by 10.82.152.16 with SMTP id z16mr2876836bud.1185555023064;
        Fri, 27 Jul 2007 09:50:23 -0700 (PDT)
Received: by 10.82.191.19 with HTTP; Fri, 27 Jul 2007 09:50:23 -0700 (PDT)
In-Reply-To: <118833cc0707261234u59e30bchc274ae29569d8500@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53933>

On 7/26/07, Morten Welinder <mwelinder@gmail.com> wrote:
> Why the lstat and that stat in the beginning?  That's just asking for race
> condition.  readlink will tell you if it wasn't a link, for example.

Here's an example of the sort of thing I'm trying to avoid:

foo is a symlink to bar
bar is a symlink back to foo

readlink() on either one will succeed, but I'll end up with infinite
recursion because I'll resolve foo to bar, then bar to foo, then foo
back to bar, etc.

To avoid craziness like this the OS refuses to follow a chain of more
than a very small number of symlinks.  By experimentation, I found the
limit to be 8 on my Linux box.

I am trying to avoid resolving symlinks manually that the OS would
refuse to resolve anyway.

However, I'm quite open to suggestions for a better way to do it.

Thanks,

Bradford
