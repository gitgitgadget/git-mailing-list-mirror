From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 2/2] diff: don't read index when --no-index is given
Date: Tue, 10 Dec 2013 19:55:33 +0100
Message-ID: <87bo0omt7e.fsf@gmail.com>
References: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com> <1386697935-18635-1-git-send-email-t.gummerer@gmail.com> <1386697935-18635-2-git-send-email-t.gummerer@gmail.com> <20131210181840.GC2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 19:55:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqST7-0006Xf-U1
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 19:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab3LJSzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 13:55:36 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:64126 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab3LJSzf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 13:55:35 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so4159498yhz.8
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 10:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=y9AM6ZkX7XByBSodwRJdHoMFUnkOZFmqwHIoHstmQqY=;
        b=rqC+M/7Phav/g1FZkFGgIOJ0Owq3nHF9SFdfBIZ9UPAdcIpVWRL3z4HPH0y0Gf8Mya
         HDOHSCIYeYhrT9NMoMPQz9Cf5/4iXCM0DTdW2w4/AjijLOquMJdAtU6XMuX6rI9ZNDkt
         0yJyEtUMp0KGsZ0n3T9SBzNlZvSAADokSF9miNG5gA/e6y/shQ8agwUvLweZzAWpBLJo
         oibNUA0V9KdPiaj1/OIeC5MZTamzXrUpj2uOkCuxREcRKfwIspanuBbsdA6/UsDZIMoe
         FJiu/GUKMM0/IatleglZz5Li1FpxHytkuN3VKkAvVbcNQxskaOiVhtJ+UJIyI+uHwr9N
         DL9A==
X-Received: by 10.236.144.194 with SMTP id n42mr2572574yhj.114.1386701734644;
        Tue, 10 Dec 2013 10:55:34 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::158d])
        by mx.google.com with ESMTPSA id v45sm23960094yha.2.2013.12.10.10.55.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2013 10:55:33 -0800 (PST)
In-Reply-To: <20131210181840.GC2311@google.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239148>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Gummerer wrote:
>
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -295,7 +295,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>  			break;
>>  	}
>>
>> -	prefix = setup_git_directory_gently(&nongit);
>> +	if (!no_index)
>> +		prefix = setup_git_directory_gently(&nongit);
>
> What is the value of nongit in the no_index case?

In the no_index case it doesn't matter, since no_index is always checked
first.  The only other place where it is used, when no_index is set
is after diff_no_index, which can't be reached if no_index is set.  I
could initialize nongit to 0, but I don't think that would change
anything.

I've also seen that the no_index and nongit parameters to diff_no_index
are not needed anymore, and will remove them in the re-roll therefore.

I'll wait to see if there are any more comments and then send a re-roll.

Thanks!

--
Thomas
