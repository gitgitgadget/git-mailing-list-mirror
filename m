From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 17:35:49 +0300
Message-ID: <48D8FEC5.3060503@panasas.com>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>	 <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>	 <48D8CFF1.8030403@panasas.com> <94c1db200809230714k6b007919yfd8ad1b86cbcd385@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mario Pareja <mpareja.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 16:37:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki90l-00017X-CX
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYIWOf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 10:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbYIWOf4
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 10:35:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:22248 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYIWOfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 10:35:55 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1626795ugf.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=gFJNWYVPUg+qdrhsLpJ1/QSVydFMTwjNgPIZUumGg/U=;
        b=Wv4lboP70XuiBQdUAUWB9pvFfR7QEYJX8Wzmq0PKsKtQPYd3TYfEa0BBALdYMwbdR4
         l2ryjmZL5SWiZoc85pViZxrtbTm/gHtbe4QfIUvJqj9tXT0fA4Fkmo70T0aQBpOwmVym
         4JnUk2gH1vaEd1XiWgfBgpZeoRAQfDKvdgtsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=g/+7XrcUnJnQMZfXDTNgHxpycfC8KaYBNwgYJtA+Rs0RcmzxSPKddZsX1StG9gIvYX
         vsBJLySJ6kRWfd0uudl1KtWqycHpmfJzSW8lfvGq5pau+WnjmbxdMaSXBevmcFhXSDFm
         k88rRGo6aW+6TwkxrfQJBgFKqWzRnnpWas93s=
Received: by 10.86.52.1 with SMTP id z1mr6158631fgz.63.1222180553074;
        Tue, 23 Sep 2008 07:35:53 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id e20sm7615039fga.1.2008.09.23.07.35.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 07:35:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <94c1db200809230714k6b007919yfd8ad1b86cbcd385@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96570>

Mario Pareja wrote:
>> It should be easy for a company to set a policy where a couple of scripts
>> must be run for particular type of files. Given that, the implementation
>> of such scripts is easy:
>>
>> For every foo.bin there is possibly a foo.bin.lock file.
>>
>> Lock-script look for absence of the lock-file at upstream then git-add
>> the file (With some info that tells users things like who has the file).
>> If git-push fails, since I'm adding a file and someone already added
>> it while I was pushing, then the lock is not granted.
>>
>> Unlock-script will git-rm the lock-file and push.
>>
>> In both scripts mod-bits of original file can be toggled for
>> read-only/write signaling to the user. (At upstream the file is always
>> read-only)
>>
>> This can also work in a distributed system with more then one tier of
>> servers. (Locks pushed to the most upstream server)
>>
>> Combine that with git's mail notifications for commits and you have a
>> system far more robust then svn will ever want to be
>>
>> My $0.017
>> Boaz
>>
> 
> This is a reasonable approach to obtaining the desired functionality.
> Unfortunately, I have not seen any third-party packages implementing
> such a feature.  It seems to me the problem is general enough to be
> solved once rather than requiring organizations wishing to use git to
> implement an in-house locking system. It simply creates more friction.
> Perhaps, when I have the time, I will come up with something others
> can use.  For now, unfortunately, it seems I am out of luck?
> 
> Mario
> --

The open-source my friend. First comes first implements. More and more
development platforms use XML files in where they used a binary file
format before. Just for these cases. Git is mostly used with open-source
and/or very new systems that don't have binary file formats. OK graphics is
another thing, I guess.

So you are welcome to it. "git-lock" is available

Boaz
