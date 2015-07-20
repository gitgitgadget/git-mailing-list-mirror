From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 14:50:06 -0400
Message-ID: <CAPig+cQ_G=Ar0uxbxDaO6oEZwkRi7FM4qEQexDohDGxN10OJUA@mail.gmail.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:50:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHG8l-0002xp-7k
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbbGTSuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:50:10 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36215 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbbGTSuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 14:50:07 -0400
Received: by ykay190 with SMTP id y190so146110456yka.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9P/3u8nAiGOipaH1iwVp/d6vNFhUNU634lmiDJxPHO4=;
        b=xGTjD44WroSmXFkfmQbds+J8SpE4Q/Js4xx5b9DvqM8GF7Mc27GK6ltDU7xeyfx4+A
         +JwXDp1RO827970e26Ky4+IVRVX5cKWJstA8P+emYPGQ92hg1LfMi4LNd0mLOw3DsKoj
         U32gqrOyOz7eUDv9kguQ5RDkyoWtjxQlXrCA5iIvI3of68snzu+ktKuxivhHBJZpz5TJ
         aL/lvlpSD6+oFyVBmgdO406ntt4kbKhhFvUZIP3d0EK07bHITIxRaGpRbpIxH+gHVY1R
         RQOx1Y2fCC/Ji+grPZzLZO5J2MT/rh2PG5xCyYNeiyKoMpUOAga7kyOm/vFt9lUAyEBg
         jbPg==
X-Received: by 10.170.220.214 with SMTP id m205mr29595509ykf.13.1437418206912;
 Mon, 20 Jul 2015 11:50:06 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 11:50:06 -0700 (PDT)
In-Reply-To: <1437416790-5792-5-git-send-email-philipoakley@iee.org>
X-Google-Sender-Auth: 6OflJmPLi1Gmoxx0NFhwo889xi8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274347>

On Mon, Jul 20, 2015 at 2:26 PM, Philip Oakley <philipoakley@iee.org> wrote:
> Explain how the cc-cmd (and to-cmd) is invoked, along with two
> simple examples (and a how-not-to example) to help in getting started.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index ddc8a11..9f991cf 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -436,6 +436,42 @@ following commands:
>  Note: the following perl modules are required
>        Net::SMTP::SSL, MIME::Base64 and Authen::SASL
>
> +Creating a cc-cmd (and to-cmd) action
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +git-send-email invokes the cc-cmd like this:
> +
> +       $cc-cmd $patchfilename
> +
> +Thus the patch itself can be processed to locate appropriate email address
> +information if required.
> +
> +A simple solution for a basic address list is to create a 'cc-cmd' file
> +(executable) which provides a list of addressees:

Rather than calling this a "simple solution", you might instead say
that this is an example of a bare-bones script which just returns a
fixed list of email addresses without attempting to extract any
addresses from the patch file itself.

> +       #!/bin/sh
> +       echo <<\EOF
> +       person1@example.com
> +       person2@example.com
> +       EOF

I don't know if it deserves mention that the script must be executable
(chmod +x) or should we assume that readers are smart enough to
understand this implicitly? (It probably should be mentioned.)

Other than those minor points, the above looks fine, however...

> +Simply, using `cat cc-cmd` as the --cc-cmd (with cc-cmd as the text file
> +of email addresses), does not work as expected as the invocation becomes:
> +
> +       $cat cc-cmd $patchfilename
> +
> +and since 'cat' copies the concatenation of its input files to its output,
> +this adds the patch file to the address list resulting in an error
> +"unable to extract a valid address from:".
> +
> +The quick-and-dirty work-around is to use '#' to effectively comment out
> +the patch file name:
> +
> +    --cc-cmd='cat cc-cmd #'
> +
> +which works, but is very, very ugly.

This entire above text about "cat $addressfile" seems awfully
inappropriate for a manual page, especially the bit about the terrible
"cat $file #" hack.

>  SEE ALSO
>  --------
>  linkgit:git-format-patch[1], linkgit:git-imap-send[1], mbox(5)
> --
> 2.4.2.windows.1.5.gd32afb6
>
