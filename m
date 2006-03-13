From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 20:36:01 -0800
Message-ID: <4414F6B1.9080107@gmail.com>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org> <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> <4414747B.7040700@gmail.com> <4414E000.9030902@zytor.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Wooding <mdw@distorted.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 05:36:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIemw-0006B5-AQ
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 05:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCMEgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 23:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWCMEgH
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 23:36:07 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:41641 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751430AbWCMEgE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 23:36:04 -0500
Received: by zproxy.gmail.com with SMTP id 13so1238671nzn
        for <git@vger.kernel.org>; Sun, 12 Mar 2006 20:36:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=D1NzHdKKxQG4cJ2qTttMq1ZAN6ZXUA1mqb3GO2EXQaXUTZhAacF0/nuBydw0hPqCPJelAeTL7BIQf6Zo59/OJYMH8XN2hw60ysZtEoyotUT5XlD6lzRXib1rXeGNa102AvovhrRIm6SPAEWVRBjeN7gQRqIr55CJJ1d09/fxON4=
Received: by 10.36.222.43 with SMTP id u43mr4531089nzg;
        Sun, 12 Mar 2006 20:36:03 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.67.7])
        by mx.gmail.com with ESMTP id e1sm4612661nzd.2006.03.12.20.36.02;
        Sun, 12 Mar 2006 20:36:03 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4414E000.9030902@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17546>

H. Peter Anvin wrote:
> A Large Angry SCM wrote:
>> Mark Wooding wrote:
>>
>>> Linus Torvalds <torvalds@osdl.org> wrote:
>>>
>>>> So in modern C, using NULL at the end of a varargs array as a 
>>>> pointer is perfectly sane, and the extra cast is just ugly and 
>>>> bowing to bad programming practices and makes no sense to anybody 
>>>> who never saw the horror that is K&R.
>>>
>>> No!  You can still get bitten.  You're lucky that on common platforms
>>> all pointers look the same, but if you find one where `char *' (and
>>> hence `void *') isn't the same as `struct foo *' then, under appropriate
>>> circumstances you /will/ unless you put the casts in.
>>
>> Please explain how malloc() can work on such a platform. My reading of 
>> the '89 ANSI C spec. finds that _ALL_ (non function) pointers _are_ 
>> cast-able to/from a void * and that NULL should be #defined as (void 
>> *). See 3.2.2.3 and 4.1.5 if interested.
> 
> Consider the non-hypothetical example of a word-addressed machine, which 
> has to have extra bits in a subword pointer like char *.  The C standard 
> requires that void * has those bits as well, but it doesn't means that 
> any void * can be cast to any arbitrary pointer -- the opposite, 
> however, is required.

ANSI X3.159-1989

3.2.2.3 Pointers
	A pointer to *void* may be converted to or from a pointer to any 
incomplete or object type. A pointer to any incomplete or object type 
may be converted to a pointer to *void* and back again; the result shall 
compare equal to the original pointer.

For any qualifier /q/, a pointer to a non-/q/-qualified type may be 
converted to a pointer to the /q/-qualified version of the type; the 
values stored in the original and converted pointers shall compare equal.

In integral constant expression with value 0, or such an expression cast 
to type <bold>void *</bold>, is called a /null pointer constant.[*33*] 
If a null pointer constant is assigned to or compared for equality to a 
pointer, the constant is converted to a pointer of that type. Such a 
pointer, called a /null pointer/, is guaranteed to compare unequal to a 
pointer to any object or function.

Two null pointers, converted through possibly different sequences of 
casts to pointer types, shall compare equal.

[*33*] the macro *NULL* is defined in <stddef.h> as a null pointer 
constant; see 4.1.5.
