From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 0/6] Move PGP verification out of verify-tag
Date: Mon, 18 Apr 2016 14:14:26 -0400
Message-ID: <CAPig+cSmb9wFCV+9PS4LYfd3hAH5s6ifRk8orVv+e2Q=h7F3Ag@mail.gmail.com>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Mon Apr 18 20:14:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asDgu-00034h-Ij
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 20:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbcDRSO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 14:14:28 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36366 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcDRSO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 14:14:27 -0400
Received: by mail-ig0-f196.google.com with SMTP id kb1so11901508igb.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=53UIJMmIHzeKvILk9MKvH2MA3itUgoylbBCKHjLqNw8=;
        b=Bu/yHnAyr6nji5RMj3PV5BpshUGhKJLxjKmmSnzBd6KnUfJ//drvi0tbH75TCyhKpl
         2fqVUJcdAsDc+eDgbutIT2FkMmPvY59gsHkhPZrdBnU23nTWf1z1nvsVcw3h01UGEJts
         dZF/jk9n5QxKlXKIBUabrnxLOqUsfm+oqrJMV/IcaAfZi6e08DYHz2nrwGLMbbFDN9Yk
         qp931lD1MtMDoGjBjXAyMhN1L19A2OhmMbqV1mx35CKIUqHA0DHkT7chSIA0G4mD5rlF
         dVzszeFV1d2MqbXAgHmhykk6Iiuu01gnAK/EBZ72h+sb0UueXlbbhHpxjqUqv4hzMZwY
         Nyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=53UIJMmIHzeKvILk9MKvH2MA3itUgoylbBCKHjLqNw8=;
        b=MrpXK8kgZcZ6nzrKR2WUh1FJ5IWMSjHZAVbgxzbnJWRgIQCs6M4IevnN7liHUyvU5c
         R/HyQ3RULGWiFTixjkbZozcAYakjwYf3qaVa879Jyib/38RD8StKq2Wo+A7YqbDl7HPO
         ZBLwGm1x3mRhG55U6bZ9N31iG9z6QPkOKBVN1UuqRrL1uu7mdxwuKJkv0a4z90ITDNO7
         VvT46ZDvvYc8On7QgovTyrkAJp6ufo6LEOIjk0NIEQ4n3+5armvj6hnreNAdgGQntgr7
         8BCCmFCx5M+BtqAn1AoqOnveeITYCcZZAP/JGISvmaEH5fzOS4I29HfrBkE/p4Lebchm
         yduw==
X-Gm-Message-State: AOPr4FUo5y6r9ejouUCPKah4coP4x6LDo2FGTP1cB6KVmI73gZUICZIGiW7Pmfe3nQXf9qj3WSdjaA067oYsDQ==
X-Received: by 10.50.92.37 with SMTP id cj5mr21223873igb.91.1461003266973;
 Mon, 18 Apr 2016 11:14:26 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 18 Apr 2016 11:14:26 -0700 (PDT)
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: a9KyCZl896lLPI8D-KZLjmC6f6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291816>

On Sun, Apr 17, 2016 at 6:26 PM,  <santiago@nyu.edu> wrote:
> This is a follow up of [1], [2], [3], [4], and [5]. patches 1/6, 2/6 and 3/6
> are the same as the corresponding commits in pu.
>
> v6:
>  * As Junio suggested, updated 4/6, to include the name argument and the
>    ternary operator to provide more descriptive error messages. I propagated
>    these changes to 5/6 and 6/6 as well. I'm unsure about the 80-column
>    on 4/6, the ternary operator is rather long.
>  * Updated and reviewed the commit messages based on Eric and Junio's
>    feedback

Thanks. See my responses to individual patches for a few very minor
issues, not necessarily even deserving a re-roll. With or without the
code and commit message nits addressed, this version is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
