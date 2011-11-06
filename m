From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Sat, 5 Nov 2011 23:31:57 -0500
Message-ID: <20111106043157.GM27272@elie.hsd1.il.comcast.net>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 06:02:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMus6-0004p9-Im
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 06:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973Ab1KFEcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 00:32:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40974 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1KFEcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 00:32:08 -0400
Received: by ywf7 with SMTP id 7so4007709ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 21:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G0JcrVxQ3hJGRzKp3ce4qVfjGKSG+K1Enzc38W+hXaQ=;
        b=n1qP8wFiV0xez/TCil1O4Lq5iqtrVGNNs+cOjM4b6e3l1iiGsy97z3WGYdDlbAIl8+
         dq1gP21KwCRkL1BAHrmHsmxDGUwzx2vnBHtN++ieg7Bl92psXJ5cGnC0sXBuWFMcreDx
         wN7bTRQ5U1smg8qeeFqH0gPbhqJOkwq2jepe4=
Received: by 10.50.207.99 with SMTP id lv3mr28718167igc.16.1320553927400;
        Sat, 05 Nov 2011 21:32:07 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fu10sm14415505igc.6.2011.11.05.21.32.06
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 21:32:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184898>

Sverre Rabbelier wrote:

> This happens only when the corresponding commits are not exported in
> the current fast-export run. This can happen either when the relevant
> commit is already marked, or when the commit is explicitly marked
> as UNINTERESTING with a negative ref by another argument.

The above "This" has no antecedent.  I guess you mean that
fast-export writes no output when passed a range of the form A..A.

> This breaks fast-export based remote helpers,

Makes sense.

> as they use marks
> files to store which commits have already been seen. The call graph
> is something as follows:
>
> $ # push master to remote repo
> $ git fast-export --{im,ex}port-marks=marksfile master
> $ # make a commit on master and push it to remote
> $ git fast-export --{im,ex}port-marks=marksfile master
> $ # run `git branch foo` and push it to remote
> $ git fast-export --{im,ex}port-marks=marksfile foo
>
> When fast-export imports the marksfile and sees that all commits in
> foo are marked as UNINTERESTING

Hmm, I didn't know about this behavior.  Would it be possible to add
a test for it, too?

>  t/t9350-fast-export.sh |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)

With or without the change suggested above, this new test seems to me
like a good thing, even though in the longer term it might be nicer to
teach fast-export to understand a syntax like

	git fast-import ^master master:master

Put another way, the possibility of something nicer later shouldn't
stop us from adding an incremental refinement that improves things
today.

Thanks for working on this,
Jonathan
