From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] configure.ac: move the private git m4 macro to a
 dedicated directory
Date: Fri, 9 Aug 2013 19:52:50 +0200
Message-ID: <CA+EOSBkTfy+u6YGv-1QeG5qnjDquxmr5doDmp2waquUbgjBe3w@mail.gmail.com>
References: <1376059045-14866-1-git-send-email-gitter.spiros@gmail.com>
	<7v61ve7qpk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 19:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7qrw-0003Wa-ET
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758535Ab3HIRww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 13:52:52 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:60082 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758468Ab3HIRwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:52:51 -0400
Received: by mail-ve0-f174.google.com with SMTP id d10so4141283vea.19
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ubJPR1kmjKtMyLkOWS7pQ5BUnQrmq25jTtLTS0I1uK0=;
        b=okWCB5r0LkbSf5S4ZnYo5cIttTbcPm4mLZdwF24my4naEPfy722PNiUJYniOBfw75k
         q9h7Pq81ZYHFegHoBnt2U1U+It3bUXag4quuYjZxmlvn/oeUpIrs4zfkxBQP1ZBO0qs4
         A96LmWPF/mLt5CRg3k13jqLcVcYTAD4q1q/QjbqfDBCY54LnN97dQ8dQm7zFJOJMbMG6
         eW7W3PeLM2GMWxRO1H3IinNBSwuXbESESkcunfiWTqGqge8TKIaJwyHGSr8EBQJ76DGj
         CY90eXiN3djoGeoXLdTXMzoWfjkGut2fo8/1OS1VJOs42mah01QDjcVmxXfCf1JzRR61
         BrHQ==
X-Received: by 10.52.66.242 with SMTP id i18mr867973vdt.3.1376070770767; Fri,
 09 Aug 2013 10:52:50 -0700 (PDT)
Received: by 10.52.166.14 with HTTP; Fri, 9 Aug 2013 10:52:50 -0700 (PDT)
In-Reply-To: <7v61ve7qpk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232003>

2013/8/9 Junio C Hamano <gitster@pobox.com>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Git use, as many project that use autoconf, private m4 macros.
>>
>> When not using automake, and just relying on autoconf, the macro
>> files are not picked up by default.
>>
>> A possibility, as git do today, is to put the private m4 macro
>> in the configure.ac file, so they will copied over  the final configure
>> when calling autoreconf(that call also autocon). But this makes configure.ac difficult
>> to read and maintain, especially if you want to introduce new macros later.
>>
>> Starting from version 2.58, autoconf provide the macro AC_CONFIG_MACRO_DIR
>> to declare where additional macro files are to be put and found.
>> The argument passed to this macro is commonly m4.
>>
>> This macro, for the longest time, has been used only by libtool
>> starting from version 2.0, to identify where to copy its own macro files
>> when using libtoolize --copy.
>>
>> Starting from version 1.13, automake augments autoconf with a macro
>> called AC_CONFIG_MACRO_DIRS, that provides a space-separated list
>> of directories to use for looking up m4 files.
>> The same macro will be available as part of autoconf 2.70,
>> actually in development. Anyway also this version permit
>> to use AC_CONFIG_MACRO_DIR and not need automake.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>
> That explains why you created a separate directory to for the new
> file and why you needed to use AC_CONFIG_MACRO_DIR while doing so.
>
> But in the above explanation, I fail to see the reason why we would
> want to create that new file out of the existing file, only to
> include it in the original file.

Thanks.

For those who use the gnu build tool is good practice to separate the
private macros, very equilalent to an external library of C, from the
main configure.ac file. Readability, maintainability are in general
the reason in the same measure that everyone use external libraries or
external includes in C to simplify the writing of a program. Just for
a simple example, if I want to introduce  new test macros for
understeand in a portable way what are the C flags that a compiler
understand - for QA, memory checker ecc - is much more readable and
easy to update a separate file that to update the main configure.ac
file that is not intended to contain the declaration of m4 macro and
can grow larger. In fact from my experience it is difficult to find
many program that not use a separate macro dir and use the gnu build
tool.


Sorry if I was not clear, perhaps it is due to the fact that i have
the habit of using the gnu build tool always and i think  that
something is obvious but often it is  not so obvious to everyone.

Thanks and best regards
>
> Why is it needed?  Why is it a good idea?
>
