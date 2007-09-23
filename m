From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/5] git-merge: add support for branch.<name>.mergeoptions
Date: Sun, 23 Sep 2007 21:33:15 +0200
Message-ID: <8c5c35580709231233k1e24e36ayf294483d67096058@mail.gmail.com>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-2-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-3-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-4-git-send-email-hjemli@gmail.com>
	 <7vps0adx0x.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580709230331h459bd07ay8b17146b5feec212@mail.gmail.com>
	 <7vr6kpchny.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 21:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZXCk-0006uG-UB
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 21:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbXIWTdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbXIWTdR
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 15:33:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:59675 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbXIWTdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 15:33:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1766883wah
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A3IzxRPQZxTfoGFyLROQXLISpyJ7Ec6Kv3y0bQemZk8=;
        b=VJ2MbLfIZck7FVsoT/hUEDQG3GBYhKasPQ8Pc+/1FLa3gZJYRNgZ1oxLihjtbveBAIjEDlR5nbwfVKAQPNErOoh4/73tBe2Vmx1vIjSu43NYAUjDptSuRCuDBrRuAMFFGKbwPjUneHibYYX8tPGwuTkmHdI03+IpEm7M7abKEBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RyoBsOjnkX6cLWQZkWncA/iTe3OcyTdrjbuLHfbTPCn37a00PnU6pcSKmpqbjGT1xLlr77WssddBbjkJknqoZ92yqfPQSvtJJFIVJEoEz1nhW/Y/MnZoB1x40wuaITArbgAsximVbhNq+rtQdpUurZhJgAYND+TIU7C+S6EblH8=
Received: by 10.114.134.1 with SMTP id h1mr2453819wad.1190575995482;
        Sun, 23 Sep 2007 12:33:15 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sun, 23 Sep 2007 12:33:15 -0700 (PDT)
In-Reply-To: <7vr6kpchny.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58981>

On 9/23/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > On 9/23/07, Junio C Hamano <gitster@pobox.com> wrote:
> >> Lars Hjemli <hjemli@gmail.com> writes:
> >> > +branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
> >> > +mergeopts=$(git config "branch.$branch.mergeoptions")
> >> > +parse_config $mergeopts
> >>
> >> What should happen when your head is detached?
> >>
> >
> > My plan was 'nothing', but I should have tested it (it does work, but
> > also prints an ugly "fatal: ref HEAD is not a symbolic ref").
>
> That, and also running "git config branch..mergeoptions" and
> expect it does not change behaviour to issue more strict
> warning, are both not so good.  Perhaps the code needs to be
> more defensive like:
>
>     if branch=$(git symbolic-ref -q HEAD)
>     then
>         mergeopts=$(git config "branch.${branch#refs/heads/}.mergeoptions")
>         if test -n "$mergeopts"
>         then
>             parse_config $mergeopts
>         fi
>     fi

Yes, this is much better (and the ${parameter#word} syntax was nice too).

Thanks.

--
larsh
