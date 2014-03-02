From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] skip_prefix:rewrite so that prefix is scanned once
Date: Sun, 2 Mar 2014 13:57:26 -0500
Message-ID: <CAPig+cS9SXwF5ZGzPW1GGoWqxQhKXSyGuEv2yWKbtKXDR-7CAA@mail.gmail.com>
References: <1393772584-3716-1-git-send-email-siddharth98391@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Siddharth Goel <siddharth98391@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 19:57:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKBZs-00039Z-39
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 19:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbaCBS52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 13:57:28 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:51530 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaCBS51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 13:57:27 -0500
Received: by mail-yk0-f177.google.com with SMTP id q200so8195308ykb.8
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 10:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XxOuxhl94Csw59JuwCAHRZgnqbEg7Rt7AlnxoCg++L8=;
        b=t4AC0K6+7VspqFzXPmguY1I9m/VE+2nr64mzT1Y49iqWl+M3lkuy0a17OwRt0UVabV
         13qf1douQ3u/V9Csw4UIuy1b+OhwhfessfiAF+En4pv29PlGPht/Gucr8k1+emUScEuV
         9eVtn0Ge0st9OeuK9DRj7mdV8+8ZVAYwfnZ/1UxabErsvWHq1szSXBIBw3iaBY35j+KY
         SEWGopBzw0zbEF5fJIR91QrJSJmFO4ZL/0Q90P0d6fpd0T3P4uGL1hJdfpUDjenzFfXd
         zNMM/vYYjQSQh5X1W2WgZ+U50EZj702iM3a5mlb2hOBbwq9mwPvpwvs3mBzJsQ39zxoQ
         qQKg==
X-Received: by 10.236.100.235 with SMTP id z71mr16112992yhf.43.1393786646991;
 Sun, 02 Mar 2014 10:57:26 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 10:57:26 -0800 (PST)
In-Reply-To: <1393772584-3716-1-git-send-email-siddharth98391@gmail.com>
X-Google-Sender-Auth: s_Dsl-epX9ts8j7jtNlppOuqD7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243155>

On Sun, Mar 2, 2014 at 10:03 AM, Siddharth Goel
<siddharth98391@gmail.com> wrote:
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Siddharth Goel <siddharth98391@gmail.com>
> ---
> Thanks a lot Eric for your valuable comments. Please let me know if there is
> anything else which needs to be modified in this patch.

Other than suggesting that you insert a space after the colon in the
subject, I don't have any further comments on this patch. That's
probably not a reason to resend, though.

As general commentary to any potential GSoC students reading this: do
what you can to ease the review process. One way to do so is to supply
commentary below the "---" line (or in the cover letter) explaining
what changed in the present patch compared with the previous attempt.
Bonus points for providing a reference to the previous version of the
submission, like this [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243097

>  git-compat-util.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 614a5e9..550dce3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
>
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {
> -       size_t len = strlen(prefix);
> -       return strncmp(str, prefix, len) ? NULL : str + len;
> +       while (*prefix != '\0' && *str == *prefix) {
> +               str++;
> +               prefix++;
> +       }
> +       return (*prefix == '\0' ? str : NULL);
>  }
>
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
> --
> 1.9.0.138.g2de3478.dirty
