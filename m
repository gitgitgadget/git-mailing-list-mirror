From: Kyle McKay <mackyle@gmail.com>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and skelta mode
Date: Fri, 5 Jul 2013 15:58:27 -0700
Message-ID: <E82AC74E-3294-415D-8E59-97DDD213B11A@gmail.com>
References: <kr7beq$ilk$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Rothenberger <daveroth@acm.org>
X-From: git-owner@vger.kernel.org Sat Jul 06 00:58:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvExW-0005b3-Su
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 00:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab3GEW6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 18:58:31 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:64025 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab3GEW6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 18:58:30 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so4045820oah.35
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=5nEX199GJLzLd0nD0Oc2+xRj3XuzLg0zPRxKg5nRxNo=;
        b=sDvv6JeAuxhwZZ0uwVV0eCytsDS+yXfzrhk2Xp5gMcclnuzGkL6bForo1wVHanOlVT
         iJyeuhJedAHMhJvEuorLxLmxZZGxF/p4WPK1Cx/0u06qeG5rFLpsID3quupAx7AZr7/e
         BSKr6W9himwijJO6iowbykIpaZ3wtSzsXM85HElWqaKqbdhR1I3uAnX/tCyto4dZY6p9
         P4mJ0aUzu/OErQK63JCVkcFsGNFYwlso101e1WPS63OoyiseyFjOQDPTr/kiScZFr3Dl
         CucT1Iu6/iU4bcDmY9+nI+SVAQ0DxU/zWLh73cIi9SNB8fbz5tAZp9ToF+ZWEiQovkGn
         ZhbQ==
X-Received: by 10.182.214.39 with SMTP id nx7mr13349038obc.20.1373065110068;
        Fri, 05 Jul 2013 15:58:30 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id el16sm18333359oeb.2.2013.07.05.15.58.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 15:58:29 -0700 (PDT)
In-Reply-To: <kr7beq$ilk$1@ger.gmane.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229682>

On Jul 5, 2013, at 13:48, David Rothenberger wrote:
> I recently upgraded my Subversion server to 1.8.0 and started
> receiving the following error from "git svn fetch":
>
> Temp file with moniker 'svn_delta' already in use at /usr/lib/perl5/ 
> vendor_perl/5.10/Git.pm line 1024.
>
> This occurs only when using an http:// URL; svn:// URLs work fine.
[snip]
> The client is Cygwin: svn version 1.8.0 and git version
> 1.8.3.2.

The subversion 1.8 release has removed the neon library, all svn  
client http access now always goes through the serf library.  If you  
put "http-library = serf" in the "[global]" section of the  
"~/.subversion/servers" file you will get the 'svn_delta' error with  
git-svn when running earlier versions of the svn client as well.

> I initially reported this to the subversion users mailing list, but
> was (not so politely) told to report this to the git-svn authors.
> I'm not so sure, since the problem goes away simply by downgrading
> the subversion-perl bindings back to 1.7.

That changes the default http client access back to neon which doesn't  
exhibit the problem.  Adding "http-library = serf" as described above  
will make the problem reappear with the 1.7 subversion-perl bindings  
(and the 1.6 as well).

Kyle
