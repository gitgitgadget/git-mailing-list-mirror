From: Junio C Hamano <gitster-vger@pobox.com>
Subject: Re: cherry-pick is slow
Date: Sat, 12 May 2012 18:11:11 -0700
Message-ID: <CAPc5daW6eBLUf55_Qk+4bA6Y16TehfOUGc1xFzhib9vm=8O2Yw@mail.gmail.com>
References: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dmitry Risenberg <dmitry.risenberg@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 03:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STNLx-0007vJ-4e
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 03:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab2EMBLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 21:11:34 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62591 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab2EMBLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 21:11:33 -0400
Received: by wibhn6 with SMTP id hn6so1342192wib.1
        for <git@vger.kernel.org>; Sat, 12 May 2012 18:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=+9jRDPuimN6JcJfOV0JAf3LPmTzoqMO3uteu8rxDsKc=;
        b=WeiW5IS+p/kj/7JWjSMKaobCtjsswOVUuauYSjnKqBj7wN5pcS9J7h9mriNFtjggwG
         OFdS+vxqR9cpoXeXtWZ3kmr5ftO1+vdMDTS/KNRoW9VWxA6i/q6JtJHgxcvoXsk0LiGY
         B3j3oiwELmx0k36IROL4y59y85/RiX8HeWjDRcydojUilPc4CSsXQIiBzW5gxIrn/aYR
         PZwcxSdDJl2C/W46UI40NdRaoYV8oZNKoRClZoEZS/P5pN5mV6R2L8Uaw21xh80XlEp5
         kz5WSiyYG4hi8qUIPl9ii/No/scQe5ifaX55sZG/rxprIKv1Bvn9CmZ8p91wdveuY4xg
         Pw/w==
Received: by 10.180.78.105 with SMTP id a9mr7726187wix.20.1336871492041; Sat,
 12 May 2012 18:11:32 -0700 (PDT)
Received: by 10.216.235.91 with HTTP; Sat, 12 May 2012 18:11:11 -0700 (PDT)
In-Reply-To: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
X-Google-Sender-Auth: xB-FKoTfi8aBJ1f70dopXrnmRec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197742>

On Sat, May 12, 2012 at 3:39 PM, Dmitry Risenberg
<dmitry.risenberg@gmail.com> wrote:
>
> Hello.
>
> I have a very big git repository (the .git directory is about 5.3 Gb),
> which is a copy of an svn repository fetched via git-svn. In fact
> there are a few repositories ("working copies") that share the same
> .git directory (via symlinks), in which I have different svn branches
> checked out. Now I want to merge a commit from one svn branch to
> another via git cherry-pick. The commit contains diff in only one
> file. So I do
>
> git cherry-pick <commit>
>
> And the operation takes tens of seconds to finish. In "top" output I
> see that git process uses almost no CPU, but has hundreds of page
> faults, so I assume that it is reading a lot of files from disk.

Wild guess: poorly (or worse yet, never) packed repository?
