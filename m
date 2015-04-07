From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t7300: add tests to document behavior of clean and
 nested git
Date: Tue, 7 Apr 2015 15:40:12 -0400
Message-ID: <CAPig+cQ9DD8BwG6-KDRqLzJSYh6O7c--GD0TR7-VAf_7PZx+Zw@mail.gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
	<1428320904-12366-2-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 21:40:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfZMC-0001uh-PR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 21:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbbDGTkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 15:40:15 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:34834 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbbDGTkO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 15:40:14 -0400
Received: by labbd9 with SMTP id bd9so38833383lab.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=GlpFP5mxUIj0dUdYFvLbFz4UvCWPbOrSWfkTDdxf6/o=;
        b=iY7VB6DqX9TY54HV5fCfOxtH1p6Sy7LgThos1TnwhSkM4FKJdOmWG3CUBEAZHXR/vv
         RE6YCmlIhF3wJkoewV5esgKN2XVh+aaPW3zTmLlysAVYy12/rtCvIJkxlKxTE7w2E489
         8k7zNr9Y4yFQhtMbziP1uqC6daS2eREX/pCEzIJ9Xfz0K2ZQAVu0aGgWDP5xGrw5N4pF
         57O5I6g/3+cqtZantW7TlU92zyFKzI0TZJcLMV5aNmmiVYK2p8GhubwnDUW3+ZyUGd+/
         fSsDrh24+JTJS4VYPWeG5zL8dpmP28dUIJmt7FirQPJt2V+vvfN3ygkc/sv1DtFmd2Zx
         TTwA==
X-Received: by 10.152.179.233 with SMTP id dj9mr16999156lac.101.1428435612910;
 Tue, 07 Apr 2015 12:40:12 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 7 Apr 2015 12:40:12 -0700 (PDT)
In-Reply-To: <1428320904-12366-2-git-send-email-erik.elfstrom@gmail.com>
X-Google-Sender-Auth: SeJSwN45_mwURUqOLE-e9ZK0dLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266935>

On Mon, Apr 6, 2015 at 7:48 AM, Erik Elfstr=C3=B6m <erik.elfstrom@gmail=
=2Ecom> wrote:
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 99be5d9..cfdf6d4 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -455,6 +455,88 @@ test_expect_success 'nested git work tree' '
> +test_expect_success 'giving path in nested git work tree will remove=
 it' '
> +       rm -fr foo &&
> +       mkdir foo &&
> +       (
> +               cd foo &&
> +               git init &&
> +               mkdir -p bar/baz &&
> +               cd bar/baz &&
> +               >hello.world

In my earlier review, I utterly forgot to  mention the broken &&-chain
here and throughout the patch.

> +               git add . &&
> +               git commit -a -m nested
> +       ) &&
> +       git clean -f -d foo/bar/baz &&
> +       test -f foo/.git/HEAD &&
> +       test -d foo/bar/ &&
> +       ! test -d foo/bar/baz
> +'
