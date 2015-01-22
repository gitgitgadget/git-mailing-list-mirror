From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] git-add--interactive: print message if there are no
 untracked files
Date: Thu, 22 Jan 2015 13:11:37 +0600
Message-ID: <CANCZXo5OQHNCyz3kUY6c0Y_Lpabee0WS+eQ5G53QupMLwOw=jg@mail.gmail.com>
References: <1421867004-31672-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqmw5bx2ii.fsf@gitster.dls.corp.google.com>
	<xmqqegqnx281.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:11:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEBva-0005Qu-NQ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 08:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbbAVHLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 02:11:39 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:47136 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbAVHLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 02:11:38 -0500
Received: by mail-oi0-f48.google.com with SMTP id v63so5321489oia.7
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 23:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ov0pqN53Ed2TJGIUCGfVURN3grIcKiGeUGtMy05Rgio=;
        b=1KAFpWMQDZ1RwzciuW6enRMS8QGcsOOGoDMMSB6Dny6GJ8Fh3xpmB7XjQH+h5TOLmC
         1+R0sBGKmIuigipbbcjE8r7wgR3JjdsHeJZQjaaO4pJDQobISmV4scCxq8oCXiPUOcgE
         SWS0f7yXpzYZiuhCBBJq3KMYu/VnYfNGOpW/DhcgD/2Vl6bMxTXu8fn5eD5wcmhirEh5
         zbJEEf2Nx/mFbGhTUrkcWVvFpSuTgI8iRVONAZ/CR7TRZ3T3lR1Mwwky2bTOZQsmXb23
         8PTtYHpiSkPQKNgrnpVxwunxgoTBQdE2epohWJssgw8oymeF0Dxr1qN9XU17fTyVZaIK
         h1wQ==
X-Received: by 10.60.156.196 with SMTP id wg4mr1409045oeb.11.1421910697500;
 Wed, 21 Jan 2015 23:11:37 -0800 (PST)
Received: by 10.182.26.116 with HTTP; Wed, 21 Jan 2015 23:11:37 -0800 (PST)
In-Reply-To: <xmqqegqnx281.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262803>

No i don't see any reasons why list_and_choose() shoud give a prompt
without candidates. Will resed patch.

Thank you.

2015-01-22 3:17 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>  sub add_untracked_cmd {
>>> -    my @add = list_and_choose({ PROMPT => 'Add untracked' },
>>> -                              list_untracked());
>>> -    if (@add) {
>>> -            system(qw(git update-index --add --), @add);
>>> -            say_n_paths('added', @add);
>>> +    if (system(qw(git ls-files --others --exclude-standard --))) {
>>
>> But this ls-files invocation that knows too much about how
>> list_untracked() computes things does not.
>>
>> Why not
>> ...
>> or something instead?
>
> Actually, is there any case where list_and_choose() should give a
> prompt to choose from zero candidates?
>
> In other words, I am wondering if this affects other callers of
> list_and_choose in any negative way.
>
>  git-add--interactive.perl | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 94b988c..46ed9a7 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -519,6 +519,10 @@ sub error_msg {
>  sub list_and_choose {
>         my ($opts, @stuff) = @_;
>         my (@chosen, @return);
> +
> +       if (!@stuff) {
> +               return @return;
> +       }
>         my $i;
>         my @prefixes = find_unique_prefixes(@stuff) unless $opts->{LIST_ONLY};
>



-- 
_________________________
0xAX
