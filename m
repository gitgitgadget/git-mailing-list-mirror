From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Tue, 20 May 2014 17:54:23 -0500
Message-ID: <CAMP44s03--Y8FJigWFw3kniULmUGNA7+8U=fvHn0QoC2K_eO1A@mail.gmail.com>
References: <53795175664d5_10da88d308ce@nysa.notmuch>
	<xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
	<537bc3e1c605c_a6f166b3088f@nysa.notmuch>
	<xmqqtx8krvem.fsf@gitster.dls.corp.google.com>
	<537bcbf7efd4_1d08f2d2f8a7@nysa.notmuch>
	<xmqqa9acrrsv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 00:54:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmsvT-0005kN-VF
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 00:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbaETWyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 18:54:24 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:62723 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaETWyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 18:54:24 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so1923596qgz.2
        for <git@vger.kernel.org>; Tue, 20 May 2014 15:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vCV001cZ/A6fHSnt9/s4usZs0dPLg8uUuPS8p4cWFCE=;
        b=KXpG4NbaZa6LJs7nY6FyhiT7Dus3oIUSIR7XpcdM/THDrtQhr9ltQL63Qi6ZULXorl
         DqMg929fqShzXb0B1oos0UsTGAvD+wbf22X344LLzLph/i1if7H9qjVmX47EBwuIte3b
         Hlhr2nLuUtSiJNO3owUCsQqut/nIyPlukcNhNQ4oV9k+PihV8kIqVN/xelcCt33ADCoe
         6eO2rlpoRC2pf94krNCPWvfJXvqxatr/W3+xGD67l/kX4oyuD/Wo7iPDBmDoOVlyrs3E
         Qtl1xdnzasT8h+3biX5JRZffFxnY8kY2uOBGY95wxIpBnVg5LTPXUoF2eIggLb7000oR
         FbZA==
X-Received: by 10.140.36.149 with SMTP id p21mr61340916qgp.54.1400626463464;
 Tue, 20 May 2014 15:54:23 -0700 (PDT)
Received: by 10.140.19.242 with HTTP; Tue, 20 May 2014 15:54:23 -0700 (PDT)
In-Reply-To: <xmqqa9acrrsv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249759>

On Tue, May 20, 2014 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I'm not sure what would be the usefulness of using things like
>> 'xx/topic~4'.
>
> As a notation it is not very pretty ;-).
>
> Imagine that xx/topic is about a multistep introduction of a
> backward incompatible feature.  The beginning part of the series up
> to xx/topic~4 are the step to start warning (i.e. "will change---do
> this to keep the old one or do that to live in the future"),
> xx/topic~3..xx/topic~1 are the next step to flip the default and
> still keep warning (i.e. "have changed---do this to keep the old one
> or do that to live in the present"), and the final xx/topic is the
> endgame where everybody lives with the new default with no warning,
> without having to know what the old default was.
>
> While the topic is being prepared for the next release, the insn
> sheet for 'jch' would have xx/topic~4 before "match next" marker,
> and then an entry for xx/topic~1 somewhere after it, and finally an
> entry for xx/topic (i.e. the tip, final commit).  When the first
> step cooked well enough in 'next', selected entries of 'jch' insn
> sheet before "match next" ones are used to merge them to 'master'
> and the part up to xx/topic~4 (but not later patches on the topic
> branch) will be part of the upcoming release.
>
> You could simulate that with multiple branches stacked on top of
> each other, but there are times when keeping things together in a
> single branch is more handy.
>
> In restrospect, if I found xx/topic~4 too ugly, I might have instead
> made "branches stacked on top of each other" easier to manage, but
> having Reintegrate support "in the middle of a branch" was simpler.
> They are both OK solutions to the same problem, and I didn't have to
> solve it both ways ;-)

Yes, I see how xx/topic~4 would be useful in the instruction sheet, I
just didn't see it would be useful to generate that from an existing
integration branch. After the explanation above I see how it could be
useful to some people (though not all). I'll implement that.

-- 
Felipe Contreras
