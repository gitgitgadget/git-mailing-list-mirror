From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 13:33:43 -0500
Message-ID: <CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:33:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbqg-0007yy-6J
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab3EASdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:33:46 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:36668 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab3EASdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:33:45 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so1562916lab.29
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ABe1nNiVE/arY/vKrNpeAcGGS454KKhUayVSbR4YkPw=;
        b=iz3vWG20n23hj6cTSCajIQ8xtVMj91zXBv3G5jf+KJ7is8BG4DXabdV23wkme993yM
         XwTW0IDJgMTKVN6TqDezU92SmnM2EMguBoUMGVoogEgJFdLUjP7rAfQO4L/WU/A5+e6v
         WN6+l2oQW+R3iqk6U2Rauo+sbYKMiN4AzVFiHcFZHB/SPQPjmaHGEt2RtP/hBZNnVR9N
         yA20TKAA71YY4FgNDOM3gxXZczdu3ZAuYLbEZCRcHjwhmnaOlsaBFWNTWEriZdE/S8Fz
         xTLjOlapjciYBBPVow8ErOiDBChWW7eaAMRUusK4wAlYNnpQUpi+Ne8pr/RK//idhmtu
         UCqA==
X-Received: by 10.112.146.133 with SMTP id tc5mr1527155lbb.88.1367433223540;
 Wed, 01 May 2013 11:33:43 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 11:33:43 -0700 (PDT)
In-Reply-To: <7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223113>

On Wed, May 1, 2013 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
>> can't remove '{0}'?
>>
>> This patch allows '@' to be the same as 'HEAD'.
>
> While the above reasoning is cute, it is misleading.
>
> If you start from HEAD@{1}~0^0, we can remove '^0', we can remove
> '~0', but you cannot remove HEAD from the remaining "HEAD@{1}"
> without changing what it means.  @{1} is where the current branch
> was, while HEAD@{1} is where you were---they are different when you
> have just did "git checkout anotherbranch".  HEAD@{1} is the tip of
> your previous branch, @{1} is where anotherbranch was before its tip
> became the commit you have checked out.

Replace @{1} with @{u} and it holds.

> You have to be specially talking about "HEAD@{0}" as a whole for
> that reasoning to hold; it does not work for HEAD@{$n} for an
> arbitrary value of $n.
>
> So I'd suggest toning it down, perhaps something like this:
>
>         Even though we often can do without having to type "HEAD",
>         e.g. "git log origin.." substitutes missing RHS with "HEAD",
>         sometimes we still do need to type "HEAD" (thats six f*cking
>         keystrokes "Caps Lock", "H", "E", "A", "D" and finally "Caps
>         Lock").

I don't know what RHS means, and I don't use caps lock :)

>         That is four keystrokes too many to name an often needed
>         reference.  Make "@" usable as its synonym.

Yeah, that's nice, but doesn't explain why "@", and why not something else.

>> So now we can use 'git show @~1', and all that goody goodness.
>>
>> Until now '@' was a valid name, but it conflicts with this idea, so lets
>> make it invalid. Probably very few people, if any, used this name.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 76e3219..3b06e5e 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -965,6 +965,17 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
>>       return st;
>>  }
>>
>> +/* parse @something syntax, when 'something' is not {.*} */
>> +static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
>> +{
>> +     if (len || name[1] == '{')
>> +             return -1;
>
> This function is to handle a string that begins with '@', so by
> definition len is zero when anything useful is done by it.  So...
>
>> +     strbuf_reset(buf);
>> +     strbuf_add(buf, "HEAD", 4);
>> +     return 1;
>> +}
>> +
>>  static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
>>  {
>>       /* we have extra data, which might need further processing */
>> @@ -1025,9 +1036,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>>       cp = strchr(name, '@');
>>       if (!cp)
>>               return -1;
>> +
>> +     len = interpret_empty_at(name, namelen, cp - name, buf);
>
> ... it is suboptimal (from readability point of view) to have the
> caller unconditionally call interpret_empty_at() when the function
> clearly is marked to handle something that _begins_ with '@'.
>
> I would suggest something like
>
>         if (cp == name)
>                 len = interpret_empty_at(name, namelen, buf);
>
> which people may find much easier to follow.

Why are we then doing:

  int len = interpret_nth_prior_checkout(name, buf);

This function also needs the string to begin with '@', but we don't
check that, we leave that to the function to let us know if it did
interpret it, or not.

> For that matter, it may make even more sense to just remove the
> "empty-at" function and inline its body here:
>
>         if (cp == name && name[1] != '{') {
>                 strbuf_reset(buf);
>                 strbuf_add(buf, "HEAD", 4);
>                 len = 1;
>         } else {
>                 len = -1;
>         }
>
>> +     if (len > 0)
>> +             return reinterpret(name, namelen, len, buf);
>> +

If you are going to do that, there's no need to check len separately.

	if (cp == name && name[1] != '{') {
		strbuf_reset(buf);
		strbuf_add(buf, "HEAD", 4);
		return reinterpret(name, namelen, 1, buf);
	}

But I think it's less readable.

Cheers.

-- 
Felipe Contreras
