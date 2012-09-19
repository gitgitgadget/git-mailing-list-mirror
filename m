From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: possible bug in autocompletion
Date: Thu, 20 Sep 2012 01:08:29 +0200
Message-ID: <CAMP44s33b7uNg6G3m3wHEACa_wYwf_5==h64CHw2b86-rJd5VQ@mail.gmail.com>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
	<20120717121232.GA32571@sigill.intra.peff.net>
	<CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
	<20120919174336.GA11699@sigill.intra.peff.net>
	<CAMP44s1Xvvs7g1quUEs2b43VciK2=Nt-AntJcwG0CPf6p8Xk_A@mail.gmail.com>
	<CAMP44s1ZVTgBTQDyBHKvos-uSo0FeOO437MvTYH0YE0Lx-xDOA@mail.gmail.com>
	<20120919195518.GA22310@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeroen Meijer <jjgmeijer@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETOT-00063I-2r
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab2ISXIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:08:31 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48083 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab2ISXIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:08:30 -0400
Received: by iahk25 with SMTP id k25so1194330iah.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ASZkGTyc7ND6QaUgDVq9glMfsqiFUb+qgZrF4+a6yt0=;
        b=lMNUEx+YhmLvRTn8KA9oUFo/fW20ocxhOKGUSqS5G06Dm8QsulSxc/bLDcw8dZBM82
         wMSHYlVeixQWDTWWG7lSkS/+Sh0axCSiCvOAYkOO3S+Qn4kn33uXws8MOv+huntfJsLm
         rKL7wrpXHrT82SU3H+8kiFRd5w5UK6qRuEh7gctsreYr2/v8rPXiOvzGBiY811uFRqFf
         ugPBG29kGeT1fZ5fRhT2agzfA3CFIrq+c703dqO3vwhB90NdHPueIKG/463uQ6JDJx74
         LbJ605iAzSQbggZwviyw+0GksCMMoO3zieiPxeFbLQWT4rf/Zr7v4TG488gwKzmyrjcL
         1++Q==
Received: by 10.182.152.65 with SMTP id uw1mr3985051obb.91.1348096109398; Wed,
 19 Sep 2012 16:08:29 -0700 (PDT)
Received: by 10.60.164.7 with HTTP; Wed, 19 Sep 2012 16:08:29 -0700 (PDT)
In-Reply-To: <20120919195518.GA22310@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206007>

On Wed, Sep 19, 2012 at 9:55 PM, Jeff King <peff@peff.net> wrote:

> I have no idea if that internal to bash's filename completion, or if
> there is some easy facility offered to programmable completions to do
> the same thing.  I don't think this is a high priority, but it would be
> nice to handle it. And moreover, I am really wondering if we are missing
> some solution that bash is providing to help us with the quoting issues.
> Surely we are not the first completion script to come up against this.

I found a much easier solution:

-       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
+       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$(quote "$1")"
-- "${3-$cur}"))

But what about the people that don't have bash-completion?

BTW:

quote()
{
    local quoted=${1//\'/\'\\\'\'}
    printf "'%s'" "$quoted"
}

-- 
Felipe Contreras
