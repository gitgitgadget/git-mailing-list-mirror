From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/2] push optimizations
Date: Mon, 7 Jul 2008 22:12:26 +0100
Message-ID: <b0943d9e0807071412j71780300p87d00cccea6cd8f4@mail.gmail.com>
References: <20080702060113.11361.39006.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 23:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFy1W-0008Ez-MB
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 23:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621AbYGGVM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2008 17:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756586AbYGGVM2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 17:12:28 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:29022 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597AbYGGVM1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2008 17:12:27 -0400
Received: by py-out-1112.google.com with SMTP id p76so1023099pyb.10
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qYTWAV93UCE7C0FAUXZpnBfW67vFfiCfC2XdcMUXXW0=;
        b=E8NMkWPN2ivWKSsGm77AUCzOivbtWYT6rG4wFYGkExOmvvssAStHhKrsqqGd5hwmTL
         QFPXoHD6PVh3807m7fzGSZ6u77d77T8+Lkncs36ivFp9+Welr3hywcZYXCOVz9cnOs90
         KXbDnRJcs1jDLjVBGLN8idEYjgXZKsYsNxA1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=av15QxIdLvU86+kjv18j1wmHJtI8AM7SCSxS8sja7qyBagW12vlm0w7t0iTmezdsor
         kKlsh8YJkHNCygKvEe+W9ffDfRcU0Cm35m+SS2SzwDA6DvAUWtO1u00/MPjCxr9RzdM1
         SdgdPPEocRphKb8mknGMm207RAInkxdVY21M8=
Received: by 10.114.161.11 with SMTP id j11mr7093902wae.105.1215465146606;
        Mon, 07 Jul 2008 14:12:26 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Mon, 7 Jul 2008 14:12:26 -0700 (PDT)
In-Reply-To: <20080702060113.11361.39006.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87657>

2008/7/2 Karl Hasselstr=F6m <kha@treskal.com>:
> Here's the git-apply call you asked for. You were right: it was a hug=
e
> speed-up.

I know, I've been through this couple of years ago :-)

> I set up a benchmark to test it:
>
>  * 32 directories, each containing 32 subdirectories, each containing
>    32 small (and different) files.

Can you try with a Linux kernel like the -mm tree? You get normally
sized patches which might show a difference with the patch log. You
can clone the for-akpm branch on git://linux-arm.org/linux-2.6 and
just uncommit ~300 patches.

>  * I set all this up with a python script feeding fast-import. A huge
>    time-saver!

What is fast-import?

>
>  * Pop patches, git-reset to upstream, then goto top patch. This
>    makes sure that we use the new infrastructure to push, and that we
>    get one file-level conflict in each patch.
>
> Before the first patch, the "goto" command took 4:27 minutes,
> wall-clock time. After the first patch, it took 1:31. After the
> second, 0:48; one second or so slower than the stable branch (which
> does not have a patch stack log).

One second is just noise and depends on how warm the caches are. You
could run a few times consecutively and discard the first result but
we don't need to be that accurate.

--=20
Catalin
