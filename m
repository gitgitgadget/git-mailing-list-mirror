From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/1] contrib/subtree: Add a test for subtree rebase
 that loses commits
Date: Mon, 18 Jan 2016 13:10:36 -0500
Message-ID: <CAPig+cS6ouc+kdJaz10M2AApPoDODDcgDX9Azz8ih=4zxxD2zg@mail.gmail.com>
References: <CAPig+cTMAnbyT3-FFN4juUooosiydOCX-ETwTghpnKoOeXcMpQ@mail.gmail.com>
	<047e625a28954b8fd79225b55cab7620cb5f3b1f.1453074191.git.greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Mon Jan 18 19:10:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLEGQ-0006Bx-2c
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 19:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbcARSKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 13:10:43 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36044 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283AbcARSKh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 13:10:37 -0500
Received: by mail-vk0-f65.google.com with SMTP id e64so9549338vkg.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zI8A2Dw4ZNiCXQFAZE0wajV3VqXbYtGNFQXhEwg1p4E=;
        b=YCzjM/+Yty1XQ6LzrLeliWWEhC5/wkLjzpky+4MDNtpgFn4xCF9q7GUTQOr3NK6sVT
         0cwYlkNh9CM/PgKXtQy9C7Os69WnYu/ATAUouwrt7Ifnc21604ADdwNzXV2wU86vuvm+
         LmTLug60xQ6+JFMA0pg6jNN+Bu+iV26dhQpITJmWYEzgbjC7SnX64Yglpu6lZk35+MuA
         vXU8+dHY1fsd0MrEukf9lGY73012ytHPfx9MPP5oUk0raFU4+VPKiJ69Ubai8GwghrPV
         2XYvC18er6TUlcUbwcLwAGYJwzrrLtAtwKQSHPnRb57K/X3P8bdcgfXuRqtjUd0VSKtG
         hHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zI8A2Dw4ZNiCXQFAZE0wajV3VqXbYtGNFQXhEwg1p4E=;
        b=Ha3tBsFhLlLnC2EWGiKo+9MagDUF80zEomrFWqKXBq+N9TIUHvXbcADwW5i6jp+PGg
         hJrFlyTfV8YtJ/QrV4OJMmgeCxRoB+43qdgXpfh1SgXgQztmSBCUfk6xmiKp/LcYoT0x
         uGAB59JzxvDps6wFtxpDkGPMVqlaSEKrVgtEHgF8ojmeg7b7kQktOEWpXPMWpW6tKKcT
         MdirzrkNrCUxCOc8ByXwio1UVmts3Mv8FEelAT/lygPLNiN20wkbRsvmi5dWO0r5MzLh
         Zny9Td1YEmZR+HVxqbZNEj5oezMtIPQTjHh9gtbJ3LmA6SP6uq3Mdk5sHI9GDXmISGvy
         acsA==
X-Gm-Message-State: ALoCoQnnVRdVOdrqdiZCKzPfWMfhgY2UD4MayAphQZiRfQMpInK1Cgwzv0u5OEmAdJYztDIyhnQfOgJ5+ggVlKiz4W77ZzqqsQ==
X-Received: by 10.31.58.74 with SMTP id h71mr17818720vka.151.1453140636154;
 Mon, 18 Jan 2016 10:10:36 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 18 Jan 2016 10:10:36 -0800 (PST)
In-Reply-To: <047e625a28954b8fd79225b55cab7620cb5f3b1f.1453074191.git.greened@obbligato.org>
X-Google-Sender-Auth: 3h8PPPHQAkDCVpx1Ejjwc-eCRbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284301>

On Sun, Jan 17, 2016 at 6:43 PM, David Greene <greened@obbligato.org> wrote:
> This test merges an external tree in as a subtree, makes some commits
> on top of it and splits it back out.  In the process the added commits
> are lost or the rebase aborts with an internal error.  The tests are
> marked to expect failure so that we don't forget to fix it.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> @@ -0,0 +1,70 @@
> +# FAILURE: Does not preserve master4 and master5.
> +test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto' '
> +       reset_rebase &&
> +       git checkout -b rebase-preserve-merges master &&
> +       git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +       git commit -m "Empty commit" --allow-empty &&
> +       git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
> +       verbose "$(last_commit_message)" "files_subtree/master5"

Hmm, does this test succeed? If it does, it's only by accident.
verbose() is just a helper for printing the the expression being
tested upon failure, but you still need to supply a proper expression
for testing. It is intended to be used like this:

    verbose test "$(last_commit_message)" = files_subtree/master5

Same comment applies to the remaining tests.

> +'
> +
> +# FAILURE: Does not preserve master4, master5 and empty.
> +test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto' '
> +       reset_rebase &&
> +       git checkout -b rebase-keep-empty master &&
> +       git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +       git commit -m "Empty commit" --allow-empty &&
> +       git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
> +       verbose "$(last_commit_message)" "Empty commit"
> +'
> +
> +# FAILURE: fatal: Could not parse object
> +test_expect_failure 'Rebase -Xsubtree --onto' '
> +       reset_rebase &&
> +       git checkout -b rebase-onto master &&
> +       git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +       git commit -m "Empty commit" --allow-empty &&
> +       git rebase -Xsubtree=files_subtree --onto files-master master &&
> +       verbose "$(last_commit_message)" "Empty commit"
> +'
> +
> +test_done
> --
> 2.6.1
