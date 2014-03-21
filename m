From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Rewritten fetch-pack.c:filter_refs() using starts_with()
 instead of memcmp()
Date: Fri, 21 Mar 2014 02:27:05 -0400
Message-ID: <CAPig+cS+6Kg3S+mqLk_9dBdp96M_2L2fgyc1p29irrpmHuLNvA@mail.gmail.com>
References: <1395309889-340-1-git-send-email-mustafaorkunacar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>
To: MustafaOrkunAcar <mustafaorkunacar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 07:27:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQsvU-0000rM-Nd
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 07:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbaCUG1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 02:27:08 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:63026 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbaCUG1G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 02:27:06 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so5148323ykp.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=LS//HmqE8c1Y9fYTqJHi9L3xUGXKUZXsQIrbF44w3ck=;
        b=HJA5nALBTNsZiyzTWgd6l7o+DrS/bYFuIfjsIHuaa0aFuSRgPDYvnrP7dTwBYOpFQk
         5lewL/7uo2DCDe+RToYva4mIDXTQ2aWTWoCxWRzOFbFI00zznxEox408cYUGWWon6ob0
         GmjpmumiDnsjf38BVLmvVjIGgATkuT+TnxApVpdIJxnY+BvumKD/dp+knzlz9wOD5yO7
         +NSPW+zsILUZgTFKe3JgpbVBTTuhHkhMfZh5XtqOq3EuvUnIxhAqYfq+a6GfxlKBrql4
         o0vWU6N5ckBbIA0RSpEHKI3DkOrxS06YW4eK8h4S1tXMlFd8Ryktkx5f2n7Y0YQGSnsf
         nZZA==
X-Received: by 10.236.181.137 with SMTP id l9mr24415411yhm.97.1395383225340;
 Thu, 20 Mar 2014 23:27:05 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 23:27:05 -0700 (PDT)
In-Reply-To: <1395309889-340-1-git-send-email-mustafaorkunacar@gmail.com>
X-Google-Sender-Auth: yam1yMpEpW_gBZG1nwfdA1W4fgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244643>

Thanks for the submission. Comments below to give you a taste of the
Git review process...

On Thu, Mar 20, 2014 at 6:04 AM, MustafaOrkunAcar
<mustafaorkunacar@gmail.com> wrote:
> Subject: Rewritten fetch-pack.c:filter_refs() using starts_with() instead of memcmp()

Use imperative mood: "Rewrite" rather than "Rewritten". Mention the
module or function you're touching at the start of the subject,
followed by a colon and space. For example:

    Subject: filter_refs: replace memcmp() with starts_with()

> Hi, I have completed one of the microprojects -14th one: "Change fetch-pack.c:filter_refs() to use starts_with() instead of memcmp()." The only line in the function filter_refs() containing memcmp() is changed with starts_with(). I plan to apply for GSoC 2014. Any feedback is appreciated. Thanks.

Wrap text to 65-70 characters.

This area above your sign-off is where you should explain the purpose
of the patch and justify the change. For a small one like this, you
shouldn't need more than one or two simple sentences.

> Signed-off-by: MustafaOrkunAcar <mustafaorkunacar@gmail.com>
> ---

This area below the "---" line under your sign-off is for commentary
which won't likely be relevant to someone looking at the patch in the
project history months or years from now. Everything you wrote above
about GSoC and only one instance of memcmp() belongs here.

The patch itself looks reasonable. As suggested by the microproject,
were you able to find any other places in the project which could
benefit likewise? If so, perhaps include a few of them when you
resubmit.

>  fetch-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f061f1f..17823ab 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -506,7 +506,7 @@ static void filter_refs(struct fetch_pack_args *args,
>                 int keep = 0;
>                 next = ref->next;
>
> -               if (!memcmp(ref->name, "refs/", 5) &&
> +               if (starts_with(ref->name, "refs/") &&
>                     check_refname_format(ref->name, 0))
>                         ; /* trash */
>                 else {
> --
> 1.9.1.286.g5172cb3
