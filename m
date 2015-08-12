From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Tue, 11 Aug 2015 20:01:50 -0400
Message-ID: <20150812000150.GA41558@flurp.local>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
 <1439336384-1445-1-git-send-email-viktorin@rehivetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	gitster@pobox.com
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 02:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPJUj-0006N0-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 02:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbbHLAB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 20:01:57 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33967 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbbHLAB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 20:01:57 -0400
Received: by iodb91 with SMTP id b91so4339542iod.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4MATYRvNRayzYjwnEC2yT1BGEwq7ToLh46QImQ8hhxA=;
        b=mmCrArgNKR9tY62GWF6rFCZPP7AzjJsBqTKR8FciEhPI+Arj5IU64fmZfx6nqwJ9Fg
         UCiHxa3sHu6ZKj1GfnLkli66W1UjDIes6UD9HTXlHAAg4ZDsRGL/FfusKSkAMeshIUTP
         VPRb7WtI4OdLiA4+HYbYAx4RcHeeNexS7HxI4/x2XBh0EBeP2xAJYPZMOoj+PRBpjrCg
         3Yf+Hw9NczBSbbSmWm7skBADq3af7tlI6UI/F+kVxrkSVRJf8OeYloPegH5FslXMlvuQ
         oIqxuzNwxiyOZMfzUFgVzO05jcd9Af+xKPqzlykbmrqc7Vvghc61N89JAmx263ATAo+m
         1NwQ==
X-Received: by 10.107.34.81 with SMTP id i78mr31362360ioi.40.1439337716668;
        Tue, 11 Aug 2015 17:01:56 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id rr5sm2671514igb.7.2015.08.11.17.01.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 17:01:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1439336384-1445-1-git-send-email-viktorin@rehivetech.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275746>

On Wed, Aug 12, 2015 at 01:39:44AM +0200, Jan Viktorin wrote:
> When sending an e-mail, the client and server must agree on an
> authentication mechanism. Some servers (due to misconfiguration
> or a bug) deny valid credentials for certain mechanisms. In this
> patch, a new option --smtp-auth and configuration entry smtpAuth
> are introduced. If smtp_auth is defined, it works as a whitelist
> of allowed mechanisms for authentication selected from the ones
> supported by the installed SASL perl library.
> 
> Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
> ---
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index f14705e..82c6ae8 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -171,6 +171,17 @@ Sending
>  	to determine your FQDN automatically.  Default is the value of
>  	'sendemail.smtpDomain'.
>  
> +--smtp-auth=<mechs>::
> +	Whitespace-separated list of allowed SMTP-AUTH mechanisms. This setting
> +	forces using only the listed mechanisms. Example:
> +
> +	$ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
> +
> +	If at least one of the specified mechanisms matches the ones advertised by the
> +	SMTP server and if it is supported by the utilized SASL library, the mechanism
> +	is used for authentication. If neither 'sendemail.smtpAuth' nor '--smtp-auth'
> +	is specified, all mechanisms supported by the SASL library can be used.

Unfortuantely, this won't format correctly in Asciidoc. The following squash-in fixes it...

---- 8< ----
Subject: [PATCH] fixup! send-email: provide whitelist of SMTP AUTH mechanisms

---
 Documentation/git-send-email.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 82c6ae8..9e4f130 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -174,13 +174,15 @@ Sending
 --smtp-auth=<mechs>::
 	Whitespace-separated list of allowed SMTP-AUTH mechanisms. This setting
 	forces using only the listed mechanisms. Example:
-
-	$ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
-
-	If at least one of the specified mechanisms matches the ones advertised by the
-	SMTP server and if it is supported by the utilized SASL library, the mechanism
-	is used for authentication. If neither 'sendemail.smtpAuth' nor '--smtp-auth'
-	is specified, all mechanisms supported by the SASL library can be used.
++
+------
+$ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
+------
++
+If at least one of the specified mechanisms matches the ones advertised by the
+SMTP server and if it is supported by the utilized SASL library, the mechanism
+is used for authentication. If neither 'sendemail.smtpAuth' nor '--smtp-auth'
+is specified, all mechanisms supported by the SASL library can be used.
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
-- 
2.5.0.276.gf5e568e
