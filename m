From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from remote
 remote"
Date: Sun, 15 Apr 2012 15:19:01 +0200
Message-ID: <4F8ACAC5.7050600@gmail.com>
References: <4F893CD8.5020700@gmail.com> <20120414201446.GB29999@ecki> <4F8A0F96.5060408@gmail.com> <20120415011118.GA4123@ecki> <4F8A8211.2010908@gmail.com> <20120415105943.GD6263@ecki> <4F8AAE7C.1020507@gmail.com> <20120415114518.GB9338@ecki> <4F8AB7F1.1020705@gmail.com> <20120415120901.GA14003@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 15:19:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJPMp-00063l-Fy
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 15:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab2DONTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 09:19:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61749 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab2DONTI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 09:19:08 -0400
Received: by wejx9 with SMTP id x9so2823867wej.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=FWmrJifuP1lvEPbie9zefNVDiMhYe3qf3lU66km+2ik=;
        b=UW5Tvob0fIx/wjcDjGS30bM3CvGpNjZqKlz8dxKKsZj/vh5XfncHULk8Kf3dmqtpkV
         lH0fFUndg4Qt1c9dnCZgvPPwanlTExc0SqRhJPy40RudTLVKWeYDkr/lMeO12Rz5a5sj
         PzBgLcJLNrSp+O7EHgeMiZtzJ/KSSX+e5zcd6bToStMCLZxZMS6brfF/0C7Cru6zCuNa
         IvApIZwmOByd/0XBgmm92AH5x0CoXGL4Ik5JcGpq87hQcBbJVVde29tu5daUF13At8GL
         1pVsZ0yoUj1TxtNPHnM5cppy6oJ/VgFwgNYGm7e33+v1szzRt+XiPr7Z004IwH1LhhTu
         6uUQ==
Received: by 10.180.80.9 with SMTP id n9mr10744466wix.4.1334495946723;
        Sun, 15 Apr 2012 06:19:06 -0700 (PDT)
Received: from [87.8.92.183] (host183-92-dynamic.8-87-r.retail.telecomitalia.it. [87.8.92.183])
        by mx.google.com with ESMTPS id ex2sm19638377wib.8.2012.04.15.06.19.03
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 06:19:05 -0700 (PDT)
In-Reply-To: <20120415120901.GA14003@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195567>

On 04/15/2012 02:09 PM, Clemens Buchacher wrote:
> On Sun, Apr 15, 2012 at 01:58:41PM +0200, Stefano Lattarini wrote:
>>
>> OK, I cut & pasted your command; it ran successfully, with this output:
> 
> And your installed git version is the same as the one you are seeing the
> deadlock with?
>
No, but I see the same behaviour if I put '~/src/git/bin-wrappers' early
in PATH:

$ git --version
git version 1.7.10.130.g36e6c

$ (cd localclone; git fast-export --use-done-feature  \
     --export-marks='.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
     --import-marks='.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
     ^refs/testgit/origin/master refs/heads/master) \
  | (cd server; git fast-import \
      --export-marks='/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' \
      --import-marks='/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks')

git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:       5000
Total objects:            3 (         0 duplicates                  )
      blobs  :            1 (         0 duplicates          0 deltas of          1 attempts)
      trees  :            1 (         0 duplicates          0 deltas of          1 attempts)
      commits:            1 (         0 duplicates          0 deltas of          0 attempts)
      tags   :            0 (         0 duplicates          0 deltas of          0 attempts)
Total branches:           1 (         1 loads     )
      marks:           1024 (         6 unique    )
      atoms:              1
Memory total:          2294 KiB
       pools:          2098 KiB
     objects:           195 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize =   33554432
pack_report: core.packedGitLimit      =  268435456
pack_report: pack_used_ctr            =          1
pack_report: pack_mmap_calls          =          1
pack_report: pack_open_windows        =          1 /          1
pack_report: pack_mapped              =        254 /        254
---------------------------------------------------------------------

Regards,
  Stefano
