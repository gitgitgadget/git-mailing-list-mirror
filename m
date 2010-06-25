From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Fri, 25 Jun 2010 21:43:57 +0200
Message-ID: <CFE3DCC1-E80A-4EF3-964B-E791D3224F06@gmail.com>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <20100624111757.GB3453@pvv.org> <7veifwchb6.fsf@alter.siamese.dyndns.org> <40D1B374-E80A-4BA2-B3A2-142E8256C23E@gmail.com> <7vtyosnj23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 21:44:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSEoq-0005ZJ-Rk
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 21:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab0FYToD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 15:44:03 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34994 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756776Ab0FYToB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 15:44:01 -0400
Received: by wwi17 with SMTP id 17so1322903wwi.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=qWAgSoHc5SZ999g6EUqfI25qnN1atd57VbSTXMNmc/o=;
        b=L798VPAIPdn7DoUyz8fXliu+qL1zPhPkmyQ0QuS1n8No5w8SzkQweUlpRFvo3qb6L7
         iEQ9g3WB7LCrbtpgYEPKVxbhIxMnEHN1X2KNzP6Z7XUbF9tWs/96gQFFwCTKF8oaQDn/
         +iQ0ketZazZ5Y2IP2H6bVQtTD3dkwi6I4NelQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=LMbyMoh+eFkR66veMhlFjvh0z/IOtUryVoy5r0nPVeZMmwJbpLasCC5lDQ9MtlfqaQ
         uh27NwBmPKS/GXTSg6M6TcAYde1T0/FXoAq25CnjAnQxormqIHkkH4RQtRWGdQgRFQ1w
         b5IpZJAQ0NAkbV13gVUoexNQuVcLfb21We5I0=
Received: by 10.216.156.77 with SMTP id l55mr927027wek.28.1277495039379;
        Fri, 25 Jun 2010 12:43:59 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id w27sm1871945weq.22.2010.06.25.12.43.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 12:43:58 -0700 (PDT)
In-Reply-To: <7vtyosnj23.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149705>

On 25. juni 2010, at 00.48, Junio C Hamano wrote:

> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> 
>> Hm.  Isn't that already a requirement?  If a clean filter doesn't clean
>> to something normalized, simply touching a file could result in spurious
>> differences (much like pre-safe-autocrlf autocrlf).  I could well be
>> missing something here, though.
> 
> A natural expectation would be that g2w-then-w2g is an identity function,
> I think.  But the "feature" under discussion in this thread depends on
> that g2w-then-w2g is _not_ a noop (otherwise it wouldn't do us any good).

Well, it assumes that g2w does not smudge already smudged data (or that w2g can clean up after double smudging), but when the assumption fails you end up with the same merge conflict you would get without this series.  Is it important that _all_ filters support merging?

> IOW, we are suggesting authors of clean/smudge to make their g2w-then-w2g
> perform more than just a round-trip but actively _clean things up_, aren't
> we?  I don't think we have documented that suggestion, and I actually
> think we might even have said that g2w-then-w2g should be a no-op
> somewhere in the documentation.

I think it's worth documenting that a well-written ("normalizing", as Finn Arne said) filter allows automatic merging of filtered and unfiltered data.  I'll see what I can come up with.
-- 
Eyvind
