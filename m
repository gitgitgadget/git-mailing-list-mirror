From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Sat, 23 May 2015 11:00:57 -0700
Message-ID: <xmqq7frzcgx2.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 20:01:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwDjN-0000R8-Si
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 20:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071AbbEWSBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 14:01:00 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34905 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbbEWSA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 14:00:59 -0400
Received: by igbyr2 with SMTP id yr2so12190397igb.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xFR9vl9SUSV4l0LjOU8hkVnVlH30XbGxYzdxe5C/3QE=;
        b=g9yC/490j6Fdf7NF8sS9l38YxLt1seymp+tyzKdf81l2ZyPv5RsKtw5eTUkr/0Z+7S
         bjy1NFbIzYRzZJwfF+PWQ3Hw+7z5sR3/BFsUXzlfRNnGAW90UdEjNgScUPhuL/z+WT8G
         GISbBDdOShxM4EXt3vKKU88tR+ERaNaZnaxq1bbNhelAqroDrYi834dcZEeitgwGQf4g
         9u/KjUw1iJFjYmj5qwRQLITBSpTeuYcxy2pSLR+32qQ8d0GMZn85bpskObEGVupdf+Zh
         5kMuYAAd2UJ2mawGdmvgfBO+yzzDQTb5jz2D1P9RmZ3KnxQ4LlEupIU0Gu4KVnWO3I5I
         MWXg==
X-Received: by 10.50.27.6 with SMTP id p6mr13202287igg.46.1432404058835;
        Sat, 23 May 2015 11:00:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id qh9sm1976581igb.20.2015.05.23.11.00.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 May 2015 11:00:58 -0700 (PDT)
In-Reply-To: <xmqqfv6nchmf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 23 May 2015 10:45:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269814>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index 804554609def..97387fd27a8d 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -383,7 +383,42 @@ sendemail.aliasesFile::
>>  
>>  sendemail.aliasFileType::
>>  	Format of the file(s) specified in sendemail.aliasesFile. Must be
>> -	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
>> +	one of 'sendmail', 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.

We prefer to append to an existing list of equals, not prepend.

>> ++
>> +If the format is 'sendmail', then the alias file format is described below.
>> +Descriptions of the other file formats can be found by searching the
>> +documentation of the email program of the same name.

The phrasing feels somewhat awkward.  How about dropping the first
line, pretending as if 'sendmail' is also fully 'sendmail' format,
and then describe the limitations (like you already did below)?  I
have a feeling that other formats have similar limitations (e.g. I
do not think piping to commands in any other formats would be
supported by send-email), and other people can follow suit and
describe the limitations.

That is, drop the paragraph that describes the basics (which can be
learned by searching the documentation of the email program of the
same name), and dive right into the differences.

IOW,

	What an alias file in each format looks like can be found in
	the documentation of the email program of the same name. The
	differences and limitations from the standard formats are
	described below:
        +
	--
        sendmail;;
>> +*	Quoted aliases and quoted addresses are not supported: lines that
>> +	contain a `"` symbol are ignored.
>> +*	Line continuations are not supported: any lines that start with
>> +	whitespace, or end with a `\` symbol are ignored.
>> +*	Warnings are printed on the standard error output for any explicitly
>> +	unsupported constructs, and any other lines that are not recognized
>> +	by the parser.
	--

That way, limitations and deviations of other formats can be added
later in a consistent way.

Just a thought.
