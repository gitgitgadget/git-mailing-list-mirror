From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 3/5] builtin/notes: Add --allow-empty, to allow storing
 empty notes
Date: Sun, 9 Nov 2014 13:31:32 +0100
Message-ID: <CALKQrgdFDHUc8JzH3XnwvnHdEZOhUN=EmrWXKKDLd+6MG7jMKw@mail.gmail.com>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
	<1415351961-31567-4-git-send-email-johan@herland.net>
	<xmqq1tpehopp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnRek-0008Hv-NF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbaKIMbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:42 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:43114 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbaKIMbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:41 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1XnRee-0001Cf-3k
	for git@vger.kernel.org; Sun, 09 Nov 2014 13:31:40 +0100
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XnRed-000CdO-NV
	for git@vger.kernel.org; Sun, 09 Nov 2014 13:31:39 +0100
Received: by mail-pd0-f176.google.com with SMTP id ft15so6054599pdb.7
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:32 -0800 (PST)
X-Received: by 10.68.90.225 with SMTP id bz1mr593825pbb.153.1415536292634;
 Sun, 09 Nov 2014 04:31:32 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Sun, 9 Nov 2014 04:31:32 -0800 (PST)
In-Reply-To: <xmqq1tpehopp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 7, 2014 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:

[...]

> Assuming that it is a good idea to "allow" empty notes, I think
> there are two issues involved here:
>
>  * Traditionally, feeding an empty note is taken as a request to
>    remove an existing note.  Therefore, there is no way to
>    explicitly ask an empty note to be stored for a commit.
>
>  * Because feeding an empty note was the way to request removal,
>    even though "git notes remove" is there, it is underused.
>
> In other words, assuming that it is a good idea to allow empty
> notes, isn't the desired endgame, after compatibility transition
> period, that "git notes add" will never remove notes?
>
> With that endgame in mind, shouldn't the internal implementation be
> moving in a direction where "create_note()" will *not* be doing any
> removal, and its caller (i.e. "add") does the switching depending on
> the "do we take emptyness as a request to remove"?  I.e.
>
>          static int add(...)
>          {
>                 if (!allow_empty && message_is_empty())
>                         remove_note();
>                 else
>                         create_note();
>         }
>
>>  static void create_note(const unsigned char *object, struct msg_arg *msg,
>> -                     int append_only, const unsigned char *prev,
>> -                     unsigned char *result)
>> +                     int append_only, int allow_empty,
>> +                     const unsigned char *prev, unsigned char *result)
>
> In other words, I have this suspicion that create_note() that
> removes is a wrong interface in the first place, and giving it
> a new allow_empty parameter to conditionally perform removal is
> making it worse.  No?

I agree, and it's fixed in the re-roll. It turned into a slightly
larger rewrite than anticipated, but I'm fairly happy with the result.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
