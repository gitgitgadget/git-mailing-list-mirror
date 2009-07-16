From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v5] Re: git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 09:50:55 +0200
Message-ID: <20090716075055.GI12971@vidovic>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org> <eb6317e39369adc8d2594c35ee351b49aaadcc24.1247721562.git.nicolas.s.dev@gmx.fr> <4A5ED22B.6050101@gmail.com> <7v8wip9jjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 09:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRLkF-0004zF-4s
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 09:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbZGPHvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 03:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbZGPHvC
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 03:51:02 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:50004 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbZGPHvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 03:51:01 -0400
Received: by ewy26 with SMTP id 26so4614608ewy.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=63ed3E2X2Df2CejaX/vlZWvHkxdigiJuPJ1vkk6R4SQ=;
        b=Q3plH4YiDYUb7APNmmuBngJIgtuWfEsamz0i02COuTQklIEGN0ATeKpMgAebiGWmNy
         BrGwIrVmJsNcGb4YR0C6qm6xuIUt+LcfmiB8b1BQHI+f9TpiKbNyxJrAx6ESaCJ9xxIz
         N2qb/Skpp+iR7uFxbHDNNjf0lGg5e2YG/0QZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eGzMjgbgQNHjfM+ZdOwz77/YWcaXGzHWzw7SEfKcxEmuemVC1Riw0WPVnaCkPZGY/A
         llKr6M9S48kd0Ndnay8/lREOWQcv1hxJ+8NfkwSAFe99AqrtUe7gf61aSCFby//EMmQM
         zRErEYIDuYdWcwdeml5r6pdWf2OIThV5ynRVc=
Received: by 10.210.131.6 with SMTP id e6mr10546573ebd.63.1247730658825;
        Thu, 16 Jul 2009 00:50:58 -0700 (PDT)
Received: from @ (88-121-124-61.rev.libertysurf.net [88.121.124.61])
        by mx.google.com with ESMTPS id 28sm6395011eyg.32.2009.07.16.00.50.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Jul 2009 00:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8wip9jjw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123379>

The 16/07/09, Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
> > Nicolas Sebrecht wrote:
> 
> >> +	# Then, accept what really looks like (series of) email(s).
> >> +	# the first sed select headers but the folded ones
> >> +	sed -e '/^$/q' -e '/^[[:blank:]]/d' "$1" |
> >> +	# this one is necessary for the next 'grep -v'
> >> +	sed -e '/^$/d' |
> >> +	grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' ||
> >> +	{
> >> +		patch_format=mbox
> >> +		return 0
> >> +	}
> >> +
> >>  	# otherwise, check the first few lines of the first patch to try
> >>  	# to detect its format
> >>  	{
> >
> > This fails t4150-am.sh #10 (am -3 -q is quiet). You should redirect the
> > output of the sed and grep to /dev/null like Junio did in his "how about
> > this" patch.

Thank you.

> Honestly speaking, I do not understand why Nicolas changed my patch at
> all.
> 
> This patch wastes an extra sed process

Should we really worry about that in a script like git-am.sh? I mean,
does it matter in a day to day work?

>                                         introduces [[:blank::]] where
> space and tab inside [] is perfectly adequate, and we know the latter is
> understood by everybody's sed.

But is harder to read in editors.

> The worst part is that this check was moved before the most common case of
> mbox file for which none of the overhead for this this extra processing is
> necessary.

Well, I did this move just because of the logical structure of the code.
That said, you're right about the overhead.

-- 
Nicolas Sebrecht
