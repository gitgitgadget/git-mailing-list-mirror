From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of post-rewrite
Date: Fri, 22 May 2015 07:22:22 -0700
Message-ID: <xmqq1ti8heu9.fsf@gitster.dls.corp.google.com>
References: <0000014d7bc3f6bf-72bd5f07-9e26-411a-8484-e9b86a1bf429-000000@eu-west-1.amazonses.com>
	<0000014d7bc3f7a5-332dd95f-907f-4f46-a5d6-6b9e5dc70b0a-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri May 22 16:22:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvnqO-0001fn-7l
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbbEVOW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:22:27 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33959 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422646AbbEVOWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:22:24 -0400
Received: by ieczm2 with SMTP id zm2so32353595iec.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lQW1+N9l/f4bMFb/1CVv01nRCgtxm6wRdxFBBl3RmkQ=;
        b=lZtaNbu2cfDnf//0hPaeTjWKtMUo5GRZe4y7/27+848XwCSt5doQ0HK9lLcnGLw4hL
         DFNnIt4C26fjAm4B0shIQkvN2JjR0oIuPQkTHAuwjQrMiC8J6QpGhb5GeEbNzKTnFV1t
         UrYHXpuYHJpeIIXnmijjKcePEeNRNEQ4V6z8JlytRMKuRT/OobSEJPovqZ10RLdNoano
         pNZIXlNbaROB+WuO2sKLswwY3s74PgVEszrWmFGFdF2QFNacYQTVFXgQlo/nnsucIGA/
         ossV6iwr3go/RqSex5gCVlfkDyzKU0tyrIQSrJPIcj7ADCP4SVRZFeXWR2yTW6xxnjwI
         sUPg==
X-Received: by 10.50.61.229 with SMTP id t5mr5977465igr.34.1432304544082;
        Fri, 22 May 2015 07:22:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id 69sm1891545ioz.10.2015.05.22.07.22.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 07:22:23 -0700 (PDT)
In-Reply-To: <0000014d7bc3f7a5-332dd95f-907f-4f46-a5d6-6b9e5dc70b0a-000000@eu-west-1.amazonses.com>
	(Matthieu Moy's message of "Fri, 22 May 2015 13:15:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269720>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The 'exec' command is sending the current commit to stopped-sha, which is
> supposed to contain the original commit (before rebase). As a result, if
> an 'exec' command fails, the next 'git rebase --continue' will send the
> current commit as <old-sha1> to the post-rewrite hook.
>
> The test currently fails with :
>
> --- expected.data       2015-05-21 17:55:29.000000000 +0000
> +++ [...]post-rewrite.data      2015-05-21 17:55:29.000000000 +0000
> @@ -1,2 +1,3 @@
>  2362ae8e1b1b865e6161e6f0e165ffb974abf018 488028e9fac0b598b70cbeb594258a917e3f6fab
> +488028e9fac0b598b70cbeb594258a917e3f6fab 488028e9fac0b598b70cbeb594258a917e3f6fab
>  babc8a4c7470895886fc129f1a015c486d05a351 8edffcc4e69a4e696a1d4bab047df450caf99507

Indent displayed material like the above a bit, please.
And please sign-off your patches.

> ---
>  t/t5407-post-rewrite-hook.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index ea2e0d4..53a4062 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -212,4 +212,21 @@ EOF
>  	verify_hook_input
>  '
>  
> +test_expect_failure 'git rebase -i (exec)' '
> +	git reset --hard D &&
> +	clear_hook_input &&
> +	FAKE_LINES="edit 1 exec_false 2" git rebase -i B &&
> +	echo something >bar &&
> +	git add bar &&
> +	# Fails because of exec false
> +	test_must_fail git rebase --continue &&
> +	git rebase --continue &&
> +	echo rebase >expected.args &&
> +	cat >expected.data <<EOF &&
> +$(git rev-parse C) $(git rev-parse HEAD^)
> +$(git rev-parse D) $(git rev-parse HEAD)
> +EOF

By using a dash to start the here-document like this:

	cat >expect <<-\EOF &&
	$(git rev-parse C) $(git rev-parse HEAD^)
        ...
        EOF

you can tab-indent the contents and the end marker at the same level
to make it easier to read.

> +	verify_hook_input
> +'
> +
>  test_done
>
>
> ---
> https://github.com/git/git/pull/138
