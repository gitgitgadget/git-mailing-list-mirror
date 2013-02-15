From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH] contrib/subtree: remove contradicting use options on echo wrapper
Date: Fri, 15 Feb 2013 23:18:42 +0000
Message-ID: <CALeLG_mzBj7q2Vd6vLPTQWexKQB2bEDvh2NT9i9_m8atuiZFcA@mail.gmail.com>
References: <CALeLG_=p9k2B6AmTG0iKf9GpGB=_6kcECmCdDV1nmruJ4bdGcw@mail.gmail.com>
	<7vtxpdfbhx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 00:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6UYf-0006ZX-HV
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 00:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439Ab3BOXSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 18:18:47 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33645 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab3BOXSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 18:18:43 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so4044911obq.7
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 15:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=AVtyeY/sfpLmWmpyLAaz25u60khC7E5ejktsQIWKUds=;
        b=lze12ghSams4gFt/7ihZTcbtWIrTZbeljdFfKZqFWeRy77eCNItk8f8uN0GCCRAeH0
         88YSuP+ZNnTpeRDP8ufXb50RLr6H4MjX8iG31DUCXXaLMX6iZWOVSqKP8bsaIWnIBNSx
         S3ZJgI/f+MJhyzc9wVZfFGe6n8/yHN8PBch4V0nRqYJdqU5jL/iuBYjD4xYDHfEoWlKr
         oZnwWlfFIkki3O4praz5Gj4IpL/Q9i5EOFi4Abtd5HsAJgs2Y7TRjI5oztvqcQl0Sq0L
         WlVgR7zmWMe0R1waodl87xaKYz1N8qy5DyfM7OUKsAbQV/uZe1cMKnd6XOTJhjtg4978
         lPUw==
X-Received: by 10.182.64.74 with SMTP id m10mr2910827obs.61.1360970322831;
 Fri, 15 Feb 2013 15:18:42 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Fri, 15 Feb 2013 15:18:42 -0800 (PST)
X-Originating-IP: [2.102.85.14]
In-Reply-To: <7vtxpdfbhx.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl/rix3YmYo3ALRN/QV1tHJ2E5m1ykdE7qQ0PRc9ez6caU7PLpD3wz7YkWs3tlCWS95y46q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216364>

On Fri, Feb 15, 2013 at 10:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Campbell <pcampbell@kemitix.net> writes:
>
>> Remove redundant -n option and raw ^M in call to echo.
>>
>> Call to 'say' function, a wrapper of 'echo', passed the parameter -n, then
>> included a raw ^M newline in the end of the last parameter. Yet the -n option
>> is meant to suppress the addition of new line by echo.
>>
>> Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
>
> I generally do not comment on comment on contrib/ material, and I am
> not familiar with subtree myself, but
>
>         for count in $(seq 0 $total)
>         do
>                 echo -n "$count/$total^M"
>                 ... do heavy lifting ...
>         done
>         echo "Done                  "
>
> is an idiomatic way to implement a progress meter without scrolling
> more important message you gave earlier to the user before entering
> the loop away.  The message appears, carrige-return moves the cursor
> to the beginning of the line without going to the next line, and the
> next iteration overwrites the previous count.  Finally, the progress
> meter is overwritten with the "Done" message.  Alternatively you can
> wrap it up with
>
>         echo
>         echo Done
>
> if you want to leave the final progress "100/100" before saying "Done."
>
> Isn't that what this piece of code trying to do?
>
>> ---
>>  contrib/subtree/git-subtree.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 8a23f58..51146bd 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -592,7 +592,7 @@ cmd_split()
>>       eval "$grl" |
>>       while read rev parents; do
>>               revcount=$(($revcount + 1))
>> -             say -n "$revcount/$revmax ($createcount)
>> "
>> +             say "$revcount/$revmax ($createcount)"
>>               debug "Processing commit: $rev"
>>               exists=$(cache_get $rev)
>>               if [ -n "$exists" ]; then

[Apologies for resending this Junio. Forgot to hit reply all.]

Ah. I've not seen that done in shell before. In other languages I've
seen and used '\r'  for this purpose, rather than a raw ^M.

I was getting frustrated with it as my apparently braindead text
editor was converting it to a normal unix newline, which would then
keep getting picked up by git diff.

Please ignore my patch.

-- 
Paul [W] Campbell
