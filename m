From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 15:18:30 +0100
Message-ID: <531DC9B6.6030605@gmail.com>
References: <531D8ED9.7040305@gmx.net> <CANgJU+W+f3KUxehDGxd+f77RO24VadsnOV=szE2MkBXjs8wDCQ@mail.gmail.com> <531DA519.8090509@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Dennis Luehring <dl.soluz@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 15:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN12L-00025s-Ly
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 15:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbaCJOSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 10:18:33 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:44580 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbaCJOSc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 10:18:32 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so88271wiw.12
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qdi9Q4k2diPBTBDa36SZtU7EGo+5SPvEc/snrayWIyY=;
        b=kTXYZEesdwQNLEIvDyvYICqvUUvOn4/BwucYJrrlLSsZnRR3eEa6Pk0+5eKUmHLDqx
         ogNPWMwiKyKNXuUjdmkcDhmX8D0w4nx1sO67PMBVjwPTUelQ/ryh0MZx6b8+S4cjC5iF
         N3D3n3c/XQaxyUCRwO8AAuCSTz9B+5RXEXj7BxgH/YgYML8Qrx+l+RHepTmzHhivbD7m
         MEGbziDlbA/HBPdGN+w+Yig3+izsat4feJcF4qX3ZLTaOX6VgIR5iDaq9Ob+D/L00t7l
         HVUJeL5fXeJOJBM1MqZnw8lUbGC3z6k+7sXr0M6sIm0hnahWTlIYGgsilP4J5+OsEgEm
         a80g==
X-Received: by 10.194.202.230 with SMTP id kl6mr31946087wjc.9.1394461111254;
        Mon, 10 Mar 2014 07:18:31 -0700 (PDT)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fs4sm13028056wib.11.2014.03.10.07.18.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 07:18:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <531DA519.8090509@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243761>

Am 10.03.2014 12:42, schrieb Dennis Luehring:
> Am 10.03.2014 12:28, schrieb demerphq:
>> I had the impression, and I would not be surprised if they had the
>> impression that the git development community is relatively
>> unconcerned about performance issues on larger repositories.
> 
> so the question is if the git community is interested in beeing competive in such
> large scale scenarios - something what mercurial seems to be now out of the box
> 

The hgwatchman site claims (https://bitbucket.org/facebook/hgwatchman)

"On a real-world repository with over 200,000 files, hg status normally takes over 3 seconds. With hgwatchman it takes under 0.6 seconds."

There have been a few performance improvements in git status to support such large repositories. I just re-checked git status performance with the WebKit repo (~200k files):

Linux (with core.preloadIndex)
git status -uall: 0.620s
git status -uno : 0.255s

Windows (with core.preloadIndex and core.fscache)
git status -uall: 1.006s
git status -uno : 0.695s

Of course, for more reliable benchmark data, you'd have to compare the same repo on the same platform. But on first glance, it seems that mercurial with hgwatchman extension may be as fast as git is out of the box, not the other way around.

This comes at the cost of running a background daemon, which may slow down the entire system. E.g. if the daemon activates whenever the compiler creates a .o file, it will probably slow down build performance.

Note that hgwatchman doesn't support Windows, so git is probably much faster there.
