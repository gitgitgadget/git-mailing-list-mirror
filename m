From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 p2 3/9] transport-helper: trivial code shuffle
Date: Wed, 28 Nov 2012 01:05:34 +0100
Message-ID: <CAMP44s0fmt+bHN-ycza8b+y8Ep-Cyqmg1U1PVas267fTY5iPPQ@mail.gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
	<1353727520-26039-4-git-send-email-felipe.contreras@gmail.com>
	<7vk3t7nfql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdV9z-0006Fh-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab2K1AFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:05:36 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54099 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab2K1AFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:05:35 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11515647obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 16:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ELjzXdqr/XBrdvXFy1c5juCiWNYcg6Y9jwDukiKPmYI=;
        b=qe9ZPq8BBgo2gH2vT8P+23ZvTUmA/2zEte/0DGMKquQfh4BVl6C6WBkweex054Y6Da
         uJLR2TpIKqnInXVansOv454iDbKL3YVMNm7C3KswDngRTnPXHt20WZxeNidMy2PUSGRj
         zdLqZfTdylsPd3AWOysy4LQcMDyl4PExleAMBKbXMsfXkdmvdMH2Y1wJmKXVVHxqy4N9
         zic2nxCrTaVHA38h8K6xE6J8/0TYVcOFaiDBZH6KSqx/IMc8HZsxS2hR8ypNCuBHK246
         nVjQiS6tBmqyJXJxcNklVsHnW20moUjs0UImm3Eak3RjIrm13igbdtnWbjg1Q8Lep6K1
         XRsQ==
Received: by 10.60.30.70 with SMTP id q6mr14127416oeh.103.1354061134725; Tue,
 27 Nov 2012 16:05:34 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 16:05:34 -0800 (PST)
In-Reply-To: <7vk3t7nfql.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210635>

On Tue, Nov 27, 2012 at 6:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Just shuffle the die() part to make it more explicit, and cleanup the
>> code-style.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  transport-helper.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/transport-helper.c b/transport-helper.c
>> index 32ad877..0c95101 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -775,6 +775,9 @@ static int push_refs_with_export(struct transport *transport,
>>               char *private;
>>               unsigned char sha1[20];
>>
>> +             if (ref->deletion)
>> +                     die("remote-helpers do not support ref deletion");
>> +
>>               if (!data->refspecs)
>>                       continue;
>
> This is not just "just shuffle the die to make it explicit" but it
> does change the semantics; earlier ref->deletion was perfectly fine
> as long as data->refspecs is not given, but the new code always
> dies.
>
> If this semantic change is a good thing, please explain why it is so
> in the log message.  If the change is "it does not matter because
> when data->refspecs is not given and ref->deletion is set, we die
> later elsewhere in the code anyway", then it needs to be described.

refspecs are optional, but when they are not present the code doesn't
work at all. This patch changes the behavior that was totally broken
anyway.

-- 
Felipe Contreras
