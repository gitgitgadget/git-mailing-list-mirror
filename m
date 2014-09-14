From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] help: ensure that common-cmds.h is only included by
 help.c
Date: Sun, 14 Sep 2014 00:35:13 -0700
Message-ID: <20140914073511.GA39361@gmail.com>
References: <1410657073-3089-1-git-send-email-davvid@gmail.com>
 <5414f6b2.XwoOyI03zlXiZ3ds%perryh@pluto.rain.com>
 <CAPc5daXDCAi3eP3YmXfcO+9ncN8=b6tCGUFUxwKE=MuRBuXvEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Perry Hutchison <perryh@pluto.rain.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 09:35:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT4LK-0008Km-6F
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 09:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbaINHf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 03:35:26 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39534 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbaINHf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 03:35:26 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so4187854pdb.39
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zuODzYIdtU2PbY2/T5XXLfafnzyt2yiSOObCqROnbzk=;
        b=ph97RsbNtzX8NODNW1MC6jE93k9Naxo63SmIEQHvac8AoDFhVCvZ0h+wMd7Lm+v57G
         CZEP0r/SvZC47CZZx0If+0SBA2jDWMYii/pcH5mww4Sf7G5xtuvyAPoKcpwvr5DjTWwP
         6dwGqfB1HaafjMAxJkAJggKjCE8BeFNvTkp8Ere5AjnYYHtiBo01K1kc09VzWO5RwtdP
         Cx2CA15SVW0cLXpJFiH/nEufdcnwUNnuNl3Hr9rluWtx7YTDa551h1mN0NbGP1MtOJfK
         9DYncbJTUkRBeXmd1Fb/5fecoDd2ztH/YpTQI5q8vFLxnxL0+gZlFoi9d6rFjN4YGqUn
         DxUQ==
X-Received: by 10.68.131.163 with SMTP id on3mr29144738pbb.38.1410680125231;
        Sun, 14 Sep 2014 00:35:25 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id p4sm8201953pdp.27.2014.09.14.00.35.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Sep 2014 00:35:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPc5daXDCAi3eP3YmXfcO+9ncN8=b6tCGUFUxwKE=MuRBuXvEg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256998>

On Sat, Sep 13, 2014 at 10:23:03PM -0700, Junio C Hamano wrote:
> On Sat, Sep 13, 2014 at 7:00 PM, Perry Hutchison <perryh@pluto.rain.com> wrote:
> > David Aguilar <davvid@gmail.com> wrote:
> >> Add a #ifndef guard to ensure that common-cmds.h can only
> >> be included by help.c.
> >
> > This strikes me as a very peculiar, and sub-optimal, way of
> > achieving the purpose.  If these definitions are intended to
> > be private to help.c, why not put them there and eliminate
> > common-cmds.h entirely?
> 
> Have you studied where common-cmds.h comes from?
> After you have done so, would you make the same suggestion?
> 
> Having said that, I also do not think this is such a good idea.
> Wouldn't the new "check" script added in this series a better
> place? For example, it may want to make sure that git-compat-util.h
> (or a couple of its equivalents) is the first file included in any mainline
> C source file, and such an inclusion is done unconditionally.
> 
> Which would mean that the checker would scan *.c files with grep
> or a Perl script. It would be trivial to enforce "nobody other than these
> small selected C files is allowed to include common-cmds.h" rule.

Good idea. I implemented this check and the tweaks to make it
pass are small and focused. I'll send these patches shortly.

> Regarding the other patch that butchers many *.h files, I am not
> still very enthused. Including cache.h at the beginning of branch.h,
> for example, would mean git-compat-util.h ends up included at the
> beginning of branch.h.

I can look into Jonathan's forward-decl approach later too.
That'll probably result in less of a butchering.
-- 
David
