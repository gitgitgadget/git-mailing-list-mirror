From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 06/10] remote-hg: disable forced push by default
Date: Tue, 14 May 2013 15:23:08 -0500
Message-ID: <51929d2c37125_13a8f89e181936@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLoB-00017b-CW
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222Ab3ENU0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:26:47 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:56801 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab3ENU0q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:26:46 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so1201101oag.25
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=RWOU8bXXtn+xd8rDlf0EUjJcSJmlpaxU2YswlYT8Bqc=;
        b=NphTwPama6/sCBXz60whgzkxBXadGHm1uXJUna025+R5O8kdtx2Bm11B/vHUOtnhnb
         VSIRbAGFnixUkzXTrY5q8dp6aQxc2CR65/yunYGHEw4oh52HrFRhZJeuZsiygJO1XI1S
         RHcxV0/v6BVY838N78/rqqg1OkFTyoSZnBfuLKK4PqU2pnCTaZVk/H6n+/y5cnK/YhId
         M3RtUOfN0aNQBvIQOsT6Dcj4F7U0hKGuEj8RAlbwNdORSGwg5oCY6IBEbsF94fTU2u7+
         eyMV5a7mMl1cOutW06O1/5MeCVjT+AoD7PnMquPhH5egVwJB+ChPPnlIsA8zQK7f6IuU
         0l5g==
X-Received: by 10.60.85.74 with SMTP id f10mr17642114oez.32.1368563206033;
        Tue, 14 May 2013 13:26:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm23197957obg.3.2013.05.14.13.26.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:26:45 -0700 (PDT)
In-Reply-To: <1368486720-2716-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224338>

And here is the important fix. We are essentially reverting back to the old
v1.8.2 behavior, to minimize the possibility of regressions, but in a way the
user can configure.

The cleanups before made it so this patch eas easy and simple.

And the fix before this makes it so the new default force_push=False still is
able to push new branches, so we don't disable other v1.8.3 features.

Felipe Contreras wrote:
> In certain situations we might end up pushing garbage revisions (e.g. in
> a rebase), and the patches to deal with that haven't been merged yet.
> 
> So let's disable forced pushes by default.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 3cf9b4c..53412dd 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -914,7 +914,7 @@ def main(args):
>  
>      hg_git_compat = get_config_bool('remote-hg.hg-git-compat')
>      track_branches = get_config_bool('remote-hg.track-branches', True)
> -    force_push = get_config_bool('remote-hg.force-push', True)
> +    force_push = get_config_bool('remote-hg.force-push')
>  
>      if hg_git_compat:
>          mode = 'hg'
> -- 
> 1.8.3.rc1.579.g184e698



-- 
Felipe Contreras
