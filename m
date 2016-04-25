From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 3/3] git-p4: fix Git LFS pointer parsing
Date: Mon, 25 Apr 2016 09:33:01 +0200
Message-ID: <8340C6E5-C774-46EE-A1F9-1C4C7DF9CEB9@gmail.com>
References: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com> <1461524292-20490-4-git-send-email-larsxschneider@gmail.com> <CAHGBnuMs6h478FXGA_x2nP1D6BJCxGzhumR_xq5JFmNgzM6Sdw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, ben.woosley@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 09:33:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aub16-0002e6-BB
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 09:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbcDYHdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 03:33:08 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38909 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbcDYHdF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 03:33:05 -0400
Received: by mail-wm0-f50.google.com with SMTP id u206so112357212wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aDCpvHRr3KwDBdKiz2inF9MZdnaNuGx7SgeLgcwxUNM=;
        b=oZPvdAPMK2LJyUMXl3k1F3ajQqoD2+PC7u1bf39+w+xJ+4sKzIE8W07A+ZbmWdlJ5P
         +zuqdagS+N4RjHByFc1jOnIZ1jxFwIHPAJiYdr1gfal8CeGo2WawnmUlBGyaxDd5Sq0U
         6su5lcwQFTwIml4cWlXLVWUruSG/UhXirLJZJXv8lamwVdJu6LqkOM8oVmJUWTaCto5j
         bL0dWn4OkK1ngIspiVUfzKtVA8YkRaBscXQYe8SzCKft8Q7AyL6n4WXTogN/ggK2N28Q
         PJhUK2iMZnZsNTMNIFER8HCQT004Ma7S8/hXUf0YBS19+xkPdNyAOXUTE9U+j9YrLz4O
         z3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aDCpvHRr3KwDBdKiz2inF9MZdnaNuGx7SgeLgcwxUNM=;
        b=SQYszLLCoK87o0+TEs2Oz6KrNnyWqnAwf+6d81ZaOdejFCf+0pmNupOskLpyajM2se
         +VhZOG1mAY7zdHDC2m/xcTYVVzulNGXcQw+qWlrQLs86CbrhDxWBXdBnMDBzXSJhHDG3
         Ob82oqjgzqeE9grQBkmwphExKjv/8JRpKyveW5b/FPEsFq9WDozLFI4NvR8Vo6omZRRt
         31UcS2hNOtolZkhL8+SlHOr3h0l7Z+FOhxko1AUx4jE+9/DxelAyoZ+3Vky+W5CszdPk
         og2bhQalHgJMLyIT5uMkH0pF4b6rUBf1JicZwvd1yK1Varql82L9Hz18pvRNgS7s/i3L
         ddvQ==
X-Gm-Message-State: AOPr4FUWUSlTra7MVQBl1aP63dY8pZBAa1HQBR1Tar6YMoTDni0kz9hiHGEWL6oenl7dZw==
X-Received: by 10.28.24.195 with SMTP id 186mr10366986wmy.30.1461569584563;
        Mon, 25 Apr 2016 00:33:04 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4886.dip0.t-ipconnect.de. [93.219.72.134])
        by smtp.gmail.com with ESMTPSA id gt7sm22139013wjc.1.2016.04.25.00.33.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 00:33:03 -0700 (PDT)
In-Reply-To: <CAHGBnuMs6h478FXGA_x2nP1D6BJCxGzhumR_xq5JFmNgzM6Sdw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292453>


On 24 Apr 2016, at 21:16, Sebastian Schuberth <sschuberth@gmail.com> wrote:

> On Sun, Apr 24, 2016 at 8:58 PM,  <larsxschneider@gmail.com> wrote:
> 
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1064,8 +1064,15 @@ class GitLFS(LargeFileSystem):
>>         if pointerProcess.wait():
>>             os.remove(contentFile)
>>             die('git-lfs pointer command failed. Did you install the extension?')
>> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
>> -        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
>> +
>> +        # Git LFS removed the preamble in the output of the 'pointer' command
>> +        # starting from version 1.2.0. Check for the preamble here to support
>> +        # earlier versions.
>> +        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
>> +        if pointerFile.startswith('Git LFS pointer for'):
>> +            re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
> 
> I liked the code from v2 better. I know Ben said "there could be
> expansions or other modifications applied by git-lfs between input and
> output", but I believe it's better to be too strict than too lenient
> if you're omitting lines from the output. Also, the regex matches
> against the whole multi-line string. That is, if the file for some
> reason was ending in '\n\n' instead of just '\n', the '.*' would match
> almost all content of the pointer file, not just the remains of the
> preamble. One way to fix this would be to use
> 
> re.sub(r'Git LFS pointer for [^\n]+\n\n', '', pointerFile)
> 
> instead.

In general you are right as "*" is greedy. However, in Python "." matches any 
character except a newline [1]. Therefore I think the regex is correct.

Nevertheless... thanks for making me read the line again. I forgot to
assign the pointerFile variable in the version I sent around :-(

This is how it should be:

pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)

Thanks,
Lars


[1] https://docs.python.org/2/library/re.html
