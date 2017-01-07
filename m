Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27131FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 02:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940919AbdAGCQK (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 21:16:10 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34599 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940670AbdAGCQC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 21:16:02 -0500
Received: by mail-qk0-f181.google.com with SMTP id a20so93291948qkc.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 18:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=ne6DSNpsJZByeRFAG9jbcUVAbO8GA9lNSV6QkOc8+mY=;
        b=d9uoGRhxjCVbuSfiwsn8f0aCJLfIj3cyeSEp5DCrcFh/SO83FrT5TGn5IhcaoLYmes
         ny/Lf6IlZmAbX57exQPjYxQ/5FCD1wnrfp4obiIVjhB7LovVOL9V1k4r+odNkGg1ktp0
         lOkRGi4JM3lRI6rrFJL+Egkk+JwgXehdQhq0dXSStWmBOhCEAR4QvurJTBcMWuMO7cxv
         VPD+TtLPeYPmWSfznsiIMarGwkX02LdB3PLTojSFbK48bsAkP4E2LFZopfVoTLhhv+pw
         j89ZGcp0tofBR70c/GbmbdmDObSJfRVR5q7l0mOVC3BjMeFFozGCzc8ZmlSnXBa9qXJY
         oR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=ne6DSNpsJZByeRFAG9jbcUVAbO8GA9lNSV6QkOc8+mY=;
        b=nMyVI4l4KNfvVs1C3PwXdgpT1cpTWe5j8DinBwMbk0AIUxdBLCohaVc8n5dxzVv2eA
         ZALpk/HDkqpxJZCLqzWwA1y1KMPacwQQ6CQDiGJhr1uQbV/4uIrSrYlSss/Nd11rVVbi
         U1HMScErdbXICXPSBt4huCDSB7rxw0PS3jHv6/bd1ORYTO2S9XdDd7Wmisk9VLUKMJxy
         3E51LzgSbRGkVvqZ4/IYHW01A37OIYbQZNxfBOVR0y0EFM/YhmTJ71N3A4TPpzerVzrK
         dRn9lz141F79/dKLgcXTbh82RFujkau6lfTNliDVxP22n9f7YiUKE3/ZhCUR5Dsgoz1q
         KQ9A==
X-Gm-Message-State: AIkVDXJgMnfBOHr26r7a+I9kjN4BmPGejATGUS+OpplCZK49t6WP9h0h39fi9iJbco0udDzE
X-Received: by 10.55.31.203 with SMTP id n72mr83467437qkh.210.1483755361671;
        Fri, 06 Jan 2017 18:16:01 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([2620:0:1004:2:11b6:6b62:9863:9910])
        by smtp.gmail.com with ESMTPSA id c76sm837097qke.0.2017.01.06.18.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2017 18:16:01 -0800 (PST)
Subject: Re: [PATCH v2 4/4] mergetool: fix running in subdir when rerere
 enabled
To:     Johannes Sixt <j6t@kdbg.org>
References: <20170104005042.51530-1-hansenr@google.com>
 <20170106010945.79382-1-hansenr@google.com>
 <20170106010945.79382-5-hansenr@google.com>
 <199807ae-844c-57cd-28cf-2c10b3aee7a9@kdbg.org>
Cc:     git@vger.kernel.org, davvid@gmail.com, sbeller@google.com,
        simon@ruderich.org
From:   Richard Hansen <hansenr@google.com>
Message-ID: <7a561587-3afc-58f9-a490-6bcaa7287576@google.com>
Date:   Fri, 6 Jan 2017 21:16:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <199807ae-844c-57cd-28cf-2c10b3aee7a9@kdbg.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a1147a81c4876eb054577b7a3"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1147a81c4876eb054577b7a3
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 2017-01-06 04:42, Johannes Sixt wrote:
> Am 06.01.2017 um 02:09 schrieb Richard Hansen:
>> If rerere is enabled and no pathnames are given, run cd_to_toplevel
>> before running 'git diff --name-only' so that 'git diff --name-only'
>> sees the pathnames emitted by 'git rerere remaining'.
>>
>> Also run cd_to_toplevel before running 'git rerere remaining' in case
>> 'git rerere remaining' is ever changed to print pathnames relative to
>> the current directory rather than to $GIT_WORK_TREE.
>>
>> This fixes a regression introduced in
>> 57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).
>>
>> Signed-off-by: Richard Hansen <hansenr@google.com>
>> ---
>>  git-mergetool.sh     | 1 +
>>  t/t7610-mergetool.sh | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-mergetool.sh b/git-mergetool.sh
>> index e52b4e4f2..67ea0d6db 100755
>> --- a/git-mergetool.sh
>> +++ b/git-mergetool.sh
>> @@ -456,6 +456,7 @@ main () {
>>
>>      if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
>>      then
>> +        cd_to_toplevel
>>          set -- $(git rerere remaining)
>>          if test $# -eq 0
>>          then
>
> This cannot be a complete solution. Why do we have another
> cd_to_toplevel later, after `git diff --name-only -- "$@"`?

The arguments passed to 'git diff' (including the -O argument) are all 
interpreted as relative to the current working directory, yet 'git diff 
--name-only' outputs pathnames that are relative to the top-level 
directory.  Thus:

   * cd_to_toplevel MUST NOT be run before that 'git diff' command
     unless all pathnames relative to $PWD are converted to absolute (or
     relative to the top-level directory), and
   * cd_to_toplevel MUST be run after 'git diff' so that $files is
     interpreted correctly.

And now I realize that my change breaks -O<foo> if <foo> is relative to 
$PWD.  Grr.  Too bad we don't have tests for running mergetool 
-O<relative-path> from a subdirectory.

>
> Maybe it is necessary to revert back to the flow control that we had
> before 57937f70a09c ("mergetool: honor diff.orderFile", 2016-10-07)? It
> did not have `test $# -eq 0` and `test -e "$GIT_DIR/MERGE_RR"` in a
> single condition.

Reverting to the previous control flow won't work unless the -O pathname 
is converted to absolute (or relative to the top-level directory).  But 
I'll have to do that anyway.  Blech.

Do we already have a helper shell function somewhere that converts a 
pathname to absolute?  Thanks to symlinks it's trickier than one might 
expect.

Thanks,
Richard


>
> -- Hannes

--001a1147a81c4876eb054577b7a3
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
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBYy8dU5LbSR1FuJzXjB
j1u4jQLfn0I3PZHBXpPq0N5RMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwNzAyMTYwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC8tBdPJJoXcxXWwyIcpv3ePTOTAUU8RyJ9ivHp
CScRvmkrY9eNcYa5lvhuf7tb2EZ9LOevFxiNgfQqvMbpN3/3TJsuZrWl5dsueR34SUUYCxZJhGgz
vnl5lQNPW0IreDxjd+74u1YGyIHyFI1Z/pYA3Nfgmm+hdCBE4swB3sUfwwuQaDWaSq4IhaflS7Xz
gA3+dQDC2BuYH+AWJBDMWXjqeaMDIFYs7M88i/2Ra8tkNv+Tc8dUM12HpZruTznATVvIB4RNXOos
TMflPC8iSwvQidbF1GT95iremzsvyoqPKoyzBDU1DKvU7OkShsGbVsz5qVSMNJSg2Gsh4PYQ+8RV
--001a1147a81c4876eb054577b7a3--
