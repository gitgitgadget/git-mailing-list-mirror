From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/5] submodule: implement `module_clone` as a builtin helper
Date: Thu, 27 Aug 2015 14:57:45 -0700
Message-ID: <CAGZ79kaDT5P_LgELhCA+TWc+caCFpZDcQYsDcjW0vVquXfj3HQ@mail.gmail.com>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
	<1440636766-12738-2-git-send-email-sbeller@google.com>
	<92ffde8a07de2a4d50f79ecb7350dbb3@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:57:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV5B8-0006sB-NN
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 23:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbbH0V5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 17:57:46 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33257 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbbH0V5q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 17:57:46 -0400
Received: by ykll84 with SMTP id l84so35440677ykl.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1uaAcbenvOAhF2YPwgmqBxoNzXuXCc2YHi37meOSDYQ=;
        b=UoCb/fOTa3GIh+Le5zT9qT5SfWiVfP19T4ryn1iE9t5ZXAOOK72i0uQVTcSricuWyl
         jwl+qWZewZSRHN0dHywO1JrItrnfm6a7A4CsptzM7ION8u3Q8B99xKNP230a4kaL5q0c
         s83qkq9nB5sZEXl/MUlpskHvU8mAxtgYDg27Nj2mVeCDxpfYQSaWtZVaZ6mMk+hWmZrd
         6oy03spCteLivrEreVqtAEsnC4GdiMKXj8tlsISCYnsm4jyXfis9s/3AG5BOsnWldu1E
         CNwLWOAWKxz+ibvekXJ2PQMOgHLeL0bD/o6LUUyM9K9HZX0008TyyPMRIRVXPygM5Og3
         g97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1uaAcbenvOAhF2YPwgmqBxoNzXuXCc2YHi37meOSDYQ=;
        b=Bmy94o6QFF2hfyCpCIx1KR0+EsndDPniUXseX2qnPiI27wvU5ER9nhjH5WEv59/IqA
         BBkLTpoUsrtQ7nr4tlNywyTLrWR0QRfpJRxbpbMhAZEYZIqZtychvUb1eCQCSSGKoA6A
         fdNQ2NRMPaDtmOtsVVyQloPz3/HJNwHH5JWG2wLd+GIdtL1cHBj/Cmde/OwLxBeTByYG
         Hirp9VNU1xYzofjsPKiRF2kbqLBfDEx3s6r1F5GCV2yQTkwCll/8Y1x6fzICwY8I7O+9
         BVThV9x81/p/dcO53n/KhLbUuyPAqNXUmfrunJXQcZrAyBFfvEeICUdFPB+BdTzossc3
         2/qA==
X-Gm-Message-State: ALoCoQk65pmdhmdpoaciZguqlLiEL5Uy4Oi+ujwXw1p8HcAtDlNv9FzVe3ua1rBkTjtfJfkHm7c9
X-Received: by 10.129.101.7 with SMTP id z7mr5219901ywb.81.1440712665373; Thu,
 27 Aug 2015 14:57:45 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Thu, 27 Aug 2015 14:57:45 -0700 (PDT)
In-Reply-To: <92ffde8a07de2a4d50f79ecb7350dbb3@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276688>

On Thu, Aug 27, 2015 at 5:36 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Stefan,
>
> thank you so much for doing this. `git submodule` is really, really slow on Windows...
>
> On 2015-08-27 02:52, Stefan Beller wrote:
>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 4b32a3c..f11fb9c 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> [...]
>> +
>> +/*
>> + * Clone a submodule
>> + *
>> + * $1 = submodule path
>> + * $2 = submodule name
>> + * $3 = URL to clone
>> + * $4 = reference repository to reuse (empty for independent)
>> + * $5 = depth argument for shallow clones (empty for deep)
>
> I think this description is now safely obsolete and can be deleted: you introduced explicit options like --depth to avoid the "magic" of positional parameters.

ok I'll remove that in a reroll.

>
>> +static int module_clone(int argc, const char **argv, const char *prefix)
>> +{
>> +     const char *path = NULL, *name = NULL, *url = NULL, *reference =
>> NULL, *depth = NULL;
>
> This line is a little long ;-)

fixed in reroll.

>
>> @@ -135,6 +290,9 @@ int cmd_submodule__helper(int argc, const char
>> **argv, const char *prefix)
>>       if (!strcmp(argv[1], "module_name"))
>>               return module_name(argc - 2, argv + 2, prefix);
>>
>> +     if (!strcmp(argv[1], "module_clone"))
>> +             return module_clone(argc - 1, argv + 1, prefix);
>> +
>>  usage:
>> -     usage("git submodule--helper [module_list module_name]\n");
>> +     usage("git submodule--helper [module_list module_name module_clone]\n");
>
> Was the convention not to use ( ... | ... | ... )?

git tag puts it as
    usage: git tag [-a | -s | -u <key-id>]

I looked at other --helper (git-difftool--helper which has no help to
be invoced on the command line
and git-bisect--helper which doesn't have the problem as the help is clear).

So I'll go with [brackets | separated | by | pipes | inside ] then,
just as git-tag.

>
> Thanks,
> Dscho
