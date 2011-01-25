From: Simeon Maxein <smaxein@googlemail.com>
Subject: Re: git filter-branch can "forget" directories on case insensitive
 filesystems
Date: Tue, 25 Jan 2011 21:56:09 +0100
Message-ID: <4D3F38E9.9060902@googlemail.com>
References: <AANLkTimOs9m==KaD3BNHcgkTTqNQF1yV0NLA_Ew+iS-N@mail.gmail.com>
Reply-To: smaxein@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 25 21:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phpw8-0007SH-23
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 21:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab1AYU4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 15:56:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58951 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab1AYU4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 15:56:16 -0500
Received: by fxm20 with SMTP id 20so238585fxm.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 12:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:reply-to:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BYPhNRw+DSjm754FbVJT3SCQepDfkusrfO7QNP66Q68=;
        b=maw6tGKQmwydh0WbS8GAjh48iuKbeUVyDEu2BjQMtgalrr9F44vL/bRuvdhCkNf2Vg
         NBzoWiDnB0OROMjOVBVLRyE6490cQUc5YqtcEcspsDi990JvuOwIRfG+4Q6s2kUzFDmd
         dpKxv1szgyCpRGarfhDa3YO653lrE/1mYECUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=OGtjN1lb1H4eLNyAn1o3USCRjgDLYcGXKMoeSymSkzgVltJ6Ax51KKSj3eeq6JhBWC
         kT42gAT8KH71I6w8G/nWEWgpch/rEjnSYnpngsCTO0KwmJWVM711jHt01ev/nshKyH7D
         YjT19HIpTUuBXtEr8zL9mRu63M/E1Q2VaG99E=
Received: by 10.223.96.206 with SMTP id i14mr6304874fan.67.1295988975111;
        Tue, 25 Jan 2011 12:56:15 -0800 (PST)
Received: from [192.168.178.27] (kobz-590d7e94.pool.mediaWays.net [89.13.126.148])
        by mx.google.com with ESMTPS id o17sm5248687fal.1.2011.01.25.12.56.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 12:56:14 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTimOs9m==KaD3BNHcgkTTqNQF1yV0NLA_Ew+iS-N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165484>

In my opinion this is a quite serious issue, because files are lost
without any indication to the user. As of git 1.7.3.1 (tested on
Windows/NTFS with msysGit this time), the problem still exists. Please
give it a look. Fullquote of the problem description / steps to
reproduce follows.

Simeon
> When running git filter-branch on a case insensitive filesystem, the
> working tree checked out for filtering is missing a directory in my
> project. This is probably related to the problem discussed here:
> http://article.gmane.org/gmane.comp.version-control.git/154662
>
> In contrast to that report, this one affects repositories on
> case-insensitive filesystems, regardless of the setting of
> core.ignorecase.
>
> To reproduce the problem, follow the steps below. I tested them with
> git 1.7.0.4 on a laptop running Ubuntu, with the repository on a Fat32
> USB drive.
>
> mkdir gittest
> cd gittest
> git init
> mkdir testdir
> echo 'abc' >testdir/testfile
> git add testdir
> git commit -m foo
> git rm -r testdir
> mkdir testDir
> echo 'abc' >testDir/testfile
> git add testDir
> git commit -m bar
>
> Now, check out master^1 and master to ensure the commits look as
> expected. Then, run this:
>
> git filter-branch --tree-filter 'ls' master
>
> You will notice that the directory vanishes when the second commit is filtered.
>
> The problem occurs whether core.ignorecase is set to true or false. It
> doesn't occur on case sensitive filesystems.
>
> Simeon
