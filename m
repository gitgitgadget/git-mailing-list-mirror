Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE11FD8
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPWtnCFB"
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AA2D4D
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:28:12 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6cd1918afb2so3291747a34.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699928892; x=1700533692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sGDXJJgqF0RT4BDoHSAgcuajkxKJKxc0hREnnSYo658=;
        b=aPWtnCFBVeGk+qEM1RxjGETXjj048yLn3M/X50ntH8FaKK68vGofnCk7JjADlL4CT8
         RI7XNIOKQ5jHA66xtk/CFt56NTNbOcJjvgef8Yd9gPYfXFL6BUBy3lSUBRAFni5Q4Mk8
         1TfwYDH+NZLW95U8FLDJ+UWSEqmVMZXRxns0lMRKkzqLAsVJ+UWCHbfBYC+PZSMW1Com
         64vNkzo1Wsn5qKEZlO0//PNRzqBXHGdszwTOGUt2Hp9jgmhM8R6uReAqbuh/o4oB9LQ8
         4hAyM7XDP6WK59jPk/D5KU/3NNwUJiurWTVOgcz5yn6DGzAdXMTcG+qCYyb2JoDSURoe
         OAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699928892; x=1700533692;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGDXJJgqF0RT4BDoHSAgcuajkxKJKxc0hREnnSYo658=;
        b=TsUAR0uQ0Xo1yggJ3n5c1e9YCIjElV8zwtmwJZbL2sfg99SUsxWIqIDHeDlIeLacv9
         y5VzPRJeZDzXkF4lsaS3P3xGPjZNltR+s/QPUreWMYB7iqpFMlF+QDpntMxDGcfvBw3C
         nOWz25BmDp/awDaYwbpSYg4Q3H6QL08xbNYY6orX9leHnaFi+zGpfVR88k0jiGBNMHA5
         ofwfJUm/868EEMRwqgDFUC2bhbw/XCbTIrNhvUJ3h+WXTp3AcwlZKjwSt+kihpRABoyP
         XloShRpd3dzHDt3waNC/rXIxS1OiwSAhUZlWYQRwvNzn8S7Dyq3+7HXEmK0rLsDLjxIH
         UBeA==
X-Gm-Message-State: AOJu0Yx85GuCa+wTyho9nfgzySQjGYyBWZWfwUaJOHEOg2s9C1I/0BdC
	gk0rbolYGnrSv7y5J2k8pHmDwfoKVpavDsaIiSctqwTh7HGu0XcSWRr3pu1r
X-Google-Smtp-Source: AGHT+IHMpXpAjYqYmLEICgXbdsBjGJNBUqtYgO+TqLa/+lh0PLjl+yJ2K696/7+azkGR5fYZ0ZiZBV3bU59CFso7yyE=
X-Received: by 2002:a05:6870:9b0c:b0:1ef:c42a:df0c with SMTP id
 hq12-20020a0568709b0c00b001efc42adf0cmr12023542oab.43.1699928891889; Mon, 13
 Nov 2023 18:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanna Wang <jojwang@google.com>
Date: Mon, 13 Nov 2023 18:28:00 -0800
Message-ID: <CAMmZTi-7=L6XOB9-MwZCpD5QaziTi0x6J7m-UTtwQ0S00wnVgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] attr: add native file mode values support
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Joanna Wang <jojwang@google.com>, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"

>> Even if we assume that this code is currently meant to work only
>> with GIT_ATTR_CHECKIN, I do not think this is what you want.  When
>> asked to perform "git add . ':(exclude,mode=160000)'", you not only
>> want to exclude the submodules that are already known to this
>> superproject, but also a repository that _can_ become a submodule of
>> this superproject when added, no?
Sorry, I was totally ignorant of two key concepts that you mention here.
I somehow missed the concept of git_attr_direction altogether and I also
did not know submodules could be added with git-add (I was only
familiar with how
they are currently added in chromium via git update-index).
This makes sense now. I'll fix in the next patch.

>> On the other hand, the GIT_ATTR_CHECKOUT direction is hopefully much
>> simpler.  You'd see what the path in the index is, among a gitlink,
>> a regular non-executable file, an executable file, or a symlink.
I noticed for both the GIT_ATTR_CHECKOUT and GIT_ATTR_CHECKIN directions,
in read_attr(), the indexed .gitattributes file is checked with the
actual file as fallback or vice versa.
I would think that we'd only want to use attributes from one state
(e.g. what's actually in the file)
or the other (e.g. what's indexed).
So I guess I'm still not sure what the "direction" concept is.
For GIT_ATTR_CHECKOUT, would we want to fallback to lstat?

>> "ls-tree" documentation seems to call it %(objectmode).
I can change it to 'objectmode' in a followup patch, if there are no
objections to this.

>> I think the idea is that "mode" being a too generic word can be used
>> for totally different purposes
My thinking was, no matter how generic or rare a name we choose, there
is always a chance
no matter how tiny, that the name will be in use in someone's .gitattributes.
But if people are ok with choosing something less generic
and have that become a 'reserved' attribute name and not have any
existing values in .gitattributes
take precedence I can do that.
I just don't know how git has historically balanced breaking existing
workflows vs easier/more reasonable
implementation/behavior.

>> But stepping back a bit,
>> such an application is likely marking selected few paths with the
>> attribute, and paths for which "mode" was "unset" are now given
>> these natural "mode"; it is inevitable to crash with such uses.
I'm confused. This does not match what I think is the current behavior
of my patch.
If "mode" was unset or removed for a path (meaning '<path> !mode' was
added to .gitattributes),
the code in my patch would respect that and not return the native mode.
It would return 'unspecified' or 'unset'. I have tests for these in
the patch, but if I've missed some
test cases please let me know.


>> Again, this has one hole, I think.  Paths that are not mentioned
>> (not even with "!mode") would come to the function as ATTR__UNKNOWN
>> and trigger the fallback behaviour, even when other paths are given
>> end-user specified "mode" attribute values.
What you are describing sounds correct/what I intended.
So are you saying that the expected behavior is actually:
If the user sets 'mode' for 1+ paths in the repo, then the native mode
fallback should
NOT be used for all paths in the repo?
