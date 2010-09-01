From: Chris Packham <judge.packham@gmail.com>
Subject: Re: getting git to ignore modifications to specific files
Date: Wed, 01 Sep 2010 13:45:18 -0700
Message-ID: <4C7EBB5E.5080003@gmail.com>
References: <4C7EA1FF.8030307@gmail.com> <AANLkTi=cPzAAKsTR+_1sucF46Rez=yi2Okjz7RhcCZ20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBY-000790-3E
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab0IAUpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 16:45:16 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35679 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab0IAUpO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:45:14 -0400
Received: by pvg2 with SMTP id 2so3021315pvg.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=A2RfwDWeLpJ8x+BXjwOnsmjhImc5I7Ut0uExZWYQmXQ=;
        b=kTnOvJPNXb9accNw+QWibcHT/wLPD/Iqg7Znl4R7i6ijomeO/1EVoQCbwySLm5s7AG
         Kyo3i1zXiOB+wTq4gVsxTbgHrf3hA7W/TF7rVFp6A7GNiOdcTgD6ThduDwq5SQxEAPy7
         jPjzLQUE59TI2l/4J+DnOOq1NwCEyLKhr55Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Gg6rbUxYTWKJ17fJo7LwA1KXgwiHPHJe00aRW+QXs9ZbsprTMEU5tPPaeZYwqUsVgd
         hsodGD9YOWgs0BEblV8Rdk3z64dRarX9UbJCwRBVkiWpJ/Cvw8jJ2F9LtMhgoCzwmIU/
         O6/FfyatALtKpdB1h5AnMQP7rzg0yl2baaZLI=
Received: by 10.114.131.6 with SMTP id e6mr9480862wad.90.1283373914092;
        Wed, 01 Sep 2010 13:45:14 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d39sm19225999wam.4.2010.09.01.13.45.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:45:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTi=cPzAAKsTR+_1sucF46Rez=yi2Okjz7RhcCZ20@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155091>

On 01/09/10 12:12, Bruce Korb wrote:
> On Wed, Sep 1, 2010 at 11:57 AM, Chris Packham <judge.packham@gmail.com> wrote:
>> I did a bit of googling and found
>>  git update-index --assume-unchanged
>>
>> Which works locally to stop git status from complaining. Is there anyway
>> for me to make a change to our clone (a .gitattribues entry?) so that
>> everyone can get this by default?
> 
> Isn't that what .git/info/exclude is about?

Not as far as I've been able to tell. .gitignore and .git/info/exclude
are ways to tell git to ignore these untracked files so that they don't
show up in the output of git status (and others).

In my case the file is tracked, I just don't care if it changes and I
don't want git rebase/checkout to complain if I have local modifications
to this file. Ideally I'd like git add INSTALL to treat it as if nothing
changed but have git add -f INSTALL stage the changes.

Thinking about what I can do with the existing .gitattributes I could
probably have a custom diff driver that always returns 0 (/bin/true
perhaps) and a custom merge strategy of theirs (or something sensible)
if needed. A clean/smudge filter of git update-index
--assume-(un)changed may also be possible but I haven't tried it yet.
