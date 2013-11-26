From: =?UTF-8?B?IkFuZHLDqXMgRy4gQXJhZ29uZXNlcyI=?= <knocte@gmail.com>
Subject: Re: [PATCHv3] transport: Catch non positive --depth option value
Date: Tue, 26 Nov 2013 11:43:14 +0100
Message-ID: <52947B42.4080105@gmail.com>
References: <5283A380.9030308@gmail.com> <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com> <528A9877.4060802@gmail.com> <xmqq61ro9utf.fsf@gitster.dls.corp.google.com> <528E2660.6020107@gmail.com> <xmqq1u294ih3.fsf@gitster.dls.corp.google.com> <CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com> <5293DE93.3020008@gmail.com> <CACsJy8BV74W63Sak-j_9RMjp_5Bo8HMd3Xc93GTtSn4yWStfEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 11:43:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlG75-00066j-Bi
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 11:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab3KZKnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 05:43:23 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:38188 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830Ab3KZKnW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 05:43:22 -0500
Received: by mail-ea0-f179.google.com with SMTP id r15so3351216ead.38
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 02:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=r2RyuWa3FWjYFyEU+SZphMDoxcH/CWGqF3kdju5l25M=;
        b=ujUQElj5StvLz0taQDMnjg09Uc2TVkvBbne2SMcoWc1yiQRl8Skq+5sPxty8iHxmqJ
         4Mao3ko+gS1/T5fPpMeYzCYFLwvyzeVpXnXxZNS1DwZwCXqNf+ILvZxHhraFsgevq2iF
         1ssGmWt+/adWgDYOFy/ZVngFhffoFphHBLZADDr7yLAbN+Mn+8xjoTMFfsIlIMhegTQ/
         D7KUYsi4jxO67iT1B9WVc+Wvx+XYcHaq9LOvlN98TN67eveMvHbYgSZ+H9gMxC1RTbPN
         M6R3Ry0Py+UQ6XHx5UpgwK44lHnbnxBRTYIpci3OL/oHJ+AnA7SmucZjEgsCq/9HWz3H
         zLyA==
X-Received: by 10.14.127.132 with SMTP id d4mr1885665eei.66.1385462601048;
        Tue, 26 Nov 2013 02:43:21 -0800 (PST)
Received: from [192.168.0.151] (82.Red-83-39-68.dynamicIP.rima-tde.net. [83.39.68.82])
        by mx.google.com with ESMTPSA id v45sm7702610eef.11.2013.11.26.02.43.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Nov 2013 02:43:19 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACsJy8BV74W63Sak-j_9RMjp_5Bo8HMd3Xc93GTtSn4yWStfEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238377>

On 26/11/13 04:06, Duy Nguyen wrote:
> On Tue, Nov 26, 2013 at 6:34 AM, "Andr=C3=A9s G. Aragoneses"
> <knocte@gmail.com> wrote:
>> On 22/11/13 02:18, Duy Nguyen wrote:
>>> On Fri, Nov 22, 2013 at 3:18 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>>> Have you run the tests with this patch?  It seems that it breaks
>>>> quite a lot of them, including t5500, t5503, t5510, among others.
>>>
>>> I guess it's caused by builtin/fetch.c:backfill_tags(). And the cal=
l
>>> could be replaced with
>>>
>>> transport_set_option(transport, TRANS_OPT_DEPTH, NULL);
>>>
>>
>> Not sure what you mean,
>> https://github.com/git/git/blob/master/t/t5550-http-fetch.sh doesn't
>> call backfill_tags. What do you mean?

That was a typo, I meant
https://github.com/git/git/blob/master/t/t5500-fetch-pack.sh


> I wrote "I guess" ;-) I did not check what t5550 does.

Any hint on where to start looking? It doesn't look like any test is
using a non-positive depth, so I'm really confused.
