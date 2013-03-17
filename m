From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] combine-diff: coalesce lost lines optimally
Date: Sun, 17 Mar 2013 21:37:09 +0100
Message-ID: <CALWbr2yfgA8kvtn4yxzPD5cencAPmwMqx=A6n4ohsjdzfAE1bQ@mail.gmail.com>
References: <7vboalw6lt.fsf@alter.siamese.dyndns.org>
	<1363525436-21667-1-git-send-email-apelisse@gmail.com>
	<7vhak9rdne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 21:37:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHKL2-0000hh-LC
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 21:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632Ab3CQUhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 16:37:11 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:59196 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab3CQUhK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 16:37:10 -0400
Received: by mail-qc0-f179.google.com with SMTP id b40so2422459qcq.38
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=x7SoGQ6n4PFpLWwQ4SQIUM4GgZkDijjIJ6HCPp8XIWM=;
        b=spdr8x/sCgurgj9/2ISljWGdelIvWgWEJhvXII2OEoq1QpZTFH7wnqRdV0tKyA9dpP
         DUTpJIt/J2iZeSCuNIz+7zpmsnM2ryAoIWWwjNUpkFVKIR2jkfZ8NA+EEhDtlzJ8BxX9
         N5zmAEWbhqNHPHBt/Fk1KNQkZFUNs4+zwADo/Edx9uHPE0gSqj5BRY8rOMApUxN10ion
         lxRI5wjfheOauUsIz5lAjqXs/aUTzeBXoyuEHKzvUPSulmmJP4ooUG8fBy4sodIumONs
         VgAes52y5qtjuAqdC19mV0pc8ZM8415DPkKlprCYEDMYIw15zpCj0Vm2dWdhKYFAvGdj
         SnTA==
X-Received: by 10.229.118.158 with SMTP id v30mr3071977qcq.52.1363552629872;
 Sun, 17 Mar 2013 13:37:09 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sun, 17 Mar 2013 13:37:09 -0700 (PDT)
In-Reply-To: <7vhak9rdne.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218373>

Hopefully, my patch takes about the same time as git 1.7.9.5 and
produces the same output on that commit ;)
Unfortunately on a commit that would remove A LOT of lines (10000)
from 7 parents, the times goes from 0.01s to 1.5s... I'm pretty sure
that scenario is quite uncommon though.

On Sun, Mar 17, 2013 at 9:10 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> This replaces the greedy implementation to coalesce lost lines by us=
ing
>> dynamic programming to find the Longest Common Subsequence.
>>
>> The O(n=C2=B2) time complexity is obviously bigger than previous
>> implementation but it can produce shorter diff results (and most lik=
ely
>> easier to read).
>>
>> List of lost lines is now doubly-linked because we reverse-read it w=
hen
>> reading the direction matrix.
>>
>> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
>> ---
>> Hi,
>> This is a very first draft for improving the way we coalesce lost
>> lines. It has only been tested with the two scenarios below.
>>
>> What is left to do:
>> - Test it more extensively
>> - Had some tests scenarios
>>
>> I'm also having a hard time trying it with more than two parents. Ho=
w I
>> am supposed to have more than two parents while octopus merge refuse=
s if
>> there are conflicts ?
>
> 9fdb62af92c7 ([ACPI] merge 3549 4320 4485 4588 4980 5483 5651 acpica
> asus fops pnpacpi branches into release, 2006-01-24) is one of the
> amusing examples ;-)  Cf.
>
>     http://thread.gmane.org/gmane.comp.version-control.git/15486
