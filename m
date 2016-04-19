From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] git-p4: fix Git LFS pointer parsing
Date: Tue, 19 Apr 2016 22:54:08 +0200
Message-ID: <A6FD8E93-63E8-49EE-838D-2AF3FD3910D4@gmail.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com> <1461096530-82448-3-git-send-email-larsxschneider@gmail.com> <xmqqtwixz6i4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, luke@diamand.org, sschuberth@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 22:54:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ascf2-0007z3-HN
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbcDSUyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 16:54:12 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37669 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbcDSUyM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2016 16:54:12 -0400
Received: by mail-wm0-f42.google.com with SMTP id n3so50290252wmn.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=swyJ9CLZehS+l5xv6NfJYQ1deTBbwxg8D1VGWEX4wYs=;
        b=Vf6Q8XaPNxIQCznRhv8tOtp6ykltdYk4+j4ccxYGHz8Vel+oSXIteyJ+b+KgPhOhfg
         VMINbH5dnkycYIIuJzszV9JvF1iLh702Ha0CJQtsNnWG9ly3rFHbhXDPbbkIK3c7pgLX
         IMgjaU6KBL45ScHXXc+3v7Egoomu36dGemYIjYX7FFn2QfXJZ7mkPgua2NmhKsOfo+/f
         JKT1cNIyaUZkv0JVFSxeNBRVhyh0+AmiI1jtfrCVZdqiXk7mJ0KehZ42nsa4mvxc1Rgp
         mIC7rO4PU72yJWpzBfQu6lXGQeff/mECf3figSnpztt1OyHj7HdgWEif3Fkh13FQvLsZ
         Giyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=swyJ9CLZehS+l5xv6NfJYQ1deTBbwxg8D1VGWEX4wYs=;
        b=TZRs6xCwyGoSzJiuKZ3i6MXDlwS0rqZpndC5JnDU3FRN6RXzLqU0eew0GCxvyCXhC1
         cr3LXuLe7/6U8OHD1pW8IGS710Wg03Mgh+1jaj8Vzf58ZTvYN72LADYJ7QQPhLJccTnr
         qiT05BQWMH/awJC+S8pSXt4l1MPp6OX+eQHLRMq1Ouo65QLg91QFs2XwZ5AaM0PgN7UY
         8m41aLB4ZsC4ZU4V3Tj1Q3PLa11LgQ5VzSdWol7vMUciBeCN71z9NCWCivViQVo9QisW
         i7hP4ZDUrxy1VR95MPF48OzFy5dqrmmkGoLRBV2nG/1ETQXmqKnn8jIxFFxe86xCb5Va
         xtDA==
X-Gm-Message-State: AOPr4FWtRkxFmP1Uwz3IydTidX6cZC22WGipvWu980XZXRt/WEiv2bJidZmW9a4WjPYg8w==
X-Received: by 10.28.99.214 with SMTP id x205mr5650665wmb.9.1461099250595;
        Tue, 19 Apr 2016 13:54:10 -0700 (PDT)
Received: from [192.168.178.40] (p508BAC17.dip0.t-ipconnect.de. [80.139.172.23])
        by smtp.gmail.com with ESMTPSA id ux5sm2070757wjc.17.2016.04.19.13.54.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 13:54:09 -0700 (PDT)
In-Reply-To: <xmqqtwixz6i4.fsf@gitster.mtv.corp.google.com>
X-Mailer: iPhone Mail (13E238)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291924>


> On 19 Apr 2016, at 22:30, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Git LFS 1.2.0 removed a line from the output of the 'git lfs pointer'
>> command [1] which broke the parsing of this output. Adjust the parser
>> to the new output and add minimum Git LFS version to the docs.
> 
> Hmph, adjust to operate with both, or drop the support for the old
> one?
I dropped the support for the older version to keep the code as simple as possible (plus it would be cumbersome to test with an outdated Git LFS version). Since it is probably a niche feature I thought that might be acceptable.

Thanks,
Lars

>> 
>> [1] https://github.com/github/git-lfs/pull/1105
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Documentation/git-p4.txt | 3 ++-
>> git-p4.py                | 6 +++---
>> 2 files changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index 88ba42b..b862cb9 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -522,7 +522,8 @@ git-p4.largeFileSystem::
>>    that large file systems do not support the 'git p4 submit' command.
>>    Only Git LFS is implemented right now (see https://git-lfs.github.com/
>>    for more information). Download and install the Git LFS command line
>> -    extension to use this option and configure it like this:
>> +    extension (minimum version 1.2.0) to use this option and configure it
>> +    like this:
>> +
>> -------------
>> git config       git-p4.largeFileSystem GitLFS
>> diff --git a/git-p4.py b/git-p4.py
>> index 527d44b..d2be574 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1064,8 +1064,8 @@ class GitLFS(LargeFileSystem):
>>         if pointerProcess.wait():
>>             os.remove(contentFile)
>>             die('git-lfs pointer command failed. Did you install the extension?')
>> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
>> -        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
>> +        oidEntry = [i for i in pointerFile.split('\n') if i.startswith('oid')]
>> +        oid = oidEntry[0].split(' ')[1].split(':')[1]
>>         localLargeFile = os.path.join(
>>             os.getcwd(),
>>             '.git', 'lfs', 'objects', oid[:2], oid[2:4],
>> @@ -1073,7 +1073,7 @@ class GitLFS(LargeFileSystem):
>>         )
>>         # LFS Spec states that pointer files should not have the executable bit set.
>>         gitMode = '100644'
>> -        return (gitMode, pointerContents, localLargeFile)
>> +        return (gitMode, pointerFile, localLargeFile)
>> 
>>     def pushFile(self, localLargeFile):
>>         uploadProcess = subprocess.Popen(
>> --
>> 2.5.1
