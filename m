From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Tue, 21 Oct 2008 18:25:36 +0200
Message-ID: <4ac8254d0810210925l11b8b471p27cc06206c7b24ca@mail.gmail.com>
References: <1224445691-1366-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7vy70k5las.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0810200935sf7ad873tea53c0fb53bbe1c0@mail.gmail.com>
	 <7vwsg22568.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 18:27:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsK4e-0007qp-2T
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 18:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbYJUQZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbYJUQZk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 12:25:40 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:60489 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbYJUQZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 12:25:39 -0400
Received: by yx-out-2324.google.com with SMTP id 8so435538yxm.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ss2lKZuPwTYTrgH0IYJBFfzAaQbEHpCUs1/2VOCxlcY=;
        b=DC1Y2T0C5AEspLOSbBrV0An9LYSzrbvUMHAeAlWpG9F6LOb1Mwg2YyNGafN3R5nS/S
         3G3NFdR+zCgwZ7V8UWemGnA/t4dNocI9oKIqX9WcxOhMhvfphe1UX5REHlFU+jMDAvcO
         slAKLgF+WuGspZSEm7vJODM//gbQOqxLnRKHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WEfFI9l+8j/76rvA38tNSiAyMBimpb+9EHXS0GfRc25G7eYvlLEp6fNvhzy88ea7ta
         +E0chXvLg8V2AImHaqaWOX2zqWq3yMQ4x+44lPHBKm2cHoOllFnTzOaGHmqMc0HloNy/
         /PCpUiVlQk/QKYVJUCYVI3fIYwtgiheeSMFxs=
Received: by 10.65.75.2 with SMTP id c2mr6850708qbl.58.1224606336842;
        Tue, 21 Oct 2008 09:25:36 -0700 (PDT)
Received: by 10.65.114.10 with HTTP; Tue, 21 Oct 2008 09:25:36 -0700 (PDT)
In-Reply-To: <7vwsg22568.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98792>

On Tue, Oct 21, 2008 at 1:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>> On Sun, Oct 19, 2008 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>>> @@ -23,6 +24,10 @@ rebase=$(git config --bool branch.$curr_branch_short.rebase)
>>>>  while :
>>>>  do
>>>>       case "$1" in
>>>> +     -q|--quiet)
>>>> +             verbosity="$verbosity -q" ;;
>>>> +     -v|--verbose)
>>>> +             verbosity="$verbosity -v" ;;
>>>
>>> You know verbosity flags (-q and -v) are "the last one wins", so I do not
>>> see much point in this concatenation.
>>
>> Without concatenation I would need to analyze the content
>> of the variable each time the option is passed to the shell
>> script. Do you know of a simpler/better way still keeping the
>> functionality that
>> $ git pull -q -v --quiet --verbose --quiet gives verbosity=QUIET
>> and
>> $ git pull -q -v --quiet --verbose --quiet -v yields verbosity=VERBOSE
>> ?
>
> Wouldn't
>
>        verbosity=
>        while :
>        do
>                case "$1" in
>                -q|--quiet) verbosity=-q ;;
>                -v|--verbose) verbosity=-v ;;
>                ... others ...
>                esac
>                shift
>        done
>        git pull $verbosity other options
>
> give the -q for the former and -v for the latter to "git pull"?

Yes that is much simpler and works :). Thanks.
Please see my next patch in a few minutes.
I might not reply before the weekend as I'm pretty busy, btw.
