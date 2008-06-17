From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Wed, 18 Jun 2008 00:54:33 +0200
Message-ID: <200806180054.33490.jnareb@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <200806171633.26864.jnareb@gmail.com> <48583A73.7020508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8k5L-0002Nj-NY
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758464AbYFQWyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758371AbYFQWyg
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:54:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:50019 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758215AbYFQWyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:54:35 -0400
Received: by ug-out-1314.google.com with SMTP id h2so677515ugf.16
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nH2sweNsfHsheX+SPai5AW0JcB5TB624FzVtnoY8Gug=;
        b=HNVpswrszLt8HYqfoGG7ytLCvs8KzK8ICSr88JNvPR0V5XuNC1TVXq0hPICKTAKNue
         Qz8lDL/hI/XbH2PRDGAIqGv3llvzbAjXMZ2WYtrO7RvbvH/Ld5xNndWSoIZF60DaE7Iw
         jmhHr13eaUYghdYoNx8rlx4x6CPgicjGKwYGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WItH3btp9X1Ojb3ja5NZo5+MTIaSFAae9vDJtvMPB6kCOXx05boClFyakOOMIi+kRW
         JWe8fIs+8gesxap7KWnHpZRJTJta2TOzTXDQi4XKMZyPRPIfyX5TCRKdSJuAyhtSurEK
         PeaTrM7yJxq9N5iTQ9ud1cxmvXXxkY3fPXGFk=
Received: by 10.67.25.9 with SMTP id c9mr8480925ugj.46.1213743273837;
        Tue, 17 Jun 2008 15:54:33 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.204.69])
        by mx.google.com with ESMTPS id 18sm13272155ugk.44.2008.06.17.15.54.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 15:54:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48583A73.7020508@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85340>

Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > But that means checking arguments in the "fast path", which means
> > additional calls to git commands in the _common_ case, not only in
> > the case of errors.
> 
> No, it doesn't, it just pipes stuff into cat-file --batch-check,

Ah, O.K., it does add additional call to git command, which should not
matter much performance wise on sane operating systems; it would matter
on OS with slow fork, like MS Windows, if gitweb ran on Windows
(perhaps it can, but certainly not with ActiveState Perl, IIRC).

But what are arguments for "check params; run command" vs "run command;
check params if error" proposed by Junio?  Why do you want to check
parameters upfront?  Does it make code much, much easier?

> which has to be opened on virtually any call to gitweb.

IIRC it is for checking parameters?  Even then, using it only on "slow 
patch", i.e. in preence of error might be better solution.

Or is it needed for something else too?

> Before telling me about the performance of my code, can you please
> (a) read it [...]

By the way, would you be sending your current WIP for review?


P.S. I wanted to ask in another subthread if adding object oriented 
interface (wrapper) to git repositories (similar to the one used by 
StGIT / git-python perhaps?) is really needed for implementing gitweb 
caching?;  I still think that you have to chose which spots to cache, 
and do it from gitweb, and not cache everything.  But if it is needed 
for sane error reporting, and perhaps better ETags...

-- 
Jakub Narebski
Poland
