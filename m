From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: add config option for custom
 instruction format
Date: Thu, 11 Jun 2015 10:02:38 -0400
Message-ID: <CANoM8SW13UYazBQgXn6BSDa-rz+jqj19CO3b0K82CV5Ab6HmKw@mail.gmail.com>
References: <1433986244-76038-1-git-send-email-rappazzo@gmail.com>
 <1433986244-76038-2-git-send-email-rappazzo@gmail.com> <dabb4e8e3a864b26c002e9ef966bdf85@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 11 16:03:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z334T-0005mw-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 16:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbbFKODA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 10:03:00 -0400
Received: from mail-ob0-f196.google.com ([209.85.214.196]:35804 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbbFKOC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 10:02:59 -0400
Received: by obbnt9 with SMTP id nt9so1260112obb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2hKYwqdqNFqnkbl23DcW4YaOCy5+bg67OTvlI5fdJbQ=;
        b=knCekfG/UBE65y9yltMd5O2sCaPRVO2gbWBRb+pRlbd40LWnWw2MdXpDDGWu9lX5Vg
         hYVWps9jVIQT5p9Fxzrk9zodCxXwFD51dAWpAiU4660YoVFoNJRp41T+JDVoL3z+U2YF
         wP0JjYWDFxiKc4/wI2aiip6mn9ItC0MRME/LOi7QwNpCZmYIAY8SXvuyd6q647OIRHGw
         rfq/UnqnB3cPlrbIj8jrB5NLraa+xLWdMdane9HPlF398BCj47Z2LZz56LMNUEhXesLO
         w33sNPMPdoEjTjy9BrS1fM0V5XqUhZq9i+MEAKnE26GmMyK/oJa9H7M81X5bBdt++ZZQ
         dJCQ==
X-Received: by 10.60.44.167 with SMTP id f7mr7882072oem.58.1434031378893; Thu,
 11 Jun 2015 07:02:58 -0700 (PDT)
Received: by 10.202.204.20 with HTTP; Thu, 11 Jun 2015 07:02:38 -0700 (PDT)
In-Reply-To: <dabb4e8e3a864b26c002e9ef966bdf85@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271407>

On Thu, Jun 11, 2015 at 9:40 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Michael,
>
> On 2015-06-11 03:30, Michael Rappazzo wrote:
>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index dc3133f..6d14315 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -740,10 +740,19 @@ collapse_todo_ids() {
>>  # "pick sha1 fixup!/squash! msg" appears in it so that the latter
>>  # comes immediately after the former, and change "pick" to
>>  # "fixup"/"squash".
>> +#
>> +# Note that if the config has specified a custom instruction format
>> +# each log message will be re-retrieved in order to normalize the
>> +# autosquash arrangement
>>  rearrange_squash () {
>>       # extract fixup!/squash! lines and resolve any referenced sha1's
>> -     while read -r pick sha1 message
>> +     while read -r pick sha1 todo_message
>>       do
>> +             message=${todo_message}
>
> Why not just leave the `read -r pick sha1 message` as-is and simply write
>
>                 # For "autosquash":
>                 test -z "$format" ||
>                 message="$(git log -n 1 --format="%s" $sha1)"
>
> here?

I did notice that I am not using '$todo_message' in the first loop at
all, so I will adjust it.  In the second loop, I do use both the
original and the reformatted.  I will apply your suggestion there if
applicable.


>
>> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
>> +     git rebase --autosquash -i HEAD^^^ &&
>
> We usually write HEAD~3 instead of HEAD^^^...
>

Sure, I'll adjust it.  I personally usually use up to 3 '^' and then
switch to '~' for > 3

>
> [The two test functions are] copied almost verbatim, except for the commit message. The code would be easier to maintain if it did not repeat so much code e.g. by refactoring out a function that takes the commit message as a parameter.

Makes sense.  I'll implement that.
