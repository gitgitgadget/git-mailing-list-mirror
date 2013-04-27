From: Ilya Basin <basinilya@gmail.com>
Subject: Re: git-svn --preserve-empty-dirs: Failed to strip path
Date: Sat, 27 Apr 2013 19:05:16 +0400
Message-ID: <1603362637.20130427190516@gmail.com>
References: <917648658.20130427112832@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 17:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW6ig-0003G8-4u
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 17:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab3D0PHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 11:07:15 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:49403 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab3D0PHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 11:07:14 -0400
Received: by mail-la0-f41.google.com with SMTP id fq13so4359069lab.14
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=DpZNgxr69RdCtDA2C59MwECX0QPXdSosdtKLHoU8FVo=;
        b=VoZ4kfigVEHGXKid2xP1zLQjodD/ySUImU2AyqraBPMgpxdlXxHqUOAhQemw48YLnv
         tXJrIZZBeUL2ro+MpWuDwxu3pzBd/G+zAJKsiMVBA3JTTA1yo5w+mwl7yKGh2UoKRftQ
         aJxFgAyYNn/dJSjor3UCXj9Ro18pZLUxLStDSnEEp5QpzDLsckSp3GmV3NOUJ8fOjIR9
         nhAFR0yNK2R3EisrlIm13DIQwMDLVn9Gp4VOvA+zzaRFa51x8VXWiremiVB5UomFq0Em
         c2vRAIVWkGllh91uXhH438S+k0NKop8/9tPYGUeq1X0oSnZQxkKjFA19r38jQea0fm3/
         HpNQ==
X-Received: by 10.112.146.98 with SMTP id tb2mr23648157lbb.77.1367075232237;
        Sat, 27 Apr 2013 08:07:12 -0700 (PDT)
Received: from [192.168.0.78] (92-100-233-116.dynamic.avangarddsl.ru. [92.100.233.116])
        by mx.google.com with ESMTPSA id u2sm6513491lag.7.2013.04.27.08.07.03
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 08:07:09 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <917648658.20130427112832@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222656>

Small test script:

    rm -rf testrepo.svn testrepo.gitsvn
    svnadmin create testrepo.svn
    url=file://`pwd`/testrepo.svn

    svn mkdir -m "" "$url/trunk" "$url/branches" "$url/tags"
    rm -rf testrepo
    svn co "$url" testrepo
    cd testrepo/trunk

    mkdir -p foo/bar/
    svn add foo/
    svn commit -mx

    svn rm foo/bar/
    svn commit -mx

    svn up
    mkdir -p baz/
    svn add baz/
    svn commit -mx

    echo x > fil.txt
    svn add fil.txt
    svn commit -mx

    cd ../..

    git svn clone --stdlayout --preserve-empty-dirs "$url" testrepo.gitsvn

result:

    Initialized empty Git repository in /tmp/testrepo.gitsvn/.git/
    r1 = 677463d6218c2229f81a8d891479435250cb9c87 (refs/remotes/trunk)
    r2 = f61c011cc800eaa9953026b8bd4534c9cc7825a8 (refs/remotes/trunk)
            D       foo/bar/.gitignore
            D       foo/bar/
    W: -empty_dir: trunk/foo/bar
    r3 = b674724183fe4960b1b10813c41a91c5b22e805e (refs/remotes/trunk)
    r4 = 8b1c8fdbf9b43390efb37b053c868a5f40567249 (refs/remotes/trunk)
            A       fil.txt
    Failed to strip path 'foo/.gitignore' ((?-xism:^trunk(/|$)))
    

git version 1.8.2

-- 
