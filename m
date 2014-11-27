From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] commit: inform pre-commit if --amend is used
Date: Thu, 27 Nov 2014 09:40:08 -0500
Message-ID: <547737C8.7070609@gmail.com>
References: <1416828111-4567-1-git-send-email-oystwa@gmail.com> <20141125034424.GA19161@peff.net> <xmqqtx1nub9e.fsf@gitster.dls.corp.google.com> <20141125050331.GB20805@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w5h5c3RlaW4gV2FsbGU=?= <oystwa@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 15:40:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu0F3-0007TR-9K
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 15:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbaK0OkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 09:40:14 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:62055 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbaK0OkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 09:40:13 -0500
Received: by mail-qg0-f45.google.com with SMTP id f51so3572680qge.18
        for <git@vger.kernel.org>; Thu, 27 Nov 2014 06:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=kH8v+dpIj4sU/HBJ1GlKwT1xIIAnVhQZoFGjuB5iBo4=;
        b=LdavW9YkcQyg3PtUl8AUvuDDbRzwGj0l0thv6v6KINZhJiIlZMmrKbYr7CGt9EoA26
         y41tpD2lzLnxMqGpOEgMN1Nbw16ewdeSoRX1brdZDYkrF+8Jmrc16FBCXAsK3lpcaZ7e
         45z+ukY07Idbb0J57Sg1+wScGikmz6r01Ia1PVeWU4tIH1a9jscGfLG44Goqma4Nq9Vk
         fh/+XbuEp7atqqdPzDe4fLD/dg3UWRL0dVR+QGND0Qf4/APYvEGW1A3j4pr0mBrEZ6Kb
         HLnDJVSHS5C4TZqwbZVUphDm2wBxA1AZV2nNChTYp0FcQY2JIAvt+ri4rnAi6od1CgDV
         XQfQ==
X-Received: by 10.140.106.138 with SMTP id e10mr55294435qgf.71.1417099212647;
        Thu, 27 Nov 2014 06:40:12 -0800 (PST)
Received: from marklaptop.lan (pool-173-79-126-100.washdc.fios.verizon.net. [173.79.126.100])
        by mx.google.com with ESMTPSA id b20sm6711330qaw.3.2014.11.27.06.40.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Nov 2014 06:40:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20141125050331.GB20805@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260344>

On 11/25/2014 12:03 AM, Jeff King wrote:
> On Mon, Nov 24, 2014 at 08:58:37PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>>    1. It is a bit more obvious when debugging or dumping arguments (e.g.,
>>>       via GIT_TRACE), especially if new options are added after the
>>>       first.
>>>
>>>    2. It makes it easier for a script to work on old and new versions of
>>>       git. It sees either "amend" or "noamend" for the two obvious cases,
>>>       and if it sees no argument, then it knows that it does not know
>>>       either way (it is running on an old version of git).
>>>
>>>       Technically one can tell the difference in shell between an empty
>>>       string and a missing argument, but it is sufficiently subtle that I
>>>       think "noamend" is a better route.
>>
>> If we ever add more info, would we want to keep piling on new
>> arguments, though?  Wouldn't it a viable option to use "amend" vs
>> not giving anything (not even an empty string), so that normal case
>> there won't be no parameter?
>
> Then when you add new arguments, the hook has to search through the
> parameters looking for one that matches, rather than just checking "$1"
> for "amend" (and "$2" for the new option, and so on). As long as the set
> of options remains relatively small, I think that is preferable.
>
> We could also just pass them through the environment, which gives nice
> named parameters.
>
> -Peff
>

See http://comments.gmane.org/gmane.comp.version-control.git/148479 for 
an earlier conversation on this exact topic. Also, see 
http://permalink.gmane.org/gmane.comp.version-control.git/148480 for a 
similar change in git-gui.

-Mark
