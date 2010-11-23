From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 5/6] msvc: opendir: handle paths ending with a slash
Date: Tue, 23 Nov 2010 20:31:03 +0100
Message-ID: <4CEC1677.6000207@lsrfire.ath.cx>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com> <1290537509-360-6-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com, jrnieder@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 20:31:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKyaH-0001HP-Gl
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448Ab0KWTbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 14:31:15 -0500
Received: from india601.server4you.de ([85.25.151.105]:54114 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab0KWTbP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 14:31:15 -0500
Received: from [10.0.1.100] (p4FFD8C84.dip.t-dialin.net [79.253.140.132])
	by india601.server4you.de (Postfix) with ESMTPSA id 1E70E2F8037;
	Tue, 23 Nov 2010 20:31:12 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1290537509-360-6-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162013>

Am 23.11.2010 19:38, schrieb Erik Faye-Lund:
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  compat/msvc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/compat/msvc.c b/compat/msvc.c
> index 199eb22..fdbfb70 100644
> --- a/compat/msvc.c
> +++ b/compat/msvc.c
> @@ -23,6 +23,8 @@ DIR *opendir(const char *name)
>  
>  	/* check that the pattern won't be too long for FindFirstFileA */
>  	len = strlen(name);
> +	if (is_dir_sep(name[len - 1]))

Perhaps extend this thus, and handle multiple slashes?

	while (len > 0 && is_dir_sep(name[len - 1]))

> +		len--;
>  	if (len + 2 >= MAX_PATH) {
>  		errno = ENAMETOOLONG;
>  		return NULL;
