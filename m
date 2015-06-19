From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 08:59:59 -0700
Message-ID: <xmqq616jbse8.fsf@gitster.dls.corp.google.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
	<xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
	<20150618201323.GB14550@peff.net> <20150618202205.GA16517@peff.net>
	<xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
	<CANCZXo72BscpXKGAtVPt_1QuffcOpTz6nGB+__q0JLisuTaKsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 18:00:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5yiJ-00064L-7A
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 18:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbbFSQAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 12:00:05 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37109 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbFSQAD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 12:00:03 -0400
Received: by igblr2 with SMTP id lr2so16225792igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aVQNFjf//P8xtyC90Achs+LojOK8QxhP74GE5q2WRK0=;
        b=r2C/nwq3aKoUu07do3boOvWfHr+GQhpd00glggTCqt0QF7VXVy6pwLrTjAsK3Uw1Vu
         VsWBnVevKuFl7Z97r1U9fl8EvuLi459PtAd3Vf8ViBqvbzvRNm4g3gjIDqs8ayh50dN1
         cFtENZtASucdBQrm2+8o7Vwr+g9MYQBj0gOAWcrHfBVGYDHB9sz3crc9zkTPe7zn92Uo
         hB0IetM89CX4DAEChC+CyUNCRCgem7xN1hwv1x3peRfFjTv2wTbZNAQHDhP5bVrUurR2
         /tXaPFlLvqis2aqPmv1Ob6AUI6NvCE/Ay971lFVGIjKEqtJ+xMUz81CncnpC0Cq/87rP
         /Wpg==
X-Received: by 10.107.149.133 with SMTP id x127mr23372526iod.20.1434729602809;
        Fri, 19 Jun 2015 09:00:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id 137sm7280107ioo.29.2015.06.19.09.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 09:00:00 -0700 (PDT)
In-Reply-To: <CANCZXo72BscpXKGAtVPt_1QuffcOpTz6nGB+__q0JLisuTaKsQ@mail.gmail.com>
	(Alexander Kuleshov's message of "Fri, 19 Jun 2015 19:33:01 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272163>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> 2015-06-19 3:46 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
>> I agree with "later -o should override an earlier one", but I do not
>> necessarily agree with "'-o -' should be --stdout", for a simple
>> reason that "-o foo" is not "--stdout >foo".
>>
>> Perhaps something like this to replace builtin/ part of Alexander's
>> patch?
>>
>> @@ -1337,6 +1342,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>                 die (_("--subject-prefix and -k are mutually exclusive."));
>>         rev.preserve_subject = keep_subject;
>>
>> +       if (!output_directory && !use_stdout)
>> +               output_directory = config_output_directory;
>> +
>>
>
> But there is following condition above:
>
>  if (!use_stdout)
>       output_directory = set_outdir(prefix, output_directory);
>
> After which output_directory will be "./" everytime and
>
>>
>> +       if (!output_directory && !use_stdout)
>> +               output_directory = config_output_directory;
>> +
>>
>
> will not work here.

I thought I made that "if we did not see '-o dir' on the command
line, initialize output_directory to what we read from the config"
before we make a call to set_outdir().

What I am missing?  

Puzzled...  FWIW, IIRC, the patch you are responding to passed the
test you added.
