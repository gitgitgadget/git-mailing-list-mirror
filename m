From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Sat, 16 May 2015 16:32:38 -0700
Message-ID: <xmqqoalkdrop.fsf@gitster.dls.corp.google.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
	<xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
	<CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
	<xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
	<CACRoPnSbekLANNiGOyxN70TCUd1c=wcrU_6Gfew5pp5EBpSEsA@mail.gmail.com>
	<xmqq7fs9hekc.fsf@gitster.dls.corp.google.com>
	<CACRoPnSP9xfyW47ZqU7QO5o4tyzROh4hGRPqG9g9OB5cquS+uw@mail.gmail.com>
	<xmqq617sfj05.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 01:32:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtlZV-0006Fg-1Y
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 01:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbbEPXck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 19:32:40 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37299 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbbEPXck (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 19:32:40 -0400
Received: by igbsb11 with SMTP id sb11so23792476igb.0
        for <git@vger.kernel.org>; Sat, 16 May 2015 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y43Q0dbmzv+qCUvSbpkzcOru3+90qlCvWW/w6H/2fSs=;
        b=QtD6Tld+diTbWxWRkLSW7ArucdBIhuKsLiBfeM0j4XSCQiiuruANlOpx43E0ELa/gZ
         xUsSant1NNVOjB4QjQa+6r7yiQVqPW0YFfwv/cNm9Q2wlQZxwmAsr845QvKNUmolBY58
         ft4IP/bnrTkl49WQOLaoHeyEgHaKXsXeO+SmCqIeflovwJNvF/VowBVDxL61Vyy1P3yJ
         CtNgZpzeKJRYrj/I+zFzm8yZCZFN/sVl2rCc4jMbX90DJAxrBoxOepKdZ6ljXALeogtD
         w4qRk+yxTKqVcskuwFtvHnT3JvTfHyUUs7hTRVHZ/6WTtu5DTSk1+K0kje2JGKStWAJ+
         KsxA==
X-Received: by 10.50.61.234 with SMTP id t10mr6431066igr.19.1431819159575;
        Sat, 16 May 2015 16:32:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1b0:922b:6b11:b020])
        by mx.google.com with ESMTPSA id j4sm2356357igo.0.2015.05.16.16.32.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 16 May 2015 16:32:38 -0700 (PDT)
In-Reply-To: <xmqq617sfj05.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 16 May 2015 11:57:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269204>

Junio C Hamano <gitster@pobox.com> writes:

> Paul Tan <pyokagan@gmail.com> writes:
>
>> So the first example would be:
>>
>>     test_output "git show HEAD:file2" new
>
> Simple things like that look fine, but when a variable is involved,
> use of eval combined with the fact that the test body is inside sq,
> makes the callers unnecessarily ugly.
>
> 	test_expect_success 'some title' '
> 		var=$(...) &&
> 		test_output "git show \$var:file2 | sed -e \"s/$old/$new/\"" new
> 	'
>
> Which is the concern this shares with the other one I sent about
> counting the number of lines in the output from a command that made
> me hesitate to suggest it.
>
> So I dunno.

I actually think that "test" that compares output from command and a
constant string, and "test" that compares outputs from two commands
are lazyily written forms of these:

        echo constant string >expect &&
	command >actual &&
        test_cmp expect actual

	command1 >expect &&
        command2 >actual &&
        test_cmp expect actual

The examples you gave in the earlier message were

>
>      test new = "$(git show HEAD:file2)"
>
> or these:
>
>      test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
>

and I suspect they match my observation.

My earlier test_output_count was probably in the same "lazy"
category.  "test $(command | wc -l) = 20" is better written
as

	command >output &&
        test_line_count = 20 output

instead of using the hypothetical

	test_output_count = 20 "command"

that evals the command argument, not only because the quoting of
'command part will become complex for real world uses, but because
the output itself would be the first thing we would want to inspect
once the command fails.  For that reason, I'd rather not to add the
test_output_count I suggested earlier, so that we would encourage
the more straight-forward form, i.e.

	command >output &&
        test_line_count = 20 output

to be used.
