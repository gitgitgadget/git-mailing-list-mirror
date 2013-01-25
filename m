From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Fri, 25 Jan 2013 08:46:37 +0700
Message-ID: <CACsJy8Bq8aQ69twWtwHyNzez2OwTN1wHxqHwb_AM-Qo4TUuv8Q@mail.gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
 <1357008251-10014-2-git-send-email-pclouds@gmail.com> <7vr4lcnbn5.fsf@alter.siamese.dyndns.org>
 <7v1udcn84w.fsf@alter.siamese.dyndns.org> <CACsJy8DiVy7tcG_t2JENKoPSFWV24Tneh4q=upPPJML4VESMag@mail.gmail.com>
 <7vwqv3dw2n.fsf@alter.siamese.dyndns.org> <CACsJy8CtV-ngy4iGm3Vn3bu9XwpSrZ_AeWpPxTC2TY_qXv=Cxw@mail.gmail.com>
 <7v1udacugj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 02:47:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyYOA-0000fT-AE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 02:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab3AYBrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 20:47:09 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36016 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab3AYBrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 20:47:08 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc20so9988082obb.36
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 17:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=I9k3yd5lhilU5mDqIR0tinXjcRp+AL7Rt37GToDnmDU=;
        b=Y1NftqM7xieGqnWe83J2YwOpl8dtArA+CHrLYPxpJTQ+3ZflijMOHuy82s4zVa864D
         kVp6pTL1pURnrWIuVNELPFGvWMm9+o5b0as54cWkVYTQML08+cv29rO7pJQPHpxdQxlP
         PLSyA8lgcr61suL/oZYAfxe15EoSWAOZcaOxcDlgy1e2ho4+I2apiST99W+rOGe6IaZp
         tt99X7bmfQ9jdhTA+LxxUreKLDa3lA1vUNWLOn6QnJBhRXNaeyXxtT0BkUwUa1Vi61sk
         um++G57hh29JOd+rS3Cw4hLhDEfxNjPepFAlJgpTNl/Tkv+Y942i2R1gMznNVHcPWlRu
         nJkw==
X-Received: by 10.60.8.131 with SMTP id r3mr3229014oea.14.1359078427058; Thu,
 24 Jan 2013 17:47:07 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 24 Jan 2013 17:46:37 -0800 (PST)
In-Reply-To: <7v1udacugj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214478>

On Fri, Jan 25, 2013 at 1:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I don't think we need to support two different sets of wildcards in
>> the long run. I'm thinking of adding ":(glob)" with WM_PATHNAME.
>> Pathspec without :(glob) still uses the current wildcards (i.e. no
>> FNM_PATHNAME). At some point, like 2.0, we either switch the behavior
>> of patterns-without-:(glob) to WM_PATHNAME, or just disable wildcards
>> when :(glob) is not present.
>
> Yeah, I think that is sensible.
>
> I am meaning to merge your retire-fnmatch topic to 'master'.

I thought you wanted it to stay in 'next' longer :-)

> What should the Release Notes say for the upcoming release?
>
>     You can build with USE_WILDMATCH=YesPlease to use a replacement
>     implementation of pattern matching logic used for pathname-like
>     things, e.g.  refnames and paths in the repository.  The new
>     implementation is not expected change the existing behaviour of
>     Git at all, except for "git for-each-ref" where you can now say
>     "refs/**/master" and match with both refs/heads/master and
>     refs/remotes/origin/master.  In future versions of Git, we plan
>     to use this new implementation in wider places (e.g. "git log
>     '**/t*.sh'" may find commits that touch a shell script whose
>     name begins with "t" at any level), but we are not there yet.
>     By building with USE_WILDMATCH, using the resulting Git daily
>     and reporting when you find breakages, you can help us get
>     closer to that goal.

That looks ok. You may want to mention that "**" syntax is enabled in
.gitignore and .gitattributes as well (even without USE_WILDMATCH). We
could even stop the behavior change in for-each-ref (FNM_PATHNAME in
general) but I guess because it's a nice regression, nobody would
complain.
-- 
Duy
