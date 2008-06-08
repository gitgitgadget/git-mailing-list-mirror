From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH] A simple script to parse the results from the testcases
Date: Sun, 8 Jun 2008 02:34:25 +0200
Message-ID: <bd6139dc0806071734h16aa4218md051fbbe9f025f43@mail.gmail.com>
References: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
	 <1212884291-13847-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dsymonds@gmail.com
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 02:35:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K58t0-0007av-L8
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 02:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbYFHAea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 20:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbYFHAea
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 20:34:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:63968 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097AbYFHAe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 20:34:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1538066wfd.4
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 17:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=ihDh/44J5v9lyXjNsUzENH/XxSZgblTVnO2Du0MZ1wY=;
        b=YOWa2nTtWsswAcNrOyBqgdwECqB7rnaMBBLPSZkVkrRYg22Pdt+yGMdUJSLmtSeXBu
         e2R2EES25iQwVIw4miX+dRZcvupKAqI9go1ZfpjYs7XDvgmE453j/iqJCWz7XtpOOlmr
         OiBveWif0e1B4B/++x+IwYO9c7ezmWEjxZkn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=MNDyTBG6FQ+Ao4uYvS3D5wIQ25E4KB1BY/0p80qQHn+AaaNE7SdICaM54UI69o5ujS
         +F+UGVb1ZdCqEjGYVC386+UuhL99Brk2UZqhwynTBP7EOzPoUNldvANoIlZMZeBYTZx1
         6aMRAL5ckELOlStbmM8UIoV4JU1dBMpEypxtM=
Received: by 10.143.30.16 with SMTP id h16mr735995wfj.44.1212885265237;
        Sat, 07 Jun 2008 17:34:25 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Sat, 7 Jun 2008 17:34:25 -0700 (PDT)
In-Reply-To: <1212884291-13847-1-git-send-email-vmiklos@frugalware.org>
Content-Disposition: inline
X-Google-Sender-Auth: 1b7f8d87d2ea52ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84236>

On Sun, Jun 8, 2008 at 2:18 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> This is a simple script that aggregates key:value pairs in a file.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Mon, May 12, 2008 at 11:33:51AM +0200, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> This is a simple script that aggregates key:value pairs in a file.
>
> Here is a shell version. Just to avoid python.
>
>  t/key_value_parser.sh |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
>  create mode 100755 t/key_value_parser.sh
>
> diff --git a/t/key_value_parser.sh b/t/key_value_parser.sh
> new file mode 100755
> index 0000000..db568fe
> --- /dev/null
> +++ b/t/key_value_parser.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +input="/tmp/git-test-results"
> +
> +fixed=0
> +success=0
> +failed=0
> +broken=0
> +total=0
> +
> +while read type value
> +do
> +       case $type in
> +       '')
> +               continue ;;
> +       fixed)
> +               fixed=$(($fixed + $value)) ;;
> +       success)
> +               success=$(($success + $value)) ;;
> +       failed)
> +               failed=$(($failed + $value)) ;;
> +       broken)
> +               broken=$(( $broken + $value)) ;;
> +       total)
> +               total=$(( $total + $value)) ;;
> +       esac
> +done < $input
> +
> +printf "%-8s%d\n" fixed $fixed
> +printf "%-8s%d\n" success $success
> +printf "%-8s%d\n" failed $failed
> +printf "%-8s%d\n" broken $broken
> +printf "%-8s%d\n" total $total
> --
> 1.5.6.rc0.dirty

Awesome, what do you want to do with the other patches? I mean, this
patch on it's own doesn't make a lot of sense, but with [1/3] and
[3/3] I think it deserves some proper reviewing by the list.

-- 
Cheers,

Sverre Rabbelier
