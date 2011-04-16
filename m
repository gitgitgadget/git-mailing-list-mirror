From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] http-push: refactor curl_easy_setup madness
Date: Sun, 17 Apr 2011 02:24:14 +0800
Message-ID: <BANLkTinv4M7biQ_Wd3rWYbGLSwgGBmhbUA@mail.gmail.com>
References: <1301535531-1244-1-git-send-email-dpmcgee@gmail.com>
	<1301535531-1244-2-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 20:24:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBAAQ-00080H-Jz
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 20:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1DPSYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 14:24:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44633 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab1DPSYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 14:24:15 -0400
Received: by iwn34 with SMTP id 34so2890787iwn.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Pt8gg5KxlpYmbORZqqsq8P8J9lTJ29wNvnQaJPbPfyU=;
        b=EPHyrmmAglwFWilzWgMwUS2y1KK3GPrXlrH7b29736+VVtSnK9Xwx/sk9Gee9Z/fTx
         SkcUX6fm4p82tLXx+4ezQC8zDwpWzzNR+dG0L64sDdhealXQSoI5nJ4JUF0rwHzHkEvH
         yzq+NtL9HUfLJ4ymG52w+Ueo5YzBoA7pbffFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QTF4Eggh6+GxlbwTo/j1vGsGzA/M3JYCyyXarQpdQP6yaA2Im32hA18VgK36ZPzytj
         UO8Q2hTSNWfuygFtfRXe2wpjWnctKxJPr4py9GRymC681R5Nb0etczQebcUBUxwvLSB2
         qkmJsa+hs+wpaKHFKrdL1tChf0K90f8tOhYz0=
Received: by 10.42.146.196 with SMTP id k4mr4319016icv.105.1302978254458; Sat,
 16 Apr 2011 11:24:14 -0700 (PDT)
Received: by 10.43.55.10 with HTTP; Sat, 16 Apr 2011 11:24:14 -0700 (PDT)
In-Reply-To: <1301535531-1244-2-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171690>

On Thu, Mar 31, 2011 at 9:38 AM, Dan McGee <dpmcgee@gmail.com> wrote:
> We were doing (nearly) the same thing all over the place, in slightly
> different orders, different variable names, etc. Refactor most calls
> into two helper functions, one for GET and one for everything else, that
> do the heavy lifting leaving most callsites a lot cleaner in the
> process.
>
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

Nice work.

Perhaps you should mention in the commit message that the setting of
CURLOPT_PUT at the callsites of curl_setup_http() which previously
didn't do it (eg. locking_available(), remote_ls()) is ok, since that
option is deprecated in place of, and has the same effect as,
CURLOPT_UPLOAD.

> --- a/http-push.c
> +++ b/http-push.c
> @@ -169,7 +169,7 @@ enum dav_header_flag {
>        DAV_HEADER_TIMEOUT = (1u << 2)
>  };
>
> -static char *xml_entities(char *s)
> +static char *xml_entities(const char *s)
>  {
>        struct strbuf buf = STRBUF_INIT;
>        while (*s) {

Perhaps the addition of "const", and elsewhere in this patch, should
be placed in a separate patch.

--
Cheers,
Ray Chuan
