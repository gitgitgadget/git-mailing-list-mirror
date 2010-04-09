From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 3/3] send-email: Add sendemail.smtpdomain
Date: Fri, 9 Apr 2010 20:40:49 +0200
Message-ID: <201004092040.50142.jnareb@gmail.com>
References: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com> <1270827245-28958-4-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 20:41:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0J8Z-0008S3-5s
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 20:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab0DISk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 14:40:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:45250 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab0DISk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 14:40:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1298056fga.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 11:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=b0YgvO10UYLsVz1Ycz3ZH+31JPz+HuG7PrYwj+B9K+o=;
        b=UgLQ4dL0MaWfWraGUagzKb9sVXteA0jgwlz2gi6eif/tM0fwkirofoHxObzgbyn6PK
         cZx+RZImbrsKLvAP+84JNw03h5QC/QJfJ1te3YI9pbo1j7ZZ6MLgfL1YlJUVsLybQrBx
         YHufXw7CZmPin+cm5QSZb/Mp+EK7XPpkidM0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fFZRR3sqmp8dyXL3M3mIRJE2BbJooTzM2Pe7V83yA5NNeoo8sJPP+3CdNkaOh57CMM
         Y85L1R/tBq1I+Tuhi9gIQ2d6J9GEbO2nq27w9nZbxIvfH+G7ce0adzYVddAo/MqDs2/2
         ZAfke5xGi8CYlIzktQdFBGLBz+a01DphiFCo4=
Received: by 10.87.1.2 with SMTP id d2mr939626fgi.34.1270838455895;
        Fri, 09 Apr 2010 11:40:55 -0700 (PDT)
Received: from [192.168.1.13] (abvc167.neoplus.adsl.tpnet.pl [83.8.200.167])
        by mx.google.com with ESMTPS id 16sm908537fxm.4.2010.04.09.11.40.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 11:40:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1270827245-28958-4-git-send-email-brian@gernhardtsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144454>

On Fri, 9 Apr 2010, Brian Gernhardt wrote:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index f491d44..bdfe3f2 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -132,8 +132,7 @@ my $have_email_valid = eval { require Email::Valid; 1 };
>  my $have_mail_address = eval { require Mail::Address; 1 };
>  my $smtp;
>  my $auth;
> -my $mail_domain_default = "localhost.localdomain";
> -my $mail_domain;
> +my $smtp_domain_default = "localhost.localdomain";

Why this change, this renaming of variables from $mail_domain_default
and $mail_domain to $smtp_domain_default and $smtp_domain?  Why you
have removed this forward declaration of $smtp_domain/$mail_domain?
  
>  sub unique_email_list(@);
>  sub cleanup_compose_files();
> @@ -190,7 +189,7 @@ sub do_edit {
>  # Variables with corresponding config settings
>  my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
>  my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
> -my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
> +my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_domain);
>  my ($validate, $confirm);
>  my (@suppress_cc);

Why have you moved $smtp_domain declaration (formerly $mail_domain)
here?  And why it is not described in commit message (at least "Cleanup.",
or something like this)?

-- 
Jakub Narebski
Poland
