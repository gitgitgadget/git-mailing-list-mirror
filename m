From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PULL svn-fe] vcs-svn: simplifications, error handling
 improvements
Date: Sat, 26 Mar 2011 01:46:53 -0500
Message-ID: <20110326064653.GC20529@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
 <20110323003240.GA4949@elie>
 <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 07:47:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3NH8-0000qn-9Q
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 07:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab1CZGrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 02:47:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58360 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab1CZGq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 02:46:59 -0400
Received: by iwn34 with SMTP id 34so1792474iwn.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 23:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YOQOFtuZUmyV1yo0YRlk7VBOTJx7VkP1AB3lA3F5tbg=;
        b=VrNRmvyrI8aG25KyUCiuyWHHxGKT+P3b/Glhv+roy1N6aTUhtMWHkIkINydcUlktGN
         FH3OkR9t0dzFvy+m6rjpxpfqozJYecvLjb09KvgkxEVoLwjkGpdaSRnQDp6+gEMeNyJx
         xSDoWHm71Vs7Wn0/vYsBtLQlVxQvgC/aMlK78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KpL4UHUYHOJECEDd3AH+BoxQv8nn2+jLqc6cM8zNca/I2mxyPmgdhrWwfYJ2ZJXYOL
         pOBkUpQDfLVWrNBMPwUU4gNAA+e6saw0Lbjn3hcwqFimnS8JWdFVbg3HYA8oFi/rZ9IR
         TzVCkmQ1xKAlqOO3sDQDwLJgFs4WGpsxKmlw8=
Received: by 10.43.43.137 with SMTP id uc9mr2925542icb.209.1301122017545;
        Fri, 25 Mar 2011 23:46:57 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.sbcglobal.net [68.255.102.141])
        by mx.google.com with ESMTPS id 8sm1183372iba.55.2011.03.25.23.46.55
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 23:46:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170042>

Hi,

Junio C Hamano wrote:

> Done.

Turns out that introduced a regression (in handling of properties with
embedded NULs; thanks to David for catching and debugging it).  Could
you pull

  git://repo.or.cz/git/jrn.git svn-fe

for a fix and some other improvements in the area?

Sorry for the trouble,
Jonathan Nieder (4):
      vcs-svn: make reading of properties binary-safe
      vcs-svn: remove buffer_read_string
      vcs-svn: avoid unnecessary copying of log message and author
      vcs-svn: handle log message with embedded NUL

 t/t0081-line-buffer.sh  |   35 ++++++----------
 t/t9010-svn-fe.sh       |  104 +++++++++++++++++++++++++++++++++++++++++++++++
 test-line-buffer.c      |    6 ---
 vcs-svn/fast_export.c   |   12 +++--
 vcs-svn/fast_export.h   |    7 ++-
 vcs-svn/line_buffer.c   |    8 ----
 vcs-svn/line_buffer.h   |    4 +-
 vcs-svn/line_buffer.txt |   12 +----
 vcs-svn/repo_tree.c     |    5 +-
 vcs-svn/repo_tree.h     |    4 +-
 vcs-svn/svndump.c       |   42 +++++++++----------
 11 files changed, 156 insertions(+), 83 deletions(-)
