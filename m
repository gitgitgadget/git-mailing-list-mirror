From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv12 10/10] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Mon, 12 Jan 2015 18:40:28 -0500
Message-ID: <CAPig+cT4SvvO=KCuRNaEZ7Vn1AeBy19mMeKtC=XJ1Mqw+zYYzA@mail.gmail.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
	<1420687404-13997-11-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:40:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAob3-0001qG-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 00:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbbALXk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 18:40:29 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:41847 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbALXk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 18:40:29 -0500
Received: by mail-yh0-f46.google.com with SMTP id t59so11106225yho.5
        for <git@vger.kernel.org>; Mon, 12 Jan 2015 15:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Vyu8AXItHqihCYL8poueF4SKYfwG7M1F9AlUOvAmwns=;
        b=TTc01y9NeovpVLoUnhFPwSvkMuw0KL7Sn6bQpNzh5Cja7NXXWVDPYTM45OHD7h1lGc
         Q/XiBCslEK9bfJK853lrkhQr7Zf5c131/rWXr/ubAsz376/3f63FyZt81gae+3nYdluA
         2IZ6rITsswZzHTb4JIafos9UO43cipy2KUChrN4y8e1y6+zPfB0F2TVY6MDTEKFlbBxA
         MCcEezWsVv93oNeGvb3w2RSUlxH75ZTrayEYlpYpHree88r6h0VF4LVcAv7FNYhn7Iwp
         pbSdblU9pX4sYg41/KsqKpVJ4H+dq7yG1ysis56lqDmrmRmfr4c4hpvBFCFEW/W1Mc8H
         gSpA==
X-Received: by 10.236.7.107 with SMTP id 71mr24406449yho.148.1421106028347;
 Mon, 12 Jan 2015 15:40:28 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 12 Jan 2015 15:40:28 -0800 (PST)
In-Reply-To: <1420687404-13997-11-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: xjKou-8LYy3eZqYOd6gBT3b8sc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262303>

On Wed, Jan 7, 2015 at 10:23 PM, Stefan Beller <sbeller@google.com> wrote:
> This adds tests for the atomic push option.
> The first four tests check if the atomic option works in
> good conditions and the last three patches check if the atomic

s/patches/tests/

> option prevents any change to be pushed if just one ref cannot
> be updated.

The commit message talks about 7 tests, but I count 8.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
> new file mode 100755
> index 0000000..3480b33
> --- /dev/null
> +++ b/t/t5543-atomic-push.sh
> @@ -0,0 +1,194 @@
> +test_expect_success 'atomic push is not advertised if configured' '
> +       mk_repo_pair &&
> +       (
> +               cd upstream

Broken &&-chain.

> +               git config receive.advertiseatomic 0
> +       ) &&
> +       (
> +               cd workbench &&
> +               test_commit one &&
> +               git push --mirror up &&
> +               test_commit two &&
> +               test_must_fail git push --atomic up master
> +       ) &&
> +       test_refs master HEAD@{1}
> +'
> +
> +test_done
> --
> 2.2.1.62.g3f15098
