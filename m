Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA66120756
	for <e@80x24.org>; Tue, 10 Jan 2017 17:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936939AbdAJRJi (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 12:09:38 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34541 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755547AbdAJRJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 12:09:36 -0500
Received: by mail-qt0-f178.google.com with SMTP id l7so122487830qtd.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=KSX7Df/1qsQXNI4Isg/ZsIDnA5VNvI2eU+tIsK8Xuzg=;
        b=re3CxAgpS0NXSPJwQBj07azfci1AyWutqL9W0lUX74uPE+8YSCqcb2uRVg9K3w9YmA
         IUbpYduRPYo7LW+f/9QilpEdAURgMKkHiavDvrQeu1c/zG9sVG8LdQanN/kXwM9JXDf8
         5CgQlpWXqyutIeebwDfX0YyX64jgq5k5UQM5w10gtMzugysJGDzJK9LtnSWblXLFUZ2S
         y6wRUlD1K12LXmSXleSG61G5biLMghGJYCcyiFFs91EjSDDv7qmZ0MJILl+Oov5XsIHL
         cOQf1Aaov38gV2F9Vx36MyD8Le4CkEb0o9P/FMV8b8tKUan1OEqiHlD2+o4x5+tzoUsR
         INgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=KSX7Df/1qsQXNI4Isg/ZsIDnA5VNvI2eU+tIsK8Xuzg=;
        b=RupHkIhF4Kb97YGiGxT+CvACEqSQresNP7p87sWdC+dSB0b6nY4q74g7jvEc2Z5N+g
         jX5I5CbXVnKs9dSqNZRsf9aQI5Gowdgg1IS+ZqFRumwxRgrQDH+OXdqzgf4zmohmLFxJ
         tYoNgTcrHKjAynLNz1Vxw+bj739dJ9Nj5brR6SvKmoY8/2xMAQ/OOcUBhyPkboEqyGOu
         LPhIYvpBCnpNFI8g9Yxu7KA35dFfA5rIbNrSEyhYYJ2M/0XD6vN9qYAvz6o0K/aGKLu8
         XbntqNjtH6hAru3fmZsdMDazDRZybBxk4+ivqAEIFKgq7HUkx7aUe8L14Ah6H6y90yTH
         xhHw==
X-Gm-Message-State: AIkVDXK4NS7ciULivT8ByjGPv/gNbfFkhlCsy6MtnjNyeojy1oiXjCHAXGYEpDD2qALSo17v
X-Received: by 10.200.37.199 with SMTP id f7mr3020090qtf.186.1484068175422;
        Tue, 10 Jan 2017 09:09:35 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([2620:0:1004:2:c4d:bcd2:8be8:b9f6])
        by smtp.gmail.com with ESMTPSA id 5sm1822323qts.47.2017.01.10.09.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 09:09:34 -0800 (PST)
Subject: Re: [PATCH v4 14/14] mergetool: fix running in subdir when rerere
 enabled
To:     Johannes Sixt <j6t@kdbg.org>
References: <20170109054238.42599-1-hansenr@google.com>
 <20170109232941.43637-1-hansenr@google.com>
 <20170109232941.43637-15-hansenr@google.com>
 <3a09e318-f14b-5f14-a992-3bd045f0a4c6@kdbg.org>
Cc:     git@vger.kernel.org, davvid@gmail.com, sbeller@google.com,
        simon@ruderich.org, gitster@pobox.com
From:   Richard Hansen <hansenr@google.com>
Message-ID: <10bd75ad-15d6-5694-bdf1-6b820d0b3201@google.com>
Date:   Tue, 10 Jan 2017 12:09:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <3a09e318-f14b-5f14-a992-3bd045f0a4c6@kdbg.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a1140605270e1440545c08cae"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1140605270e1440545c08cae
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2017-01-10 01:17, Johannes Sixt wrote:
> Am 10.01.2017 um 00:29 schrieb Richard Hansen:
>> The pathnames output by the 'git rerere remaining' command are
>> relative to the top-level directory but the 'git diff --name-only'
>> command expects its pathname arguments to be relative to the current
>> working directory.  Run cd_to_toplevel before running 'git diff
>> --name-only' and adjust any relative pathnames so that 'git mergetool'
>> does not fail when run from a subdirectory with rerere enabled.
>>
>> This fixes a regression introduced in
>> 57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).
>>
>> Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Richard Hansen <hansenr@google.com>
>> ---
>>  git-mergetool.sh     | 16 ++++++++++++++--
>>  t/t7610-mergetool.sh |  7 ++++++-
>>  2 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-mergetool.sh b/git-mergetool.sh
>> index b506896dc..cba6bbd05 100755
>> --- a/git-mergetool.sh
>> +++ b/git-mergetool.sh
>> @@ -454,6 +454,15 @@ main () {
>>      merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
>>      merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
>>
>> +    prefix=$(git rev-parse --show-prefix) || exit 1
>> +    cd_to_toplevel
>> +
>> +    if test -n "$orderfile"
>> +    then
>> +        orderfile=$(git rev-parse --prefix "$prefix" -- "$orderfile") || exit 1
>> +        orderfile=$(printf %s\\n "$orderfile" | sed -e 1d)
>
> Is the purpose of this complication only to detect errors of the git
> invocation?

Yes.  I've been burned so many times by the shell not stopping when 
there's an error that I always like to do things one step at a time with 
error checking, even if it is less efficient.

> IMHO, we could dispense with that, but others might
> disagree. I am arguing because this adds yet another process; but it is
> only paid when -O is used, so...
>
>> +    fi
>> +
>>      if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
>>      then
>>          set -- $(git rerere remaining)
>> @@ -461,14 +470,17 @@ main () {
>>          then
>>              print_noop_and_exit
>>          fi
>> +    elif test $# -ge 0
>> +    then
>> +        files_quoted=$(git rev-parse --sq --prefix "$prefix" -- "$@") || exit 1
>> +        eval "set -- $files_quoted"
>
> BTW, the --sq and eval business is not required here. At this point,
> $IFS = $'\n',

Whoa, really?  That's surprising and feels wrong.

(BTW, I just noticed that guess_merge_tool sets IFS to a space without 
resetting it afterward.  That function is always run in a subshell so 
there's no problem at the moment, but it's still a bit risky.)

> so
>
>         set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")
>
> will do. (Except that it would not detect errors.)

I think I would prefer to leave it as-is in case IFS is ever changed 
back to the default.

>
>> +        shift
>>      fi
>
> As I don't see anything wrong with what you have written, these comments
> alone do not warrant another re-roll.

I'll reroll if I hear other votes in favor of changing.  Thanks for 
reviewing!

-Richard

>
> -- Hannes
>


--001a1140605270e1440545c08cae
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6QYJKoZIhvcNAQcCoIIS2jCCEtYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBPMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNtaW1lY2Ex
LmNydDAdBgNVHQ4EFgQUbPFPDSp3rGDbNu3Pb8jJO+QTw0AwHwYDVR0jBBgwFoAUyzgSsMeZwHiS
jLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIFoDAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAG7GEcPrcRoMakd1
k8cdl7NUgGsEGoTzcS1ASh1ZaKlEzGR0uHyB7QwpX1hSHCvUKMRAqe5vXqZWhVhiPNPc0792yPHo
K+K5sV1W+pF66TlYY/9qlz0IDyKlMRKyCkc77PdrXubuJjauu2WGnbDpHvVwLTqwwlR5O0OLig48
m4YUSo869xADdrGrWJ7KzroFbucLZYh3niIjVICp7fh9wtLgbX7X/akdubehYhy/l+AIMml6Zlyu
GNGCGIleyQ0bAdjjG+dKrDErUlui8wd/YplvelaTAzSvNpxcrr+2YB8UBWcYkgULkp5GDCC2guKl
rMF1mTS6N6GMxUi30sZicbMxggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxAgwvfEOc
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFDYUCYcvhvJ6uHUc0rC
rOifKqh6eg9W+8GaoK63GZ+wMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDExMDE3MDkzNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCFLTpl156UHgsCRylWwwerVcoUnBhJ5ieYCIou
8PcZ/DncMLERXZwQ91rFgyTPsWuGHpagPBJnMrMy8uaOINOeiyDlioMytXAY5oAMRbXvTKvjVxwD
3fXjzab9emLA2Mszf3FsS+myIrc/ABV23/Nj+mwOBOrRlH+PoyFzsGhZMBr7n0FWMezlx7YndpyT
PWrMjhpTDyImAXxsUYtbgCNCvEXLZXcwcaeVlwRziZQmDiiqy84i9se2vJbt863E6hlOO1brZs9o
RBi2P+snNyaQSYI+3JqcSiZdMVrEmFxQfueWp9gyeJ8CMY93pjjd4uIwOtvOxHQpWtePxQgg7paV
--001a1140605270e1440545c08cae--
