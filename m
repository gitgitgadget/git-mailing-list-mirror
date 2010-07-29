From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] log: parse detached options like git log --grep foo
Date: Thu, 29 Jul 2010 17:25:16 -0500
Message-ID: <20100729222436.GA1824@burratino>
References: <1280391629-30017-1-git-send-email-Matthieu.Moy@imag.fr>
 <1280391629-30017-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 30 00:26:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OebYy-0004wL-Kv
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 00:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488Ab0G2W0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 18:26:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52901 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab0G2W0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 18:26:47 -0400
Received: by ywh1 with SMTP id 1so310874ywh.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=n7FGp/PqE0M9zdHINEi8k0AHtmn75Xkml2y0dh74nZM=;
        b=N+YJq9Tf4TR5WTrKuD6kI/e3yJYrl4LbKbQ2SnBguza/z1PYAzBgBHCeswyt+oMcD2
         MvaFbxFkBmTUKIP2axhR/h/DIOrJXb5wawFAEl4WRXHApiY3GC8pUxroIltCyvnmLFHP
         yL73Tl0xeq36bPrX+l85D5hNsBPHVbeHmyS6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=C+BoC2nj4+u6PKADsocig6c8gQ1AeG9+5ZKF1THp9d7oc8LcAJgTkFGbaI8zrw/IiB
         YQ0FX80SGLFk3yloVAk9/d6+mYKLxm3InmGNJZTDPmdE2o7tIOSDSvN+OdkzEZI0Lacj
         svn4oR+fPm67s/Zj3ot2KXrHYfAPo4ATGeOEg=
Received: by 10.101.141.15 with SMTP id t15mr1046376ann.51.1280442406591;
        Thu, 29 Jul 2010 15:26:46 -0700 (PDT)
Received: from burratino ([205.197.14.202])
        by mx.google.com with ESMTPS id g33sm1647961qcq.16.2010.07.29.15.26.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 15:26:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280391629-30017-5-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152208>

Hi,

Glance over this again:

> +++ b/revision.c
> @@ -1382,12 +1400,12 @@ static int handle_revision_opt(struct rev_inf=
o *revs, int argc, const char **arg
>  		revs->grep_filter.fixed =3D 1;
>  	} else if (!strcmp(arg, "--all-match")) {
>  		revs->grep_filter.all_match =3D 1;
> -	} else if (!prefixcmp(arg, "--encoding=3D")) {
> -		arg +=3D 11;
> +	} else if ((argcount =3D diff_long_opt("encoding", argv, &optarg)))=
 {
>  		if (strcmp(arg, "none"))
> -			git_log_output_encoding =3D xstrdup(arg);
> +			git_log_output_encoding =3D xstrdup(optarg);

I think arg should be optarg in the string comparison, too.  Sorry I
didn=E2=80=99t notice last time.

I wonder why t3900 and t8005 do not catch this.

>  		else
>  			git_log_output_encoding =3D "";

Curious,
Jonathan
