From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-create.sh: Support for multiple {to,cc,bcc} options
Date: Sat, 9 Aug 2008 09:23:15 +0200
Message-ID: <36ca99e90808090023r545bbef4ie6fbe6e5561f3a55@mail.gmail.com>
References: <1218141086-16063-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080809003357.GQ10151@machine.or.cz>
	 <7vbq039dfa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 09:24:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRioF-0003BJ-BF
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 09:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbYHIHXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 03:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbYHIHXR
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 03:23:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:38770 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbYHIHXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 03:23:16 -0400
Received: by wx-out-0506.google.com with SMTP id h29so643979wxd.4
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 00:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VE28AzvehCbp+08qnhQnBD1h1yYxVtr2kRi7FDPx3W0=;
        b=jOFS9DWme4nuQUoeLnLU79d1joEBCzuvsDNd1LmmsrT8YWRGiUL0W5s9cQmrfjh8R3
         A8IojLLrfX+xR+8XNbYFX0+4KZ/JLEw58JxIwseE0W+kEiUuhrWNLlceo3saTBsRu6qb
         1WD8j8frscC8cErg9WhX1111M0cDHrgAegWQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mLdKRrh9U/HAeK30qC1eSegy3zd1XvStPgMkE7a6d76uU2H/wwogQm1p5ISPJkzCjH
         eTbx7R2UrFGqgbqSrdxULXcHFJc6Fo1d1zuSFpl33dNp8VnT+Hl/+u7URknuv7kHUxVT
         +5XFhChJpbkTScp9Runft6mA9vdueuM2Cii/o=
Received: by 10.70.74.11 with SMTP id w11mr7271522wxa.47.1218266595256;
        Sat, 09 Aug 2008 00:23:15 -0700 (PDT)
Received: by 10.70.28.18 with HTTP; Sat, 9 Aug 2008 00:23:15 -0700 (PDT)
In-Reply-To: <7vbq039dfa.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91745>

On Sat, Aug 9, 2008 at 03:37, Junio C Hamano <gitster@pobox.com> wrote:
> Petr Baudis <pasky@suse.cz> writes:
>
>>> +    prefix="$(echo "$2" | sed -e 's/\//\\\\\//g')"
>>
>> Maybe use s### ? ;-)
>
> Personally I like '|' instead.  It's much less visually distracting than #.
  ^^^^^^^^^^ says it all ;-)
>
>>> +
>>> +    git config --get-all topgit.$1 2>/dev/null |
>>> +            sed -e "s/^/$prefix /g"
>>> +}
>>
>> Won't this return an error code and terminate the script in case no
>> option is defined?
I tested it with none defined options: no error, no distracting empty
lines, no error messages. so it worked here.

>>> -    ! header="$(git config topgit.to)" || echo "To: $header"
>>> -    ! header="$(git config topgit.cc)" || echo "Cc: $header"
>>> -    ! header="$(git config topgit.bcc)" || echo "Bcc: $header"
>>> +    get_multi_config to  "To:"
>>> +    get_multi_config cc  "Cc:"
>>> +    get_multi_config bcc "Bcc:"
>>>      ! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
>>>      echo "Subject: [${subject_prefix}PATCH] $name"
>>>      echo
>>
>> One trouble here is that I've seen mailers mess up when there is
>> multiple occurences of these headers, so it would be probably safer to
>> concatenate them all to single line, comma-separated.
>
> It is not just "I've seen mailers"; RFC2822 wants you to have at most one
> (see the table on Page 20).
But do we generate a valid mail with tg patch, or just a patch file
with some special looking lines? Anyway, I thought about the comma
separated solution too, but git send-mail handles these multi lines
well. So I take the easy road.

Bert
