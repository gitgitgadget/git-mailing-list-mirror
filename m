From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Mon, 21 Apr 2014 16:24:15 -0500
Message-ID: <53558c7fbd4d4_604be1f30c30@nysa.notmuch>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
 <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
 <xmqqppka8jiw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 23:34:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLrP-0002nl-IN
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbaDUVek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:34:40 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:50155 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbaDUVei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:34:38 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so4082132yha.27
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=KDiEsR85T41780sts/3boAf0oqtBgmi6LoQAnSl3b/E=;
        b=GRk8W0CrSP+O511zNHWWUnxYg/UKrHixdgDwvKd7lPr+DrIWn93wpMFsxBLx+dSCSa
         LVSMm8zKagMVGwLNSNxDiK7rV6iFVGTRtLrfoGpuMWJgGbLMKulsNrcuNPqNRlsUQRdF
         gNVWembLY3K2M46alacJ8/lHpHsGKrZHMezwHHn+1InC4mnk9ffEcKIB/1kywVUecPfG
         9wpQDECJmkoSKNB1I8hPIpzsGQuKZxj2kKKJ9RxufLa0s1h+YSDX43ZAXphtZTsPKr2G
         QVVTnaxgRNC223ZU2n4ZccseXFAfRf8oOpCo0sY/PzWARdWI62rWXLguRpspts9Zl/TI
         a75A==
X-Received: by 10.236.156.65 with SMTP id l41mr55242398yhk.9.1398116077983;
        Mon, 21 Apr 2014 14:34:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j76sm73828335yhi.33.2014.04.21.14.34.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:34:36 -0700 (PDT)
In-Reply-To: <xmqqppka8jiw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246648>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >  contrib/remote-helpers/test-bzr.sh                         | 2 +-
> >  contrib/remote-helpers/test-hg-bidi.sh                     | 2 +-
> >  contrib/remote-helpers/test-hg-hg-git.sh                   | 4 ++--
> >  contrib/remote-helpers/test-hg.sh                          | 2 +-
> >  contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py | 0
> >  contrib/remote-helpers/git-remote-hg => git-remote-hg.py   | 0
> >  8 files changed, 9 insertions(+), 5 deletions(-)
> >  rename contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py (100%)
> >  rename contrib/remote-helpers/git-remote-hg => git-remote-hg.py (100%)
> > ...
> > diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
> > index 2b5aa9d..d44ec92 100755
> > --- a/contrib/remote-helpers/test-hg-bidi.sh
> > +++ b/contrib/remote-helpers/test-hg-bidi.sh
> > @@ -17,7 +17,7 @@ then
> >  	test_done
> >  fi
> >  
> > -if ! python -c 'import mercurial' > /dev/null 2>&1
> > +if ! "$PYTHON_PATH" -c 'import mercurial' > /dev/null 2>&1
> 
> Does this change relate to the moving of main scripts, and if so
> how?

Yes.

Before the scripts were not generated, the shebang was '/usr/bin/env python',
that means if the user doesn't have 'python' but 'python2' git-remote-hg would
fail, even if the user did PYTHON_PATH=python2, therefore the test scripts
should fail too, and that's the reason 'python' is used in the test scripts.

Now that the scripts are generated the build system would replace the shebang,
and PYTHON_PATH will be used correctly, and we should use that in the tests.

I actually implemented this script generation inside contrib/remote-helpers,
indepedently of the move, but you didn't apply those patches.

-- 
Felipe Contreras
