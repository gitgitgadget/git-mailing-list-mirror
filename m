From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/9] fast-export: add new --refspec option
Date: Sun, 22 Sep 2013 21:35:10 -0500
Message-ID: <523fa8de6a048_57ae47e7441437@nysa.mail>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
 <1377789808-2213-5-git-send-email-felipe.contreras@gmail.com>
 <523FA07C.9040909@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 04:41:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNw60-0007Yj-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 04:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab3IWClx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 22:41:53 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:52159 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab3IWClw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 22:41:52 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so153481oag.35
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 19:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=1/C2NVMN84iKJZHeWqDErcWraXQaFK5/henVOOCAOoY=;
        b=ygyzZZJ4TL6Wq8p4T56SA0u+8WuEIHQyqimXyIdlpJ2HMkQ1/je303Xw8LZ+9ycYO0
         vWva1jJ5HckjaLQ10lIAhTxpZJ4r/FkLiX4UvSQMqUDVH0BFtx6COSsqbiEUfikxLKI7
         z1heqsrZyHIXGCscT5OpOH9Uqm/aO7duVwIN03Fful/+IW7qdEUxOh808JT4wcYpVN9c
         8E/yJlBaw4tl5vMPUV+57EEUx8/8ZlVD27b1ydd7RXgRMz9+KGMLOn5gpPhVON6HC8hj
         to3WvElLctCMU3L3qUkAU5QPI7a3sJN5df6nTpWCVb5CdCc8htDJgDJk5m/c24iYFj7V
         WNOw==
X-Received: by 10.182.250.163 with SMTP id zd3mr17771628obc.20.1379904112585;
        Sun, 22 Sep 2013 19:41:52 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm11759694obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 19:41:51 -0700 (PDT)
In-Reply-To: <523FA07C.9040909@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235182>

Richard Hansen wrote:
> On 2013-08-29 11:23, Felipe Contreras wrote:
> > So that we can covert the exported ref names.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/git-fast-export.txt |  4 ++++
> >  builtin/fast-export.c             | 30 ++++++++++++++++++++++++++++++
> >  t/t9350-fast-export.sh            |  7 +++++++
> >  3 files changed, 41 insertions(+)
> > 
> > diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> > index 85f1f30..221506b 100644
> > --- a/Documentation/git-fast-export.txt
> > +++ b/Documentation/git-fast-export.txt
> > @@ -105,6 +105,10 @@ marks the same across runs.
> >  	in the commit (as opposed to just listing the files which are
> >  	different from the commit's first parent).
> >  
> > +--refspec::
> > +	Apply the specified refspec to each ref exported. Multiple of them can
> > +	be specified.
> > +
> 
> Do you mean '--refspec=<refspec>' and/or '--refspec <refspec>'?

I mean --refspec refspec1 --refspec refspec2.

> > diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> > index 34c2d8f..dc6666f 100755
> > --- a/t/t9350-fast-export.sh
> > +++ b/t/t9350-fast-export.sh
> > @@ -504,4 +504,11 @@ test_expect_success 'refs are updated even if no commits need to be exported' '
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'use refspec' '
> > +	git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
> > +		grep "^commit " | sort | uniq > actual &&
> > +	echo "commit refs/heads/foobar" > expected &&
> > +	test_cmp expected actual
> > +'
> > +
> >  test_done
> > 
> 
> I think it'd be good to add a test for multiple refspecs.

Maybe. If these patches were to actually be applied.

-- 
Felipe Contreras
