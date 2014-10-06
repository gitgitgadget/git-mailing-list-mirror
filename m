From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Tue, 07 Oct 2014 00:29:07 +0530
Message-ID: <5432E67B.8070604@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>	<xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>	<542DB2FE.609@gmail.com>	<xmqqmw9emdax.fsf@gitster.dls.corp.google.com>	<542DB711.9040503@gmail.com>	<xmqqiok2m494.fsf@gitster.dls.corp.google.com>	<vpqeguptz5k.fsf@anie.imag.fr>	<xmqq1tqpm2na.fsf@gitster.dls.corp.google.com>	<vpq4mvlgchj.fsf@anie.imag.fr> <xmqqeguolxow.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 06 20:59:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbDVB-00079A-4p
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 20:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbaJFS7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2014 14:59:14 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55185 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbaJFS7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2014 14:59:13 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so5711273pad.22
        for <git@vger.kernel.org>; Mon, 06 Oct 2014 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NXqPhexaMEIKgTgv/lpk7pySbDYyKcCY30gH8xAtn9A=;
        b=XJ0EG99XxoxyCpMrQpMKP80OYoedXcTY2hN5yv+GCNEUAMzDT5jAX6Ri7/oTnoaFC9
         wiLC7f4wBvefWslFrB4KYr4g3HHTtYbQUfYHWhi/I6zLvH7tMOaYe4BrHh7G9SOME6kb
         hTFfXzm1//SwtSsjofiVzN6FQ5kSMbA4cSZhvF2X9DBjRdVDH4gR7puWVgf+/tp7xqhs
         +J2YNbgM2Rp5OBXQKJea2DxBHlvNAG+cu8430wyW9CXVsK68v152FdILTRkW7RKFhqGv
         R8cwE5PbAPoeyj8z4k1kfRzeh+XzNhXLX4aGgn5X04w/UoMsvOS/yvLEiZRaNVKflkyT
         w7TA==
X-Received: by 10.66.254.136 with SMTP id ai8mr26080161pad.56.1412621952570;
        Mon, 06 Oct 2014 11:59:12 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.254.133])
        by mx.google.com with ESMTPSA id uj7sm14260016pac.4.2014.10.06.11.59.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 Oct 2014 11:59:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqeguolxow.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257915>

On 10/4/2014 1:42 AM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>>> Well, the normal use-case for unset.variable is to put it in a local
>>>> config file, to unset a variable set in another, lower-priority file.
>>>
>>> I agree that is one major use case.
>>>
>>>> This common use-case works with the command-line "git config", and it
>>>> would be a pity to forbid the common use-case because of a particular,
>>>> unusual case.
>>>
>>> Either you are being incoherent or I am not reading you right.  If
>>> you said "If this common use-case worked with the command-line 'git
>>> config', it would be nice, but it would be a pity because it does
>>> not", I would understand.
>>
>> I think you missed the "another" in my sentence above. The normal
>> use-case is to have foo.bar and unset.variable=foo.bar in different
>> files. In this case, you do not care about the position in file.
> 
> I didn't miss anything.  The reason you want to have "unset foo.bar"
> in your .git/config is to override a "foo.bar = z" you have in
> another place, e.g. ~/.gitconfig; which would let you sanely do
> another "foo.bar = x" in .git/config for multi-value foo.bar, *if*
> the unset comes before foo.bar.
> 
> But what if you have this in your .git/config file
> 
> 	[core]
> 		bare = false
>             ... standard stuff left by git init ...
> 	[foo]
>         	bar = x
> 
> before you add "unset foo.bar" there?
> 
> And that is not a contribed example.
> 
> The likely reason why you want to resort to "unset foo.bar" is that
> you found that you get an unwanted foo.bar=z in addition to desired
> foo.bar=z in a repository that has the above in .git/config, and at
> that point you would want to say "I want to unset the outside
> influence".
> 
> And there is no "[unset] variable = foo.bar" in there yet; without
> some special casing, if you treated unset.variable as if it were
> just another ordinary variable, it would go after you define your
> own foo.bar=x, which is not what you want.

I have made some conclusions after reading the whole thread,

1> Add some tests for this use case which seems the most appropriate
use case for this feature,

(Copied from Junio's mail)

    - Define "[xyzzy] frotz 1" in $HOME/.gitconfig (I think $HOME
      defaults to your trash directory).

    - Verify that "git config xyzzy.frotz" gives "1".

    - Define "[unset] variable = xyzzy.frotz" in .git/config (it is
      OK to use "git config unset.variable xyzzy.frotz" here).

    - Verify that "git config xyzzy.frotz" does not find anything.

    - Define "[xyzzy] frotz 2" in .git/config (again, it is OK to
      use "git config xyzzy.frotz 2" here).

    - Verify that "git config xyzzy.frotz" gives "2".

2> Leave the internal implementation as it is, as it helps in manually
writing unset.variable in its appropriate place by using an editor,
i.e this use case,

	[unset]
        	variable = ... nullify some /etc/gitconfig values ...
	[include]
        	path = ~/.gitcommon
	[unset]
		variable = ... nullify some ~/.gitcommon values ...
	[xyzzy]
		frotz = nitfol

3> Special case "unset.variable", so that git config unset.variable foo.baz
pastes it on the top of the file. The implementation should be trivial, but,
Junio had said in an earlier mail that he doesn't think this approach would
do much good.

Other than this approach, Junio had suggested to append it after the last mention
of "foo.baz", but I don't think if it would be worth it, but still I will cook up
the code for it.

4> Change the name to config.unset or something.

I will make the above changes in the next revision.

Thanks.
