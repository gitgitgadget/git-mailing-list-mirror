From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 13:52:15 -0700
Message-ID: <d4bc1a2a0810151352s6c963e32jc4f492a7c84841dc@mail.gmail.com>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>
	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>
	 <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
	 <20081015062539.GB3775@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:54:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqDNH-0000de-Q6
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbYJOUwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2008 16:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYJOUwR
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:52:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:46824 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbYJOUwP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 16:52:15 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2777829wfd.4
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pDE9JtE3LG2DYL9nE99WJBfE5F+xzKQc90KK1hfM+R0=;
        b=ilZdqYgdwFjwJzyuuATcgFIJNgonjwQBZ/NZ1g+ofctd0tWxylPWhhWSqgpVOTNzuF
         P06Kw2RLWxnlKlF8mAIMwZRU8sLYTZGC6Scn+VzG/R/ZVxttGMcgjyJlmimh5uZsB1g9
         E3H1e4cbZBwKo0jBVS40uTvY2jZpQxdi8jkGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mJgiIXo2BTsycybDpcKoDuM44HmhR9wbvmTDxJ1hdtBaCvryK/yQu2Pc7slmzpAOrW
         AmnnzzIgElsG8oIPUFNW1//fYDT2CiiruIBcALThoxO3oBuKpUnRySXLXM/D1wEsR9h9
         xm8GPCoETEgOoOq95WTXu/wnmr8u7Eg+zIFmU=
Received: by 10.115.79.1 with SMTP id g1mr1481212wal.61.1224103935086;
        Wed, 15 Oct 2008 13:52:15 -0700 (PDT)
Received: by 10.114.158.12 with HTTP; Wed, 15 Oct 2008 13:52:15 -0700 (PDT)
In-Reply-To: <20081015062539.GB3775@blimp.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98325>

> Is your conversion two-way? IOW, is it possible to convert the
> converted file and get the original? (Because all the existing
> conversions are reversible)

Yes and no. The CRLF conversion isn't always invertable=97it is so long
as your use of CRLF/LF is consistent. The tab/space conversion is
similar: if you consistently use spaces, then tabs_to_spaces will
always give you back your original version; if you consistently use
tabs, then spaces_to_tabs will give you back your original version. If
you use some crazy mix of the two, you cannot reconstruct your
original without remembering where there were tabs versus spaces,
which information either filter destroys. But that's the same as the
CRLF conversion. You could enable a warning when worktree file has an
inconsistent mixture of tabs and spaces, like there is for
inconsistent CRLF files.

On Tue, Oct 14, 2008 at 11:25 PM, Alex Riesen <raa.lkml@gmail.com> wrot=
e:
> Stefan Karpinski, Wed, Oct 15, 2008 03:44:10 +0200:
>> I find myself really wanting to enforce standards in the use of spac=
es
>> versus tabs. I deal with some unruly programmers who refuse to set
>> their editors to use soft tabs, but I *hate* tabs in the repo. And o=
f
>> course others feel equally strongly about keeping only tabs in the
>> repo (e.g. the git repo).
>>
>> This led me to wonder if it wouldn't make sense to have this
>> conversion ability built into git. The following patch implements th=
is
>> functionality. It still needs work=97it's not meant to be final, jus=
t to
>> give an idea=97but I just wanted to see if people on the git list
>> thought this sort of thing would be worthwhile at all.
>
> Is your conversion two-way? IOW, is it possible to convert the
> converted file and get the original? (Because all the existing
> conversions are reversible)
>
