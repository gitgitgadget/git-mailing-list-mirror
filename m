X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by hand.yhbt.net (Postfix) with ESMTP id 321E22DC01B
	for <normalperson@yhbt.net>; Mon,  3 Nov 2008 19:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYKCTR4 (ORCPT <rfc822;normalperson@yhbt.net>);
	Mon, 3 Nov 2008 14:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbYKCTR4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:17:56 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:48345 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbYKCTRz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 14:17:55 -0500
Received: by mu-out-0910.google.com with SMTP id g7so2911173muf.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 11:17:51 -0800 (PST)
Received: by 10.187.210.3 with SMTP id m3mr119631faq.59.1225739871027;
        Mon, 03 Nov 2008 11:17:51 -0800 (PST)
Received: from ?192.168.1.11? (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id k1sm21353424ugf.3.2008.11.03.11.17.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 11:17:49 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=peuzB7Cuztv50RMyxbi3VJqULtZvM0wxXySUC7YBDxU=;
        b=DWJ2jmoFq1OEJu+Q3A0qpqgfjUV4+5rkouBSm4+M4jG1Vf7TYeDua5x5shRx7/kwjn
         f0UAQ6NctgixMTa2xoS25TFBzLAoN6jUmHuj617+IkRyqik/vIX2/sPtx1hNE/GXJ2J0
         TbHWBbrymREoZXanxyEhPOvsgGogkKkCu1R+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=P78+PRefrdD5HkJ6lZbRljGyhGL4mjTJBt3XfOujZSRHJDlsD/UhGSEYcaNJtPaTGL
         MLGCDYnT8R8yQNZAN8sm5df1HE15qpp99He+Ty2eUeZaAYfhrrNYkFe9n/KfKVOLfv4P
         va9PHq/UpYjze1sRX+kjMsFtuoCWgqLjzVeBI=
From:	Jakub Narebski <jnareb@gmail.com>
To:	Francis Galiegue <fg@one2team.net>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date:	Mon, 3 Nov 2008 20:17:47 +0100
User-Agent: KMail/1.9.3
Cc:	"Alexander Gavrilov" <angavrilov@gmail.com>, git@vger.kernel.org
References: <200811031943.30033.angavrilov@gmail.com> <m38ws0fzca.fsf@localhost.localdomain> <200811031944.03116.fg@one2team.net>
In-Reply-To: <200811031944.03116.fg@one2team.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200811032017.47652.jnareb@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Dnia poniedziałek 3. listopada 2008 19:44, Francis Galiegue napisał:
> Le Monday 03 November 2008 19:18:56 Jakub Narebski, vous avez écrit :

> > > Well, as far as Apache is concerned, it can do:
> > > 
> > > * basic .htpasswd authentication,
> > > * LDAP,
> > > * PAM,
> > > * SSL certificate check (via mod_ssl),
> > > * probably others.
> > > 
> > > Plenty of possibilities.
> > [...]
> > 
> > Well, the question is if Apache (and other web servers used with
> > gitweb) can do authentication based on path_info or on query-string.
> > Because it is encoded in gitweb (via $projectroot) where to find git
> > repositories...
> > 
> 
> Can you expand on path_info and query-string? Keep in mind that Apache
> has mod_rewrite, which can rewrite URLs in any way before it gets
> actually sent to the underlying program (whether it be a CGI or
> anything else), even badly (or mischievously).

What I mean here that the following example gitweb URLs

  http://example.com/gitweb.cgi?p=some/project.git;a=commit;h=HEAD
  http://example.com/gitweb.cgi/some/project.git/commit/HEAD

with the following gitweb configuration

  $projectroot = /var/scm

both refer to git repository (directory) at

  /var/scm/some/project.git

Apache (or other web server) would have to somehow decide based on URL
that it refers to some project, and based on project and authentication
decide whether to grant access to it.


What is more, and what cannot be done by web server alone, is that we
would want to not show projects which you don't have access to in the
'projects_list' page, i.e. at

  http://example.com/gitweb.cgi

-- 
Jakub Narebski
Poland
