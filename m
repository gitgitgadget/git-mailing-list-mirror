From: William Clifford <mr.william.clifford@gmail.com>
Subject: Re: [PATCH/RFC 0/2] custom format for interactive rebase todo
Date: Wed, 10 Sep 2014 07:48:14 -0700
Message-ID: <CAFY06=jqNEo=G7HFjHn-8i8tLMdHwg3yZdwidW_j=_Tw90tnhQ@mail.gmail.com>
References: <864mwhi9qu.fsf@gmail.com>
	<xmqqtx4gloii.fsf@gitster.dls.corp.google.com>
	<xmqqha0glo3j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 16:48:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRjC0-0004jH-ID
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 16:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbaIJOsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 10:48:16 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:36391 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaIJOsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 10:48:15 -0400
Received: by mail-vc0-f169.google.com with SMTP id ik5so2162344vcb.14
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=dbu6hnJvqknVycfcdqlk1/lLCj/uBsK/3AlohXFBcrw=;
        b=Xs4EvrHTpW38SVuDvZ3yD5PjKtSRUWuJZgSlI2OM+8cJHv8U9tBnwFSqIVpKxm2V02
         6tbeRJEP/29HfF3hl9+tT9U9gSrszZxQw4G1kxcpeBGGzpQuKv6itD3qe+AE2KBv6tqf
         m9KAYgDMDEDMT+Qn+iz5pPRxSAyGPdS6F+bdntgpHH6YduDz9pq4Hyoa4c0Gsz3gyM8D
         Ll8TKaWDxng/XaD7b6dKhs4eRgbm7lHtxV1JY4m4RNgCsgxlLg1YlnMIdHB4BuoA5HoY
         XtQkOhRTclOxliATbn+UFj50xHuo79zLK1jl+pCT9QUESlYoaPHBKAcByseAyBW0iymq
         WRRw==
X-Received: by 10.52.36.176 with SMTP id r16mr826201vdj.70.1410360494800; Wed,
 10 Sep 2014 07:48:14 -0700 (PDT)
Received: by 10.220.154.208 with HTTP; Wed, 10 Sep 2014 07:48:14 -0700 (PDT)
In-Reply-To: <xmqqha0glo3j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256748>

Thanks! I've set it up just this way and it seems to work fine.

It turns out the formatted string is processed by the shell `read`
later on, which happens to ignore everything after the first line, so
it seems like it should be safe. But doing something explicit about it
seems like a good idea in this case. I will see about actually reading
in additional lines and raising an error, but it occurs to me that if
I can read in the additional lines, I could also insert them as
comments, and then it should be as safe as any of the other comments
inserted in the rebase todo. In any case I will look into it and
prepare another patch.

On Tue, Sep 9, 2014 at 10:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> William Clifford <mr.william.clifford@gmail.com> writes:
>>
>>> A couple of examples:
>>>
>>> - `git config sequence.format "%<(12,trunc)%ae %s"`
>>> - `git config sequence.format "%s <%aN %aE>"`
>>> - `git config sequence.format "%s%n%%n%b"`
>>> ... I'm unsure what would happen if I tried to rebase with the
>>> third style unedited or uncommented.
>>
>> It should be simply forbidden.  The body part may have a line that
>> is similar enough (i.e. starting with one of the command words and
>> then a hexadecimal string) to confuse the sequencing machinery.
>>
>> Other than that safety issue, I am not fundamentally opposed to the
>> idea.
>>
>> As to the implementation in 1/2, your unconditional use of ">%h" is
>> wrong (you would end up including the commits from the left side).
>>
>> Use '%m' instead of a hardcoded '>', perhaps?
>
> Also, I do not think you want to make the prepending of "%m%h "
> conditional.  If the user for whatever silly reason asks to use a
> format "%m%h %m%h %m%h", let her have that _after_ the "%m%h " the
> machinery needs to operate, i.e. "%m%h %m%h %m%h %m%h".  It is far
> easier to explain to the users and you can lose three lines from the
> second patch.



-- 
William Clifford
