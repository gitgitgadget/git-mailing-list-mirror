From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] git-request-pull.sh: remove -e switch to shell
 interpreter which breaks ksh
Date: Tue, 1 Jun 2010 23:30:46 -0500
Message-ID: <20100602043046.GB8245@progeny.tock>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
 <Wt_M4qptcPdpY0Q3jqUbfP4zZEkPwPt44bpwlkuoHdyyNRTiITmTBE-eGA_-F-7NiaN6W4MRrlA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:30:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfbL-00007f-Ga
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab0FBEam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 00:30:42 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:40463 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0FBEal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 00:30:41 -0400
Received: by ywh9 with SMTP id 9so4603516ywh.17
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 21:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eVD6mp2WWjFnAQs/WjOJgZSfMiiRqpKXI2mrEgmXFbg=;
        b=YJNT5fM5cLIZwIkfAgOwSXumqCbc926QaBn6pNqavxIFvBYBufcqJuF3v0HSf0iqiI
         gSV6yHTrNTXV2pHFx/kUzUZPT2zcn16vW67BlenwAu3JnhzBN+arMAIEEFEHbbKYUsIs
         1rs3mGsjLomub44FGTNns6SvbrCVBAXTP8GyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=roW5uhXLrhPCDOYyFcHLcQWZpy9/rSAuk6/JhB3a2D115TzZok74GFGGEHMIhgndBw
         u80Sqr4x+P89DwRat82/jkxIVQDaJHm2NouQlNP/y9GQRpp04zEX8JS1aQNZaS1Kip4L
         pOMCU4fiyarvm9NyW/ZqTRB2MwE7tfIn804yU=
Received: by 10.42.1.140 with SMTP id 12mr2271945icg.27.1275453040216;
        Tue, 01 Jun 2010 21:30:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm34622658ibl.10.2010.06.01.21.30.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 21:30:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfP4zZEkPwPt44bpwlkuoHdyyNRTiITmTBE-eGA_-F-7NiaN6W4MRrlA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148192>

Brandon Casey wrote:

> When git-request-pull was originally written, it did not do any error
> checking and it used this shell feature to exit when an error occurred.
> This script now performs proper error checking and provides useful error
> messages, so this -e option appears to be merely a historical artifact and
> can be removed.

Also, the MinGW port ignores -e on a #! line, so we should not rely on it.

> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh -e
> +#!/bin/sh

To maintain the old behavior, I think we would need something like
this:

-- 8< --
Subject: request-pull: more explicit error handling

git request-pull includes -e on its #! line to catch miscellaneous
errors, but most of the body of the script explicitly handles
errors.  Finish the job so we can remove the -e.

Suggested-by: Brandon Casey <drafnel@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 6dfb885..6fdea39 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -70,10 +70,10 @@ git show -s --format='The following changes since commit %H:
 
   %s (%ci)
 
-are available in the git repository at:' $baserev
-echo "  $url $branch"
-echo
+are available in the git repository at:' $baserev &&
+echo "  $url $branch" &&
+echo &&
 
-git shortlog ^$baserev $headrev
-git diff -M --stat --summary $patch $merge_base..$headrev
+git shortlog ^$baserev $headrev &&
+git diff -M --stat --summary $patch $merge_base..$headrev || exit
 exit $status
