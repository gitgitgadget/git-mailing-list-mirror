From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 08/11] t6050-replace: check that -f option bypasses the
 type check
Date: Sun, 1 Sep 2013 03:50:44 -0400
Message-ID: <CAPig+cTSTk7f+EwwwMZpNU5QsiU3_Nu92aQz1AsZ2bSGzEgcTg@mail.gmail.com>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
	<20130831191215.26699.37671.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Sep 01 09:51:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG2R3-0003ob-OA
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 09:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab3IAHur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 03:50:47 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:60304 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab3IAHuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 03:50:46 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so2656456lab.4
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6xldJkVp/x593tK8qtWYQk/zZbV0WzfzLj0AwY8d8dk=;
        b=QgYVrfz2aWgRG7/GiuNp+ayGMPy191In9wlrvefV869j7lMNPFmV7D2CcrO5wS8pBs
         DAllyNHplI8LFO2PGruwpbmbFK9U+s83UNmCsEQDjQVEizWFVEY5Xjl3T33M6BRclD2B
         dC3kzIlT526MyxEo2bYSsqH+IufAlB2pEHTg0xkQGC+bQ1zH1YJx5i6L+/xMb99c50cX
         us8WDetsjtkyjMeWjBHTgIKjpCstQbmA7lJbq7Wm59lxH7zOAfYuC08bDngJgjOOe56z
         NkGk7vSv4pUjPXsteyfyv1uQddzGSfTwtlZs1m76Ewr8Cl27xUOE2tM9QlA63lsql25q
         rQLg==
X-Received: by 10.152.8.115 with SMTP id q19mr15998885laa.16.1378021844330;
 Sun, 01 Sep 2013 00:50:44 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 1 Sep 2013 00:50:44 -0700 (PDT)
In-Reply-To: <20130831191215.26699.37671.chriscool@tuxfamily.org>
X-Google-Sender-Auth: Dl3cagnAFcPwsEhrd9EtrfdctsY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233570>

On Sat, Aug 31, 2013 at 3:12 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t6050-replace.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index 05be228..0b07a0b 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -276,6 +276,12 @@ test_expect_success 'replaced and replacement objects must be of the same type'
>         grep "$BLOB. points to a replacement object of type .blob" err
>  '
>
> +test_expect_success '-f option bypasses the type check' '
> +       git replace -f mytag $HASH1 2>err &&
> +       git replace -f HEAD^{tree} HEAD~1 2>err &&
> +       git replace -f HEAD^ $BLOB 2>err
> +'

Is there a non-obvious reason you are redirecting stderr to a file in
this test? Unlike the test added earlier, this one never consults the
error output. By dropping this apparently unnecessary redirection,
diagnosis of a regression potentially becomes simpler since any error
output from git-replace will become visible when the test is run
verbosely.

> +
>  test_expect_success 'replace ref cleanup' '
>         test -n "$(git replace)" &&
>         git replace -d $(git replace) &&
> --
> 1.8.4.rc1.31.g530f5ce.dirty
