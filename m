From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Thu, 14 Jan 2016 15:43:27 -0800
Message-ID: <CAGZ79kZZxoD=+GJVPOCuQK_oLqR-pOQw2QM98Yxx3XoGRMAXfQ@mail.gmail.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
	<xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka0rxYK7GRSjh13XOsg887EgqYtc5B60z9qU=tAoJGERQ@mail.gmail.com>
	<56980A14.1060605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 00:43:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrYD-0008Gc-Eb
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbcANXna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:43:30 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:36036 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203AbcANXn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:43:28 -0500
Received: by mail-io0-f170.google.com with SMTP id g73so276212588ioe.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P+w30Gom9XCNHauwVGOqNRLC5FqWjGltIJvFtKHbHek=;
        b=dNvmDlJPQljbEsIYHUiTZZqE3dJt8R9wpYEmYyZwLA4BZAqNjzUhjBBeBb7MpgK3/N
         4sQNSCbMAtuQAdkd8VXB4uWqXXS49uNG3joDqGKTvBWMMhbCtvJd8/2Q12aOodlUbTZx
         UcR73E/dBsddHU7yHnvCUVnvQGSw876d94o84PvaHPuqYNkzvKSKR02pdY6NdtFuUVlQ
         LbOfXtY8Yg0bQsW9oBf2XcCxlxuCdcJ1lHu/W61KRw6XhTASfI9yJ1o6GW513CyRh4jK
         sBb5nRpQU7HTzaGFcjjQ7nlgVyAE/D0J2F4NGiiQIxOaWR3TrYK5MhuQ8KXriqhjKusP
         0AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=P+w30Gom9XCNHauwVGOqNRLC5FqWjGltIJvFtKHbHek=;
        b=WDgy05+C7lKydkCHl/BSHoxG8obEDit+a61ENvrlDanwwb2yuBew6hgdXoEUrKf3s/
         /cXeDes9r242K1kvl5wj6X7/Js2l+x8L2XxF4rseqC503ZxFs9oqERt7uR+7ajF2gith
         pxdsqXkv5BjJF+PF2LFmrJOxNqNNRvT9h0bcC/fv9g9gzAiGLEQ5B3VBSNq943ZKjQlt
         eyXwXSIaQG0mXY/1g6nfkcOP44x4swxzP6T9+KIEAsYdwvr+sNg0lhVA+CecOp35mi+r
         QHAZac+IzVOVYh2xESrTP56aG35h1aCdbsm5wg/g7eJiZylniCQ9ZntjiOmptj3rumXd
         qYQA==
X-Gm-Message-State: ALoCoQndJAB/iVRezGVDCLIH2yJj7vH3LSWAviMSzo7luer7PiibPUSHx7kfcF+A+8612fPtaelVS71BHnSA4y9u2X8Nvx3jCCaA/JVfhaQkulW9SWsFKxQ=
X-Received: by 10.107.129.149 with SMTP id l21mr7156886ioi.174.1452815008021;
 Thu, 14 Jan 2016 15:43:28 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 14 Jan 2016 15:43:27 -0800 (PST)
In-Reply-To: <56980A14.1060605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284102>

On Thu, Jan 14, 2016 at 12:50 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 13.01.2016 um 23:47 schrieb Stefan Beller:
>>
>> On Wed, Jan 13, 2016 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> Later on we want to deprecate the `git submodule init` command and make
>>>> it implicit in other submodule commands.
>>>
>>>
>>> I doubt there is a concensus for "deprecate" part to warrant the use
>>> of "we want" here.  I tend to think that the latter half of the
>>> sentence is uncontroversial, i.e. it is a good idea to make other
>>> "submodule" subcommands internally call it when it makes sense, and
>>> also make knobs available to other commands like "clone" and
>>> possibly "checkout" so that the users do not have to do the
>>> "submodule init" as a separate step, though.
>>
>>
>> Maybe I need to rethink my strategy here and deliver a patch series
>> which includes a complete port of `submodule init`, and maybe even
>> options in checkout (and clone) to run `submodule init`. That way the
>> immediate benefit would be clear on why the series is a good idea.
>
>
> I think that makes lots of sense. It looks to me like clone already
> has that option (as --recurse-submodules must init the submodules),
> but it might make sense to add such an option to checkout to init
> (and then also update) all newly appearing submodules (just like
> "git submodule update" has the --init option for the same purpose).

The next series I'll send out will replace the shell part of `git
submodule init`
with a small wrapper for `git submodule--helper init` which will then have
the functionality to initialize submodules. I'll break that C code in a way
that we'll end up having a function like:

    void init_submodule(const char *path);

After that is donw, I'll try to call this from all the places which currently
do setup a child process for init or `update --init`.

>
>> The current wording is mostly arguing to Jens, how to do the submodule
>> groups thing later on, but skipping the immediate steps.
>
>
> I really believe that in the future a lot of users will hop on to the
> automatically-init-and-update-submodules train once we have it (and I
> think users of the groups feature want to be on that train by default).

Rereading old mail I wonder if we had a miss understanding on the groups
feature or rather the  automatically-init-submodules feature.

As far as I understand initializing git submodules, you can do it multiple times
without hurting yourself, i.e. an implementation of update could look like

update()
{
    auto-init-subs = { }
    if groups selected:
        auto-init-subs = {subs selected by groups}
    foreach uninitialized submodule:
        if submodule has set auto-init (in superprojects .gitmodule I'd guess)
            auto-init-subs += {that submodule}
    if auto-init-subs not empty:
        git submodule init <auto-init-subs>
    update-as-we-know-it
}

and then multiple calls to update() would not hurt.
That way we would not need to add any logic to the init sub command as my
first patch series had. There it was more like:

update()
{
    if groups selected:
        git submodule init --groups # have the logic inside of init
    update-as-we-know-it
}

I think I'll redo the groups patch series as the former now.

>
> But I also believe we'll have to support the old school init-manually
> and update-when-I-want-to use cases for a very long time, as lots of
> work flows are built around that.

Sure, the "submodule init" command is not going away. I just want to have
an easy way to access it from within C code, hence the rewrite effort.

Thanks,
Stefan
