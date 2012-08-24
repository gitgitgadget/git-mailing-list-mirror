From: Iain Paton <ipaton0@gmail.com>
Subject: git no longer prompting for password
Date: Fri, 24 Aug 2012 21:19:28 +0100
Message-ID: <5037E1D0.6030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 22:20:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T50Mr-0006Ro-In
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 22:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760057Ab2HXUUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 16:20:13 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57845 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab2HXUUL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 16:20:11 -0400
Received: by wgbdr13 with SMTP id dr13so1777024wgb.1
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=gjxZDuslNc90+aEsbqV1bvR7QB64JhJNNdxnf9VI6qU=;
        b=I8dmgzbRNz6pg1XUaI40V+yR9LG+WYg1J139ESRGLfq7HX+gHi/L5VVCqfMRRgNnCx
         bBItPsRZEbwlI1O3TIJOciM6ZcImf002nXU15XLaRKXfduhZWprhfCbZV1SKvXMMhl7l
         +2bOaX+/4DGV+Pg3FWufV8VwdET4eGWbJWqv2g5MrvrPxQ5CWXknkMcCMIrnFsMxtwSw
         /5HMAazToRm5ob/kBRKfNJn6kyCvfS24007pYdXWHyNhXZdewsWheR37jYHQaIlYEDb5
         cTYWxPW9Bg7LCUcBqQB8P6pQVO2/zGkoc2C2L/of0jWa6eV6FF29fysFnuiKzla1ol9t
         MhDQ==
Received: by 10.216.158.212 with SMTP id q62mr3151610wek.53.1345839609768;
        Fri, 24 Aug 2012 13:20:09 -0700 (PDT)
Received: from [10.44.16.58] (hades.darkvoyage.org.uk. [81.187.177.1])
        by mx.google.com with ESMTPS id r9sm355402wia.2.2012.08.24.13.20.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Aug 2012 13:20:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204231>

Hi List,

A recent update to git 1.7.12 from 1.7.3.5 seems to have changed something - trying to push to a smart http backend no longer prompts for a password and hence fails the server auth.

The server is currently running git 1.7.9 behind apache 2.4.3 with an almost verbatim copy of the apache config from the git-http-backend manpage.

Backtracking through the versions I've skipped and this doesn't seem to be a new problem, client side up to 1.7.7.7 works, 1.7.8 onwards don't. Server side version doesn't seem to make a difference.

user@fubar01:~/test# git --version
git version 1.7.7.7
user@fubar01:~/test# git push http://ipaton@10.0.0.1/git/test.git master
Password: 

type the password in and the push is successful

user@fubar01:~/test# git --version
git version 1.7.8
user@fubar01:~/test# git push http://ipaton@10.0.0.1/git/test.git master --verbose
Pushing to http://ipaton@10.0.0.1/git/test.git
Counting objects: 6, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (5/5), 491 bytes, done.
Total 5 (delta 0), reused 0 (delta 0)
error: RPC failed; result=22, HTTP code = 401
fatal: The remote end hung up unexpectedly
fatal: The remote end hung up unexpectedly

Watching the connection with wireshark shows that it does appear to try to authenticate with the correct username, but without a password. Not surprising since it doesn't ask for one..

googling for git and password just seems to give results where people want it to stop asking for a password, which is the oppsite of what I want!  
Looking at changelogs for 1.7.8 and I'm not really seeing anything that says I need to do something different.

Any help or pointers appreciated.

Thanks,
Iain
