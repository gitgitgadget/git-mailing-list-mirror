From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list to a subdirectory
Date: Mon, 30 Jan 2012 21:48:03 +0100
Message-ID: <201201302148.03909.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <20120130200355.GA2584@server.brlink.eu> <7v39axaq0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Bernhard R. Link" <brl@mail.brlink.eu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:47:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rry8Y-00053b-78
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab2A3Ura (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:47:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39224 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290Ab2A3Ura (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:47:30 -0500
Received: by eaal13 with SMTP id l13so1254392eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 12:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=5SLjHDGFAKLmCl/ZSkR7LbHuaX5JDIY0M7QuV7e7SlI=;
        b=pKefYnLT8Km1gq4CdilrZiatUw4/IyhAq8hieuzEsAV2WcBnz6QzkVvZ4yETZJWLj1
         8fhCafzOCGvAG0el0036KI3pzE0V8t3RpIxZsNopszur2kKcy/AmfuxrkCplnVSRVzEP
         fPxEMVMoVMynL9HuwiCwEDv7cNNTuEi2valiM=
Received: by 10.213.2.67 with SMTP id 3mr2964827ebi.114.1327956448583;
        Mon, 30 Jan 2012 12:47:28 -0800 (PST)
Received: from [192.168.1.13] (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id y54sm77020173eef.8.2012.01.30.12.47.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 12:47:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v39axaq0v.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189420>

On Mon, 30 Jan 2012, Junio C Hamano wrote:
> "Bernhard R. Link" <brl@mail.brlink.eu> writes:
> 
> > I'll resend the series as replies to this mail.
> 
> Thanks; I'll queue them in 'pu' for now (if Jakub wants to Ack the pieces,
> I'll amend them).

You can add Ack from me for the whole series.

> Regarding the first patch in the series, while it may be a valid perl to
> introduce a new variable, assign to it and then munge its contents with
> s///, all inside a parameter list of a function call, it is doing a bit
> too much and makes it hard to see if the variable may or may not later be
> used in the same scope (in this case, it is not).
> 
> I am tempted to squash the following in.
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b764d51..f215eaa 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6003,7 +6003,8 @@ sub git_forks {
>  		die_error(400, "Unknown order parameter");
>  	}
>  
> -	my @list = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
> +	my ($filter = $project) =~ s/\.git$//;

This doesn't work: it is syntax error:

  Can't declare scalar assignment in "my"
  
It has to be either

 +	(my $filter = $project) =~ s/\.git$//;

or

 +	my $filter = $project;
 +	$filter =~ s/\.git$//;

-- 
Jakub Narebski
Poland
