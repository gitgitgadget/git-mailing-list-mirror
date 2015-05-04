From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Mon, 04 May 2015 19:01:16 +0530
Message-ID: <554774A4.4020504@gmail.com>
References: <55463094.9040204@gmail.com>	<xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com>	<xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>	<CAPig+cQKqkoqN+o_QfVBRvxGdNuJn_oxD5YMsvnBOHguimJhGQ@mail.gmail.com> <CAPig+cStUNPZqEyE1rJVj5AsTeZFU54mc97rgQqiPbr5V1B0Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 15:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpGT2-0003P8-5z
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 15:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbbEDNbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 09:31:24 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35365 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbbEDNbW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 09:31:22 -0400
Received: by pabtp1 with SMTP id tp1so160850771pab.2
        for <git@vger.kernel.org>; Mon, 04 May 2015 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fzRYKuNOVb+2/FBOPlxlD5HaOcak4cZbHvocGMElwSA=;
        b=ZOP4rwfb4uRPip/N0BFnJ8fXrREvAF/xSkleiBDDxh+oVZ1z84Z59B5uLEWsaAsvOC
         S6bPKPOQEmtxCrx4DQrDa7O0q9IWF6TLo63QycNHZVw6kS5NLIuBt0qumuC7BheWfeQN
         nK64qnegKsmdu6k7CwaRfLwBlqhAomkl9NyyxYb6EhZoYurRZpTtTixxtGd7azDNd+xG
         ieg1xNga7trgYpHsfWtwrfmPIGxlLzSfFnmi5GX1vM6k+T1FyhU0kjQ1qs/KdObnuJ7I
         /IRy5mMEqyprpNC4CZkqAwg7ZAqulzj3yTMEinireXVEQ3DJxP0wLJtk1Jy3h/+iRm6/
         uxqQ==
X-Received: by 10.70.35.6 with SMTP id d6mr41782954pdj.166.1430746281911;
        Mon, 04 May 2015 06:31:21 -0700 (PDT)
Received: from [10.0.0.21] ([106.51.242.250])
        by mx.google.com with ESMTPSA id ef3sm12873869pbc.26.2015.05.04.06.31.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 06:31:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cStUNPZqEyE1rJVj5AsTeZFU54mc97rgQqiPbr5V1B0Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268326>



On 05/04/2015 09:00 AM, Eric Sunshine wrote:
> On Sun, May 3, 2015 at 10:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, May 3, 2015 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Hmmmm... you do not seem to pass your own test.
>>>>
>>>> expecting success:
>>>>          echo $bogus_type >expect &&
>>>>          git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
>>>>          test_cmp expect actual
>>>>
>>>> --- expect      2015-05-04 00:09:24.327335512 +0000
>>>> +++ actual      2015-05-04 00:09:24.335335473 +0000
>>>> @@ -1 +1 @@
>>>> -abcdefghijklmnopqrstuvwxyz1234679
>>>> +abcdefghijklmnopqrstuvwxyz123467abcdefghijklmnopqrstuvwxyz1234679
>>>> not ok 86 - Type of broken object is correct when type is large
>>>
>>> Perhaps it would have a better chance of being correct with this
>>> squashed in.
>>
>> Interestingly, neither test passes on Mac OS X even with this fixup.
>> In fact, the git-hash-object invocation which computes/retrieves
>> 'bogus_sha1' with the extra long bogus type crashes with SIGABRT in
>> write_sha1_file_prepare(). Still investigating.
>
> It's a buffer overflow problem. I'm preparing a patch.
>
Just saw your patch, thanks Eric.
