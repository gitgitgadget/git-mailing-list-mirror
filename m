From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: ignoring files/directories in git
Date: Mon, 22 Sep 2008 13:41:07 +0300
Message-ID: <48D77643.1090908@panasas.com>
References: <19596152.post@talk.nabble.com> <19599905.post@talk.nabble.com> <48D74B1C.6020408@panasas.com> <20080922085200.GI21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: mwolfe38 <mwolfe38@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 12:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khis2-0002ar-J0
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 12:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYIVKlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 06:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbYIVKlO
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 06:41:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:56426 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbYIVKlN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 06:41:13 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1332167ugf.37
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=+tEPzEHiMiqnIjH9o2kvX5Bbb2T69jflvlNZ/1ulDI4=;
        b=I+XW0aWOPoAop5pZdlyJDL1abzuIczPCTF5LvJA5tI7oBEPsxsoRfOj5EG1M6V9pPi
         DJgJtCNcZ4hGNVWdRBlkEA/WIYLm0d/7pUSnxJ3X3/fXYGRblMM6JZR/gnI2Lidf41CH
         glVgi4iPsy7vlLlX9C4rfmEABkGjMs+jxYUOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=v01J03mVaVY2uiGEPUKKs9aJr58PSC1DyoiI/Dl6EymuMNUwsamBsQNWpVX4ER+znn
         LKEcPTavlR599AwyOl3tjM2Tn43tibyk3O4pzOg9Ks4aQ1VE5R1unRnzZZaqShPZlBiE
         ek4dZzFN2GpujvivkCyg52L9mp6O7WCFRvg+g=
Received: by 10.210.19.4 with SMTP id 4mr4721932ebs.45.1222080071376;
        Mon, 22 Sep 2008 03:41:11 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com ( [212.235.53.3])
        by mx.google.com with ESMTPS id 5sm7134888eyh.2.2008.09.22.03.41.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 03:41:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080922085200.GI21650@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96471>

Dmitry Potapov wrote:
> On Mon, Sep 22, 2008 at 10:37:00AM +0300, Boaz Harrosh wrote:
>> I have 1.6.0.1 I compiled here, and it has the same problem. So it is
>> a very recent fix
> 
> I certainly tested 1.6.0.1 and does not have this problem, and it was
> fixed a long time ago:
> 
> ===
> commit d6b8fc303b389b026f2bf9918f6f83041488989b
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Thu Jan 31 01:17:48 2008 -0800
> 
>     gitignore(5): Allow "foo/" in ignore list to match directory "foo"
> 
>     A pattern "foo/" in the exclude list did not match directory
>     "foo", but a pattern "foo" did.  This attempts to extend the
>     exclude mechanism so that it would while not matching a regular
>     file or a symbolic link "foo".  In order to differentiate a
>     directory and non directory, this passes down the type of path
>     being checked to excluded() function.
> 
>     A downside is that the recursive directory walk may need to run
>     lstat(2) more often on systems whose "struct dirent" do not give
>     the type of the entry; earlier it did not have to do so for an
>     excluded path, but we now need to figure out if a path is a
>     directory before deciding to exclude it.  This is especially bad
>     because an idea similar to the earlier CE_UPTODATE optimization
>     to reduce number of lstat(2) calls would by definition not apply
>     to the codepaths involved, as (1) directories will not be
>     registered in the index, and (2) excluded paths will not be in
>     the index anyway.
> ===
> 
> The patch is included in 1.5.5.
> 
> Dmitry
> --

Ok I found it. Regular subdirectories it works as you said,
but soft-link to a folder does not. Sorry for the noise i didn't
realize that in my test it was a simlink and not a full directory.

Please don't fix it if it will hurt performance, I'm happy with
current solution as it is. Just maybe a small addition to the
.gitignore documentation perhaps.

Boaz
