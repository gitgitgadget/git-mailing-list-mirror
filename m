From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 07/15] t4019 (diff-wserror): add lots of missing &&
Date: Fri, 1 Oct 2010 06:00:05 -0500
Message-ID: <20101001110005.GE6816@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 13:03:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1dOa-0004vD-EG
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 13:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278Ab0JALDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 07:03:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62111 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233Ab0JALDN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 07:03:13 -0400
Received: by gwj17 with SMTP id 17so1079115gwj.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nQnkItal2BMhQRbVvGrOv7qiucvgwnpftSicZX9QAK0=;
        b=fHt+rRccla4/6Y3qc1lJNiINHI6z1tvRG5uxbuC7mYytSMMJIYEgs2pAjX85HyFqFa
         wewKOwivgPi0/y2T3go7+Qua6kEhzOppLdy0U/UXWwA4vBl91y0nwvP1H/xDV3hPvqju
         Mbr4cFTIc9Q51cOYPd1zZSWLYye5yReJYiU2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=loTpXlhPjaVGYCzt2RH5dWLoOQuHbnLYNOExT9yxo9Qu7tnwY0+9dPSpgjCaRRuHED
         pXvy1trWYPPv4bKES3WGh/dk0aJBYug87IPLX50ceDqtjRWx0QzOJAbAY/sITA5Z7NYt
         43bAlgLRkIepyEcKc/oS6CRr/kw6fisZ/QdYQ=
Received: by 10.150.55.27 with SMTP id d27mr804371yba.284.1285930992235;
        Fri, 01 Oct 2010 04:03:12 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id x2sm740180ybh.5.2010.10.01.04.03.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 04:03:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285542879-16381-8-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157743>

Elijah Newren wrote:

> --- a/t/t4019-diff-wserror.sh
> +++ b/t/t4019-diff-wserror.sh
> @@ -40,7 +40,7 @@ prepare_output () {
>  
>  test_expect_success default '
>  
> -	prepare_output
> +	prepare_output &&

The exit status from prepare_output is the exit status from its last
command, which is "grep -v <something blue>".  It seems that never
fails in these test cases, but should we be relying on that?

(I haven't thought hard about the answer.  If we shouldn't be, a
workaround could look like this.)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 36f06c7..afd74c8 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -36,6 +36,7 @@ prepare_output () {
 	git diff --color >output
 	$grep_a "$blue_grep" output >error
 	$grep_a -v "$blue_grep" output >normal
+	:
 }
 
 test_expect_success default '
-- 
