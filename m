From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] test doc: test_write_lines does not split its arguments
Date: Mon, 5 May 2014 16:51:43 -0700
Message-ID: <20140505235143.GU9218@google.com>
References: <1398622524-26207-1-git-send-email-mst@redhat.com>
 <1398622524-26207-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:20:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiDP-0007Xo-Vc
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992AbaEEXvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 19:51:48 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:59269 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973AbaEEXvr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 19:51:47 -0400
Received: by mail-ee0-f43.google.com with SMTP id d17so1190293eek.16
        for <git@vger.kernel.org>; Mon, 05 May 2014 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7GLdDsS4ZRjxFVuj8+ykHV/FDkCrugfNwKtoAPovXck=;
        b=kc2sboPSvB5z8qN09AlBVMzuqefND1+WrTdME8XsuGN3fYI41csXLJ68RZn7FwIGrf
         BdU1msP34h2nLfKRiOhE1hA8OnlKbzUpIrDaFODaOI38WHnI2YZDSN8eyg4sNoPqSmPK
         CfoM3Wgy6Q0f+ymjfptH/18s/a3JEpX6dz0KnTNXsdUMC/LVhcjctnaCe7gS7T7Cg6YU
         DSFpDKNMfF3tO54Kgus83wvOLDQMDH93i4f8DUYQASF3gGBjcxiPOglB7Ku7+UCqhe+1
         gADUlyWxfDoFtLa71voapUAMdJ5fUN9kMRdVd5SAOJo6xu73TYKu9YmzEJVnKouPpxKD
         ZG1w==
X-Received: by 10.14.221.2 with SMTP id q2mr6006021eep.68.1399333906649;
        Mon, 05 May 2014 16:51:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nx12sm82508591pab.6.2014.05.05.16.51.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 May 2014 16:51:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398622524-26207-2-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248178>

test_write_lines carefully quotes its arguments as "$@", so

	test_write_lines "a b" c

writes two lines as requested, not three.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Michael S. Tsirkin wrote:

> +++ b/t/README
> @@ -596,6 +596,28 @@ library for your script to use.
> +	test_write_lines "a b c d e f g" >foo
> +
> +   Is a more compact equivalent of:
> +	cat >foo <<-EOF
> +	a
> +	b
[...]
> +++ b/t/test-lib-functions.sh
> @@ -717,6 +717,11 @@ test_ln_s_add () {
>  	fi
>  }
>  
> +# This function writes out its parameters, one per line
> +test_write_lines () {
> +	printf "%s\n" "$@"
> +}

How about this patch?

Thanks,
Jonathan

 t/README | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 2d6232f..8a9d499 100644
--- a/t/README
+++ b/t/README
@@ -596,15 +596,14 @@ library for your script to use.
 		...
 	'
 
- - test_write_lines <text>
+ - test_write_lines <lines>
 
-   Split <text> to white-space separated words and write it out on standard
-   output, one word per line.
+   Write <lines> on standard output, one line per argument.
    Useful to prepare multi-line files in a compact form.
 
    Example:
 
-	test_write_lines "a b c d e f g" >foo
+	test_write_lines a b c d e f g >foo
 
    Is a more compact equivalent of:
 	cat >foo <<-EOF
-- 
1.9.1.423.g4596e3a
