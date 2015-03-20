From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/2] fix test suite with split index
Date: Fri, 20 Mar 2015 22:43:12 +0100
Message-ID: <1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
References: <20150320195943.GB6545@hank>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 22:43:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ4hi-0007Jn-GT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 22:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbbCTVn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 17:43:26 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33359 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbbCTVn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 17:43:26 -0400
Received: by wixw10 with SMTP id w10so3011657wix.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 14:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=llXcGh4lEKBjsSE1k9Vx8vMwtA/4npthR9tu2CF82YM=;
        b=x0o0zrWMtF4sdQsDHE/XvsxRLqYLMt76eSP14rDQwOCRCznnmdSAdkhCpy7+YJEeX5
         rHXhnZBsjzz3P6edUwzhNaB2Y6ejH9K9Y5U/+38l7tWYrJE9YAhpaBD4hEZCmxI0WLNC
         AYZDrFMH3EQo86F3PCxD8o7r1PEzx0XCh7XkKh/tgZnOrqqNwt6Y25OMW7vQrrJIwroR
         MzcttBIViMykxEMpMBrVIw1D8JhEy3bXr6a/+yLLs8jP/MsuLdNpVI1OdgWGSLPb5MQT
         GuHY/SS4g2kKCvEkNLcXIABaQr2Z/RCIu5QNWx3jcBK4LCqyMQVFTg0JGVrf4i61hkp4
         6tVA==
X-Received: by 10.180.187.200 with SMTP id fu8mr8458115wic.2.1426887804949;
        Fri, 20 Mar 2015 14:43:24 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id n6sm8026419wjy.8.2015.03.20.14.43.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 14:43:24 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.264.g0463184.dirty
In-Reply-To: <20150320195943.GB6545@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265968>

> I've now tried to set the GIT_TEST_SPLIT_INDEX environment variable
> and run the tests, and quite a few seem to fail for both v3 and v4.
> I'm looking into that now, but that seems to be unrelated to index v4,
> and I'm not sure yet if I'm testing the right thing.

So now I've tracked it down, 15999d0 read_index_from(): catch out of
order entries when reading an index file breaks reading split index
files in some cases.

The first patch allows setting TEST_GIT_TEST_SPLIT_INDEX in config.mak
to make running the test suite with split index easier, the second
patch fixes the issue.  With the patch I previously sent, the test
suite now passes with split-index enabled for both index v3 and v4.
	    

Thomas Gummerer (2):
  test-lib: allow using split index in the test suite
  read-cache: fix reading of split index

 Makefile      |  6 ++++++
 read-cache.c  | 42 +++++++++++++++++++++++-------------------
 t/test-lib.sh |  6 ++++++
 3 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.1.0.264.g0463184.dirty
