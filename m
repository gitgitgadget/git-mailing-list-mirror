From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: provide port separately from hostname
Date: Fri, 5 Jul 2013 04:12:19 +0530
Message-ID: <CALkWK0mJAx+-iZ0e+jRQE14Vve=ea=fbzgmNEjUh5ANpDCriCA@mail.gmail.com>
References: <1372975492-981035-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, krzysiek@podlesie.net
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jul 05 00:43:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UusF1-0002rp-9y
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 00:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933418Ab3GDWnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 18:43:00 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36326 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933309Ab3GDWm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 18:42:59 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so3888522iea.25
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0F8lWbuvNTc+zh6iamExDb4CwGowQLE3QlerRQA8Fbo=;
        b=n3ux9wXL1V8BqoPxjkt09OEch24arj5k/Rbqg+2AaGLD6kWcMDjUxEkol2F46F9E3H
         JoI877YjufOj0nUOdwg5DO8skghHBiXw2Oss0KHxNULvPElCE0zHEs2aRVRy126/fTt+
         86ndo+mS1wl0k+41BhORJcdPyARN9d5GjEKFWKTI+mBx/L2p+hQ411UTZDMYYHK1wUmF
         xCTTBfeKOCyZo9/Y6Q0QYt4lR1iS/fQbtTLbRaB1HWRoQQjQKXPgPhbpVcSKf+5ByLYp
         R1Mt4KfAF+YtNlyFSF4xJoe1RQg612tXqhr67FsoVYEJ1s2QwKvutNYjeYJYCquQ53yG
         BIPQ==
X-Received: by 10.43.88.3 with SMTP id ay3mr2928147icc.61.1372977779230; Thu,
 04 Jul 2013 15:42:59 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Thu, 4 Jul 2013 15:42:19 -0700 (PDT)
In-Reply-To: <1372975492-981035-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229622>

brian m. carlson wrote:
> diff --git a/git-send-email.perl b/git-send-email.perl
> index bd13cc8..ca86a13 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1199,9 +1199,11 @@ X-Mailer: git-send-email $gitversion
>                 else {
>                         require Net::SMTP;
>                         $smtp_domain ||= maildomain();
> -                       $smtp ||= Net::SMTP->new(smtp_host_string(),

Hm, so the problem occurs when you give smtp_host_string() to
Net::SMTP->new() as the first argument.

> +                       $smtp_server_port ||= 25;

So if smtp_host_string() returns a hostname without a port, then
Net::SMTP->new() will connect to port 25 by default?

> If the SMTP port is provided as part of the hostname to Net::SMTP, it passes
> the combined string to the SASL provider; this causes GSSAPI authentication to
> fail since Kerberos does not want the port information.  Instead, pass the port
> as a separate argument as is done for SSL connections.

I need to be in a (firewalled?) network that uses Kerberos to
reproduce this, right?  Even if I can't reproduce it, the change seems
to be fine.

While we're on the subject, do you know how to get rid of this huge
ugly warning I get everytime I send emails?

*******************************************************************
 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
 is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
 together with SSL_ca_file|SSL_ca_path for verification.
 If you really don't want to verify the certificate and keep the
 connection open to Man-In-The-Middle attacks please set
 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
*******************************************************************
  at /home/artagnon/src/git/git-send-email line 1200.

Thanks.
