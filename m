From: "Krzysztof Kowalczyk" <kkowalczyk@gmail.com>
Subject: Re: [PATCH] Optimize common pattern of alloc_ref from string
Date: Sun, 11 May 2008 13:15:52 -0700
Message-ID: <7ce338ad0805111315q3745ea7fn4c38b557170e521f@mail.gmail.com>
References: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
	 <20080510233918.GA315@sigill.intra.peff.net>
	 <7ce338ad0805101730n5b964a0em39d9fdcd9fc45f00@mail.gmail.com>
	 <20080511080709.GA6971@sigill.intra.peff.net>
	 <7vskwo3ct5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 22:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvHye-0007Jk-Rc
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 22:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbYEKUQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYEKUQJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 16:16:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:50658 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbYEKUQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 16:16:08 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1146880ywe.1
        for <git@vger.kernel.org>; Sun, 11 May 2008 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yyNqXFnUY20ECwBU5Z8glZTf/9lu/dr3Xpu+ZulGvCQ=;
        b=aQUNm8KYhYwlvlH52fhvmHmpORrHGd22mkvpnO/roD7zunIrVqDQM76jR45YHDHMUQyx5aSta2WGmQKfx9F5SN9kRj4FL5CZPIM85ZEKlj9v+qLc4zkg0GTC70Q7E3DLRkEXHzb9cT1ypap5pHvba1vksXN8Z1b2s8kNa4qyVoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CrzrtP3NNC0270f+6uUtQlc7zRILsyw+nATXCgxjV59Vu2Y2NGU6PpQVWinl4LnTYtxmQDvHwYvwJANaujXwzQaB9FDJNAx0wA2v3DabI0xJDrI8v1g+MHEKmLc3jvpc0TRsnGvCNv+6zlBNYYjnMngXzLSZP+zZyXTJtcO6seA=
Received: by 10.150.49.1 with SMTP id w1mr7422382ybw.22.1210536952979;
        Sun, 11 May 2008 13:15:52 -0700 (PDT)
Received: by 10.150.134.9 with HTTP; Sun, 11 May 2008 13:15:52 -0700 (PDT)
In-Reply-To: <7vskwo3ct5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81819>

On Sun, May 11, 2008 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> But really my main worry is that now we have _two_ functions which
>> allocate refs, so if "struct ref" ever grows a new field that needs
>> initializing, it has to go in two places (whereas if alloc_ref_from_str
>> calls alloc_ref, it works automatically).
>
> This is a very good point.  We really do not want a micro-optimization in
> a way that hurts maintainability.
>
> Krzysztof's patch has the new function with the duplicated allocation
> implementation between the base allocator function and the existing
> copy_ref() function which also has yet another duplicated allocation
> implementation.  When somebody needs to modify one, it is likely to be
> noticed that these three go hand-in-hand, hopefully ;-).
>
> By the way, why isn't alloc_ref() doing xcalloc(), I have to wonder...

I've sent updated patch that incorporates the feedback. Changes wrt.
to this patch:
* simpler version of alloc_ref_from_str() per Jeff's suggestion
* switches alloc_ref() to xcalloc() per Junio's suggestion
* uses alloc_ref_from_str() in one more place
* better (?) commit message

-- kjk
