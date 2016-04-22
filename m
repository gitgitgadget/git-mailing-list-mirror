From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 2/2] git-p4: fix Git LFS pointer parsing
Date: Fri, 22 Apr 2016 09:53:30 +0200
Message-ID: <780ED4D6-AD96-4BAF-A522-C724C3938EED@gmail.com>
References: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com> <1461139809-6573-3-git-send-email-larsxschneider@gmail.com> <xmqq60vcuh9v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>, luke@diamand.org,
	sschuberth@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 09:53:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atVuJ-0007gg-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 09:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbcDVHxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 03:53:34 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35019 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcDVHxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 03:53:34 -0400
Received: by mail-wm0-f43.google.com with SMTP id e201so9180812wme.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 00:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i5th40xxT/WjO6bjHUJhb1ea6t0gQjvwTTik02+ht3E=;
        b=nFpqY5SZwfGfihT4YF8QCQyhxOwVu1FBlVTJbA0Mj6S2BX3L8scc9eATRLmIgm8BUK
         bygScFRTXVTqTGChWRQJZ+PcXmGz/5E/BxueaixAZ2Imh05ZONT0gLhbR2nL6VsnIPvK
         QjfUnEGvxoh+skLXne3n7kVL9IUy38wjUqgXn6uVBCgK0AcgXm6oV+bB3OvFPXo8d5rG
         49f4c5sjmW/CeAhv/OHnZNKRfeTjZ1LuRZoGmX4WGspNSfjfBLsB1YAQ9vMLRir6dBZf
         rK68mXwjGnvgNQkVwrhy5cZ5Z31qPCbGtaPwcnTz/QKlhhBXesuCEiI8OIaipKEVs1M0
         betA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i5th40xxT/WjO6bjHUJhb1ea6t0gQjvwTTik02+ht3E=;
        b=jsMSFwRwaXL3jkW0OherMxF3duKT60EazqGSGc64C5bZyu3VOYD065TDS0gFPLQfJY
         g/Iey8VA+8E8xiEy6lq7U0heIVjTwrbZ6KvLiUzrhdXPCQ/mZIflyMcJ+OUErsGVCpL1
         WRJs2iUL2SGYb4BaLiKshaU3bxZhyEeNOu4PQR7VQihGKZQC0SqT3aZNJyAKWG4Iu8oy
         spuhP00+QtMaLbsiRNOSv/xlMJ41yfWpI9Oov+L6SgLpkg6rTflTfQ00Ul25aOCuL5bu
         0Rb+RcQCSkWpp5RZXz4Ki3aZI15MbEm+PS5QVg8cASvGXYG1ADxpfWGDzepuNTwdek6u
         kl2Q==
X-Gm-Message-State: AOPr4FW26+2ZQzIixhVPtcew0wb3mclw7jDegc5iCWe1vOQi9G681N3ieO0QKPSPLmtHAQ==
X-Received: by 10.194.84.2 with SMTP id u2mr18387823wjy.61.1461311612483;
        Fri, 22 Apr 2016 00:53:32 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB43AA.dip0.t-ipconnect.de. [93.219.67.170])
        by smtp.gmail.com with ESMTPSA id vu4sm6750775wjc.27.2016.04.22.00.53.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 00:53:31 -0700 (PDT)
In-Reply-To: <xmqq60vcuh9v.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292177>


> On 20 Apr 2016, at 23:01, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
pointerFile was split here by '\n'. The splitting removes the newline and
the i+'\n' adds it again. This back and forth makes it unnecessary hard
to read.


>> -        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
>> +
>> +        # Git LFS removed the preamble in the output of the 'pointer' command
>> +        # starting from version 1.2.0. Check for the preamble here to support
>> +        # earlier versions.
>> +        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
>> +        preamble = 'Git LFS pointer for ' + contentFile + '\n\n'
>> +        if pointerFile.startswith(preamble):
>> +            pointerFile = pointerFile[len(preamble):]
>> +
>> +        oidEntry = [i for i in pointerFile.split('\n') if i.startswith('oid')]
>> +        oid = oidEntry[0].split(' ')[1].split(':')[1]
>>         localLargeFile = os.path.join(
>>             os.getcwd(),
>>             '.git', 'lfs', 'objects', oid[:2], oid[2:4],
>> @@ -1073,7 +1082,7 @@ class GitLFS(LargeFileSystem):
>>         )
>>         # LFS Spec states that pointer files should not have the executable bit set.
>>         gitMode = '100644'
>> -        return (gitMode, pointerContents, localLargeFile)
>> +        return (gitMode, pointerFile, localLargeFile)
> 
> It seems to me that you used to return pointerContents which is an
> array of lines (each of which are LF terminated); the updated one
> returns pointerFile which is a bare string with many lines.
The pointerContents is a string with LF separators (see comment above). 
The only difference is that the old implementation was a list of strings 
each with a LF at the end ['line1\n'],['line2\n'] and the new 
implementation is one string with LF separators 'line1\nline2\n'.

pointerContents goes through a few layers and is eventually used in 
the "writeToGitStream" method [1] like this:

        for d in contents:
            self.gitStream.write(d)

At this point it doesn't matter if it is an array of strings or one
string.

[1] https://github.com/git/git/blob/e6ac6e1f7d54584c2b03f073b5f329a37f4a9561/git-p4.py#L2401-L2402


> Is that change intentional?  Does the difference matter to the
> caller of this method?  Even if it doesn't, is it a good idea to
> change it as part of this commit?
Yes, it was intentional. I wanted to make the code simpler/more readable.
As shown above the change doesn't matter to the caller method.

I understand your concern of making this change part of the commit.
However, I don't see another way because passing pointerFile as
is in the old implementation would brake Git LFS 1.x support (because
pointerFile contains the preamble).

What would be the best way forward? A v3 with a better commit message
mentioning the array -> string change?

Thanks for the review,
Lars