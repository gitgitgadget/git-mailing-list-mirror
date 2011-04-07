From: Ciaran <ciaranj@gmail.com>
Subject: Re: p4Merge bundled command and the behaviour with files (same name)
 added on different branches.
Date: Thu, 7 Apr 2011 10:48:55 +0100
Message-ID: <BANLkTik0HnV9+436dt=c0yKQb0KxpbgGGg@mail.gmail.com>
References: <BANLkTimpsg=26C0mq=feVT7mt0nwZBoBUA@mail.gmail.com>
	<20110407094347.GB7593@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 11:49:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7lpm-0003Jf-2K
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 11:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab1DGJs5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Apr 2011 05:48:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54257 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab1DGJs4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 05:48:56 -0400
Received: by yxs7 with SMTP id 7so916769yxs.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4i3dhs8c9dK77/FghgdvHEvTE2Te6kiAMgN+r9JG+xM=;
        b=HjgJonT7LXTS2vNH0ql8cPdmnMRv0UZWfT4vTTEGD1PQzLZ5/0x0M+/xwxyMPYnUKb
         4KxybB/PlBlHONHaV8v06fAhby8ycd39j4FEbwbGwGBKdGz2DhuKj2hWirAB6WUNi5EK
         V/wKShksfcyLNDTwXq9WW24YdghGq2ooFMDjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VzS2Fyo8ApYtj1rKI5Gtu+fCHE1VUW+nUQRwzh6on7bCal4K6jzHas6k+6RPfTUqIG
         Aqp7Y7FUMcoxPhjy+FteV0O7Mz4UJf2ijB7nQqwF844Lk7sUvlXqOh2pH9GBOSnmedL9
         NC4HATGB19URYeakCsqWdxWS+tRHnrxJygvDY=
Received: by 10.236.187.102 with SMTP id x66mr817736yhm.114.1302169735438;
 Thu, 07 Apr 2011 02:48:55 -0700 (PDT)
Received: by 10.236.103.173 with HTTP; Thu, 7 Apr 2011 02:48:55 -0700 (PDT)
In-Reply-To: <20110407094347.GB7593@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171050>

On Thu, Apr 7, 2011 at 10:43 AM, David Aguilar <davvid@gmail.com> wrote=
:
> On Mon, Apr 04, 2011 at 09:55:41AM +0100, Ciaran wrote:
>> [...]
>> We would expect a 'both added' merge conflict (both the other branch=
,
>> and the master branch added the file named bar.txt, but with differe=
nt
>> content.) =A0This is all good and right. =A0So in a system configure=
d to
>> use p4merge as the mergetool, one fires up with 'git mergetool'
>>
>> What happens now is p4merge starts and tells us:
>>
>> Base: bar.txt.LOCAL.<num1>.txt
>> Left: bar.txt.LOCAL.<num1>.txt Differences from base: 0
>> Right: bar.txt.LOCAL.<num2>.txt Differences from base: 1
>> Merge: bar.txt Conflicts:0
>>
>> Presenting the left + right options on top of each other in the resu=
lt
>> window (which may be correct) and leaving the save button disabled
>> (grayed out)
>>
>> If at this point one closes the window without editing the presented
>> (apparently merged) file, then nothing will be saved to disk and we
>> will see:
>>
>> bar.txt seems unchanged.
>> Was the merge successful? [y/n]
>>
>> In the console. =A0Which Git wise is correct, that is exactly right,=
 the
>> p4merge tool hasn't made any actual changes to the underlying file.
>>
>> This behaviour seems confusing to me (the p4merge client behaviour,
>> *not* Git's) =A0 I believe it is because in the case where there is =
no
>> logical base between two files the local one is arbritrarily chosen,
>> and p4merge *thinks* that this is equal to the merge result and has
>> nothing to persist.
>>
>> I have attached a patch that resolves the issue for me (e.g.
>> introduces the behaviour I expect) by passing a reference to an empt=
y
>> file in the case where there is no meaningful base. =A0Unfortunately=
 I
>> don't understand enough to say whether this change is correct or not
>> and would value feedback on it.
>>
>> Many thanks
>> =A0- Cj.
>
> Thanks. =A0If this patch were for actual consideration you would
> inline the patch instead of sending an attachment as described
> in Documentation/SubmittingPatches. =A0Marking the subject line
> with "[RFC PATCH]" lets us know that you're interested in
> feedback. =A0I have a few questions below.
Thank you for respnding, I wasn't sure on the etiquette (and quite
frankly nervous as it was about posting to the list ;) ), so please
accept my apologies.

>
>> index fb3f52b..3e486dc 100644
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -262,7 +262,9 @@ run_merge_tool () {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if $base_present; then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$merge_=
tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$merge_to=
ol_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch ".em=
pty"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$merge_to=
ol_path" ".empty" "$LOCAL" "$REMOTE" "$MERGED"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm ".empty=
"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_unchanged
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> --
>
> What if the user has a file called '.empty' in their repository?
Then it will get over-written ;)

>
> What if the user Ctrl-C's out of mergetool -- does a stale
> .empty file get left behind?
Yup, I imagine so.

>
> Does it work if we pass /dev/null instead?
> Is such a strategy portable to Windows?
I don't think so, that was my first try (in Windows.)

>
> If /dev/null doesn't work, would it be better if the
> empty file were given a different name?
> Maybe something like foo.EMPTY.<num>.txt?
I'm amenable to anything.   My patch was really an example, hoping to
prompt a conversation with someone who actually knows the working of
git / mergetool-lib :)

Presumably I can co-opt whatever logic drives the existing
local/remote/merged temporary file names to create an 'empty' filename
in the temporary folder, since this file will always be identical it
shouldn't matter if it hangs around/gets updated con-currently etc. ?

Thanks
- Cj.

> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0David
>
