From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 2/3] submodule: implement `module-name` as a builtin helper
Date: Tue, 1 Sep 2015 09:18:53 -0700
Message-ID: <CAGZ79kYAEic2kNmK10xB5g2JArpyqcqxNWjTBUkx6DfG3a_zpg@mail.gmail.com>
References: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
	<1441068029-19158-1-git-send-email-sbeller@google.com>
	<1441068029-19158-3-git-send-email-sbeller@google.com>
	<CAPig+cTTiW_tZBNoz-kj6CkViR+MFegv1Tz5xmVvbGxZ0pbqwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:19:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWoGy-0005Xj-43
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 18:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbbIAQSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 12:18:55 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34967 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbIAQSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 12:18:54 -0400
Received: by qkcj187 with SMTP id j187so47964144qkc.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bq4x0+aivU+4+R1vQ0AAWlAn55fXOMG26Uee5czJC4o=;
        b=FfcRl5zfKaKIhdqCe85ZKXcuAsE8u6wq2IKyr/yns692OO/Ag4MDd23TLgd2T1oj/d
         +q2UVCOKarSO4FZj9Bqzj+Su9lQOMJUZRUuGWZXIEeabVRcxSCnYUrEXijto5rORo/Un
         g/hm0uQniGwdepOxb4FxoD5V68dS3I1hrQr4d+fQu9rvlNM/JIFiKZp0qvlRhtt1xs0z
         fI9liytiEMr+nQSMkW8h3N5WAjoRJWGKCevsXoJ7nqi6bi8BtH1P7VlpEtaNrl85H4dj
         I+FXufZqEBRQh5D10AADllkGVS5G78wDnSQ3Ac/wVG1uheTzmJ3gQVA+3mfpcHSHzV3e
         N75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bq4x0+aivU+4+R1vQ0AAWlAn55fXOMG26Uee5czJC4o=;
        b=QcqRUnt34LdsgHUcWD0aQGLSiDbDouFOJwGZU+O6E1crUXSRii0hCB6LLYi3VyhxQY
         pSC+NFjURe4Ir+Iose5BXIbSbJjLP+dXgsW16JqiDRZMngqP7FsSY4payG6on4dUJ6b8
         KW4DaXUgsDvxyO+gjovtDtTH4zmwy4OHncdd3sUrJfL1Qr2Xw9GxKaWpUKgX5zx1EJ9N
         wGrxnQQ+GvJ7F/iCVpZGTNCKK5tIpggWwcXkPb8ND2FSiQyV3MQjHCGj+Y9a73KvgWCZ
         rGvZ5e433gmfDqUWBEGIy5Tz8YBn3+uygYuiJmyx/oyvEM4D3bloIc/e3j1r1tavomsJ
         vhwQ==
X-Gm-Message-State: ALoCoQkd+1RuCP7wN5IraKOR5AYXM+3EU5WmQ7moyY9Nvcz4qffaIFAa5EcgPr/uDY4zQgFJOSSA
X-Received: by 10.129.124.2 with SMTP id x2mr29495770ywc.44.1441124333691;
 Tue, 01 Sep 2015 09:18:53 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Tue, 1 Sep 2015 09:18:53 -0700 (PDT)
In-Reply-To: <CAPig+cTTiW_tZBNoz-kj6CkViR+MFegv1Tz5xmVvbGxZ0pbqwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276987>

On Mon, Aug 31, 2015 at 7:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 31, 2015 at 8:40 PM, Stefan Beller <sbeller@google.com> wrote:
>> This implements the helper `module_name` in C instead of shell,
>> yielding a nice performance boost.
>>
>> Before this patch, I measured a time (best out of three):
>>
>>   $ time ./t7400-submodule-basic.sh  >/dev/null
>>     real        0m11.066s
>>     user        0m3.348s
>>     sys 0m8.534s
>>
>> With this patch applied I measured (also best out of three)
>>
>>   $ time ./t7400-submodule-basic.sh  >/dev/null
>>     real        0m10.063s
>>     user        0m3.044s
>>     sys 0m7.487s
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 44310f5..91bd420 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -102,16 +105,38 @@ static int module_list(int argc, const char **argv, const char *prefix)
>> +static int module_name(int argc, const char **argv, const char *prefix)
>> +{
>> +       const struct submodule *sub;
>> +
>> +       if (argc != 1)
>> +               usage("git submodule--helper module_name <path>\n");
>
> usage(_("..."));
>
> s/module_name/module-name/
>
> I think you also need to drop the newline from the usage() argument.
>
>> +       gitmodules_config();
>> +       sub = submodule_from_path(null_sha1, argv[0]);
>> +
>> +       if (!sub)
>> +               die(N_("No submodule mapping found in .gitmodules for path '%s'"),
>> +                   argv[0]);
>> +
>> +       printf("%s\n", sub->name);
>> +
>> +       return 0;
>> +}
>> +
>>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>>  {
>>         if (argc < 2)
>>                 die(N_("fatal: submodule--helper subcommand must be called with "
>> -                      "a subcommand, which is module-list\n"));
>> +                      "a subcommand, which are module-list, module-name\n"));
>
> Manually maintaining this list is likely to become a maintenance issue
> pretty quickly. Isn't there an OPT_CMDMODE for this sort of thing?

If we were using OPT_CMDMODE, we'd need to have all the options in
one array, passing it to the option parser. I don't think we could have
2 layers of option parsing here. If the first layer only contains the
check for argv[1] (list, name, clone), then it would fail not knowing the
arguments for each of these sub commands.

If we parse all the options together, then we would need to have lots of

 if (cmd == name)
    die ("it makes no sense to give --reference or --depth");

also the variables where the options are passed into would not be
function specific, but file global.

>
> Also, it would like be more readable if the possible commands were
> printed one per line rather than all squashed together.
>
>>         if (!strcmp(argv[1], "module-list"))
>>                 return module_list(argc - 1, argv + 1, prefix);
>>
>> +       if (!strcmp(argv[1], "module-name"))
>> +               return module_name(argc - 2, argv + 2, prefix);
>> +
>>         die(N_("fatal: '%s' is not a valid submodule--helper subcommand, "
>> -              "which is module-list\n"),
>> +              "which are module-list, module-name\n"),
>
> And, it's duplicated here, making it even more of a maintenance problem.
>
>>             argv[1]);
>>  }

Maybe we can do it similar to git.c to have our own array with name
and function pointers,
which can be used both in the help text as well as the actual function call.
