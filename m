From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] prefer xwrite instead of write
Date: Fri, 17 Jan 2014 12:07:15 -0800
Message-ID: <xmqqa9euwex8.fsf@gitster.dls.corp.google.com>
References: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
	<20140117182148.GY18964@google.com>
	<xmqq4n52xw95.fsf@gitster.dls.corp.google.com>
	<20140117200236.GA18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,  git@vger.kernel.org,  msysgit@googlegroups.com,  Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRB5U242LAKGQELK4VKJI@googlegroups.com Fri Jan 17 21:07:20 2014
Return-path: <msysgit+bncBCG77UMM3EJRB5U242LAKGQELK4VKJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f191.google.com ([209.85.214.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB5U242LAKGQELK4VKJI@googlegroups.com>)
	id 1W4FhH-0001du-Ea
	for gcvm-msysgit@m.gmane.org; Fri, 17 Jan 2014 21:07:19 +0100
Received: by mail-ob0-f191.google.com with SMTP id vb8sf882347obc.28
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Jan 2014 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=i6d70KJwbKv14wAOLszB0vJFbRYT79aBFquhqFMclYo=;
        b=BBbCwOkZRoAWS0gaq3LVNvlWybfDWsj5I4fzo5mz1YjlGsv9zCRlLAoHx6p9DfG1sr
         QJsFLFpH2IdlnftjFa02sNg/cBv3AaIGNf5GrcLRNf0BByz7FB/4FKuVd+WH3DyC2mv8
         ffjMDaMlCn43+V/vERybtWD4mboGsQOy0Gssc1L6CWo8jSDsGHDOncOTespapfiGbDyT
         Csby8ijWIsnW367A20DTP/AUwWzuf4CXwtR1xD/VJBHRjTXAZslSP9Kg9B1HSGVIyiy0
         0OOuqyKc8dWwZOv6Q6UQsIjrpw/3x4dQcezLelyrzOZ38b+NddGsG8y0QKs8lTaFPvOo
         PgBg==
X-Received: by 10.182.47.161 with SMTP id e1mr40104obn.24.1389989238409;
        Fri, 17 Jan 2014 12:07:18 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.22.200 with SMTP id g8ls639254obf.30.gmail; Fri, 17 Jan
 2014 12:07:18 -0800 (PST)
X-Received: by 10.182.111.227 with SMTP id il3mr1440821obb.41.1389989238027;
        Fri, 17 Jan 2014 12:07:18 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id xe5si675514vdc.0.2014.01.17.12.07.17
        for <msysgit@googlegroups.com>;
        Fri, 17 Jan 2014 12:07:18 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7345E62CFB;
	Fri, 17 Jan 2014 15:07:17 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56EBF62CF9;
	Fri, 17 Jan 2014 15:07:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E50362CF6;
	Fri, 17 Jan 2014 15:07:16 -0500 (EST)
In-Reply-To: <20140117200236.GA18964@google.com> (Jonathan Nieder's message of
	"Fri, 17 Jan 2014 12:02:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F66E95FC-7FB2-11E3-9285-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240623>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Shouldn't this use write_in_full() to avoid a silently truncated result? (*)
>>
>> Meaning this?  If so, I think it makes sense.
> [...]
>> -	if (xwrite(fd, out.buf, out.len) < 0)
>> +	if (write_in_full(fd, out.buf, out.len) != out.len)
>
> Yes.  Either '< 0' or '!= out.len' would work fine here, since
> write_in_full is defined to always either write the full 'count'
> bytes or return an error.

An unrelated tangent but we may want to fix majority of callers that
do not seem to know that ;-)

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
