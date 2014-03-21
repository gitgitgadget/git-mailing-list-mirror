From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GUILT 20/28] "guilt graph": Handle patch names containing quotes.
Date: Fri, 21 Mar 2014 03:57:37 -0400
Message-ID: <CAPig+cQ8aPSjCzf0AjNQRvtJJ52eaOi=fJNZ8vXdnFoE5vxyAQ@mail.gmail.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
	<1395387126-13681-21-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff Sipek <jeffpc@josefsipek.net>, Git List <git@vger.kernel.org>
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:57:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQuKk-0002L7-BZ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760040AbaCUH5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:57:38 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:51758 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbaCUH5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:57:37 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so5325692ykt.4
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dyS/lRthDEBwpoyK/zu4v3ocyBYt8SwunBWOfqoGF9I=;
        b=saFINaNUetHLf2QPQP0O2oVYc99TQZ7VUpuN3lLyjpZT769W+yNIHFw/aDspwNejkV
         ZZ1krjfd2MseZMfmKkS3++BLhzC5gNo/qyPIG4G9rOs462ubJ4QGo91/PXVrnzxicUDs
         ns8a5njm781UPXzF0rqOjVgnmtTjGTZ+jmSlDiMLEHAQ9NGjbd8pqwuORg4/TBogGzwQ
         5emoiiTIJIITvvJCjtY8IIuDfemiQMP13SuB5hVGXUQqtvjF5wLaWvBmO88xMRglJsfR
         RpjL/lFuhC/qRqV9u592j3aumLhDvkXnooxK7y8+eDG90jK8/cGokjcqOd/7f5a1bL41
         Hhnw==
X-Received: by 10.236.2.37 with SMTP id 25mr361877yhe.123.1395388657433; Fri,
 21 Mar 2014 00:57:37 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 21 Mar 2014 00:57:37 -0700 (PDT)
In-Reply-To: <1395387126-13681-21-git-send-email-cederp@opera.com>
X-Google-Sender-Auth: -O9LhmQtAqzSgZx9p0ny6UYG6dI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244677>

On Fri, Mar 21, 2014 at 3:31 AM, Per Cederqvist <cederp@opera.com> wrote:
> Quote quotes with a backslash in the "guitl graph" output.  Otherwise,

s/guitl/guilt/

> the "dot" file could contain syntax errors.
>
> Added a test case.
> ---
>  guilt-graph          |  2 ++
>  regression/t-033.out | 22 ++++++++++++++++++++++
>  regression/t-033.sh  |  9 +++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/guilt-graph b/guilt-graph
> index 575f03b..24ab83b 100755
> --- a/guilt-graph
> +++ b/guilt-graph
> @@ -58,6 +58,8 @@ while [ "$current" != "$base" ]; do
>  }"`
>         [ -z "$pname" ] && pname="?"
>
> +       pname="`printf \"%s\" $pname|sed 's/\"/\\\\\"/g'`"
> +
>         disp "# checking rev $current"
>         disp "  \"$current\" [label=\"$pname\"]"
>
> diff --git a/regression/t-033.out b/regression/t-033.out
> index e638d7b..1c28ea9 100644
> --- a/regression/t-033.out
> +++ b/regression/t-033.out
> @@ -63,3 +63,25 @@ digraph G {
>         "ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
>         "891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
>  }
> +% guilt new a-"better&quicker'-patch.patch
> +% git add file.txt
> +% guilt refresh
> +Patch a-"better&quicker'-patch.patch refreshed
> +% guilt pop
> +Now at c.patch.
> +% guilt push
> +Applying patch..a-"better&quicker'-patch.patch
> +Patch applied.
> +% guilt graph
> +digraph G {
> +# checking rev bc7df666a646739eaf559af23cab72f2bfd01f0e
> +       "bc7df666a646739eaf559af23cab72f2bfd01f0e" [label="a-\"better&quicker'-patch.patch"]
> +# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
> +       "891bc14b5603474c9743fd04f3da888644413dc5" [label="c.patch"]
> +       "bc7df666a646739eaf559af23cab72f2bfd01f0e" -> "891bc14b5603474c9743fd04f3da888644413dc5"; // ?
> +# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
> +       "c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
> +# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
> +       "ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
> +       "891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
> +}
> diff --git a/regression/t-033.sh b/regression/t-033.sh
> index 57dce78..968292c 100755
> --- a/regression/t-033.sh
> +++ b/regression/t-033.sh
> @@ -46,3 +46,12 @@ cmd git add file.txt
>  cmd guilt refresh
>  fixup_time_info c.patch
>  cmd guilt graph
> +
> +# A patch name that contains funky characters, including unbalanced
> +# quotes.
> +cmd guilt new "a-\"better&quicker'-patch.patch"
> +cmd echo d >> file.txt
> +cmd git add file.txt
> +cmd guilt refresh
> +fixup_time_info "a-\"better&quicker'-patch.patch"
> +cmd guilt graph
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
