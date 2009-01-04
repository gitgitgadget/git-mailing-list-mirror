From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sun, 4 Jan 2009 12:41:14 +0100
Message-ID: <9b18b3110901040341n5ff5fa09s878228131d11d2a6@mail.gmail.com>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
	 <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
	 <7vvdsv3af6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matt Kraai" <kraai@ftbfs.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 12:42:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJRNO-0004ni-6G
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 12:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbZADLlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 06:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbZADLlR
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 06:41:17 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:13171 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZADLlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 06:41:16 -0500
Received: by qw-out-2122.google.com with SMTP id 3so6007227qwe.37
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 03:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KhneZrOO6HvD37sEsZMo3Hec6is209XJ4PNzueBtNPk=;
        b=gc2WnmcCzE/wBaOyata3MirKV14onSaHHI/yyr5gfTa1LWUjUs7Hnl0smdZ44czLd1
         3YzmjlYFR1cH8Yf613zKR5GkbO8U8QMe1cf5fBJ1/C0l8cUu+JZDCEaZ8VzqgAzDFzxJ
         kTpgzBnvKzaeidp/m6X1iKVqIzgmIw2v4J6To=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b/1e3kxDEzS3qwK1Cz1ce2b6MaCIVGoF0mZKTMqFeXBjDxm323TB3p2hihZ5j4aDfL
         nCtkRtdUwjtVdXwUOqL0ZIXurqUsH+cdxfJ7kgETuWA2FKHy9/vzwKnhQgSky8B529YR
         NKeG1s970hquTMLr0JgzmgXmnhXc9yahGhoU0=
Received: by 10.214.243.9 with SMTP id q9mr15805191qah.61.1231069274429;
        Sun, 04 Jan 2009 03:41:14 -0800 (PST)
Received: by 10.214.241.2 with HTTP; Sun, 4 Jan 2009 03:41:14 -0800 (PST)
In-Reply-To: <7vvdsv3af6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104508>

2009/1/4 Junio C Hamano <gitster@pobox.com>:
> demerphq <demerphq@gmail.com> writes:
>
>> 2009/1/3 Matt Kraai <kraai@ftbfs.org>:
>> [...]
>>> -sub feature_blame {
>>> -       my ($val) = git_get_project_config('blame', '--bool');
>>> +sub feature_bool {
>>> +       my $key = shift;
>>> +       my ($val) = git_get_project_config($key, '--bool');
>>>
>>>        if ($val eq 'true') {
>>>                return 1;
>>
>> Maybe that should be:
>>
>>            return ($val eq 'true');
>>
>> as It is not a good idea to use 0 as a replacement for perls false, as
>> the two have different behaviour.
>
> I'd rather want to keep our scripts free of deep Perl magic.  Even if
> there are SVs that are interpreted as false other than 0, that does not
> necessarily mean you have to fear that 0 can sometimes evaluate to true.

No, thats not the point. The point is that why should the code do more
work to return a value that a perl programmer might find unexpected.
Especially when the function has the word "bool" in it. Its like
writing a function whose name says "int" that returns a double. If the
routine was not called "bool" then it wouldnt matter at all.

> As long as you refrain from doing something crazy like "0 but true",
> people who are not (and/or are not inclined to become) familiar with the
> gory innards of Perl can rely on 0 being false and 1 being true when
> calling feature_something subs, no?

Why execute more opcodes, and return a slightly surprising false, when
you dont have to?

Is it really deep perl magic to do:

  return $val eq 'true';

instead of

  return $val eq 'true' ? 1 : 0;

or the actual use:

   if ($val eq 'true') {
      return 1
   } else {
      return 0
   }

Isn't the former superior just on pure minimalism metrics? Theres less
code to understand, less code to go wrong, and as a bonus it returns a
true boolean. Isn't that just a win-win-win? I mean most perl
programmers I know would instantly convert the latter two to the first
just on the grounds that the first version is the clearest expression
of the desired intent.

Anyway, leave it or not, its a minor nit.

cheers,
Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
