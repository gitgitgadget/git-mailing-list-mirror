From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv10 01/10] receive-pack.c: shorten the execute_commands
 loop over all commands
Date: Mon, 5 Jan 2015 13:07:47 -0800
Message-ID: <CAGZ79kbRLPYRw+iifigRHqJ5Lc1brQ3qkUV=4YYPSwr72+giPg@mail.gmail.com>
References: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
	<1420482355-24995-1-git-send-email-sbeller@google.com>
	<20150105202244.GL29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 22:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8EsT-0003oa-Fs
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 22:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbbAEVHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 16:07:49 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37927 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbbAEVHs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 16:07:48 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so20347415iec.38
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 13:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3Gkqa/OJTUeU4IC+Iibn7gt5TRSI1G4ZLLHqPZPzwa0=;
        b=ddCuY73jzyW57RjzDeLfoXuC5Fgt3jHbhS9/NXYrW/VjbbjFz2Tpr0wSe1McOYltpN
         1c1NZK55DukvSwuj9/81XGl+h+ISqM9myl3wNy3RlJYeRLGwJ8MGm3RTMvyIvRQTqcpT
         ntEQuO7pix7fmNGM5gtw/kI9mV++MXTNiwRB4q+xmFWnuyQyAT0nAE05vhWIx7G1l3jq
         pQBtO02m2Fgvl9lf3uFE8JaghTrI3NXjQlRBDkxN0+JBuUNhTwDplnmr6fTuqZns/y6K
         2OLHgXHV/8kMteMkV+vbAauCsGRofNBDdsk0IA8Q/eEiEL7tB0uPUiVIbOgvIZRzQq/t
         9zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3Gkqa/OJTUeU4IC+Iibn7gt5TRSI1G4ZLLHqPZPzwa0=;
        b=mnVg+GH4qb8hRdIFyUmVf+xhsKuxrmBk53AIxrH3tPNq70PW0XjXhjAsEWfp/TWhEz
         6ovfFChyqmOsbgUfFc521uyEOuysBP7DNr+bNnyoAGSqYApRRVqBS8jHjbAPzC30b1RH
         qahh7EyrXdea7J9BkPMGe+iKQOJqd+We6duilus+NpSN7Lmh+ulkQGABK+VlyaA1Ag7J
         NoyBBVUIvH47K+4952HK3tMbxzy+f+PWATEbfyhfyzeptU3VNfrEqPMX62XOxzKD8TEZ
         P29pxEXgnWZ2NHVMOiOBGeWIPCkhwXK+xA/20OQavI6kgaMNO49djZYAzSu1XML7Vgn8
         nQmA==
X-Gm-Message-State: ALoCoQn3Y4bb6/dbLf3rmmHCRG/k1NyfhRgIWn1SLid9HBndR5JV0WR9sOFXj9bc6b7Q2n+TKXmu
X-Received: by 10.43.82.72 with SMTP id ab8mr70981025icc.76.1420492067604;
 Mon, 05 Jan 2015 13:07:47 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 5 Jan 2015 13:07:47 -0800 (PST)
In-Reply-To: <20150105202244.GL29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262033>

On Mon, Jan 5, 2015 at 12:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
> [...]
>> @@ -1077,27 +1100,15 @@ static void execute_commands(struct command *commands,
> [...]
>> +     if (shallow_update)
>> +             assure_connectivity_checked(commands, si);
>
> Looking at this code alone, it seems like assure_connectivity_checked()
> is going to ensure that connectivity was checked, so that I can assume
> connectivity going forward.  But the opposite is true --- it is a
> safety check that prints a warning and doesn't affect what I can
> assume.

I disagree on that. Combined with the next patch (s/error/die/) we can assume
that the the connectivity is there as if it is not, git is dead.

This is why I choose the word assure. Maybe check_assumption would be better?

>
> The factored-out function fails in what it is meant to do, which is to
> save the reader of execute_commands from having to look at the
> implementation of the parts they are not interested in.
>
> Would something like warn_if_skipped_connectivity_check() make sense?

The next patch would then change this to die_if_... ?
I'd be ok with that, but in your original email you would still have the last
die(...) in the execute_command function which I dislike.
So what about:

if (shallow_update)
       (warn|die)_on_skipped_connectivity_check()

?

>
> Jonathan
