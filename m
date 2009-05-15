From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Fri, 15 May 2009 15:18:59 +0400
Message-ID: <20090515111859.GB26812@dpotapov.dyndns.org>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <alpine.DEB.2.00.0905141441200.20117@perkele.intern.softwolves.pp.se> <4A0C77D9.5050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 13:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4vT2-0008OF-RR
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 13:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbZEOLUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 07:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbZEOLUf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 07:20:35 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:62543 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbZEOLUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 07:20:34 -0400
Received: by pzk13 with SMTP id 13so1015147pzk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8zPz9c3+9Zo24xUZ2Zub/Q17NHgPiuR9250v1I/xTzU=;
        b=Qgy0qnJNn5ge6k8Kbb/S9MR5RD4tCL+Ad6jJ2np51svFv3CdtlRlcOR974u1UalBs2
         VNvUd0yYcxGgByVNYTps0sFueCb18WNIO3hjl96yL775js6Da4mv0n0zkmjGZkj/yURF
         g3183S4GuNJeVM3kM01yAzCqfcOb2FSkHeTJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hNiqJzgxH5sCUfb/WJWBEyzbfJLNT1xoyj7rw7Mi4UYBZALqsbo0JGxpvGbNDQHd6k
         kftWD9TJbCOqcYJkwEA6C762S56ObpTxfSiR8c3PuvsCIstnPfNjsEGFsQWTM3zlUD3u
         jpVdNAATwVQm9XsixQQsnf5NaicuWcbTk7X+0=
Received: by 10.114.88.1 with SMTP id l1mr4634003wab.62.1242386435603;
        Fri, 15 May 2009 04:20:35 -0700 (PDT)
Received: from localhost (ppp91-76-19-160.pppoe.mtu-net.ru [91.76.19.160])
        by mx.google.com with ESMTPS id l38sm1359910waf.3.2009.05.15.04.20.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 04:20:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A0C77D9.5050402@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119254>

On Thu, May 14, 2009 at 10:58:17PM +0300, Esko Luontola wrote:
>
> What about if some disorganized project has people committing with many  
> different encodings? Should we allow it, that a directory has the names  
> of some files using one encoding, and the names of other files using  
> another encoding? Or should we force the whole repository to use the  
> same encoding?

The whole repository should have the same encoding internally. Anything
else will be too complex and too slow... Have you seen any file system
where file names would be stored in different encodings? And Git does
far more operation on file names than a file system does. So, it is
clearly to me that the whole repository should have a single encoding.

Now, I don't think that you will find many open source projects that use
non-ASCII in file names. Moreover, most Linux users are either use UTF-8
already or switch to it in the near future. Mac OS X uses UTF-8 (though
there is a problem with decomposed characters, but Linus posted a
possible solution). So, the only platform were non-ASCII characters may
be interesting to Git users and that does not support UTF-8 is Windows.
AFAIK, Cygwin 1.7 has UTF-8 support. So, it is mostly a problem for
msysGit... Though adding support for legacy encodings can help to some
degree, it means that every system call involving a file name will go
through UTF-8 <-> LEGACY_ENC <-> UTF-16LE conversion. IMHO, having a
legacy encoding involved is far from the best possible solution; but
to avoid that, you need to change MSYS to be able to work with UTF-8.
(I have never looked at MSYS myself, but I suspect it may be not easy).


Dmitry
