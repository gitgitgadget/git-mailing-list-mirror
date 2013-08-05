From: kazuki saitoh <ksaitoh560@gmail.com>
Subject: Re: [PATCH] git-p4: use "p4 fstat" to interpret View setting
Date: Mon, 5 Aug 2013 13:49:51 +0900
Message-ID: <CACGba4wiVarQhtqMqaSU+qjp0=5V0w_UUKZt1QZ4MYf=MJn7=Q@mail.gmail.com>
References: <CACGba4yGZDnr-1R-6k-sZoh4P=fu9M0bsmH3uoqj3tXUPsZRYw@mail.gmail.com>
	<20130802215359.GB9142@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 06:49:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Ck1-0002gB-Vz
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 06:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab3HEEty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 00:49:54 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:50762 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3HEEtx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 00:49:53 -0400
Received: by mail-la0-f51.google.com with SMTP id fp13so1723857lab.10
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 21:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7Tjj7xenuae5BqbRFvteXJOqXeHw4lNnjePXwRI27/I=;
        b=mqvuHe/xJPHQ+BT8gWT9z334QzUZlcVA24NycPPlkfKoC25e7Di0NqNxaYj1Yt96Cs
         oYkWLucy+3SDO8lHI5zgUc+Go8ybK1DU7eQRxgVrVkVWFlHEz47qefYC0Hqh7/tHocow
         cXNDSQOXRn/Cg7D2S1pnSNbnYT9bINIA7SpTN9VD+MiKLjcIh82RD1OhItQ3wE5dqhhI
         xgmooqA8OSl+1VnySobxJw87ez/i/wRcqd42dopvnOIHsHmWq73vbVfkWy6HLSLvd5BP
         L1f7pbeQwb1LRneWuzFLQzvKMk5YAFGA5EKOMjcL1eCewswetshZ93orH/8bRC6p8xfN
         rQIQ==
X-Received: by 10.152.121.73 with SMTP id li9mr7808910lab.42.1375678192090;
 Sun, 04 Aug 2013 21:49:52 -0700 (PDT)
Received: by 10.114.176.232 with HTTP; Sun, 4 Aug 2013 21:49:51 -0700 (PDT)
In-Reply-To: <20130802215359.GB9142@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231639>

Hi, Pete
Thank you reply.

> Your theory is:  there is a client spec, and p4 knows how to
> interpret these things, so instead of figuring out and
> implementing the algorithms for %% and * and ... in git-p4, just
> ask p4 directly.
That's right.
It is simple way to get my purpose unless break existing function
And passed all existing test.

> Let me play with this for a bit.  I wonder about the performance
> aspects of doing a "p4 fstat" for every file.  Would it be
> possible to do one or a few batch queries higher up somewhere?
Oh yes, thank you advice.
My patch is quick hack to get file info absolutely, but now, I found
directory unit query (e.g.   p4 fstat -T clientFile
//depot/project/... )
Better way is that use directory unit query  then caching.
I will try it.


> > +P4USER=""
> > +P4PASS=""
> > +P4CHARSET=""
>
> Why do you need these?
My environment set P4CHARSET=utf8, but "start_p4d" is failed.
So I undefined P4CHARSET and then passed.
I don't understand source cause clearly, perhaps only Japanese
environment problem.
How about other environment?

P4USER, P4PASS description is no need, just it make sure. I will remove, sorry.


> > +    ( p4 sync ) &&
> >   test_when_finished cleanup_git &&
>
> How does the p4 sync help here?
If remove this line, some test is failed.
Because sometime "p4 fstat" return wrong result after modified p4
client View setting.

I don't understand Perforce behavior clearly.
Maybe after modify View, something commend is need to sync server side
and client side.

This is week point of my suggestion, but I think this situation is rare.
