From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: fatal: cannot store pack file (git 1.6.0.2 + sshfs)
Date: Wed, 24 Sep 2008 12:57:55 -0500
Message-ID: <d77df1110809241057rb1d7361pf76a4cde8834b1df@mail.gmail.com>
References: <87iqsmy8q7.fsf@sms.ed.ac.uk> <20080924163400.GU3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jhair Tocancipa Triana" <jhair.tocancipa@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:59:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYdp-0006Dz-Qt
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYIXR57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 13:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbYIXR57
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:57:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34784 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbYIXR56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:57:58 -0400
Received: by ug-out-1314.google.com with SMTP id k3so13593ugf.37
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YKWoEAJRGuN0KL/1SSPE7m07PmPPAcfNRov9xXtuh2U=;
        b=S6h6j155bSIpYhCIaN32cz+4pthvnBTqeGHBEMFwbROgsxqRN0U1cJ53GRLWyyaepN
         iLEYvplu29QsrbLMqaqXFG9yFBtrOM6CkRSjK2f5RGXOLLlul2d45mvNsshTodj+N5c8
         wfhzUW7//gLY5HI8nN7Mf/iwj9YcedfS5nCBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FbkA9CDhj7Sry5Btx33TDnygIJ/jAwPJGAfWe5YiJWEK47yiVe8TC8rMdm11icQddw
         YsVA2zc2sJv49OLQrX2kCrnI7i7j3wL79YAiwP8SgcekScFOWkGyBPa+0rrcGCYVtLen
         fRkSDPzepmmc4Vp7XogqhlcI58iH2BBns8oW8=
Received: by 10.67.27.3 with SMTP id e3mr822280ugj.74.1222279075329;
        Wed, 24 Sep 2008 10:57:55 -0700 (PDT)
Received: by 10.66.234.6 with HTTP; Wed, 24 Sep 2008 10:57:55 -0700 (PDT)
In-Reply-To: <20080924163400.GU3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96672>

Resend with reply to all:

When I mount with sshfs, I have to give the option

sshfs -o workaround=rename ...

to make things work normally.

On Wed, Sep 24, 2008 at 11:34 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jhair Tocancipa Triana <jhair.tocancipa@gmail.com> wrote:
>> I'm getting the following when running git on a partition mounted with
>> sshfs:
>>
>> $ git pull
> ...
>> error: unable to write sha1 filename .git/objects/pack/pack-dc5c3614e795918f457a2f98a58f10134ebf246b.pack: Operation not permitted
>> fatal: cannot store pack file
>> fatal: index-pack failed
>>
>> git pull worked fine in the same repository yesterday (new files where
>> committed in the meantime).
>>
>> I'm not sure if this is a problem in git or in sshfs (or somewhere
>> else).
>
> Its the size of the fetch.  The day before you probably had a smaller
> number of objects downloaded (<100) so Git used unpack-objects
> instead of index-pack.  Yesterday it was a larger download (>100),
> so it used index-pack.
>
> In 1.6.0.2 index-pack writes a temporary file to .git/objects but
> later tries to rename it into .git/objects/pack.  That renaming
> must not be working on sshfs.
>
> Latest "master" has a change from Pasky (8b4eb6b6 "Do not perform
> cross-directory renames") that should fix this issue.  Or just
> don't use sshfs.  Or teach sshfs to rename across directories.
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
