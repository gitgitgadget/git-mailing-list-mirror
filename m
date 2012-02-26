From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] index-pack: reduce memory usage when the pack has
 large blobs
Date: Sun, 26 Feb 2012 11:10:14 +0700
Message-ID: <CACsJy8Cncs8RYiSB0N20vy9zu2NRTTHpfw3rSfmW64i-4_wxSw@mail.gmail.com>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
 <1330086201-13916-2-git-send-email-pclouds@gmail.com> <20120224161613.GH9526@pomac.netswarm.net>
 <CACsJy8C-8dvXpNTU=JpdupSpS8OuqqTpGvDs6s1ASeKdk9d5Dg@mail.gmail.com> <20120225224533.GJ9526@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 05:10:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1VRi-0002dC-SO
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 05:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab2BZEKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 23:10:46 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42101 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab2BZEKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 23:10:45 -0500
Received: by wgbdr13 with SMTP id dr13so749837wgb.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 20:10:44 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) client-ip=10.180.99.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.99.65])
        by 10.180.99.65 with SMTP id eo1mr7976535wib.13.1330229444465 (num_hops = 1);
        Sat, 25 Feb 2012 20:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZcmKrQK0XFtOvjXFw/NRTRj7LnQZ8/arRVWQNRk9QSs=;
        b=pWkya1+Z5JmZ6yhwFhS8K972W7goiCDcggfKUyqsbraIvKRd0whKFZy3ZOwS61nqF4
         ZYu5jPonK1CSUWv+TzxIfDwztxivnHjfaYVDcMddfm3JI8Ro6JtZe4YrvMIz5yUCU2La
         jxmZ3H/vzBOViXMH7ZyDdIE7YwmrJAuG0W9Yc=
Received: by 10.180.99.65 with SMTP id eo1mr6281917wib.13.1330229444386; Sat,
 25 Feb 2012 20:10:44 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sat, 25 Feb 2012 20:10:14 -0800 (PST)
In-Reply-To: <20120225224533.GJ9526@pomac.netswarm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191554>

On Sun, Feb 26, 2012 at 5:45 AM, Ian Kumlien <pomac@vapor.com> wrote:
> Actually, i added a backtrace and used addr2line to confirm my
> suspicion... which is:
> builtin/index-pack.c:414
>
> ie get_data_from_pack...

That function should only be called when objects are deltified, which
should _not_ happen for large blobs. What is its caller?

>
> It looks to me like, if we are to support this kind of things, we need a
> slightly different approach - instead of passing the data around, it
> feels like passing a function pointer around would be beneficial.
>
> Looking at the code i see alot of places where this would be a issue,
> just the fact that get_data_from_pack is used in several functions that
> might do some small operation and then just free it.
>
> I understand and recognize that my "problem" is not what git was
> designed for; it was designed for small files, which is very evident in
> how it approaches the data... And I'd most definetly have to look alot
> closer to this code... =)
>
>> --
>> Duy



-- 
Duy
