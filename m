From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] prefix_path(): Unconditionally free result of prefix_path
Date: Tue, 5 May 2015 09:28:40 -0700
Message-ID: <CAGZ79kZjeG8UG5ALE-KSO52fD5gJk4xks=VtSV9bHQVA=ST+5Q@mail.gmail.com>
References: <1430766714-22368-1-git-send-email-sbeller@google.com>
	<20150505032158.GA23587@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 05 18:58:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpgB6-0003bW-HK
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 18:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbbEEQ6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 12:58:35 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36678 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760895AbbEEQ2l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 12:28:41 -0400
Received: by iebrs15 with SMTP id rs15so149653219ieb.3
        for <git@vger.kernel.org>; Tue, 05 May 2015 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BkdD0kyAHLUZKwuuZkzxUXfzynxz/TGA4AX39T31EGQ=;
        b=OIaxUnX7T5dFMH7VOU+uc6bN2HAlbIPZHWPBPX9JIg8kmPgnLTR+nkdxW59xu8ziBV
         5DpXVRcqWJq/RBXA41LDmJODJlb9RF3pDkQrP36/6ytMRB1OeqJ1P7PsX83q0V5bTBPe
         wpxQ0yVG1U8vD8a0lcRF5dtQi35ifXH8z8SNhpJtI0ds3HhRbiIznTGHDbfcsKC3lYEb
         UzFjC0t3qnvhV6KP8SYx24SDf4Q2X21jFbNm4edYkp8gxhsnwKPWWnzhln0qXKmEuhbT
         6AvtgyfVM2oitocRXW2Y9YcgN8A1P2FYv1lyoAJW9+Yn2V7RLea/I5+GP4NvXm1tojva
         vbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BkdD0kyAHLUZKwuuZkzxUXfzynxz/TGA4AX39T31EGQ=;
        b=MKknXna/L3EtZ+csnzQVpgOgyHAYMTRmr1fKk9pjPQztgITaS1wRYxE66T2gxzBhnQ
         OtgbaezZJhJxD9EkEwh8A0WXHUc0dEmh8npUBQbEDWcwBE33wxs8K+FrqXxF9Wx+smRs
         mp0XCGQrdBg2ZnFhtGH+pgaUkiYhFOafA1QOGg62NUF+k1EtoEzExFSf/18ibmDvauhe
         T234o0s2CeICsvWu9mbIY3vSqJbjn1gAi802irsVMoP66oMlUA3VSwubtj24taJKqy9D
         hu4LR+hkJmiFiDn6n2MYRLyoOJ1FEq4AEq6O8qqMEr8W0qTBSlY8dca8zrk+kdoQ38H5
         dbRg==
X-Gm-Message-State: ALoCoQnzYbR3WwCX2a0GVioBTKEhdvNomEWHnpngPnZu+ZvgMqIHT+72le7F01VKjnQk+6cM8zNK
X-Received: by 10.50.138.72 with SMTP id qo8mr2852183igb.10.1430843320310;
 Tue, 05 May 2015 09:28:40 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 5 May 2015 09:28:40 -0700 (PDT)
In-Reply-To: <20150505032158.GA23587@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268397>

On Mon, May 4, 2015 at 8:21 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 04, 2015 at 12:11:54PM -0700, Stefan Beller wrote:
>
>> prefix_path() always returns a newly allocated string since
>> d089eba (setup: sanitize absolute and funny paths in get_pathspec(),
>> 2008-01-28)
>>
>> Additionally the const is dropped from the pointers, so the call to
>> free doesn't need a cast.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     Thanks for all the suggestions!
>>     They are incorporated into this version of the patch.
>>
>>  builtin/checkout-index.c | 10 ++++------
>>  builtin/update-index.c   |  5 ++---
>>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> Should we also squash in these sites? I think they are adequately
> covered under the proposed log message.

That sounds good to me.

>
> Found by grepping for prefix_path calls. The only remainders are:
>
>   1. in blame, we assign the result to a const char that may also point
>      straight into to argv, but we never actually free either way
>
>   2. test-path-utils does not free at all, but we probably don't care
>      either way
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index a92eed2..0665b31 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -870,14 +870,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                 case PARSE_OPT_DONE:
>                 {
>                         const char *path = ctx.argv[0];
> -                       const char *p;
> +                       char *p;
>
>                         setup_work_tree();
>                         p = prefix_path(prefix, prefix_length, path);
>                         update_one(p);
>                         if (set_executable_bit)
>                                 chmod_path(set_executable_bit, p);
> -                       free((char *)p);
> +                       free(p);
>                         ctx.argc--;
>                         ctx.argv++;
>                         break;
> @@ -908,7 +908,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>
>                 setup_work_tree();
>                 while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
> -                       const char *p;
> +                       char *p;
>                         if (line_termination && buf.buf[0] == '"') {
>                                 strbuf_reset(&nbuf);
>                                 if (unquote_c_style(&nbuf, buf.buf, NULL))
> @@ -919,7 +919,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                         update_one(p);
>                         if (set_executable_bit)
>                                 chmod_path(set_executable_bit, p);
> -                       free((char *)p);
> +                       free(p);
>                 }
>                 strbuf_release(&nbuf);
>                 strbuf_release(&buf);
