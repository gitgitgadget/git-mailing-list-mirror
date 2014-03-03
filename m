From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon, 3 Mar 2014 03:12:34 -0500
Message-ID: <CAPig+cQ7Zg-jPewuaYJ7K8aZBfJQPPt64Pzn9g1GdbikTQORzQ@mail.gmail.com>
References: <1393828581-65523-1-git-send-email-mzguanglin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Guanglin Xu <mzguanglin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 09:12:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNzM-0007le-DD
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 09:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbaCCIMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 03:12:35 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:40279 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbaCCIMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 03:12:35 -0500
Received: by mail-yh0-f43.google.com with SMTP id b6so2824047yha.30
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=00IUJFBwU/18IkxX1E3pQi03vGPCL3QXb2B+9eE32kM=;
        b=r0W+kHJLwneu9i3hExrxsm+dyYwlB0E8hgb8QWfSHofG3i4x9hahH3f+eqKC8PZvHK
         81IKeCagc/+PII1gv8/Aegx6IVobZ9nbgCkITAZfvPeSy2rcyUKOBSI/uGF4mzm4jAd7
         chZDwTpxZHkO92Ndx6OzrrbzL5jcOTCKK5T7RxpLvolI0kQA++K9lxSnnKBdE/LzAYtp
         pLibZUSaRjof8fE82C2NsL3HUA5lTk14EfPaOSka/3OMJ6gTP0+KymoT1/+gP8gv5eTW
         C9BM9ZcRQ9CY8+mFAYXB4sh0yk0pKoPcf/om0rNLXYDxI7Mc5E7wLNYYdyZFYx9H4IpM
         ymYw==
X-Received: by 10.236.15.102 with SMTP id e66mr338596yhe.69.1393834354578;
 Mon, 03 Mar 2014 00:12:34 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 00:12:34 -0800 (PST)
In-Reply-To: <1393828581-65523-1-git-send-email-mzguanglin@gmail.com>
X-Google-Sender-Auth: DoG5svN0Ek9a40gKktGfT2yGQp4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243196>

On Mon, Mar 3, 2014 at 1:36 AM, Guanglin Xu <mzguanglin@gmail.com> wrote:
> to avoid a magic code of 11.
>
> Helped-by: Sun He <sunheeh...@gmail.com>
> Helped-by: Eric Sunshine <sunsh...@sunshineco.com>
> Helped-by: Jacopo Notarstefano <jaco...@gmail.com>
>
> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
> ---
>
> This is an implementation of the idea#2 of GSoC 2014 microproject.
>
>  branch.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..4eec0ac 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -49,8 +49,12 @@ static int should_setup_rebase(const char *origin)
>
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
> -       const char *shortname = remote + 11;
> -       int remote_is_branch = starts_with(remote, "refs/heads/");
> +       const char *shortname = skip_prefix(remote ,"refs/heads/");
> +       int remote_is_branch;
> +       if (NULL == shortname)
> +               remote_is_branch = 0;
> +       else
> +               remote_is_branch = 1;

A bit verbose. Perhaps just:

    int remote_is_branch = !!shortname;

which you will find to be idiomatic in this project.

>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> --
> 1.9.0
