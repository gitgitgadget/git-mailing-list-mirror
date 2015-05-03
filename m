From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [PATCH] upload-pack: Optionally allow fetching reachable sha1
Date: Sun, 3 May 2015 22:13:31 +0200
Message-ID: <CABA5-znFVPunBxET-42jDTC00gH8VMkG280Ptyr8FUU6vfuiCA@mail.gmail.com>
References: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com> <xmqqy4l5v9tm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 03 22:14:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp0H1-0001xp-1L
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 22:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbbECUNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 16:13:55 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35854 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbbECUNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 16:13:53 -0400
Received: by lbbqq2 with SMTP id qq2so93014491lbb.3
        for <git@vger.kernel.org>; Sun, 03 May 2015 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dx+wvtmfk4iNz/VSQ1doZS5iuPOWEvMZI2sleVqbI54=;
        b=OPHTgm7k2zb30TU0SokQG4FYblV0zCPVB5DaEk3VvnHPGn0PABGDlwG8n3UpcWz94D
         9oELiywBDTqVepCY0fSqjYp/ghxTTzWf52N4vV+Y+RkzvsGOyfA6E2mcaE1H9lq7a2QN
         SLOftZ9oDMmtVnVseaD4BSsAqunbl+513MWLUoRYQauKJGBJ09hgKHgbGMlcsqr40MTd
         m7pXS0BypXPPifnNj82iY+bqDDQRXn8orW/Uba/axQZlRHEVI+1TsukMYvXyQubRy27L
         jl4X4WqmSBQtIo5zOocZ1ow1zkKR4VL0YSEX6IxgNP8173w6jh6TSzK3CDweTbo34CMS
         aVkw==
X-Received: by 10.112.65.37 with SMTP id u5mr16835903lbs.44.1430684031757;
 Sun, 03 May 2015 13:13:51 -0700 (PDT)
Received: by 10.114.10.130 with HTTP; Sun, 3 May 2015 13:13:31 -0700 (PDT)
In-Reply-To: <xmqqy4l5v9tm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268290>

2015-05-03 19:40 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Fredrik Medley <fredrik.medley@gmail.com> writes:
>
>> For you who don't remember the email discussion, look through the references.
>
> Please don't do this.  Always describe the background yourself in
> the log message so that "git log" can be read offline.  "describe
> yourself" can be done by summarizing earlier discussion, borrowing
> others' words, of course.  And it is a very good idea to give
> references like you did after your summary to optionally allow
> people to verify your summary is correct.

Okay, I understand. My intention was to recapture the old thread, but
to keep the part under the references for the commit message. When
I get this answer, I do see that this is impossible to understand and I
should probably have added a cover-letter instead. (This is my first
time every I've supplied patches to such an open-source project.)

Is the text under the reference enough describing or should there
be added some more background text?

Unless someone asks for more answers about my attempt to recap
the old mail thread, I skip commenting on this part.

>
> ...
>
>> With uploadpack.allowreachablesha1inwant configuration option set,
>
> "option set" on the server side, I presume?
Yes, can fix that.
"...configuration option set on the server side, "git fetch" can..."

>
>> "git fetch" can make a request with a "want" line that names an object
>> that has not been advertised (likely to have been obtained out of band or
>> from a submodule pointer). Only objects reachable from the branch tips,
>> hidden by transfer.hiderefs or not, will be processed.
>
> I am not sure if I am reading the last sentence correctly.  If there
> are two branches, 'master' (exposed) and 'occult' (hidden),
>
>     ---o---o---2---1---x master
>         \
>          o---2---1---y occult
>
> you can ask for the 40-hex object name of occult~2, but you cannot
> ask for the 40-hex object name of master~2?  Why such a restriction?
>
>  ... wait for an answer that justfies the restriction ...
>
> Does that justification applies for allowing occult~4 but not master~4?
I thought I wrote that both visible and hidden branches will be counted as
branch tips. Obviously need to reformulate. Maybe:
"Only objects reachable from the branch tips, i.e. the union of advertised
branches and branches hidden by transfer.hiderefs, will be processed."

>
>> @@ -456,8 +457,11 @@ static void check_non_tip(void)
>>       char namebuf[42]; /* ^ + SHA-1 + LF */
>>       int i;
>>
>> -     /* In the normal in-process case non-tip request can never happen */
>> -     if (!stateless_rpc)
>> +     /*
>> +      * In the normal in-process case without
>> +      * uploadpack.allowreachablesha1inwant, non-tip requests can never happen.
>> +      */
>
> That's quite an overlong line; if you switched it to multi-line,
> then fold the line once more, perhaps before "non-tip"?

Yes, can change that. This was to avoid more than 80 characters per line.
Should I split to three lines then?

>
>> @@ -728,6 +732,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
>>                            sha1_to_hex(sha1), refname_nons,
>>                            0, capabilities,
>>                            allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
>> +                          allow_reachable_sha1_in_want ? " allow-reachable-sha1-in-want" : "",
>
> Which printf format specifier does this new element correspond to?

Ouch! How could I miss that?! Fixing.
