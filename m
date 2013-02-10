From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3 07/11] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Sun, 10 Feb 2013 15:36:31 -0800
Message-ID: <CA+sFfMdajb3euvxANyXhbk-XhYASdH+7spW1r8tXz16kU8syEw@mail.gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
	<1359335515-13818-8-git-send-email-drafnel@gmail.com>
	<20130128031424.GK8206@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:37:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4gS9-0006Js-6r
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 00:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab3BJXge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 18:36:34 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:45829 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936Ab3BJXgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 18:36:33 -0500
Received: by mail-we0-f177.google.com with SMTP id d7so4345698wer.36
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 15:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MwoSV6fcV7JMAuCR+6QtMHievJxmcRrSNAkXUyOpns8=;
        b=PDddneQbq1SOwXZlvYuIhxMKHfEtsd624gqzFhOQpRIJyFpVHQ0jZ4dSkbzeSRVMnl
         UV6mfKK+nA9OLfvvGjxlGEGKYOz1nRnN1mqyGSpBykkuK5GdBF8OcftR/+yP8Jps00bX
         mNEYdfWHnEg4TJMCRd0YxmADfRp1wSnNhJes1inDonvB4x29bEzY7NCBE/vRPQV6BLf+
         V4Gi5B/LGWJOki9N7okbfyEejGwbH8Faex1VnJDHJBsKA81mV/xJhfhUF7LjADVsupfZ
         TpnSAli6iGgH0eS86P7vNT4YM3QopfPKK4bDUizm7BaaKEF6TDpKGpqLrx6Jf4KQATLS
         oVDg==
X-Received: by 10.194.92.65 with SMTP id ck1mr20555626wjb.54.1360539391637;
 Sun, 10 Feb 2013 15:36:31 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Sun, 10 Feb 2013 15:36:31 -0800 (PST)
In-Reply-To: <20130128031424.GK8206@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215972>

On Sun, Jan 27, 2013 at 7:14 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Casey wrote:
>
>> --- a/sequencer.c
>> +++ b/sequencer.c
> [...]
>> @@ -1096,10 +1117,16 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
>>       strbuf_addch(&sob, '\n');
>>       for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
>>               ; /* do nothing */
>> -     if (prefixcmp(msgbuf->buf + i, sob.buf)) {
>> -             if (!i || !has_conforming_footer(msgbuf, ignore_footer))
>> -                     strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
>> -             strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
>> -     }
>> +
>> +     if (i)
>> +             has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
>
> Is this "if (i)" test needed?  I'd expect that if the message has no newlines,
> has_conforming_footer() would notice that and return 0.

Thanks for pointing out this awkwardness.  It should be pushed into
has_conforming_footer().

-Brandon
