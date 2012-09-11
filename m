From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 2/2] build: don't duplicate substitution of make variables
Date: Tue, 11 Sep 2012 20:26:23 +0200
Message-ID: <504F824F.3050903@gmail.com>
References: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com> <1c54b744c0ec6987f7987a41853ab0ae00513d03.1347378210.git.stefano.lattarini@gmail.com> <7vtxv4h3lh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 20:26:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBVAR-00079y-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 20:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab2IKS02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 14:26:28 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56584 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab2IKS01 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 14:26:27 -0400
Received: by eekc1 with SMTP id c1so673568eek.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GZ13DRkJSXnPIiJlzhRCDyQ6eBu4+m8gNJS33gsJqLM=;
        b=yK2rKnQLU4TMfHLxr//mcjcq1Kl5wNWslf4oioNyAI6Uqv1VpmGSZZGTItCyJ3Wet3
         B7UvixvXXJ4qj9rpM/DauJPgkSEsnXDXgLfIMHXPnUVPL0aINZH7Q8o4D1F5dDI67M4u
         UQIPYnyzKbVlIoMMF8vLLNN1jlgalPOtsVXVbPcPrhMGE9t/sMBWBZGz7C+HugD/ZYZB
         GgW0vW1Xfm9Pfv4yFLB5irtGUIAusNZbS/bqXIaOHAE4mof28iq2+DCS4xnIxoTRDyoK
         A0MpGeNh26zChmkVyJZJJRB9zulZLYbyU9fgAScSnh4TRUIIm5qC4qc+MERM51Dbflx5
         zEjQ==
Received: by 10.204.154.141 with SMTP id o13mr5100107bkw.72.1347387985887;
        Tue, 11 Sep 2012 11:26:25 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id m9sm10438557bkm.10.2012.09.11.11.26.24
        (version=SSLv3 cipher=OTHER);
        Tue, 11 Sep 2012 11:26:24 -0700 (PDT)
In-Reply-To: <7vtxv4h3lh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205257>

On 09/11/2012 07:27 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> Thanks to our 'GIT_CONF_SUBST' layer in configure.ac, a make variable 'VAR'
>> can be defined to a value 'VAL' at ./configure runtime in our build system
>> simply by using "GIT_CONF_SUBST([VAR], [VAL])" in configure.ac, rather than
>> having both to call "AC_SUBST([VAR], [VAL])" in configure.ac and adding the
>> 'VAR = @VAR@' definition in config.mak.in.  Less duplication, less margin
>> for error, less possibility of confusion.
>>
>> While at it, fix some formatting issues in configure.ac that unnecessarily
>> obscured the code flow.
>>
>> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
>> ---
>>  config.mak.in |  49 --------------------
>>  configure.ac  | 144 +++++++++++++++++++++++++++++++---------------------------
>>  2 files changed, 76 insertions(+), 117 deletions(-)
> 
> Whoa ;-).
>
Well, I could have converted one variable at the time, but that seemed
an overkill :-)

>> diff --git a/configure.ac b/configure.ac
>> index 450bbe7..da1f41f 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -267,6 +267,8 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
>>  	USE_LIBPCRE=YesPlease
>>  	LIBPCREDIR=$withval
>>  	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
>> +        dnl USE_LIBPCRE can still be modified below, so don't substitute
>> +        dnl it yet.
>>  	GIT_CONF_SUBST([LIBPCREDIR])
>>      fi)
>>  #
>> ...
>>  AC_CHECK_FUNC([hstrerror],
>> -	[],
>> +    [],
> 
> Is there some consistent policy regarding SP vs HT in the
> indentation you are using in this patch?
>
Basically I'm trying to follow the style of the surrounding code, while
keeping in mind that in the Git codebase tabs seem to be preferred to spaces.
In this case, the indentation of the following text (that was the "meat" of
the expression) seemed to favour 4 spaces for indentation, so I followed
suit.

> These two hunks suggest
> that you may be favoring spaces, but other places you seem to use
> tabs, so...
>
I can convert the new tabs to spaces if you prefer (that would have been
my preference too, but thought trying to follow the "Git preferences"
was more important).  No big deal either way for me.

Thanks,
  Stefano
