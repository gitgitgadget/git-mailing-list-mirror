From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 22:39:25 -0700
Message-ID: <CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com> <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
 <20121024180807.GA3338@elie.Belkin> <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
 <20121024191149.GA3120@elie.Belkin> <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
 <20121025042731.GA11243@elie.Belkin> <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:40:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRGB3-0006xi-66
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab2JYFkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:40:07 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62495 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab2JYFkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 01:40:06 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so502395qcr.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ouW7IiASURuexi/SRakeuFX3GJxzLDk4hOA0x8yyeYE=;
        b=zPnOVbhb1WWzyjRLy8jn2v0tVXd4ZcL3AO7u0+5qU5quxY0PPasTzy8ppAh1IUvMJa
         MT/1TY8KFlB2QZnWJQqFgqHeq3GpBIEJEQB/BH/IM/DCzcrf06lal6IXQUXyLuFcuVGB
         ro2+IPCTc/qA8t9LiDjw1pS4R9n1NvnRfXUBGYPLxy151EDIU5SSFhYNBW21uL3Fb4WD
         sHpaOOjiAIp2Ywh+XXmS1I+AQJyFjzLBljnxaCWguiWc2CwoFC+XS5cnH30IiyWGT9G0
         kuElx+bLMmcUeoS6PbEmQUhOvrfFqcG8vs+FXv5zk48dYHfasVk/hfwt/St75qzAWeDb
         Da6Q==
Received: by 10.49.103.162 with SMTP id fx2mr10296691qeb.1.1351143605336; Wed,
 24 Oct 2012 22:40:05 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Wed, 24 Oct 2012 22:39:25 -0700 (PDT)
In-Reply-To: <20121025052823.GB11243@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208345>

On Wed, Oct 24, 2012 at 10:28 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> The testcase is imho correct and does not need changing.  So yes, I
> don't want your help changing it.  I don't suspect you will be using
> "git fast-export $(git rev-parse master)..master".  It is safe and
> good to add additional testcases documenting the syntax that you do
> use, as an independent topic.

To re-iterate Dscho's point, the reason for this testcase is that if
you do this:
$ git checkout master
$ git branch next
$ git push hg://example.com master
$ git push hg://example.com next

With the current design, next will not be present on the remote. This
is caused by the fact that git looks at "fast-export ^master next",
sees that it's empty, and decides not to export anything. This patch
series solves that, by having "fast-export ^master next" emit a "from
:42\nreset next" (or something like that, assuming :42 is where master
is currently at).

-- 
Cheers,

Sverre Rabbelier
