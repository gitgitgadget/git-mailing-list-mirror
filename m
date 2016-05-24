From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Tue, 24 May 2016 17:11:20 +0530
Message-ID: <CAFZEwPMmMEQMuT0+ap00e5UgccDfYZ75qbovRL_d8qWZ0_2XWw@mail.gmail.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7feka8kk.fsf@gitster.mtv.corp.google.com>
	<vpq1t4rri2a.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 24 13:41:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5AiF-0000MP-4J
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 13:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbcEXLlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 07:41:22 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35205 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbcEXLlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 07:41:21 -0400
Received: by mail-yw0-f169.google.com with SMTP id o16so12684171ywd.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=fNxBN0ONqkFdjBvhpSuylDy37aZH/J4vA3DApz2eTWY=;
        b=s7Vt/IaRf8K9djaqxNeQaDNKGNGcVMdF1G06e81E/sADV32kHBTnFVEKujr5FEu9+B
         efGjhVpqtvUla9xG4TmEU/zlVpdwz/qLTI6OpCrB7ErnkElc12FB+bQPv3CvarCCk+tR
         KxKYSecFVcthTpbuLiG2jk2Nb411yHOlctVNNWaBrKzt++FwwezwguQIKegyIKVE/nei
         vYjq3yMWMdCsbk7Cr1hRN/Lwiks8asXuqKUbhwqz3/I2+uFX8qZEcul6Ed1K9nYbQHSq
         NvREKDomp4DGQs/4SnTNavfSZU7SnjOYkelM+qBF1UwnQjTEMZaRc6eTd4p4zG/SwXSA
         BPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fNxBN0ONqkFdjBvhpSuylDy37aZH/J4vA3DApz2eTWY=;
        b=MJp9/xUl2LZrSiPGh7vtv1IcJVhxOr1lgjCb8FtxiinPElhXyjaa4f/ohhM+E/16Gr
         7QvQ1sgg3s3WZgn8lReE9rsWTH8lJFTdfwcp4N6mxZ7OoS6MnZ0xsHDPGALh5IyIJnGH
         8WJgbB/UpfasUSXAYNcfn2f3z+Z+QTDlart71/SMBKtQ0hwNClhKLOWuJdst3z1hymR/
         V6UmzRzmVyl5J1+jgZ14QRhZzO2Ma6tJWhMXwKwJX8GgsJ++7gNQx8l87IxPadcC9IV/
         XwhTcGORoc0WPvp8Rijc378sCWHpdBcsVBnhQXxOoZq3NrXbQkhnQJ95JaToXpdcIuJx
         OUSg==
X-Gm-Message-State: ALyK8tJfdNAOI8DzVJeiB8RClTtn1Y3i+V8MKFc/ItJ0KRb/DEl3vqKcleSzkUggPemrEJdbdA+6svYYJlnIQg==
X-Received: by 10.37.217.14 with SMTP id q14mr2106920ybg.53.1464090080442;
 Tue, 24 May 2016 04:41:20 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Tue, 24 May 2016 04:41:20 -0700 (PDT)
In-Reply-To: <vpq1t4rri2a.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295488>

Hey Matthieu,

On Tue, May 24, 2016 at 1:41 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>>  static const char *use_message_buffer;
>>> -static const char commit_editmsg[] = "COMMIT_EDITMSG";
>>> +static const char commit_editmsg_path[] = git_path_commit_editmsg();
>>
>> The function defined with the macro looks like
>>
>>       const char *git_path_commit_editmsg(void)
>>         {
>>               static char *ret;
>>                 if (!ret)
>>                       ret = git_pathdup("COMMIT_EDITMSG");
>>               return ret;
>>       }
>>
>> so receiving its result to "const char v[]" looks somewhat
>> suspicious.
>>
>> More importantly, when is this function evaluated and returned value
>> used to fill commit_editmsg_path[]?
>
> I may have missed something, but I'd say "never", as the code is not
> compilable at least with my gcc:
>
> builtin/commit.c:98:1: error: invalid initializer
>  static const char commit_editmsg_path[] = git_path_commit_editmsg();
>  ^
>
> AFAIK, initializing a global variable with a function call is allowed in
> C++, but not in C.

I wasn't aware of this fact. Thanks.

> And indeed, this construct is a huge source of trouble, as it would mean
> that git_path_commit_editmsg() is called 1) unconditionnally, and 2)
> before entering main().
>
> 1) means that the function call is made even when git is called for
> another command. This is terrible for the startup time: if all git
> commands have a not-totally-immediate initializer, then all commands
> would need to run the initializers for all other commands. 2) means it's
> a nightmare to debug, as you can hardly predict when the code will be
> executed.

Yes I agree that this approach will definitely cause a lot of
problems. I will re-roll with how Junio suggested.

> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
