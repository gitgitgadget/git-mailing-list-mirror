From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3 06/11] sequencer.c: always separate "(cherry picked
 from" from commit body
Date: Sun, 10 Feb 2013 15:25:42 -0800
Message-ID: <CA+sFfMc8YGZOUqNbTGa=X5ik0K_eBF86Pk4w5gZNppLayiCxVQ@mail.gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
	<1359335515-13818-7-git-send-email-drafnel@gmail.com>
	<20130128023409.GH8206@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:26:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4gHf-00012o-OO
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 00:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532Ab3BJXZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 18:25:44 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:61407 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab3BJXZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 18:25:44 -0500
Received: by mail-we0-f173.google.com with SMTP id r5so4372978wey.18
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 15:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=bOMHIg5G4WfbWlNBc6FlTG7lhs6RWlR7giMMGybQJCQ=;
        b=VojcMlF1OFK1yNOQd4g9aLxCDydPAhLgsjY3CT8Of9F/I9MFqOqvc5HmDdp+XHYh1E
         LL9k3PKTT1pRCYZZScfWaDHhiXiU/cvEUXfCHiaOnZ2+WVZ/HpL0/zSap7ri4wj7SVOY
         +V1RkZE+g4evrY3qKILfDYIoOoL+qhcvPWG6CHzvCNWpVwYsg3r3O9hCYXjFA1VEATTH
         ZAUx/2ahnsT/8mKAYdfxaZDxcBdLYW2CPIH0/tj1hC5H5k50rWkiCZhR6GGT+Ft+Aalw
         LFWEet3SQZn/YM5aeU9Zm0uTqYLHjBpdLb1LQ2RSGI+lwtCv01Mh/hSG8M6MaCutmtmx
         WNfg==
X-Received: by 10.180.7.232 with SMTP id m8mr12654677wia.8.1360538742800; Sun,
 10 Feb 2013 15:25:42 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Sun, 10 Feb 2013 15:25:42 -0800 (PST)
In-Reply-To: <20130128023409.GH8206@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215971>

On Sun, Jan 27, 2013 at 6:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Casey wrote:
>
>> --- a/sequencer.c
>> +++ b/sequencer.c

>> @@ -497,6 +558,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>>               }
>>
>>               if (opts->record_origin) {
>> +                     if (!has_conforming_footer(&msgbuf, 0))
>> +                             strbuf_addch(&msgbuf, '\n');
>
> What should this do in the case of an entirely blank message?
> (Maybe that's too insane a case to worry about.)

Yeah, I think there are a number of insane cases that I think we
should just say "behavior is undefined".

  - Entirely blank message
  - Message lacking trailing newline.
  - Oneline message that is actually a signed-off-by (equal or not to
the committer's sob).
  - Message body that is entirely 1 or more newlines, or one which has
more than one trailing newline.

It's probably not worth going through contortions to handle these cases.

-Brandon
