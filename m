From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 0/2] replace signal() with sigaction()
Date: Fri, 30 May 2014 13:58:15 -0700
Message-ID: <cover.1401482787.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 30 22:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTsy-0004VY-S3
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934102AbaE3U6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:58:41 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:59913 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbaE3U6i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:58:38 -0400
Received: by mail-pd0-f174.google.com with SMTP id r10so1328179pdi.19
        for <git@vger.kernel.org>; Fri, 30 May 2014 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=vKDuYXC/fLJxfA9peLC6JsmRdX8QI3uxJRtBO7Fut74=;
        b=b1SxAwryX6+7Nvko29j/Zxme/6BbtIkOo1VwYza1FmTtOvsOn2Zwe6VjN61/z1um8h
         aTWh5cCQLS6/nqUQ2Y8PbaiZUFsD/Ni4QrRA4MRhLddxT7cSGHT7gsC9tXCSM+O0Amnj
         OeErBAHcYj8d85tFwd0OXXTSE3IEVgtcmktLt/Y0QbG22QnnVf/EMW2UUnwMN56lxbzL
         TswSYSc5/yAjPa/UNJH01OEo18EbSHKBv+T++3Twlt/tfjeuhhhyAP70WJ2l//S3IOFD
         Ptn/VCgYRBw6OSbV+ZWT8Up/hpEQ9AGGfOKH+192oGfoMgGsOjGLxp8me22jVRYsTFQ2
         P8uw==
X-Received: by 10.68.231.35 with SMTP id td3mr21241195pbc.137.1401483517858;
        Fri, 30 May 2014 13:58:37 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id wl5sm7931685pbc.13.2014.05.30.13.58.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 13:58:36 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Fri, 30 May 2014 13:58:33 -0700
X-Mailer: git-send-email 2.0.0.2.g1d11d5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250482>

This is the second revision to the patch set to replace signal(2) with
sigaction(2) [1].

As Johannes pointed out [2], replacing signal with sigaction would break
MinGW compatibility.  The first patch in this series addresses this
problem by expanding the faux sigaction function in compat/mingw.c to
support signals other than just SIGALRM.  Details are in the patch
description.

The second patch is a proof of concept.  It converts signal to sigaction
in a case where signal SIGCHILD was used.  Previously this would have
failed with MinGW since the faux sigaction function only supported
SIGALRM.  Now it works as expected.

I have tested these changes under Linux and under Windows 7 using Msysgit.

[1]: http://marc.info/?l=git&m=140125769223552&w=2
[2]: http://marc.info/?l=git&m=140126288325213&w=2

Jeremiah Mahler (2):
  compat/mingw.c: expand MinGW support for sigaction
  connect.c: replace signal() with sigaction()

 compat/mingw.c | 9 +++++----
 connect.c      | 5 ++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.0.0.2.g1d11d5d
