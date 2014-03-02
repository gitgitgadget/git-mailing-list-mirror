From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] branch.c: change install_branch_config() to use skip_prefix()
Date: Sun, 2 Mar 2014 17:56:09 -0500
Message-ID: <CAPig+cRy2Jt_3DAS=ARzN-8HT3rdMCSGP5QfU8sJZGwqsJTG3g@mail.gmail.com>
References: <1393775755-15359-1-git-send-email-mzguanglin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>
To: Guanglin Xu <mzguanglin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 23:56:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKFJD-0004Wu-CV
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 23:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbaCBW4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 17:56:12 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:60592 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaCBW4L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 17:56:11 -0500
Received: by mail-yh0-f46.google.com with SMTP id v1so2912331yhn.19
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 14:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=suKEXHhX9GetQ1y6MbWDKykyl2kDfhvVo1qCuk5tIHI=;
        b=gsrjlhklwTK6Q9XjnhIw3+y/jDL5nWRzIS+cHwko4VOyJGj0vM3midhVgriEd3eX85
         sC0oQ0Fcmrk64y4ZF26qfhC9JZ5Y0BsrFV3eId1+b0gq425Z5vyh1GtGqdR/HqKEmBns
         ilQuUNhMTZYTeJCkxl6phZXtvCKPsAq2g6kRTCyd62nCOPnUW+SVmjBrsywWZuajUq0U
         0/UEKl8fCt+KPCviw7OPsopx26ytIwN/92JenIFOrnuk+nZA9exeXrr+KhhXa2n1/is5
         9JV6TL25nULSEZXs02y5sIh/Slr/zwkFeiDxsdwTzrdMzMxDrZIFAYQlkC5pouGY4Imi
         rGBw==
X-Received: by 10.236.101.227 with SMTP id b63mr16489294yhg.37.1393800969826;
 Sun, 02 Mar 2014 14:56:09 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 14:56:09 -0800 (PST)
In-Reply-To: <1393775755-15359-1-git-send-email-mzguanglin@gmail.com>
X-Google-Sender-Auth: aeu3npoR55-hMTrYA0PruQ0OEvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243164>

Thanks for the submission. Comments below to give you a taste of the
Git review process...

On Sun, Mar 2, 2014 at 10:55 AM, Guanglin Xu <mzguanglin@gmail.com> wrote:
> Change install_branch_config() to use skip_prefix() and make it conform to the usage of previous starts_with(). This is because the proper usage of skip_prefix() overrides the functionality of starts_with(). Thorough replacements may finally remove the starts_with() function and reduce  code redundency.

Justifying a change is certainly a good idea, however, the above
reasoning for this particular change is off mark. See below.

Also, wrap commit message lines to 65-70 characters or so.

> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
> ---
>  branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..ca4e824 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
>         const char *shortname = remote + 11;
> -       int remote_is_branch = starts_with(remote, "refs/heads/");
> +       int remote_is_branch = (NULL != skip_prefix(remote ,"refs/heads/"));

This actually makes the code more difficult to read and understand.
There's a more fundamental reason to use skip_prefix() here. See if
you can figure it out. (Hint: shortname)

>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> --
> 1.9.0
>
> Hi,
> I am Guanglin Xu. I plan to apply for GSoC 2014.
>
> This patch is in accordance with the idea#2 of GSoC2014 Microproject. Any comments are welcomed.

This sort of commentary, which is appropriate to the email discussion
but not meant for permanent project history, should be placed
immediately below the "---" line following your sign-off.
