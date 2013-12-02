From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Sun, 1 Dec 2013 20:21:53 -0500
Message-ID: <CAPig+cRVYLsVrmFzfKHE8VdYo90enuOpsir2HT8YueQsWs58ng@mail.gmail.com>
References: <1385922611.3240.6.camel@localhost>
	<20131201190447.GA31367@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, ingy@ingy.net
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 02:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnID1-0005O7-D7
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 02:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab3LBBVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 20:21:55 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:49936 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab3LBBVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 20:21:55 -0500
Received: by mail-la0-f42.google.com with SMTP id ec20so8110568lab.1
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 17:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KbRdi1UNzWIttq3IvMUgPRUaY+Q2ZgCg5xJN35Um4ew=;
        b=P+g9uoNLKdHb8y+AQspu2cc31eIN3t1YLPxDOVkbxFoky6xsrtcULSwrbqVY30D064
         z8J6U4FsXWcf7N9aakYeSVwVICgm8YORYsQrAKyvZ5ihLzvlXQ/VUMHLJqdouRmJUWY7
         /ao8vZmcubWKTxljnUe/VKSq5AmvanvdQi9UhsDHL17H5NLzDlHiUkTyNbGa2g9RQFhd
         XXIX89iylaR+7W7Y28tCYPtWH7QubK/M1CP4lN5s6mgrqM9eZPeHLDX36fQsuMEGoGks
         lp8XqibxB4uoifj4zY9dPg8uttVESkO3AfYp5POLfSD/gmyckHPU5IDOKqb8pQZFi1Gw
         9/Xw==
X-Received: by 10.112.134.71 with SMTP id pi7mr22470lbb.44.1385947313243; Sun,
 01 Dec 2013 17:21:53 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Sun, 1 Dec 2013 17:21:53 -0800 (PST)
In-Reply-To: <20131201190447.GA31367@kaarsemaker.net>
X-Google-Sender-Auth: 7_MF5iecu3YwpPB9-1tU_agkC50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238608>

On Sun, Dec 1, 2013 at 2:04 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index c987b5e..2bd7ef1 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -198,6 +198,13 @@ test_expect_success 'status -s' '
>
>  '
>
> +test_expect_success 'status -s with non-standard $GIT_DIR' '
> +       mv .git .foo &&
> +       GIT_DIR=.foo git status -s >output &&
> +       test_cmp expect output &&
> +       mv .foo .git

If test_cmp returns a failure status, the following 'mv' command will
never be invoked, thus all subsequent tests in the script will fail
since the .git directory will be missing. Instead, use
test_when_finished to restore .git from .foo.

> +'
> +
>  test_expect_success 'status with gitignore' '
>         {
>                 echo ".gitignore" &&
> --
> 1.8.5-386-gb78cb96
