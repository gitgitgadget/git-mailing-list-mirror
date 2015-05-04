From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Sun, 3 May 2015 23:30:39 -0400
Message-ID: <CAPig+cStUNPZqEyE1rJVj5AsTeZFU54mc97rgQqiPbr5V1B0Sw@mail.gmail.com>
References: <55463094.9040204@gmail.com>
	<xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com>
	<xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
	<CAPig+cQKqkoqN+o_QfVBRvxGdNuJn_oxD5YMsvnBOHguimJhGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: karthik nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 05:30:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp75h-0000wE-T1
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 05:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbbEDDal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 23:30:41 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:32859 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbEDDak (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 23:30:40 -0400
Received: by igbpi8 with SMTP id pi8so59197673igb.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 20:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iZFU9xueTEksUL5mfZQFXfxyR0EzJafDtBE5OghON/c=;
        b=FCA9vWwh+akm8jh4+8wg8UYLXGMNbTcRfUSi8wNE5XKqKsYLo+pt0Toq6rGOnhlPou
         qp7LT0nJOAlTv6cnGeLrbNrWbTSVkAzrBYeZfaTgebbYAey5EZ5+j3QbV/8YgikyHdIT
         onQ0+2170lBYIC4Zm0vqyIZjyhspjCXS2qzBf8xEZ4+BQKoI6T9mkQecgN8weJkoC8Xq
         lIqlpHMB44qi2C7qoDfUcqWMyCwIITKdy4Mhhom4IFsYkNPaFv33V6OI7R25cllea/1x
         u9RssAuU64kHOzD+d1UbopcCk+epUxE3bfZpfmlDFritwxLUd+ehck1gY86NIH39JuXE
         83jw==
X-Received: by 10.42.67.80 with SMTP id s16mr25460598ici.25.1430710239281;
 Sun, 03 May 2015 20:30:39 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 20:30:39 -0700 (PDT)
In-Reply-To: <CAPig+cQKqkoqN+o_QfVBRvxGdNuJn_oxD5YMsvnBOHguimJhGQ@mail.gmail.com>
X-Google-Sender-Auth: l-Q_QQfNQJZzw8vyZSEbQBI1Lf4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268304>

On Sun, May 3, 2015 at 10:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, May 3, 2015 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Hmmmm... you do not seem to pass your own test.
>>>
>>> expecting success:
>>>         echo $bogus_type >expect &&
>>>         git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
>>>         test_cmp expect actual
>>>
>>> --- expect      2015-05-04 00:09:24.327335512 +0000
>>> +++ actual      2015-05-04 00:09:24.335335473 +0000
>>> @@ -1 +1 @@
>>> -abcdefghijklmnopqrstuvwxyz1234679
>>> +abcdefghijklmnopqrstuvwxyz123467abcdefghijklmnopqrstuvwxyz1234679
>>> not ok 86 - Type of broken object is correct when type is large
>>
>> Perhaps it would have a better chance of being correct with this
>> squashed in.
>
> Interestingly, neither test passes on Mac OS X even with this fixup.
> In fact, the git-hash-object invocation which computes/retrieves
> 'bogus_sha1' with the extra long bogus type crashes with SIGABRT in
> write_sha1_file_prepare(). Still investigating.

It's a buffer overflow problem. I'm preparing a patch.
