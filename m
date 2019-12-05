Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7EC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 19:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2771E20707
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 19:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ7TL2hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfLETwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:52:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36932 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfLETwY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 14:52:24 -0500
Received: by mail-qk1-f193.google.com with SMTP id m188so4432156qkc.4
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 11:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HrXRvbiTW+t1byJCg3zQZZxcrltSnYIihgRCPxcP0hk=;
        b=bQ7TL2hR/b/PO48ocHovE/xeLtwyyp8enmT8JD03QsTHz71PwecLpag5O6EkcgbULG
         1qrwSFk+hsniLiDHhMdsLSpQ0CIliiLg2mMLKjrOYU3zDg/6ie2ArVVh2oBpJZCtLqA7
         DXbocm7mYMCdoJeH47jVo//muUQJkKR7ozRGYzFBwBY8mpB2A+gvW/wYxI2piZvKPFsR
         QyHw+Fpt9a2Sv0pZ2uYp7dJCWNueS7myV4SLZ3IXiaxatlcetXnuqkzQbZm0qXsfDWAc
         gE0xxoUy4yYEeHu+Owmg+Ss7d0xz3+Axu4Cf0tvMpuaxcWLj6iUx2rRL9HrGHPYvDKjd
         l7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HrXRvbiTW+t1byJCg3zQZZxcrltSnYIihgRCPxcP0hk=;
        b=O4RAd/XoRp6hGlwGQwaifn4N0XlSq5A8Vc5ni+x6oIi9dlf6HcPIg0Swlq5lVEIzVX
         71F62iIBWJOK10o2/fdN7R+qpPuG8NK/29e85pWNB9rjtEdYSeroQ2S3dQCkihw/DTz2
         HmEPD8Tvx9O1qI5BTK9Vmam86V/4AR9PhpVD6bv8tP416W3G0pKmq2I4DwAG2KGqQScX
         8GGEwqKXB792FAymKmBOXycY+FyiKwpWfr+6QVPOxTc6duAwJ8ocuJ1M1D3F5omgvMgX
         gy8webTUoC0hyvstxiH8HoKGB+gGwFlIJQ/aZG9LF8SKIp7i2r23jHawQIizzLgSNvi7
         kSMg==
X-Gm-Message-State: APjAAAVUqutFpqU/hEhMYoLbHQiTgSoF9Ax5XURsxYerxVdjLbKIgaOH
        AXyZcBDKEo9Z96HmsiyTj267tUcegoI=
X-Google-Smtp-Source: APXvYqwCQft4ip7zwMnMf8o3EeZyEhi3jVX26irom4riIfwLiPHES7b3t9NCQFTqCqNjqiCtfpUyag==
X-Received: by 2002:a37:6644:: with SMTP id a65mr10464700qkc.369.1575575543475;
        Thu, 05 Dec 2019 11:52:23 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id k14sm5163679qki.66.2019.12.05.11.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 11:52:23 -0800 (PST)
Subject: Re: [PATCH v4 07/11] git-p4: Add a helper class for stream writing
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <10dc059444b965c3db3fda5600de64da32de53b4.1575498578.git.gitgitgadget@gmail.com>
 <xmqqo8wm28k6.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <1fc5c388-c9bf-0699-3cfe-a5c7adaf9a0e@gmail.com>
Date:   Thu, 5 Dec 2019 14:52:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqo8wm28k6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 8:42 AM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ben Keene <seraphire@gmail.com>
>>
>> This is a transtional commit that does not change current behvior.  It adds a new class Py23File.
> Perhaps s/transitional/preparatory/?  It does not change the
> behaviour because nobody uses the class yet, if I understand
> correctly.  Which is fine.
>
> It is kind of surprising that each project needs to reinvent and
> maintain a wrapper class like this one, as what the new class does
> smells quite generic.

It is a rather generic class.  My intention was to avoid adding
any additional dependencies so a small class that only implements
the few methods we need seemed safest.

