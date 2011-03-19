From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/9] vcs-svn: avoid using ls command twice
Date: Sat, 19 Mar 2011 03:01:29 -0500
Message-ID: <20110319080129.GA6706@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300518231-20008-3-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 09:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0r6k-0003JE-Kg
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 09:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab1CSIBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 04:01:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57038 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab1CSIBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 04:01:44 -0400
Received: by iwn34 with SMTP id 34so4760012iwn.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2hPXu+oDa0f0kG6dAKTj4psIL/5dZOlJEm7QBvIvzvA=;
        b=uQEIdvDfndpfnzme8WhaKxnsagv1BVb5KwTOziwLEJTuxZ/BK6ZhK7uIfJntOlukr/
         sznhWEcHolwkiYERzHlVRB25zA6oZa5zp7dgOl6iIgXmMLQVr6JcfZGfWZpzcReQxZxR
         ZH8nEESnPX3U/Qx17V2eB3aeVRR0aGvslf4as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ess0InaXISP4I2sChWkj58JJVn7Lch2bka/nO2grQ5i5kpdawttP6jbVf5odIqvo9c
         O2loZjL2wiMZXV37Ih9EyyI8/lxsRwf9766EsQRkmIM1Gf2d5OXJm7GoGz/6oo59Jxxu
         grHGoAYdeAruUr/suaVBRKa1YFilehHoHZ6kk=
Received: by 10.43.45.66 with SMTP id uj2mr2904344icb.514.1300521704204;
        Sat, 19 Mar 2011 01:01:44 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id xi12sm2410987icb.18.2011.03.19.01.01.39
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 01:01:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300518231-20008-3-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169414>

David Barr wrote:

>  3 files changed, 6 insertions(+), 24 deletions(-)

:)

> --- a/vcs-svn/repo_tree.c
> +++ b/vcs-svn/repo_tree.c
> @@ -8,39 +8,23 @@
>  #include "repo_tree.h"
>  #include "fast_export.h"
>  
> -const char *repo_read_path(const char *path)
> +const char *repo_read_path(const char *path, uint32_t *mode_out)

Obviously good, both because it means we can use one round-trip
to get the same information that  previously took two and because
the API just makes more sense.  Thanks.
