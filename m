From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb.js: use unicode encoding for nbsp instead of html entity
Date: Fri, 20 Nov 2009 00:00:40 +0100
Message-ID: <200911200000.41658.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <1258659887-5244-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 00:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBFzg-00020H-Am
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 00:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773AbZKSXAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 18:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757616AbZKSXAk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 18:00:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53895 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757244AbZKSXAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 18:00:39 -0500
Received: by bwz27 with SMTP id 27so2938077bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lEuoc24I217sLDK5scSGtzVIVMjWZ2BvlrMzNqjw/30=;
        b=N/nPfwx5TbC6z9TG4okDYB11z7Ef8BQLSQBVuHzwS+l62+SS5e5o92FIuW66rF6Dbk
         N6nnnopbryJxt21arxqkfNa7FcQIejgaxDBC4CPW6qS7aIRG+570osisXU/jAZbZ0RYm
         FvUL5OB0+S4Fmb9HJUYaojz7HA7iAp1CJkGpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=n+HsOMZ41WVRurXz9gErQMdRauPr/Bu+Rlg+71yKy8EAVqiCBUgVPap6FpmUa7A9da
         UwE9wQwyUzVycxV1kTJk3TaCeNEJ+510IRPVYOSncvrZzcek6KFV9po9AvXR5454dHy2
         GmxE602MADdOT/gJiYFzX93AFbHZBEOauCYts=
Received: by 10.204.34.194 with SMTP id m2mr655278bkd.53.1258671644825;
        Thu, 19 Nov 2009 15:00:44 -0800 (PST)
Received: from ?192.168.1.13? (abvd116.neoplus.adsl.tpnet.pl [83.8.201.116])
        by mx.google.com with ESMTPS id 13sm368161fxm.1.2009.11.19.15.00.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 15:00:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1258659887-5244-3-git-send-email-bebarino@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 19 Nov 2009, Stephen Boyd wrote:

> It seems that in Firefox-3.5 inserting nbsp with javascript inserts the
> literal nbsp; instead of a space. Fix this by inserting the unicode
> representation for nbsp instead.

Errr... why are you avoiding writing &nbsp; or "&nbsp;" here?

> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---

[From "[PATCH 0/2] jn/gitweb-blame fixes"]
> This series is based on next's jn/gitweb-blame branch.

> The second patch fixes a visible bug I see in Firefox. Although I
> assume on other browsers it's not a problem? I haven't tested it on
> others so I can't be sure.

Well, since I moved from elem.innerHTML (which is non-standard, and
does not work for some browsers in strict XHTML mode) to setting
elem.firstChild.data (which assumes that firstChild exists and it
is a text node) I have had damned *intermittent* bugs where sometimes
'&nbsp;' would be shown literally, and sometimes this entity would
be correctly rendered.

I suspect this is either bug in Firefox, or unspecified part of DOM.

As we need this only for progress report, I am not against this change,
if it doesn't make it worse in other browsers.

>  gitweb/gitweb.js |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
> index 02454d8..30597dd 100644
> --- a/gitweb/gitweb.js
> +++ b/gitweb/gitweb.js
> @@ -31,12 +31,12 @@
>  
>  /**
>   * pad number N with nonbreakable spaces on the left, to WIDTH characters
> - * example: padLeftStr(12, 3, '&nbsp;') == '&nbsp;12'
> - *          ('&nbsp;' is nonbreakable space)
> + * example: padLeftStr(12, 3, '\u00A0') == '\u00A012'
> + *          ('\u00A0' is nonbreakable space)
>   *
>   * @param {Number|String} input: number to pad
>   * @param {Number} width: visible width of output
> - * @param {String} str: string to prefix to string, e.g. '&nbsp;'
> + * @param {String} str: string to prefix to string, e.g. '\u00A0'
>   * @returns {String} INPUT prefixed with (WIDTH - INPUT.length) x STR
>   */
>  function padLeftStr(input, width, str) {
> @@ -158,7 +158,7 @@ function updateProgressInfo() {
>  
>  	if (div_progress_info) {
>  		div_progress_info.firstChild.data  = blamedLines + ' / ' + totalLines +
> -			' (' + padLeftStr(percentage, 3, '&nbsp;') + '%)';
> +			' (' + padLeftStr(percentage, 3, '\u00A0') + '%)';
>  	}
>  
>  	if (div_progress_bar) {
> -- 
> 1.6.5.3.433.g11067
> 
> 

-- 
Jakub Narebski
Poland
