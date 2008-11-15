From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Sat, 15 Nov 2008 20:16:28 +0100
Message-ID: <4ac8254d0811151116l5c52ef59k74927362c6556543@mail.gmail.com>
References: <1226708064-19432-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7v7i7594cx.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0811150942s7d4f5444xbc2b068beecbb44f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 20:17:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1QeQ-0000Kf-3R
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 20:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbYKOTQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 14:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYKOTQa
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 14:16:30 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:46564 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYKOTQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 14:16:30 -0500
Received: by an-out-0708.google.com with SMTP id d40so828128and.1
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=C9N3mnUif/Hs/a3K6zaMz0sRxRst8rnocK9R21NXpZ4=;
        b=HUu1o5po4+aNlnUnitDKVGG9Y2v9v6U4aRoHvYdJR2GkMZ3Ewa955Cv1LY3ZS6kYo/
         SoJXfdnOhI65vii4clvoYyB6DXNYA+vd6+F9Q5WdbxpUsaljCrYzxE404vAW0cpoF8iG
         OYBSYMoY5Mgq1SIJe7QIrIKad0T92zAMVEI8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XvtCMG/hMpeKZ7QrWBn5xDRZaIxdKaWKcmOJihzk1qoACq7w09JoGUNiYv6IkWIjcK
         djt1+wERLMqZS14Gs8fvlikkMfoCGrBL9EdsaxwgfGWpC4W/xGCI3Bu6dD5Qda0yg1YW
         fWDxCKsGtfk0HOXvt+dQPRTCt0RpW7zOPTk7I=
Received: by 10.65.215.14 with SMTP id s14mr2254598qbq.5.1226776588423;
        Sat, 15 Nov 2008 11:16:28 -0800 (PST)
Received: by 10.65.231.17 with HTTP; Sat, 15 Nov 2008 11:16:28 -0800 (PST)
In-Reply-To: <4ac8254d0811150942s7d4f5444xbc2b068beecbb44f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101086>

On Sat, Nov 15, 2008 at 6:42 PM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> On Sat, Nov 15, 2008 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> @@ -637,9 +638,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>>               remote = remote_get(argv[0]);
>>>
>>>       transport = transport_get(remote, remote->url[0]);
>>> -     if (verbose >= 2)
>>> +     if (verbosity == VERBOSE)
>>>               transport->verbose = 1;
>>> -     if (quiet)
>>> +     if (verbosity == QUIET)
>>>               transport->verbose = -1;
>>>       if (upload_pack)
>>>               set_option(TRANS_OPT_UPLOADPACK, upload_pack);
>>
>> In the original code, the variable verbose can be ">= 2" when "-v -v" is
>> given, so transport->verbose is not turned on with a single "-v" alone
>> (this correctly mimics the original behaviour in the scripted version).
>>
>
> Doesn't this also mean that we need to be able to concatenate
> multiple -v options in git-pull.sh similar to what one of the first
> versions of my patch did?
>
> <snip>
>

The next patch revision arriving here in a minute or two
will do the following in git-pull.sh:
1) if -q then verbosity=-q
2) if -v then verbosity=verbosity + -v

This means that git pull -v -q will reset verbosity to -q
and allow counting of -v instances. If this is not desired
or incorrect another change is needed :-).
