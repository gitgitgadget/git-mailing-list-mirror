From: Johan Herland <johan@herland.net>
Subject: Re: What is an efficient way to get all blobs / trees that have notes attached?
Date: Fri, 1 Apr 2016 14:23:32 +0200
Message-ID: <CALKQrgdONBZOgw5--x35Gq2+2fze=mm1t_162UgC0W12JGg6Hw@mail.gmail.com>
References: <ndljs8$vj3$1@ger.gmane.org>
	<CALKQrgdytYJtMTBHXbcRQ_iT5rWakZCxxqRW1rpLsPiSejud-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 14:23:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aly77-0004tM-7z
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 14:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbcDAMXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 08:23:41 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:57931 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbcDAMXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 08:23:41 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Apr 2016 08:23:40 EDT
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1aly70-0001Md-Jp
	for git@vger.kernel.org; Fri, 01 Apr 2016 14:23:38 +0200
Received: from mail-yw0-f177.google.com ([209.85.161.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1aly70-0001V5-DK
	for git@vger.kernel.org; Fri, 01 Apr 2016 14:23:38 +0200
Received: by mail-yw0-f177.google.com with SMTP id h65so155324705ywe.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 05:23:38 -0700 (PDT)
X-Gm-Message-State: AD7BkJLN0EX42GoqhEjJLA/ctIz93/RGdsLWn+diKEb5U0y5pjHYnp+dQE3jMarDiz1xTMGACIM7Yjc0NqxfYQ==
X-Received: by 10.37.69.3 with SMTP id s3mr4669632yba.119.1459513412446; Fri,
 01 Apr 2016 05:23:32 -0700 (PDT)
Received: by 10.37.75.133 with HTTP; Fri, 1 Apr 2016 05:23:32 -0700 (PDT)
In-Reply-To: <CALKQrgdytYJtMTBHXbcRQ_iT5rWakZCxxqRW1rpLsPiSejud-Q@mail.gmail.com>
X-Gmail-Original-Message-ID: <CALKQrgdONBZOgw5--x35Gq2+2fze=mm1t_162UgC0W12JGg6Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290530>

On Fri, Apr 1, 2016 at 2:16 PM, Johan Herland <johan@herland.net> wrote:
> for notes_ref in $(git for-each-ref refs/notes | cut -c 49-)
> do
>     echo "--- $notes_ref ---"
>     for annotated_obj in $(git notes --ref=$notes_ref list | cut -c 41-)
>     do
>         type=$(git cat-file -t "$annotated_obj")
>         if test "$type" != "commit"
>         then
>             echo "$annotated_obj: $type"
>         fi
>     done
> done
>
> Can probably be made even faster by using the --batch option to cat-file...

For example:

for notes_ref in $(git for-each-ref refs/notes | cut -c 49-)
do
    echo "--- $notes_ref ---"
    git notes --ref=$notes_ref list | cut -c 42- | git cat-file
--batch-check="%(objecttype) %(objectname)" | grep
'^\(\(blob\)\|\(tree\)\) '
done


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
