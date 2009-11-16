From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: how to make gitk to use specified history information
Date: Mon, 16 Nov 2009 16:38:41 +0800
Message-ID: <4B010F91.5010208@gmail.com>
References: <4B01049A.5090402@gmail.com> <loom.20091116T090441-576@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 09:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9x5g-0004x6-Jq
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 09:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbZKPIhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 03:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbZKPIhJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 03:37:09 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:59965 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbZKPIhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 03:37:08 -0500
Received: by ywh40 with SMTP id 40so2886061ywh.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 00:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=glls3+XIlu6bzbzccDQ7Ehfr3LEP2eS2B6ixmZHPWm4=;
        b=CDKHyaUiAACgjYdtZTb+LrPBGV5YlKx2sN8vBPDGW+O0sNC5jmVQBlmIBBOIsN9xc3
         PKNzWptS8tqUZfwCOZEXKoKb9YUM9yh3hmpRo8jHsTffzmzL55W6qCe1VOswV7PX2jWE
         mHBTSWju2vaasMJYAjAEWzMQUy0yWKoQndd/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kbCfec+cYAGLj/olbj91FHd1wyRy9c5zpb21rvnvxcMez1vMV3y2l6d938UkWHJ3ai
         dGq3Bw6zKIK+R5lXM6wRlWGO4OiEahiDD9ANeW2zHqIVjF3qjIysPBIGOPflzTRWCWav
         gaJfv6723mdjj1HoXzKqrDQxZBe5T96/vuDVM=
Received: by 10.150.19.5 with SMTP id 5mr4204945ybs.103.1258360632276;
        Mon, 16 Nov 2009 00:37:12 -0800 (PST)
Received: from ?10.64.1.88? ([211.157.41.194])
        by mx.google.com with ESMTPS id 22sm39496ywh.0.2009.11.16.00.37.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 00:37:11 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
In-Reply-To: <loom.20091116T090441-576@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132993>

Eric Raible wrote:
> Liu Yubao <yubao.liu <at> gmail.com> writes:
> 
>> I want to obtain an outline of history information, for example:
>>
>>   a - b - c - d - h -i -j
>>    \         /
>>     e- f - g
>>
>> I simplify the graph like this:
>>
>>   a - c - d - j
>>     \    /
>>       g
> 
> "gitk --simplify-by-decoration"?
> 
> - Eric
> 
Thanks, but that gets "a - g - j" which isn't what I want.
(g and j are heads of two branches).

The command sequence to produce that full revision graph:

#!/bin/bash
d=/tmp/t$$
rm -rf $d && mkdir $d && cd $d || exit 1

doit () {
  for s in $@; do
    echo $s >> a.txt 
    git add a.txt
    git commit -q -m $s
  done
}

git init
doit a b c
git checkout -b t HEAD~2
doit e f g
git checkout master
git merge t
doit d h i j

gitk &
