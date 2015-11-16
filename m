From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5 5/6] git-p4: add trap to kill p4d on test exit
Date: Mon, 16 Nov 2015 08:43:54 +0000
Message-ID: <5649974A.1010903@diamand.org>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com> <1447592920-89228-6-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 09:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyFOJ-0003xj-L5
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 09:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbbKPInz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 03:43:55 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36512 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbbKPInz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 03:43:55 -0500
Received: by wmww144 with SMTP id w144so99851483wmw.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 00:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=A0Im18/SdrShmmFTOg7derXaOfCtas/7ouKGA/5Zo5A=;
        b=GEg1TT27+3p9flLw/5z1lYZ4Qa18/1LORD+dRmU6VfQ30n2msxP3ZGQ0JbNJUdDlk1
         HXIkZdyCme3i30w191QilympQ9G/0fEPQBoHbRrxPYuxqJnMz64fHbB94QTs5fYww5NU
         jeMg83LPqw7GFvPLpd5Ztm8E3NEbozPG6szq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=A0Im18/SdrShmmFTOg7derXaOfCtas/7ouKGA/5Zo5A=;
        b=WkyV7yCwVc/fICbWXZHcg7GBOCvEIlBGm3BQceWugZgkgsaM6zM73HIenVa6boHy/A
         ar7lhXUsJNqLeJoPv0x+jNnSu8dB8eufOcmQRAAq81l8xQFenvS8bl862girs1uwemmY
         3MrOziISIwkaMCrJkaNIK4HnJnUnPR5sRqiQwhSTNYv1zV6SuDWzK7Z4XMFC29kUoB0s
         Csm3tvyMOn3H/jPnpuZ7Ex40AJJyfqLbYh7hTRj2PrERP7CIWdrDsJy3UqPaeYxMk0/+
         ftwljbNe76a22wFeix0cx7X/3ETqitX2JaVxR6Lq6wUGfaDvdoKCL18kaULNBoNvgVv+
         cf9w==
X-Gm-Message-State: ALoCoQnAd7tdNZj8FcSUeH2mZqT3uWSuMmcjGzvmJUPODcUazwE7u/ssNg2nZgbRZ4Tvlzy5vhml
X-Received: by 10.28.93.145 with SMTP id r139mr16518688wmb.20.1447663433939;
        Mon, 16 Nov 2015 00:43:53 -0800 (PST)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id t126sm17364764wmd.18.2015.11.16.00.43.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2015 00:43:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1447592920-89228-6-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281332>

On 15/11/15 13:08, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Sometimes the "prove" test runner hangs on test exit because p4d is
> still running. Add a trap to always kill "p4d" on test exit.

With this change, I've started seeing this when running the tests:

cat: /home/lgd/git/git/t/trash 
directory.t9819-git-p4-case-folding/p4d.pid: No such file or directory

Probably just needs the obvious "test -f" adding.

Other than, all looks good to me. Particularly nice that I can now do:

$ make T=t98* -j10

and it actually works!





>
> You can reproduce the problem by commenting "P4D_TIMEOUT" in
> "lib-git-p4.sh" and running "prove ./t9800-git-p4-basic.sh".
> ---
>   t/lib-git-p4.sh | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index f2a009c..f9c68d4 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -65,6 +65,12 @@ cli="$TRASH_DIRECTORY/cli"
>   git="$TRASH_DIRECTORY/git"
>   pidfile="$TRASH_DIRECTORY/p4d.pid"
>
> +# Sometimes "prove" seems to hang on exit because p4d is still running
> +cleanup() {
> +	kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
> +}
> +trap cleanup EXIT
> +
>   # git p4 submit generates a temp file, which will
>   # not get cleaned up if the submission fails.  Don't
>   # clutter up /tmp on the test machine.
>
