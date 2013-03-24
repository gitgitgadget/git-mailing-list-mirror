From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Sat, 23 Mar 2013 20:57:27 -0400
Message-ID: <CAPig+cT+MgTmhqUXpSGEtiqjgerFA6asUMg7wg=-Vee85MVKoQ@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
	<1363781779-14947-1-git-send-email-pclouds@gmail.com>
	<7v1ubaeyph.fsf@alter.siamese.dyndns.org>
	<20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal>
	<20130321054349.GA18101@duynguyen-vnpc.dek-tpc.internal>
	<7v4ng4br1y.fsf@alter.siamese.dyndns.org>
	<7vvc8kabhx.fsf@alter.siamese.dyndns.org>
	<20130323031334.GA10484@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 01:58:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJZGB-0001JS-Ap
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 01:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab3CXA5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 20:57:30 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:36145 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab3CXA5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 20:57:30 -0400
Received: by mail-la0-f53.google.com with SMTP id fr10so9319414lab.40
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=+iZi0bONEw21UN+lgXpEt85/HnLBfYNPByTK3S9zi7Q=;
        b=HMpjl1xyOswn1pPLjw4Q0PGc4hzTum+vsuJ/ZPegeROlP3Yt+9sKuVZLBdUV2zdYmZ
         h2lXJuvFKGdWon2TQUEybwTy0yt4c1thfCVSEEXEa5KOKb4St1TdnHYL0b2yVKH/CO/3
         MaStUG0i5SAgwc2OgLPmjqheZBz2HoRNqQ8wIWpL3Nl1ZsyhQubR9GRi1SKysNWL9lZz
         sKbZhFfJz+Z4pfAfIdWFOj3ryT8ZnO/L2+ABY10ejnz7YpIgt3ST9U6Na1z3eQyAM10k
         wZDq7bE7J1CcvELCIqIWrPfDvyyG62M39SHalKxza3HCujZlfZG27IP45iyKT0rYyA4z
         5CYA==
X-Received: by 10.152.105.109 with SMTP id gl13mr3430146lab.40.1364086647215;
 Sat, 23 Mar 2013 17:57:27 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sat, 23 Mar 2013 17:57:27 -0700 (PDT)
In-Reply-To: <20130323031334.GA10484@lanh>
X-Google-Sender-Auth: UStFj-QloVGUq79VHvVeaMmI9y8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218927>

On Fri, Mar 22, 2013 at 11:13 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> diff --git a/setup.c b/setup.c
> index e59146b..6cf2bc6 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -5,24 +5,37 @@
>  static int inside_git_dir = -1;
>  static int inside_work_tree = -1;
>
> -char *prefix_path_gently(const char *prefix, int *p_len, const char *path)
> +/*
> + * Normalize "path", prepending the "prefix" for relative paths. If
> + * remaining_prefix is not NULL, return the actual prefix still
> + * remains in the path. For example, prefix = sub1/sub2/ and path is

s/still remains/still remaining/
...or...
s/still remains/which still remains/
...or...
s/still remains/which remains/
