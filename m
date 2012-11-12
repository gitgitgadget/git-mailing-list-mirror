From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Mon, 12 Nov 2012 23:47:55 +0100
Message-ID: <CAMP44s1gA1P-Lr1M=7RDRqFQmvQAtNnB+yAJfKC1gk3XUjbfCQ@mail.gmail.com>
References: <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
	<509EAA45.8020005@gmail.com>
	<CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
	<509FD9BC.7050204@gmail.com>
	<20121111171518.GA20115@sigill.intra.peff.net>
	<CAMP44s1mny-fBCxywM0V=AgEoxV5EZdDWc_0NK3gepcKf32nww@mail.gmail.com>
	<20121111181406.GA21654@sigill.intra.peff.net>
	<CAMP44s1m8sAD9D0F-6b=+dm_AvLb_4_f7h=3A_VMYMDUEcTW7g@mail.gmail.com>
	<20121112214127.GA10531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY2nb-0002d4-2n
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 23:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab2KLWr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 17:47:57 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52353 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab2KLWr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 17:47:56 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6803241obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 14:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vTvDZLEbyVc5GQFcvzHP+aHNWGLZeJng3tKQSfLLV4w=;
        b=YmRZAGzzQpTqXIuq00n+Ph9jK7QtHODcUtFfWyrbLBCNWP2+rFvUncqJAQ2TbvkQCI
         kM68BpD5gqGC1SgRObJTNYfJV50p6ObAWDVupXhZfRUfKar2mM99DRdPwjsDmsVB35KC
         fnUKBXiZ9Ht9RBWEVbX9+1Ns35idIG8tmdvYRFI6EOdiIr69oAzylhX54I9PdSj0wgCG
         qKmtEkvFFCNn2nMINdzfVp404J696MMfZxO5fkGfKpCm/u72O2oJ2Z3MLCJM4TMQz+GR
         OcH+92UKbZNbHq70u6iPdWKTKVZXj878U/hikNsL70GBzWpEOWbiFGlUda8umfQU4IAU
         L/2w==
Received: by 10.60.26.234 with SMTP id o10mr15499179oeg.85.1352760475935; Mon,
 12 Nov 2012 14:47:55 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 14:47:55 -0800 (PST)
In-Reply-To: <20121112214127.GA10531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209537>

On Mon, Nov 12, 2012 at 10:41 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2012 at 07:48:14PM +0100, Felipe Contreras wrote:
>
>> >   3. Exporters should not use it if they have any broken-down
>> >      representation at all. Even knowing that the first half is a human
>> >      name and the second half is something else would give it a better
>> >      shot at cleaning than fast-import would get.
>>
>> I'm not sure what you mean by this. If they have name and email, then
>> sure, it's easy.
>
> But not as easy as just printing it. What if you have this:
>
>   name="Peff <angle brackets> King"
>   email="<peff@peff.net>"
>
> Concatenating them does not produce a valid git author name. Sending the
> concatenation through fast-import's cleanup function would lose
> information (namely, the location of the boundary between name and
> email).

Right. Unfortunately I'm not aware of any DSCM that does that.

> Similarly, one might have other structured data (e.g., CVS username)
> where the structure is a useful hint, but some conversion to name+email
> is still necessary.

CVS might be the only one that has such structured data. I think in
subversion the username has no meaning. A 'felipec' subversion
username is as bad as a mercurial 'felipec' username.

Cheers.

-- 
Felipe Contreras
