From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/23] expire_reflog(): remove unused parameter
Date: Thu, 4 Dec 2014 15:28:53 -0800
Message-ID: <20141204232853.GD16345@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:29:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfpU-0005VH-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933139AbaLDX25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:28:57 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48012 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbaLDX25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:28:57 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so16765802ieb.40
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 15:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CMxUY18xy2Vgk8HxK+IrNOhKTMYPy0/ToKH/hiuCdUM=;
        b=rN+kDivQlxTmSNX0ZI6eKMPnT2skiD9TfOE7WSMVnzUDmIkRwyb9YYRH/IVzo6BP+u
         A5PCCTP9XcZFnLJSEAHGgaocxeEypThpE+2WWnZ5PRK5ZqIyXBJM7B+PfGCbCPa2GVnV
         RqtdhLCflrycGKNq3inYnRsNf8jcjkpefPbfprgRjd9yE3NVuUh2e+/gcaKc94pBo5AN
         hxCzXa6RP7ajiZqOi4Uy0EVNYBo5p+YltkZPZx3U+KILS518i3rVSbaAWhOsnuF8/WB1
         L6DOH7kbYa+jqZGZDsTROIoyVqa+ugYb6bGIZZ2srSobqXP2n9pffSMn0EOAeZjIHI3L
         lr8w==
X-Received: by 10.42.129.140 with SMTP id q12mr13153168ics.68.1417735736424;
        Thu, 04 Dec 2014 15:28:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5da0:cb9e:66b:e537])
        by mx.google.com with ESMTPSA id i69sm8529472ioe.20.2014.12.04.15.28.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 15:28:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-5-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260836>

Michael Haggerty wrote:

> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -349,7 +349,7 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
>  	return 0;
>  }
>  
> -static int expire_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
> +static int expire_reflog(const char *ref, const unsigned char *sha1, void *cb_data)
>  {
>  	struct cmd_reflog_expire_cb *cmd = cb_data;

On second thought: why not update the last parameter to be a 'struct
cmd_reflog_expire_cb *' instead of 'void *' while at it, like this?

 builtin/reflog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git i/builtin/reflog.c w/builtin/reflog.c
index 3e11bee..d860624 100644
--- i/builtin/reflog.c
+++ w/builtin/reflog.c
@@ -349,9 +349,8 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 	return 0;
 }
 
-static int expire_reflog(const char *ref, const unsigned char *sha1, void *cb_data)
+static int expire_reflog(const char *ref, const unsigned char *sha1, struct cmd_reflog_expire_cb *cmd)
 {
-	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
 	char *log_file, *newlog_path = NULL;
