From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add ls-files --eol-staged, --eol-worktree
Date: Sun, 18 Oct 2015 10:35:23 -0700
Message-ID: <xmqqpp0caxlw.fsf@gitster.mtv.corp.google.com>
References: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 18 19:35:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znrs1-0001Ik-MQ
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 19:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbbJRRf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2015 13:35:26 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33176 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbbJRRfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 13:35:25 -0400
Received: by pabrc13 with SMTP id rc13so166963694pab.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=YkoS6MczTszO7bSyElme1pnMZ/oMOa1XNjmno3qHBus=;
        b=evQh4nt8kCQs0xl+igUpYMFDA8ukKDNqsiLqXa4ByzXMnTELTFUpxq20fRsiRv+rsc
         EHKqCh7YOkzxhAnWM7+6kcQz48W3rIHbMI+bIpqmx5hnl8nZQ7aq8WBTi1HGm4uerRsN
         K4jxQE+uKmD2/JoQ/GePG/PYedAzslNKBOQcefxQQmitYE/gMWVtZL1P5jdXQUHJLSDj
         fWQpNtrERWCTDlDGtFVRU1wcMVYucdTTowqTHO2uXMzhsVNKHrIvpgrpZUOa3euLF1sb
         7pg+qAs1VzP5MOKFnLjY/V1lK2yoESssALgYk/wJcsFxGtnZGUkUDOnHLpA3N4mBHlDy
         +88g==
X-Received: by 10.66.248.10 with SMTP id yi10mr30002061pac.6.1445189725122;
        Sun, 18 Oct 2015 10:35:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:305b:5af5:2c51:11cd])
        by smtp.gmail.com with ESMTPSA id tk4sm32310426pab.45.2015.10.18.10.35.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 10:35:24 -0700 (PDT)
In-Reply-To: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sat, 17 Oct 2015 22:18:06
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279816>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Make it possible to show the line endings of files.
> Files which are staged and/or files in the working tree:
>
> git ls-files --eol-staged
> git ls-files --eol-worktree
>
> Both will show an output like this:
>
> empty    empty_file
> bin      binary_file_or_with_cr_handled_as_binary
> txt-crlf text_file_with_crlf
> txt-mix  text_file_with_crlf_and_lf
> txt-lf   text_file_with_lf
> txt      text_file_with_no_eol_at_all

This _may_ be readable by who implemented it, but I cannot tell what
you are trying to say above; "like this" does not help me at all
deciphering.

Do I get the above after doing this?

    $ >empty
    $ >empty2
    $ git ls-files --eol-worktree
    empty empty_file
    empty2 empty_file

or do you mean this?

    $ >empty_file
    $ >empty_file2
    $ git ls-files --eol-worktree
    empty empty_file empty_file2

or do you produce output one path at a time?

    $ >empty_file
    $ >empty_file2
    $ git ls-files --eol-worktree
    empty empty_file
    empty empty_file2

> txt      text_file_with_no_eol_at_all

Does it help to have this category at all?  This gives the user an
indication that this file consists on a single incomplete line and
differentiates it from a file with the same single line with LF or
CR/LF line ending.  What happens when I prepend to these three files
another copy of the same line with LF or CR/LF line ending?  You get
6 variations:

 1. line LF line
 2. line LF line LF
 3. line LF line CRLF
 4. line CRLF line
 5. line CRLF line LF
 6. line CRLF line CRLF
   =20
If you say 1 and 2 are with LF, 4 and 6 are with CRLF, eveyrything
else is mixed, then you are losing the distinction between 1 and 2
(and 4 and 6) that you made when the files were a single liner (with
or without the incomplete line ending).  Is that desirable?

I wonder if it would be easier for the scripts that process the
output from this command to handle if the report said what
combination of _three_ possible line-ending is used.  i.e. does the
file contain a line that ends with LF? does the file contain a line
that ends with CRLF? does the file contain a line with missing EOL?


> Implementation details:
> Make struct text_stat, is_binary() and gather_stats() from convert.c
> public, add a new function get_convert_stats_ascii() and use it
> in and use them in ls-files.
> git ls-files --eol-staged will give a line like this:
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

This is even worse than the "like this" above ;-)
