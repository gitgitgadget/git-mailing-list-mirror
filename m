From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 0/2] jn/gitweb-blame fixes
Date: Sun, 22 Nov 2009 20:52:06 -0800
Message-ID: <4B0A14F6.5080405@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <4B05EA37.7060704@gmail.com> <4B06157B.10203@gmail.com> <200911210132.44649.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 05:59:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCR1m-0005mL-14
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 05:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbZKWE7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 23:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756401AbZKWE7b
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 23:59:31 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:54064 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756390AbZKWE7b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 23:59:31 -0500
Received: by yxe17 with SMTP id 17so4424699yxe.33
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 20:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jQ/Qx/7pLJHEaagb9BCkXo1B4CCARvRCxqgJslwS6S4=;
        b=SkKfAuJzNJETaC0XG85qWZB40EMGxgR5bkzOdvWJhslpRwcYhnl/r96aJnG+lDixRN
         FR/sIaag99Uxo1t39KdP3ljCxfisPyfWk3SyHL8peupnWzm0o4UOsZOP2xRfiDMNQAfS
         BTixlpmSD29huOSoPMYoOV9SwNWIFB6WAWP2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nUTg14jNYTx6drYE67tKejRo3lONKyqXiORHdOEZbJPej8fLggaDTJUFltOAI2UD1v
         ZynZXdPTg6oNvBf6OP7EOJJUhRP5vSUn5BtqwtsT45LgPrm3ZSFX/+8KOzbcko+8Kuz+
         gYnsYqNRx/dRvTdTUICNfIYOp9xSZ+50Iz5ww=
Received: by 10.151.95.25 with SMTP id x25mr6203105ybl.33.1258951930150;
        Sun, 22 Nov 2009 20:52:10 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 4sm1365393ywi.12.2009.11.22.20.52.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 20:52:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <200911210132.44649.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133481>

Jakub Narebski wrote:
> I have tested gitweb with both of your patches applied, serving gitweb
> as CGI script using Apache 2.0.54 on Linux, and viewing from separate
> computer on MS Windows XP, with the following results:
>
> * For the following browsers blame_incremental view on gitweb/gitweb.perl
>   file produces correct output, but for progress info which instead of
>   (  1%) -> ( 29%) -> (100%) looks more like ( 1%) -> (29%) -> (100%)

This is due to an off-by-one error in the while loop. This should fix 
it. I'll probably squash this into patch 2 and resend.

--->8----

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 30597dd..9214497 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -43,7 +43,7 @@ function padLeftStr(input, width, str) {
        var prefix = '';
 
        width -= input.toString().length;
-       while (width > 1) {
+       while (width > 0) {
                prefix += str;
                width--;
        }
