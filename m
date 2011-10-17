From: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
Subject: Re: [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove
 leading SP from $diff_class
Date: Tue, 18 Oct 2011 08:58:02 +0900
Message-ID: <CAFo4x0KayxUfnVfO1-Qhu1LiMvwMs6g=bgPXZjqqZUxpUJsDWQ@mail.gmail.com>
References: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com>
 <7v62jnmog3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 01:58:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFx4e-0001fB-SJ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 01:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab1JQX6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 19:58:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41021 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab1JQX6X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 19:58:23 -0400
Received: by bkbzt19 with SMTP id zt19so89631bkb.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eRaeF4f/m+hzM6iy8OCYQAHUxYB7X0q/p9fCIweU6kw=;
        b=TAWwLaagGuyUwIQuU8IaKvxpVa0sxsWmBwBRzecHLIEUsOYlqeJHi4zG9ZsyokLs+c
         wVhcB4XegaQPX+leKbdvIZeZEf2AItlt9CAJw3n0oj3WJ51R5wtfH0wadkUlxGM9MgR8
         bl5Xqp6zJYeDt8kgDG5WqN5zI04Ptjo8mO860=
Received: by 10.204.156.1 with SMTP id u1mr63464bkw.18.1318895902104; Mon, 17
 Oct 2011 16:58:22 -0700 (PDT)
Received: by 10.204.36.132 with HTTP; Mon, 17 Oct 2011 16:58:02 -0700 (PDT)
In-Reply-To: <7v62jnmog3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183845>

On Tue, Oct 18, 2011 at 4:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:
>
>> The format_diff_line() will return $diff_class and HTML in upcoming changes.
>
> An auxiliary piece of information like this is fine at the end of the
> commit log message, but the patch itself wants to be justified
> standalone.  Perhaps this should be sufficient:
>
>        The $diff_class variable to classify the kind of line in the diff
>        output was prefixed with a SP, only so that the code to synthesize
>        value for "class" attribute can blindly concatenate it with
>        another value "diff". This made the code unnecessarily ugly.
>
>        Instead, add SP that separates the value of $diff_class from
>        another class value "diff" where <div class="..."> string is
>        created and drop the leading SP from the value of $diff_class.
>
> Explained this way, it does not even have to mention that the return value
> will be changed in a different patch.
>

Thanks. I couldn't write a good summary for my patch because it was just
an "adjust" for me. However your summary is really clear!

>>  gitweb/gitweb.perl |   24 +++++++++++++-----------
>>  1 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 85d64b2..095adda 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2235,28 +2235,30 @@ sub format_diff_line {
>> ...
>> +
>> +     my $div_open = '<div class="' . (join ' ', ('diff', $diff_class)) . '">';
>
> I think using a separate helper variable like this is a good change.  You
> do not have to worry about the issue in three different places.
>
> But doesn't join(" ", ("frotz", "")) still give you "frotz "?  It is OK to
> punt and say
>
>        my $div_open = '<div class="diff $diff_class">';
>
> which would be far easier to read. It may sacrifice a bit of tidiness in
> the resulting HTML but the tidiness of the source outweighs it.
>
> Of course, if you have tons of classes, it may be worth doing something
> like
>
>        join(" ", grep { defined $_ && $_ ne ""}  @diff_classes);
>
> but I do not think it is worth it in this particular case.
>

Yeah, I want to remove unnecessary SP that you mentioned before.
But well, join(" ", ("frotz", "")) give me "frotz ".
I will add some per-function test cases to gitweb before this patch series.

Thanks,

-- 
Kato Kazuyoshi
