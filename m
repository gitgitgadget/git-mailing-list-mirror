From: David Barr <davidbarr@google.com>
Subject: Re: [PATCHv2 1/2] rebase -i: optimize the creation of the todo file
Date: Fri, 9 Mar 2012 16:00:19 +1100
Message-ID: <CAFfmPPMt_o1Rg-Pvuh_KpARrASwfYSq74UN3ayp=LVzLJ0oj=A@mail.gmail.com>
References: <1331214777-9455-1-git-send-email-domq@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 06:00:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5rwL-0004JR-4K
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 06:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746Ab2CIFAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 00:00:22 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62281 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab2CIFAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 00:00:21 -0500
Received: by yhmm54 with SMTP id m54so684462yhm.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 21:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=InHuy9GMkMPM/sn/IQMLS2H7vjyZ4SqGCHYOD3/uV3E=;
        b=mDa+AHi/fwcDF4YalcvPL4dLTtX44VPDmKKFC++/Ky7IpHvFQePEpyqgHeiG/O9SUF
         8UuMwk4hTL6Rv8LJhpC2zBUMVJkKJDt2697/GY+QaM28TCNKnhtSP+2+mQhxRuAdO91q
         /7K7X6zUeDZYAk7yZBAHwAaFZyp5j5RmGjoFEf3FBhJ/QxeHtqRmUHsPnxNhVq1osTOS
         /3x8NOqmsk1lk2haEfOGKLhBIR4dQNM+pbVOX00ZgnTGp1fhFzmX5MrXc25O2MJYR9Gd
         cffFA6u6wdbDicPugh1Kw4CYaiQRe3hb9BUTvGusCWahzmKpB+H5rjplalih3mzpedIt
         NXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=InHuy9GMkMPM/sn/IQMLS2H7vjyZ4SqGCHYOD3/uV3E=;
        b=WIT7ojQFBfM9QgsbhcKLxWx9A72z5YG0uKibGWOYmgSxAgG0TzuV/y1X/iuHFJ8IvY
         1ZG4kQ5SwsOavDP8z8n1znFaPgKS/8iXLNoYkTElbYObeYanYJ6pL0kVbEeNVkdbtnCx
         JzehLEDT8e8GdTvSAySSB1He73tHYlvWgVvod8kWcI1Flq9tfvOKEgRHTPpgx/RSd2CI
         sXx3uJi8qzG/8uD7NXX3vtWA+YKdRJfOYWMZuC0pY19r1o1Tz6tn7wYct/ZtWnWz1s2H
         gAaFZyOVEsvMG+rKhM3cpR7pMnoce7xqKWOlhkxRgjwuZWtiqt3lyLTxVDvKqW5Vgpks
         VpuA==
Received: by 10.101.3.33 with SMTP id f33mr237229ani.80.1331269220119;
        Thu, 08 Mar 2012 21:00:20 -0800 (PST)
Received: by 10.101.3.33 with SMTP id f33mr237218ani.80.1331269219903; Thu, 08
 Mar 2012 21:00:19 -0800 (PST)
Received: by 10.101.154.34 with HTTP; Thu, 8 Mar 2012 21:00:19 -0800 (PST)
In-Reply-To: <1331214777-9455-1-git-send-email-domq@google.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnvZhRMe2d7rVO9hbZ1j9OeGMdPnxkMPRKFrQsEu38XoA3v15YYb0bXxTfvZQBm1IFI+VYaNmBZRTNUkpqqGK/5YzK7J4I9rnZXm5Wui/Wj/QLu/XntUD/O19UwD4l3JTvfLs+P+q6rQv4rKR39/2VFxTofkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192675>

On Fri, Mar 9, 2012 at 12:52 AM, Dominique Quatravaux <domq@google.com>=
 wrote:
> Instead of obtaining short SHA1's from "git rev-list" and hitting the=
 repository
> once more with "git rev-parse" for the full-size SHA1's, obtain both =
short and
> long SHA1's from "git log" at once.
> ---
> =A0git-rebase--interactive.sh | =A0 =A05 ++---
> =A01 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 5812222..e408e94 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -774,17 +774,16 @@ else
> =A0 =A0 =A0 =A0revisions=3D$onto...$orig_head
> =A0 =A0 =A0 =A0shortrevisions=3D$shorthead
> =A0fi
> -git rev-list $merges_option --pretty=3Doneline --abbrev-commit \
> +git rev-list $merges_option --format=3D"%m%H %h %s" --abbrev-commit =
\
> =A0 =A0 =A0 =A0--abbrev=3D7 --reverse --left-right --topo-order \
> =A0 =A0 =A0 =A0$revisions | \
> =A0 =A0 =A0 =A0sed -n "s/^>//p" |
> -while read -r shortsha1 rest
> +while read -r sha1 shortsha1 rest
> =A0do
> =A0 =A0 =A0 =A0if test t !=3D "$preserve_merges"
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf '%s\n' "pick $shortsha1 $rest" =
>> "$todo"
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sha1=3D$(git rev-parse $shortsha1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if test -z "$rebase_root"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0preserve=3Dt
> --
> 1.7.7.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Ack. Yay, less forking.

I do notice however that the output being fed to sed expands like so:

  commit >634a5f265ad729b91266de65272e2b5a35d05b1c
  >634a5f265ad729b91266de65272e2b5a35d05b1c 634a5f2 INSTALL: warn [...]
  commit >828ea97de486c1693d6e4f2c7347acb50235a85d
  >828ea97de486c1693d6e4f2c7347acb50235a85d 828ea97 Git 1.7.9

Maybe the format spec and sed command could use a little tuning.

--
David Barr
