From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally
 -t"
Date: Mon, 09 Mar 2015 18:38:23 +0530
Message-ID: <54FD9B47.7080008@gmail.com>
References: <54F89D90.6090505@gmail.com>	<1425579560-18898-1-git-send-email-karthik.188@gmail.com>	<xmqq61af100p.fsf@gitster.dls.corp.google.com>	<54F9E6B6.4070105@gmail.com>	<xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com>	<54FACD30.6080005@gmail.com>	<xmqqpp8jsyel.fsf@gitster.dls.corp.google.com>	<54FC0CCE.70009@gmail.com>	<xmqqegozsvx5.fsf@gitster.dls.corp.google.com>	<54FC292C.5060405@gmail.com> <xmqq61abs3ur.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 14:08:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUxQ9-00023m-AV
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 14:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbbCINI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 09:08:28 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34784 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbbCINI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 09:08:27 -0400
Received: by paceu11 with SMTP id eu11so58651536pac.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YbGW7gNYQTcXcN2Bgeb+M4aYYBWTwCg+aPF9x0CLt4Y=;
        b=lQ1g4XYqJ6WJDFdd9nvbKaNSD2KZtH3nkg+pOoAGjFGyqOORM+HqP68AVDIzqf7WT/
         dRbvzA+XT4vofPs+mUHttTtbWNUdLuV7SqN2Cns9Ux0pvkjb9DuB4RDWxiW8OB2eIm4i
         hlCEFipBTY6IKWrX1dnnvM59HEeJpsqxookcGp1EWofTe3XVSuudh+CUREHN1wAcKNpJ
         Pupqcs9MIwsNPbN7l8oSii9cFzsDiSPzrECwTQZnwavexfm+Q/3Dcgw4LFl8l/MKOj81
         G1VeAo5PQ86vhtlBch9zsPA0Xb0vjtaXh67b0jXeZjAmUyC6cNYG1yDnMYcGRkGd72Or
         vkpg==
X-Received: by 10.66.55.42 with SMTP id o10mr4004390pap.148.1425906506865;
        Mon, 09 Mar 2015 06:08:26 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ki2sm19264920pdb.33.2015.03.09.06.08.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 06:08:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq61abs3ur.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265164>



On 03/09/2015 12:39 AM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>> Sorry for the confusion, you did already say that in $gmane/264955 , I'm
>> talking about how I tackled the issue in $gmane/264855.
>
> Well, I am suggesting how to improve what you did in your
> $gmane/264855 and a part of that was to suggest that teaching
> parse_sha1_header() the "literally" mode may be necessary and why
> "do not have to call parse_sha1_header()" may not be a good
> solution.
>
> Unless our goal is only to support "--literally -t" and go home,
> never intending to support other things like "--literally -s" and
> "--literally flob $OBJ", that is ;-)
>
> Let's try again.
>
>> Like :
>>
>>      else if ((flags & LOOKUP_LITERALLY)) {
>>          size_t typelen = strcspn(hdrbuf.buf, " ");
>>          strbuf_add(oi->typename, hdrbuf.buf, typelen);
>>      }
>>      else if ((status = parse_sha1_header(hdrp, &size)) < 0)
>>          status = error("unable to parse %s header", sha1_to_hex(sha1));
>>      else if (oi->sizep)
>>          *oi->sizep = size;
>>
>> This way, we don't have to modify parse_sha1_header() to worry if "literally"
>> is set or not.
>
> When you are dealing with a crafted object $OBJ of type "florb", how
> would your
>
>      $ git cat-file --literally florb $OBJ
>      $ git cat-file --literally -s $OBJ
>
> be implemented, if parse_sha1_header() has not been enhanced to
> allow you to say "for this invocation, the type name in the object
> header may be something unknown to us, and it is OK"?
>
> One possible implementation of "--literally florb $OBJ" would be to
> still call the same loose object reading codepath, which would
> eventually hit parse_sha1_header() to see what the type of the
> object is and how long the object contents is, and error out if the
> type is not "florb" or the length of the inflated contents does not
> match the expected size.  Wouldn't you need a way for you to say
> "for this invocation, the type name in the object header may be
> something unknown to us, and it is OK"?
>
> One possible implementation of "--literally -s $OBJ" would be to
> change the call to sha1_object_info() to instead to call the
> _extended() version, just like you did for "--literally -t", and
> then read the result from *(oi.sizep), but the quoted piece of code
> above would not let you use it that way, no?
>
> Of course the above two are both "one possible implementation", and
> not how the implementation ought to be [*1*].  But knowing a bit of
> this part of the codepath, they look the most natural way to enhance
> these codepaths, at least to me.
>
>
> [Footnote]
>
> *1* You could for example sidestep the issue and introduce a
> parallel implementation of what parse_sha1_header() does, minus the
> validation to ensure the object type is one of the known ones, and
> use that function instead of the users of parse_sha1_header() in the
> codepaths that implement "-s" and "cat-file" itself.
>
> But I do not think that is a good direction to go in to keep the
> codebase healthy in the longer term.  A refactoring that is similar
> to what we did when we introduced sha1_object_info_extended(), which
> was done in 9a490590 (sha1_object_info_extended(): expose a bit more
> info, 2011-05-12) would be more desirable, so that we can avoid such
> a duplicated parallel implementations.  That way, the existing
> callers that do not have to know about "--literally" can keep using
> parse_sha1_header(), but parse_sha1_header_extended() is called from
> the updated parse_sha1_header() behind the scene.  And the extended
> version would let callers that need to care about "--literally" ask
> "the type name in the object header may be something unknown to us,
> and it is OK" by passing an extra flag.
>

Hey Junio!
You are indeed right! I was only thinking about "--literally -t" and 
totally ignored the possibility of a future implementation of 
"--literally -s" and maybe a "--literally -e" and a "--literally -p". 
Now I understand why you were saying i need to change
parse_sha1_header().
I will have to look into this, will get back to you when I come up with 
something tangible.
Thanks for the detailed explanation and possible ways of coming across 
this problem.
Regards
-Karthik
