From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: `bisect_log` shell function in C
Date: Fri, 20 May 2016 12:58:21 +0530
Message-ID: <CAFZEwPO3=-vqEdxPPTA40YoVf_PtEJrfjtHskicnYzAj+Efe7w@mail.gmail.com>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cTfZ1hWXZcx5OLNRRqJ7FkTigizpMB9E1xzv1Tv+8YY2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 20 09:29:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3erE-0006e1-A6
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 09:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbcETH2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 03:28:23 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34832 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbcETH2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 03:28:23 -0400
Received: by mail-yw0-f177.google.com with SMTP id g133so101577815ywb.2
        for <git@vger.kernel.org>; Fri, 20 May 2016 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=VkuYxdhc87H9vwGPt3JokQZVXO42UMNQ8wRFztMZhMI=;
        b=M3v3zFzpwZ59EaJFzrKS7fiDaGnpwjoMn2ZZk/OBjP6zn3rlbfEjiUMrOLiColrdDI
         1PRO05tHMVmvRLeBpsysBPBYjGnwLk3zaBEShWnt2FaIFojCbk5GRdbCHiRpAdiy3fBX
         7lNS9574VausnhdQMV1MZgsZlij8AZKsswCfRYenjgQbQ05iydr5wl0BvL39qE0fTxbz
         GXRIag25+ddf683Ei765PZH294NK74bI5YcJQIkq0yZ0mIaHl7Jao4e3FsF6CZuyhpJM
         iTQV0MMytW6NV0I51BPr1dz4cfl+ZgKzZwzKjWhioHaP2NpUJdhVf/p9FUNQOnMONRwg
         4YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VkuYxdhc87H9vwGPt3JokQZVXO42UMNQ8wRFztMZhMI=;
        b=Mx758ptis35jE2yp5lHxSrin6zr1pAzbkovKbRHJR5O9XpDNjgOb+0hBK6ZRa7WN/7
         4MGWfkW2o7tGqjWMuJT1NA6m9tkemkWCqILtWYicZQwJmQidbJ61g5096frIW4WqXk0F
         uB+L0yzruYC60KcrINOctzq3I+J2r+SAUhzR1l4hNrkDE0gKzVsIQfCgvOnB/jnEWYCJ
         ky4vExoKV0HZGBm0n2eSXB+MTmiqsAokLZZlTKIsas4mrDWoxz7nTz7iWZQ++PWptUe/
         2OIKwRbyIq6tIeJWrfMSBCuatMpTz2zQrUltU3/DrbOQ0zDUNbkZ3vDjCS02WmtK3Ekf
         0lBQ==
X-Gm-Message-State: AOPr4FX/IUvlpYSJI0oynw20CxSohHqcaSTzC+PO3ib5VhOHI64HHuJKnWkCXAU8gZwtqInaFm87ehQzPpmuPQ==
X-Received: by 10.129.81.87 with SMTP id f84mr832450ywb.154.1463729302037;
 Fri, 20 May 2016 00:28:22 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Fri, 20 May 2016 00:28:21 -0700 (PDT)
In-Reply-To: <CAPig+cTfZ1hWXZcx5OLNRRqJ7FkTigizpMB9E1xzv1Tv+8YY2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295154>

Hey Eric,

On Mon, May 16, 2016 at 1:06 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, May 13, 2016 at 4:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> bisect--helper: `bisect_log` shell function in C
>
> Do you need to insert "rewrite" or "reimplement" in the subject?
>
>> Reimplement the `bisect_log` shell function in C and add a
>> `--bisect-log` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh .
>>
>> Using `--bisect-log` subcommand is a temporary measure to port shell
>> function to C so as to use the existing test suite. As more functions
>> are ported, this subcommand will be retired and will be called by some
>> other method.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -79,11 +80,26 @@ int write_terms(const char *bad, const char *good)
>> +int bisect_log(void)
>
> s/^/static/

Will include this in the re-roll

>> +{
>> +       struct strbuf buf = STRBUF_INIT;
>> +
>> +       if (strbuf_read_file(&buf, ".git/BISECT_LOG", 256) < 0)
>
> As mentioned in my review of the "write-terms" rewrite, hardcoding
> ".git/" here is wrong for a variety of reasons. See get_git_dir(),
> get_git_common_dir(), etc. in cache.h instead.

Thanks. I will have a look into this.

>> +               return error(_("We are not bisecting."));
>> +
>> +       printf("%s", buf.buf);
>> +       strbuf_release(&buf);
>> +
>> +       return 0;
>> +}
>> +
>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>> @@ -109,6 +127,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>                 if (argc != 2)
>>                         die(_("--write-terms requires two arguments"));
>>                 return write_terms(argv[0], argv[1]);
>> +       case BISECT_LOG:
>
> Shouldn't you be die()ing here with an appropriate error message if
> argc is not 0?

I think it would be better to check for argc != 0 and die
appropriately. Will include this in the re-roll.

>> +               return bisect_log();
>>         default:
>>                 die("BUG: unknown subcommand '%d'", cmdmode);
>>         }

Regards,
Pranit Bauva
