From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 15:17:11 +0700
Message-ID: <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 17 10:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McxPV-0005B6-57
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378AbZHQIRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757251AbZHQIRc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:17:32 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:31679 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757278AbZHQIRa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 04:17:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so2727355and.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gLtHTJD1DlM3tguAsC7d2I3R/SyPVFSybmAYUkc7Y24=;
        b=aGvhWo3LWXDaneT0e5s/un56M8QyY36NZvWbpZDH/JhEHnstZXWvm+wBEVU/v7+p//
         IB26wIwWLVGkqny+w9CBdVRpVNasxiI1NX6lHtLT2pbKAeHLK3Lu1E2SY9Ec1L5cGoqr
         hIXdnhFSUTl8Yae8YlYBGtWqgxPDEu4BZfTJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=s2/oMf1KF/fMyrXt/wgffO2v/chEjzhJfziqaUEeS/t+DP38EA748OpOhfrb26Biiy
         RL2fCS+0OB0DUdQ+ZJhSFx9s+tOGq7pwYjQ3PasaYPM5w0TOUqZAsFzesBcrRLSJmXxl
         j2Wuz/YUx59iPcJId9/5OYzhOL/N6yLeWhWD4=
Received: by 10.100.17.20 with SMTP id 20mr3078393anq.41.1250497051196; Mon, 
	17 Aug 2009 01:17:31 -0700 (PDT)
In-Reply-To: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126139>

On Mon, Aug 17, 2009 at 1:09 PM, <skillzero@gmail.com> wrote:
> 1. Have people decided whether it should be on by default if you have
> a .git/info/sparse file? I'd definitely like it to be on by default.
> When I first tried it, I didn't realize I had to use --sparse to git
> checkout to get it to use the sparse rules. The same goes for a merge
> I did that happened to have a file in the excluded area (it included
> it because I didn't use --sparse to git merge).

I tend to make it enabled by default too. I have made it stricter to
trigger reading sparse in unpack_trees() -- only do it when
unpack_opts.update is TRUE. This should make it safer to be enabled by
default.

> 2. Is it not hooked up to git reset yet? I did a git checkout --sparse
> and things look liked I expected then I did a git reset --hard
> origin/master and it started checking out all the stuff previously
> excluded via .git/info/sparse. I tried --sparse, but it didn't know
> about that option.

Because sparse was disabled by default, and "git reset" did not enable
it. It'd be interesting to see what "git reset --hard" should do in
this case: will it apply .git/info/sparse or not, which brings us back
to the "default or not" question, hmm..

> 3. One thing that was confusing is that I needed a trailing slash on
> directories in .git/info/sparse to get them excluded. This seems
> different than .gitignore, which works for me without the trailing
> slash.

Hmm.. probably because Git feeds directories to .gitignore handling
functions. There is not much I can do, index does not have
directories. I don't know if it's worth generating "directories" from
index.
-- 
Duy
