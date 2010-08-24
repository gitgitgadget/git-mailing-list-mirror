From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] rev-parse: exit with non-zero status if ref@{n}
 is not valid.
Date: Mon, 23 Aug 2010 19:14:55 -0500
Message-ID: <20100824001454.GB17406@burratino>
References: <7vr5hp1e6i.fsf@alter.siamese.dyndns.org>
 <1282605103-8320-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 02:16:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnhC6-0005mR-UV
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 02:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab0HXAQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 20:16:46 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39580 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab0HXAQo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 20:16:44 -0400
Received: by qyk9 with SMTP id 9so3213818qyk.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 17:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=H1YRiEOvUzjGGkyfSd7uqf85kCfwgeRo04HAMENZqSk=;
        b=PI2XiC3AbuY8+W//YjUy3GOhnLi0aj0GsZUD2ms2+eZQ6HubOCQK5XuzgnZ1wxecIf
         RfuPPmDW1Ctvmy/0qRes4ZZtC7s2yWl8nwxOs8mJRHoPLa0ukoAsbX5iaIwknwuNyphQ
         ovJe/lkQargnbmL7nen+M7P9IsPALhXNHTgJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E826jI8PLOwcxirQmlB0+qK/cjG+8RzsyWtcFW2WTWZjUkSSEGQTEyP/0OONsA2qKr
         XU4Yjh1b0C0GBcanFOON955knIj2QXmTbh/Srqb4nbJj5vb3wtXC/as7kBkPW0I7S4Z+
         ngTlwZrZoNlelxNyt9oURZBUNVynQYuJd43AI=
Received: by 10.224.60.67 with SMTP id o3mr3866133qah.246.1282609000183;
        Mon, 23 Aug 2010 17:16:40 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q8sm7757182qcs.0.2010.08.23.17.16.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 17:16:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282605103-8320-2-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154274>

Jon Seymour wrote:

> +++ b/sha1_name.c
> @@ -342,7 +342,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1);
>  
>  static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  {
> -	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
> +	static const char *warn_msg = "warning: refname '%.*s' is ambiguous.";

$ git tag master
$ bin-wrappers/git rev-parse master
warning: refname 'master' is ambiguous.cfee1ae8f0c56eed7d8ffa821f650789f8b11de2

Here's a fixup.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/sha1_name.c b/sha1_name.c
index d40ae48..823e582 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -342,7 +342,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
-	static const char *warn_msg = "warning: refname '%.*s' is ambiguous.";
+	static const char *warn_msg = "warning: refname '%.*s' is ambiguous.\n";
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len;
-- 
