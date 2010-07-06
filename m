From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Why is "git tag --contains" so slow?
Date: Tue, 06 Jul 2010 16:31:43 +0100
Message-ID: <1278430303.32094.15.camel@wpalmer.simply-domain>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
	 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
	 <20100701121711.GF1333@thunk.org>
	 <20100701150331.GA12851@sigill.intra.peff.net>
	 <20100701153842.GA15466@sigill.intra.peff.net>
	 <20100702192612.GM1333@thunk.org>
	 <20100703080618.GA10483@sigill.intra.peff.net>
	 <20100704005543.GB6384@thunk.org>
	 <20100705122723.GB21146@sigill.intra.peff.net>
	 <20100705141012.GA25518@thunk.org>
	 <20100706115826.GA15413@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 06 17:31:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWA7n-0007RY-AH
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 17:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0GFPbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 11:31:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57469 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0GFPbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 11:31:48 -0400
Received: by fxm14 with SMTP id 14so4930754fxm.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=2orUV0MKZTW6im4lLKutH5FZ1zp5xKpik5C/TwnkHaU=;
        b=Vbjy2tqocpONZrsJlTUbR2rmjRm81hYMgb804iEPtQql3cBHoEBNitrBJ5JpBl9yjX
         s9pdrhA1yJYQqBEng604wgofPXpBk3HiN8hfv0rknD+nUE91oG7iSv9GFm5mdZM98V1I
         XLOW5G2ZlUbM2GaJCPazc0wpF+M409UH3HCWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ED4b/G4WKzpcB/WvW2gDptHVPxJf9zgoeWXVRguragzoKeazQpMTonyZ6W7MxDqpU8
         29oKh38aBNL9SQsJAbNItFiKVFRkZpfLSxaftomyHABJbydISNEyPIqwm54hL7fGPiWr
         8X1h5P1Un1UpZhWjVz3FHugUiCd55lTo2LKMM=
Received: by 10.86.27.5 with SMTP id a5mr3863098fga.32.1278430307279;
        Tue, 06 Jul 2010 08:31:47 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id i1sm12143075faa.5.2010.07.06.08.31.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 08:31:45 -0700 (PDT)
In-Reply-To: <20100706115826.GA15413@sigill.intra.peff.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150363>

On Tue, 2010-07-06 at 07:58 -0400, Jeff King wrote:
> On Mon, Jul 05, 2010 at 10:10:12AM -0400, tytso@mit.edu wrote:
> > I'm not sure this is a good tradeoff, but given in practice how rarely
> > most developers go back in time more than say, 12-24 months, maybe
> > it's worth doing.  What do you think?
> 
> I'm not sure. I am tempted to just default it to 86400 and go no
> further.  People who care about archaeology can turn off traversal
> cutoffs if they like, and as the skewed history ages, people get less
> likely to look at it. We could also pick half a year or some high number
> as the default allowable. The performance increase is still quite
> noticeable there, and it covers the only large skew we know about. I'd
> be curious to see if other projects have skew, and how much.
> 
> -Peff

Is it wrong to expect that git perform poorly in the edge-cases (hugely
skewed timestamps), but that it perform /correctly/ in all cases?

Clearly, marking already-traversed histories was the right thing to do,
and if I read correctly, made a good improvement on its own. But you
seem to have crossed a line at some point between "optimization" and
"potentially giving the wrong answer because it's faster"

Or am I just misunderstanding here?
