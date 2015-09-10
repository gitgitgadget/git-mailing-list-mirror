From: Josh Rabinowitz <joshr@joshr.com>
Subject: Re: [PATCH] push: don't show Done with --quiet --porcelain
Date: Thu, 10 Sep 2015 16:23:07 -0400
Message-ID: <CA+WR+g6mU9=izqskNzMYEQc=OJN2rvz9AjGpJ4XB-sMZXoVxwA@mail.gmail.com>
References: <CA+WR+g7frN4uV12dxahxZbr-5az7sj3zx2oN-Z3rKH0_Y8jqqg@mail.gmail.com>
 <xmqqvbburrkf.fsf@gitster.mtv.corp.google.com> <CA+WR+g7V0Rez_oug5P_LDmafQKXqnDHDNN_vk=-1Sbj3-754DQ@mail.gmail.com>
 <xmqqbndhg8un.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Larry D'Anna" <larry@elder-gods.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:23:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za8NX-00066r-Ve
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 22:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbbIJUX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 16:23:28 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36505 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbbIJUX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 16:23:27 -0400
Received: by igcrk20 with SMTP id rk20so26119637igc.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7ujYJAzRfxKJgZCPQ9l4ezJNv8SX9tFlAG5jn17Z7mQ=;
        b=c8FqbChkO+X00710l+TJg1zXwXaaXQS7S6VkM88ZaaNktPD0ue8slGXisfeKzM7Iuf
         PkPCptN5oKGZhzCGBWqJVaNmelGG2QM2EptumL2H//XyfCPPO7DBlTTnKJTdSrq/8kOq
         OZGSv7e3tYftZhhCoMBbqxnMcIoZhMk1XXFC5DaCHpVq7pDZCelGSVnt4PC9OQjr/PxF
         nNAQNHciMsAIlmDH+RQw9gHIWk6SH0xqhVPCLfRaNFLZ1cCkRRd9kBoSz8zVSTAOR3El
         exTg7doAsVgyi6Sr/5oqrkNDpdfOnCpToSCQCMIgfD45yBDeZtJqClXctiOgNPebipkz
         BGOg==
X-Received: by 10.50.62.112 with SMTP id x16mr9426047igr.23.1441916606528;
 Thu, 10 Sep 2015 13:23:26 -0700 (PDT)
Received: by 10.64.86.78 with HTTP; Thu, 10 Sep 2015 13:23:07 -0700 (PDT)
In-Reply-To: <xmqqbndhg8un.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: ab_wGHuT5T7Zl-sHvW1colvdc-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277633>

Hello, Junio and other recipients:

Thanks for your response.

It just seems very very unlikely that anyone would be depending on a
non-error from git pull --porcelain --quiet' to producing  the "Done"
string. In my case, it's something I didn't expect and wanted to
suppress. (I've automated the use of that command and wished that the
only output would be errors - which is what it's documented to do --
see below)

>From a consistency standpoint, it doesn't make sense to have a --quiet
option output "Done" when there is no error.

If decisions are made that almost no output can ever be changed (which
is what your opinion seems to be leaning towards) then the code is
largely stuck in the present.

It just seems insane to be stuck with the current behavior of 'git
push --porcelain --quiet' printing out "Done" -- especially since the
current behavior is in conflict with the docs (at least from 2.3.2):

  from 'man git-push':
       -q, --quiet
           Suppress all output, including the listing of updated refs, unless
           an error occurs. Progress is not reported to the standard error
           stream.

In any case, thanks again for the response and for your additional
consideration.

Best,
 Josh

On Fri, Sep 4, 2015 at 5:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Josh Rabinowitz <joshr@joshr.com> writes:
>
>> Hi Junio and other recipients:
>>
>> Junio, thanks for your response. I think you may have misunderstood my
>> patch though (or I am misunderstanding your responses), because it
>> seems we are actually in agreement.
>>
>> 1) My original patch is to make 'git push --porcelain --quiet' not
>> emit 'Done' when there is no error. It would continue to emit "Done"
>> when using 'git push --porcelain' without an error.
>>
>> 2) In your first paragraph, you seem to state that while printing
>> "Done" is advantageous when using 'git push --porcelain' without
>> --quiet, the "Done" output isn't needed when --quiet is used. This
>> appears to agree with my patch's intent.
>>
>> 3) in your second paragraph, you seem to agree with me again, that
>> "Done" is not needed when "git push --porcelain --quiet" is use
>>
>> 4) Then in your third paragraph, you say that you don't want to remove
>> the "Done" output when using "git push --porcelain" without --quiet --
>> which my patch preserves (again, it would only remove the "Done" text
>> when 'git push --porcelain' is used with --quiet and there is no
>> error.)
>>
>> In summary, I think we are in agreement that this patch is probably
>> acceptable. Look forward to reading comments.
>
> I think your 4. misinterprets what I meant to say.
>
> Even if we agree 1 thru 3, changing the output, with or without
> "--quiet", is an unwelcome thing to do to existing scripts.
