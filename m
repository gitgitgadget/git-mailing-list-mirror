From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 12:00:14 -0800
Message-ID: <20141209200014.GX16345@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQxL-0002jJ-KQ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbaLIUAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:00:18 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59600 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbaLIUAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:00:17 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so1264849ier.14
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PVRmWi79Ts4ZEssthobv0ZLZ01tarlDIlmT+yFJzCoE=;
        b=gEZupapIf5az7qNSsV9BpuHTyDemnN/9ylRLCS8LWJyncmMtKh1Iuttdgva4ZFJpu2
         K6S5TYU2Cj/PvD7MghnfAs0liKQpvNLwCqCSjxhFW6Q1YrZQwLLkvdgQ7lAMtSUM6xEK
         yGxLf159YN6D/Alqw/T/wx1Pb7ydFb61kVzaEzb+B5JcrE0s++yRb94Md2IAoKk5Bgkf
         KzIilwL8O0IrbeRuAHtFlEBK7bJ2XBXR5PMkbwSaOyUiCA02hN23Zr7KJPiQwIuaGzvh
         1z8HOj85RMwcwwg8jpFvPduBWrUpTj6hqkZKUm3DB70Yh3Tp409kj6yHoxgeiAvcKQnU
         ZhfA==
X-Received: by 10.50.124.133 with SMTP id mi5mr4291925igb.13.1418155216875;
        Tue, 09 Dec 2014 12:00:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41c9:2fc6:1317:4ac])
        by mx.google.com with ESMTPSA id l14sm1029190ioi.31.2014.12.09.12.00.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 12:00:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261150>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> +/*
>>> + * Clears the string list, so it has zero items. All former items are freed.
>>> + * If free_util is true, all util pointers are also freed.
>>> + */
>>>  void string_list_clear(struct string_list *list, int free_util);
>>
>> The api doc says
>>
>> 	Free a string_list. The `string` pointer of the items will be freed in
>> 	case the `strdup_strings` member of the string_list is set. The second
>> 	parameter controls if the `util` pointer of the items should be freed
>> 	or not.
>>
>> One option here would be to say
>>
>> 	Free a string_list.  See Documentation/technical/api-string-list.txt
>> 	for details.
>
> If we later introduce string_list_free() that is in line with the
> distinction between "free" and "clear" discussed on this thread, the
> comment for this function needs to be fixed to "Clear the string
> list.  See $doc". and that is not much different from "See $doc"
> without the first sentence which is the function name.

I still find the term "clear" to be confusing here.  It makes me think
the function will be analagous to strbuf_reset, when it's actually
analagous to strbuf_release.

In other words, the important thing is that this frees all members of
the string_list.  There might be a clearer way to say that.  The
string_list itself may not be dynamically allocated --- I'm not sure
what it would mean to free it.

How about string_list_release?

I think I could get used to "clear" if we used it consistently though.
I suspect anything we do will be confusing, unless we make them
consistent.

> Perhaps the API doc that currently says "Free" is the only thing
> that needs fixing?

I find the API doc to be pretty clear, actually.  If someone was
confused in practice then I'd be happy to try to debug the wording.

>                     And perhaps add "See $doc" at the beginning of
> the header and remove duplicated comments we already have in the
> file?

Yes, that sounds like a good way to go about it.

Thanks,
Jonathan
