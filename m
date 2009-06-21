From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/7] Modify fast-export testcase to check that we correctly
 omit tags of trees
Date: Sat, 20 Jun 2009 22:53:27 -0700
Message-ID: <4A3DCAD7.4030701@gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com> <1245472623-28103-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusambite@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Sun Jun 21 07:53:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIFzq-0002Od-BD
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 07:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbZFUFx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 01:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZFUFx2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 01:53:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:33027 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbZFUFx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 01:53:27 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1212877wfd.4
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fw52wEPa6/bln5E3bza2bpoZc4iIdPyCmMOZ0vLs4mc=;
        b=m1SdJJy+1NomEuwhNjyRtTWqiDTlWQgCoE0NxYrvI3kGO5iunIrMrcjw6Id26KUPo5
         eTI4rzlVhKyLfaPSb4Px3LM4zbbO3XL7VmTLia9OXA5UIZM4yv2/9ry9nkLQ5jpOjIec
         CcmjFqa9XpGjxrw1ppt5Ba0358tFX8bQ4uzBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lqy1Lf/S6malz0QHGVnS91fn3QrTluBv5D7FhYNBLBz7Rup316yga84oCaWwHlDc47
         6H3huOd2U77Kptds4Qerk5TqLCegyX6Khq6sDhToN3iTFdA/tGZC+sZrFDsHAQ6wxgpc
         XjEgF2Zb7rNbaMTLWYOZBt3cizI//+qlR/tdc=
Received: by 10.143.1.2 with SMTP id d2mr1212361wfi.296.1245563610193;
        Sat, 20 Jun 2009 22:53:30 -0700 (PDT)
Received: from ?10.10.0.5? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 30sm392635wfd.21.2009.06.20.22.53.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 22:53:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <1245472623-28103-3-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121965>

newren@gmail.com wrote:
> Should I have just squashed this with the previous patch?  Or with the
> other testcase patch?

I think squashing it with the previous one is better as long as this is
directly related to patch 1.

>
>  t/t9301-fast-export.sh |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
> index 8c8a9e6..d17f0e4 100755
> --- a/t/t9301-fast-export.sh
> +++ b/t/t9301-fast-export.sh
> @@ -272,7 +272,13 @@ test_expect_success 'set-up a few more tags for tag export tests' '
>  '
>  
>  # NEEDSWORK: not just check return status, but validate the output

Is this comment still relevant?

> -test_expect_success 'tree_tag'        'git fast-export tree_tag'
> +test_expect_success 'tree_tag'        '
> +	mkdir result &&
> +	cd result &&
> +	git init &&
> +	cd ..
> +	git fast-export tree_tag | (cd result && git fast-import)
> +'
>  test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
>  test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
>  test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'

I don't really know, but could test_create_repo() be useful here?
