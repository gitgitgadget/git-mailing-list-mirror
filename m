From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv9 0/6] Expose submodule parallelism to the user
Date: Tue, 9 Feb 2016 13:46:59 -0800
Message-ID: <CAGZ79kYt9bw9MreiBhA_ZQNjS+1Xi71aNGwkjcfC1hwxkOoyYA@mail.gmail.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<xmqq4mdh36o8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:47:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTG7m-0002eW-DT
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 22:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050AbcBIVrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 16:47:00 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33751 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388AbcBIVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 16:47:00 -0500
Received: by mail-io0-f182.google.com with SMTP id f81so2045664iof.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6MsqH/wAzQks0QAn5wdSO7XAH5Q38Hx8mQzfqbc5J7E=;
        b=kAz89/VzFFLrMEA67t652g65nAcI8RCFlvlmReYGg64W8fwU8d7YnTpNVot7tXJ1Oe
         DLjescSwnSznFsZij63VxhEzUiy7iplLlBWoMqjABcS9npoUXOROK0YUma+RE3RGkorZ
         A9lfDC7hGO00dGAWVJM4zj4baA4uRKtmOBKbFXYSeBLdupX52k9fMWz46BnPRvyhmOBo
         eNIpqlA0HxNkRZiOIEtdWePSTW3fF2DrCVIss9PZ1Ev/TvpW8vsTn8NaOKWyPVvBFeiy
         b/tyOlm5iaE3yir/hWTQAoMiiAcTL+zYY6kbdyx5toruPHVhWnrVUuwKP8EzPd/8cJVv
         1KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6MsqH/wAzQks0QAn5wdSO7XAH5Q38Hx8mQzfqbc5J7E=;
        b=Dv5FULz53LCaz2Hs4FDglfDeuh27J0rxt6HrTUhSXijZzkIgqpid8J24Dl8VH4OwqP
         5mMIGHBmtiGrjz+CZf5wJAosuKhKxaeKSCPTsma3EF2fl8A3VEKlraNuxVOtLMAPAG7z
         4gvn5DC2uAxCviP8ZP+GW3NKa/T918uk7T5cyFKdOXbMsDoG9twRsxw2i+uxGqfa8J3M
         XKORQkUQIKv/Xr0Y0vNHdoD7LLdRI6MWd9/R9mwPkEdX97G53IUwnfDHmN1ZNxw/CalG
         Idx3QYUNqwQrKt8YsrkvagQ3gsel/cRa5D1uaJJxHOs+X+rw328HHSxL+d/r6f5J8gIP
         0qDQ==
X-Gm-Message-State: AG10YOTbTTVDtb8aGA1RmqFPM15xHyMaJ+4Xg3vCLeJYBpr+FqyPFVnqLrgwG6aBUR1HqHsivLbVRCj75E+w9cAQ
X-Received: by 10.107.168.149 with SMTP id e21mr34837271ioj.96.1455054419317;
 Tue, 09 Feb 2016 13:46:59 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 9 Feb 2016 13:46:59 -0800 (PST)
In-Reply-To: <xmqq4mdh36o8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285871>

On Tue, Feb 9, 2016 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This replaces sb/submodule-parallel-update.
>> (which is based on sb/submodule-parallel-fetch)
>>
>> Thanks to Junio and Jonathan for review!
>>
>> * s/config_parallel_submodules/parallel_submodules/ as it is not in config any
>>   more. Also ease up the default setting.
>>
>> * use an enum for submodule update strategy
>
> Your earlier sb/submodule-init will need to be rerolled on top, as
> it depends on ->update being a string, I think.

Sure, I just want to prioritize this series as it is the bottleneck for all
other following things (init as well as the groups thing), I think.

>
>> * This seems to clash with 00/20] refs backend.
>>> Applied this on top of a merge between the current 'master' and
>>> 'sb/submodule-parallel-update' topic to untangle the dependency;
>>> otherwise there is no way for this topic to make progress X-<.
>>
>> Anything I can do to help with easing the clash?
>
> Perhaps try to rebase the series on top of such a merge (with this
> updated series) yourself and propose it as a basis for the next
> reroll for David?  In short, working together with topic(s) that
> touch the same area?

Ok, I'll see if I can find a better commit to base this series on.

>
> Thanks.
