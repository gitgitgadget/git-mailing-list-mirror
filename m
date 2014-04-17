From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Wed, 16 Apr 2014 17:41:51 -0700
Message-ID: <F88F585D-B146-4CD2-A7E9-D3CB2C5B25A4@gmail.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c> <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c> <xmqqob03le3v.fsf@gitster.dls.corp.google.com> <FAD02895-24B2-46C3-ABEF-E9CE17926FF9@gmail.com> <xmqqsipdi5lw.fsf@gitster.dls.corp.google.com> <xmqqtx9tgn5l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 02:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaaOy-0000Ek-OW
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 02:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbaDQAlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 20:41:55 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52362 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbaDQAly (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 20:41:54 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so11484492pad.7
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 17:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=Uk5a09EKrIeUqRR+RhnpDKL5As8jAGYJaD+II0HC/w4=;
        b=hunk0ousLbR1L5gFLXgi9aELAj+Uo3MNluN313A3L6muq9KIBJvLJirIxmdI7SAC7N
         t7KSDL20uKdknLv9nK5AoBkN2BTnU4nTVuP/6+m1QR1x37b02YYYUjkp1boiaNfd+rSl
         WSuUXP/pSAn/unlbLEeoS0Wpy8t2avgxMzybxa8prjVR/mAHtgN35nute8l6Kq5iAIbi
         EvpHaRE16CwnyxpxlHXp2Q3Mg2yaZEdjzGLKNLKDOGuHBk+ui0a30xfgRgsMFataUYVX
         AkJT7fMVa9y9RC7qa4QNz56lV3atTZ/B4c40fcLGBidTvwUZw9Pba01lLAwymQzQnw8e
         R2YA==
X-Received: by 10.68.245.162 with SMTP id xp2mr11930145pbc.69.1397695313946;
        Wed, 16 Apr 2014 17:41:53 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id sv10sm49581286pbc.74.2014.04.16.17.41.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 17:41:53 -0700 (PDT)
In-Reply-To: <xmqqtx9tgn5l.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246394>

On Apr 16, 2014, at 11:11, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>
>>> If I'm the only one getting a wrong meaning from the comments,  
>>> then no
>>> reason to change them.
>>
>> I agree that the description does not read well with the work-around
>> already there.  I am not sure what would be a better way to phrase
>> it, though.
>
> Here is a tentative rewrite at the beginning and the end of rebase-am:
>
>    # The whole contents of the file is run by dot-sourcing this
>    # file from inside a shell function.  It used to be that
>    # "return"s we see below were not inside any function, and
>    # expected to return from the function that dot-sourced us.

I think it's the "return from the function that dot-sourced us" that  
gives me the wrong meaning.  The "return from" part says to me that  
function will be returning which it will not unless the dot command  
was the last command in the function.

Either "return to the function that dot-sourced us" or "return from  
the dot command that dot-sourced us", but using the original wording  
implies to me that the function that dot-sourced us will return as  
soon as the dot-sourced script executes the return and that is exactly  
one of the bugs we're working around.

I think just the s/from/to/ would fix it so it does not give me the  
wrong impression, but that doesn't mean that would not confuse  
everyone else.  ;)

>    #
>    # However, FreeBSD /bin/sh misbehaves on such a construct and
>    # continues to run the statements that follow such a "return".
>    # As a work-around, we introduce an extra layer of a function
>    # here, and immediately call it after defining it.
>    git_rebase__am () {
>
>    ...
>
>    }
>    # ... and then we call the whole thing.
>    git_rebase__am

On Apr 16, 2014, at 11:23, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> By the way, you have this in your log message:
>>
>>    ... the git-rebase--*.sh scripts have used a "return" to return
>>    from the "dot" command that runs them.  While this is allowed by
>>    POSIX,...
>>
>>
>> Is it "this is allowed", or is it "this should be the way and shells
>> that do not do so are buggy"?
>
> Answering myself...
>
> The only "unspecified" I see is this:
>
>    If the shell is not currently executing a function or dot
>    script, the results are unspecified.
>
> which clearly does not apply to the version before this patch (we
> are executing a dot script).  And
>
>    The return utility shall cause the shell to stop executing the
>    current function or dot script.
>
> would mean that we are correct to expect that "should not get here"
> is not reached, as the "return 5" would cause the shell to stop
> executing the dot script there.
>
> So "while this is allowed by POSIX" may be a bit misleading and
> needs to be reworded, I guess?

"allowed by POSIX" is not incorrect. ;)

But perhaps the log message should say 'While POSIX specifies that a  
"return" may be used to exit a "dot" sourced script,' there instead to  
be clearer.  Which would make that whole first paragraph become:

     Since a1549e10, 15d4bf2e and 01a1e646 (first appearing in v1.8.4)  
the
     git-rebase--*.sh scripts have used a "return" to return from the  
"dot"
     command that runs them.  While POSIX specifies that a "return"  
may be
     used to exit a "dot" sourced script, the FreeBSD /bin/sh utility
     behaves poorly under some circumstances when such a "return" is  
executed.
