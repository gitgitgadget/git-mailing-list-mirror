From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] git-p4: Disable t9819 git-p4-case-folding test on OS X
Date: Sun, 04 Oct 2015 11:26:23 -0700
Message-ID: <xmqqa8ry1ods.fsf@gitster.mtv.corp.google.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
	<1443981977-64604-5-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 04 20:26:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZinzR-0005XS-IX
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbbJDS00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:26:26 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33409 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbJDS0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:26:25 -0400
Received: by pacex6 with SMTP id ex6so153725904pac.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TXeBGCOJ8BdSvyxfraSrZ4YNgNb4NAvkF0KH7Ba7lHY=;
        b=N12D8A1geuCc3TPaoxQ2MTmnKpO8pZs3SNL0f2A/GCSfQnxp1N1WBodxPPmcXLxKaS
         0Ev0irHSWgtocHhYH92shNLn5WTDzRDICmVIIOHk+SSVJy71IKDT4On4IrXnCI+zb8Gb
         aZn+q9WIcNbBcbavDK9NF+G/EEo2BAWGOutMG9A8Ee9Lv3/qOMKsSVt8qxTfhA4uqOsP
         wyv+z4mBPe9Pna4Sh7xvttwwkl2bVOIY17GgbeobzUIe/ho63tNj+j5hfB8Uft9FGnkH
         nPNrtjXx10zCrL1DpM93Wk5GLtsCezwcifCvpe8CR4jnWMRI1yaxC8q/fUb26XV7bh1d
         wfGQ==
X-Received: by 10.66.160.194 with SMTP id xm2mr33979390pab.111.1443983184871;
        Sun, 04 Oct 2015 11:26:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id dg2sm11977619pbb.9.2015.10.04.11.26.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:26:24 -0700 (PDT)
In-Reply-To: <1443981977-64604-5-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 4 Oct 2015 11:06:17
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279017>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> The OS X file system is case insensitive by default. Consequently this
> test does not apply.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/t9819-git-p4-case-folding.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
> index 78f1d0f..c69ae47 100755
> --- a/t/t9819-git-p4-case-folding.sh
> +++ b/t/t9819-git-p4-case-folding.sh
> @@ -4,6 +4,11 @@ test_description='interaction with P4 case-folding'
>  
>  . ./lib-git-p4.sh
>  
> +if test_have_prereq DARWIN; then
> +	skip_all='skipping P4 case-folding tests; OS X file system is case insensitive by default'
> +	test_done
> +fi

Makes one wonder what should happen on Windows, or vfat mounted on
Linux for that matter.  IOW, shouldn't the prerequisite be more like
"do not run any of these tests if the filesystem does not allow us
to have two files in different cases at the same time"?

Perhaps

        if ! test_have_prereq CASE_INSENSITIVE_FS
        then
                skip_all=...
                test_done
        fi

instead, or something?