I cleaned up this commit message as well.

>> Following the Python recommendation of keeping text as unicode internally and only converting to and from bytes on input and output, this class provides an interface for the methods used for reading and writing files and file like streams.
>>
>> Create a class that wraps the input and output functions used by the git-p4.py code for reading and writing to standard file handles.
>>
>> The methods of this class should take a Unicode string for writing and return unicode strings in reads.  This class should be a drop-in for existing file like streams
>>
>> The following methods should be coded for supporting existing read/write calls:
>> * write - this should write a Unicode string to the underlying stream
>> * read - this should read from the underlying stream and cast the bytes as a unicode string
>> * readline - this should read one line of text from the underlying stream and cast it as a unicode string
>> * readline - this should read a number of lines, optionally hinted, and cast each line as a unicode string
>>
>> The expression "cast as a unicode string" is used because the code should use the AS_BYTES() and AS_UNICODE() functions instead of cohercing the data to actual unicode strings or bytes.  This allows python 2 code to continue to use the internal "str" data type instead of converting the data back and forth to actual unicode strings. This retains current python2 support while python3 support may be incomplete.
>>
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> (cherry picked from commit 12919111fbaa3e4c0c4c2fdd4f79744cc683d860)
>> ---
>>   git-p4.py | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 7ac8cb42ef..0da640be93 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -4182,6 +4182,72 @@ def run(self, args):
>>               print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
>>           return True
>>   
>> +class Py23File():
>> +    """ Python2/3 Unicode File Wrapper
>> +    """
>> +
>> +    stream_handle = None
>> +    verbose       = False
>> +    debug_handle  = None
>> +
>> +    def __init__(self, stream_handle, verbose = False):
>> +        """ Create a Python3 compliant Unicode to Byte String
>> +            Windows compatible wrapper
>> +
>> +            stream_handle = the underlying file-like handle
>> +            verbose       = Boolean if content should be echoed
>> +        """
>> +        self.stream_handle = stream_handle
>> +        self.verbose       = verbose
>> +
>> +    def write(self, utf8string):
>> +        """ Writes the utf8 encoded string to the underlying
>> +            file stream
>> +        """
>> +        self.stream_handle.write(as_bytes(utf8string))
>> +        if self.verbose:
>> +            sys.stderr.write("Stream Output: %s" % utf8string)
>> +            sys.stderr.flush()
>> +
>> +    def read(self, size = None):
>> +        """ Reads int charcters from the underlying stream
>> +            and converts it to utf8.
>> +
>> +            Be aware, the size value is for reading the underlying
>> +            bytes so the value may be incorrect. Usage of the size
>> +            value is discouraged.
>> +        """
>> +        if size == None:
>> +            return as_string(self.stream_handle.read())
>> +        else:
>> +            return as_string(self.stream_handle.read(size))
>> +
>> +    def readline(self):
>> +        """ Reads a line from the underlying byte stream
>> +            and converts it to utf8
>> +        """
>> +        return as_string(self.stream_handle.readline())
>> +
>> +    def readlines(self, sizeHint = None):
>> +        """ Returns a list containing lines from the file converted to unicode.
>> +
>> +            sizehint - Optional. If the optional sizehint argument is
>> +            present, instead of reading up to EOF, whole lines totalling
>> +            approximately sizehint bytes are read.
>> +        """
>> +        lines = self.stream_handle.readlines(sizeHint)
>> +        for i in range(0, len(lines)):
>> +            lines[i] = as_string(lines[i])
>> +        return lines
>> +
>> +    def close(self):
>> +        """ Closes the underlying byte stream """
>> +        self.stream_handle.close()
>> +
>> +    def flush(self):
>> +        """ Flushes the underlying byte stream """
>> +        self.stream_handle.flush()
>> +
>>   class HelpFormatter(optparse.IndentedHelpFormatter):
>>       def __init__(self):
>>           optparse.IndentedHelpFormatter.__init__(self)
