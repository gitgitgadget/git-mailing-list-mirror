From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 10/23] untracked cache: save to an index extension
Date: Tue, 9 Dec 2014 18:28:30 -0500
Message-ID: <CAPig+cTB6=aFR8HFOtdbGi1h9EXcOdfNB=N=THz-DgzytQ2ceA@mail.gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
	<1418047507-22892-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 00:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyUCp-0000FE-PK
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 00:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbaLIX2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 18:28:32 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:38900 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbaLIX2b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 18:28:31 -0500
Received: by mail-yk0-f179.google.com with SMTP id 19so730773ykq.38
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 15:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=4TimyVkLb5vB5Z34o2qAD8EhDkBC0jRuxwajwNt1ljs=;
        b=N8gzwG+TvqgFsWBRG4XkysrA85yrYcvK+18hfY34DfC2Rz/A/eMCRFkwCo8ai7rQ68
         Ft+kp95XL4XuI0RjjrvMkRoz+MJCUR5y+zQftckmGF6IMzOuFLAABBKCxYNBDBRvjmIe
         bnmx1kb5zHU91laa+0PhGcWO1MnZJFWN+jY1OblJ9xO9FGe31vYrZQ+7ewfqoa/2iZaK
         ee4d4j5gxwYPCNTWY078S7kn+QXfJZf5hKDZf/cwM8uI7gZ+SJC1JqUbD15+je82YUAX
         BVjAxqBEwDmJqko7U+nE/pvwm1kbieusFvCQBJNWB+3ffnjhvTB2F6BL467/JqLPKflC
         nHwA==
X-Received: by 10.170.130.21 with SMTP id w21mr779549ykb.22.1418167710987;
 Tue, 09 Dec 2014 15:28:30 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Tue, 9 Dec 2014 15:28:30 -0800 (PST)
In-Reply-To: <1418047507-22892-12-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 7JO9FiJxfITu4CWOqoATvrQQZuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261178>

On Mon, Dec 8, 2014 at 9:04 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/technical/index-format.txt b/Documentation=
/technical/index-format.txt
> index fe6f316..b97ac8d 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -233,3 +233,61 @@ Git index format
>    The remaining index entries after replaced ones will be added to t=
he
>    final index. These added entries are also sorted by entry namme th=
en
>    stage.
> +
> +=3D=3D Untracked cache
> +
> +  Untracked cache saves the untracked file list and necessary data t=
o
> +  verify the cache. The signature for this extension is { 'U', 'N',
> +  'T', 'R' }.
> +
> +  The extension starts with
> +
> +  - Stat data of $GIT_DIR/info/exclude. See "Index entry" section fr=
om
> +    ctime field until "file size".
> +
> +  - Stat data of core.excludesfile
> +
> +  - 32-bit dir_flags (see struct dir_struct)
> +
> +  - 160-bit SHA-1 of $GIT_DIR/info/exclude. Null SHA-1 means the fil=
e
> +    does not exist.
> +
> +  - 160-bit SHA-1 of core.excludesfile. Null SHA-1 means the file do=
es
> +    not exist.
> +
> +  - NUL-terminated string of per-dir exclude file name. This usually
> +    is ".gitignore".
> +
> +  - The number of following directory blocks, variable width
> +    encoding. If this number is zero, the extension ends here with a
> +    following NUL.
> +
> +  - A number of directory blocks in depth-first-search order, each
> +    consists of
> +
> +    - The number of untracked entries, variable witdh encoding.

s/witdh/width/

> +    - The number of sub-directory blocks, variable with encoding.

s/with/width/

> +    - The directory name terminated by NUL.
> +
> +    - A number of untrached file/dir names terminated by NUL.
> +
> +The remaining data of each directory block is grouped by type:
> +
> +  - An ewah bitmap, the n-th bit marks whether the n-th directory ha=
s
> +    valid untracked cache entries.
> +
> +  - An ewah bitmap, the n-th bit records "check-only" bit of
> +    read_directory_recursive() for the n-th directory.
> +
> +  - An ewah bitmap, the n-th bit indicates whether SHA-1 and stat da=
ta
> +    is valid for the n-th directory and exists in the next data.
> +
> +  - An array of stat data. The n-th data corresponds with the n-th
> +    "one" bit in the previous ewah bitmap.
> +
> +  - An array of SHA-1. The n-th SHA-1 corresponds with the n-th "one=
" bit
> +    in the previous ewah bitmap.
> +
> +  - One NUL.
