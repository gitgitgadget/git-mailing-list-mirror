From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Allow HTTP user agent string to be modified.
Date: Sun, 8 Aug 2010 10:51:55 +0800
Message-ID: <AANLkTi=G=GvxXEh1hGuYQK42cdkMUaFhqxsQ39K=2180@mail.gmail.com>
References: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Sun Aug 08 04:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhvzV-0000Gw-Si
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 04:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab0HHCv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 22:51:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40959 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab0HHCv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 22:51:56 -0400
Received: by iwn33 with SMTP id 33so2627232iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 19:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=078qGJ430LD21LsBQPTg41yT+Z2x1VJHLFCGVIGzBCE=;
        b=meMHvxB/Idn6vj7I9fsb3Zvp5zF89+9EU/jaZ3N34xOndKo4dRpABSQtGY4Z04S/vh
         H+amJyouwjAz8A5Cwb3KDxoX6RLDpQHjqIJxF4WWLFP/Sw68wtnWF+2ZpIjZ3eE/B6t5
         H81N9tV+Do4QZy8vSeDBmL3Vd6pRHQKw8+waM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nRroqjO1x1MBicRRtV/Z3KcwbtJCtc3skIS6eiEfQAHwOLFauNj51b67WQXgfw80b4
         oNCr5uY+Gq7UM4fSBW1XpLC31yNJORmywX088NYWLXNLCMZ21qIJsOm3GIUXp7qc9jNQ
         ikb7zEAn4tldrKwLa9iFrfo6Shxh5LimaADIo=
Received: by 10.231.35.199 with SMTP id q7mr16463883ibd.47.1281235915559; Sat, 
	07 Aug 2010 19:51:55 -0700 (PDT)
Received: by 10.231.158.141 with HTTP; Sat, 7 Aug 2010 19:51:55 -0700 (PDT)
In-Reply-To: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152879>

Hi,

On Sat, Aug 7, 2010 at 11:34 AM, Spencer E. Olson <olsonse@umich.edu> w=
rote:
>[snip]
> @@ -41,6 +41,7 @@ static long curl_low_speed_time =3D -1;
> =A0static int curl_ftp_no_epsv;
> =A0static const char *curl_http_proxy;
> =A0static char *user_name, *user_pass;
> +static const char *user_agent =3D NULL;

This can be skipped, I think.

>[snip]
> @@ -279,7 +283,10 @@ static CURL *get_curl_handle(void)
> =A0 =A0 =A0 =A0if (getenv("GIT_CURL_VERBOSE"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curl_easy_setopt(result, CURLOPT_VERBO=
SE, 1);
>
> - =A0 =A0 =A0 curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AG=
ENT);
> + =A0 =A0 =A0 if (user_agent !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 curl_easy_setopt(result, CURLOPT_USERAG=
ENT, user_agent);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 curl_easy_setopt(result, CURLOPT_USERAG=
ENT, GIT_USER_AGENT);

Hmm, perhaps

    curl_easy_setopt(result, CURLOPT_USERAGENT,
        user_agent ? user_agent : GIT_USER_AGENT);

to replace the if-else?

--=20
Cheers,
Ray Chuan
