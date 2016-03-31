From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] submodule--helper clone: simplify path check
Date: Thu, 31 Mar 2016 13:04:32 -0400
Message-ID: <CAPig+cRq3CoE1mH9=TeKnujQYVb0+tURpYNSsRKtnK_FTDyBAQ@mail.gmail.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-3-git-send-email-sbeller@google.com>
	<xmqqlh4yppsq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Norio Nomura <norio.nomura@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:04:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alg1P-0000Ed-NS
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbcCaREe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:04:34 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35984 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465AbcCaREd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:04:33 -0400
Received: by mail-vk0-f68.google.com with SMTP id z68so12320658vkg.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=qjDDkf6Sz+7oza/UBNxhCRUaaqLqzWEvO22FEsLN1Rk=;
        b=Y3K1sy9QEuegQNcEFeMdK3S6gPyGuHF/Cyk8KRFHDUPoH7qhq8p8neH2d5xDapIXB9
         niaze+6o1UhHpF2cUk+TjR0a9/ikgYvDVMbFOu2S9hd9TfIDJmGnaeo2+rhrQlQCBCKH
         hysz/hU24/OCjcce2aRB1ev3D8yuDInjiuSVwlkFP04ZOw+74qvrvjsH7IxxoR7xGRs1
         /LL+HsHZj/54DUvLf4JG5Trrs4Co0Af7jwQRW5rhu1orsoamBM/Cnh+4ahpLs2pjQIJX
         iXG80KxhLvcWTHPIWvrWYzMm5So1GECGuZlpS1IPXOIPpHXOqBBwR5mqjHo0BexHfL4R
         1s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qjDDkf6Sz+7oza/UBNxhCRUaaqLqzWEvO22FEsLN1Rk=;
        b=kmmoBzkvCnwsgqi8OqzvKWQ65B1BrQGjmL0do8ui8ZeA35gMQkDeHSvjd1rJxpYG3H
         Zj3CBVobe0XFULEuHva7lkVE1QEIN3F+5kxMINCcvWPHW3E9SbLTfLyNyc3BKIS95+CC
         Pokr/slyVWQne0JQp+mIQ6nrE4eD/UYsPG5M1DXW6EW5hjPOIKnbK0EZEOx09Mlwh9G7
         BTzg4cOFyYJK1Q9BhJ/Tiusvc9P46MlDJA7qVQlUtrXvCmLc/CBIu88EobCz4VnvTNi0
         +xiS8Zet22e/gEPnOdlRVPU+NAFcry6TxHZCjss8JEQELcls9YiK4THAhn3TttbbJVCJ
         j45g==
X-Gm-Message-State: AD7BkJIHtzRw9oDkel6bQKZE2GXVJJMuGs6+GeztnN9RpQs0G7QpJMW9m70PpUf+NhIY9qD4j0rrPwhkYeCaVg==
X-Received: by 10.159.33.206 with SMTP id 72mr17675uac.14.1459443872533; Thu,
 31 Mar 2016 10:04:32 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 31 Mar 2016 10:04:32 -0700 (PDT)
In-Reply-To: <xmqqlh4yppsq.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: XTJ2ik5ybiHIwVe8-sRpLupAoF8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290421>

On Thu, Mar 31, 2016 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The calling shell code makes sure that `path` is non null and non empty.
>> (side note: it cannot be null as just three lines before it is passed
>> to safe_create_leading_directories_const which would crash as you feed
>> it null).
>
> This is not Java so let's spell that thing NULL.
>
> Perhaps it would be cheap-enough prudence to do this on top?
>
>         argc = parse_options(argc, argv, prefix, module_clone_options,
>                              git_submodule_helper_usage, 0);
>
> +       assert(path);

Hmm, from the user perspective, this is still a "crash", just as the
existing segfault is a crash. While one can argue that this is an
internal command only invoked in a controlled fashion, it's not hard
to imagine someone running it manually to understand its behavior or
to debug some problem. This function already presents proper error
messages for other problems it encounters, so it seems reasonable for
it do so for this problem, as well.

    if (!path || !*path)
        die(_("submodule--helper: unspecified or empty --path"));
