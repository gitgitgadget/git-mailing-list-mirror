From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 08/16] t4019 (diff-wserror): add lots of missing &&
Date: Sun, 3 Oct 2010 09:32:11 -0500
Message-ID: <20101003143211.GD17084@burratino>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
 <1286082644-31595-9-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 16:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Poh-00069D-DC
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 16:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0JCOfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 10:35:25 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46154 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab0JCOfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 10:35:24 -0400
Received: by qwh6 with SMTP id 6so2506474qwh.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7rdyR5LcVzfETa/9ncPYRiU7HUPoI45fZI7AgpkF128=;
        b=SnaWL5mAljYSommG4b8xbaLL/0/InmcJBGmWyWI67yJcGFiGtRh92PEbshTCatWyCC
         zQV8ONlZA5oVZCw2+J71Us9GUp3YmDjbu8Mek4hi2/0yZyPJniagQTkgLp/K6Cz5zlG3
         DQweY8S9TYkT0k/6UpPctaMp/xYoH0PSfHRmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VLRW3o1dsPTXjw7zALv8JGjT75Z/B72PrzalEDEioV65oizOiZuZm056UtBmlNOblp
         ySz4wEhFxke1LRWjupuC8FG6+fxg4n3XfGSgTpmFjZtS1GPwJN1uMS48XYUwGd4uA52H
         1JThtqNA3RbOYTVZBgn7OPQwT282HEwI1XsnQ=
Received: by 10.229.52.3 with SMTP id f3mr5821318qcg.230.1286116524026;
        Sun, 03 Oct 2010 07:35:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id e6sm4089920qcr.41.2010.10.03.07.35.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 07:35:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286082644-31595-9-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157876>

Elijah Newren wrote:

> --- a/t/t4019-diff-wserror.sh
> +++ b/t/t4019-diff-wserror.sh
> @@ -40,7 +40,7 @@ prepare_output () {
>  
>  test_expect_success default '
>  
> -	prepare_output
> +	prepare_output &&

As I asked before:

The exit status from prepare_output is the exit status from its last
command, which is "grep -v <something blue>".  It seems that never
fails in these test cases, but should we be relying on that?

So I would be more comfortable with the following on top.

---
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 36f06c7..afd74c8 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -36,6 +36,7 @@ prepare_output () {
 	git diff --color >output
 	$grep_a "$blue_grep" output >error
 	$grep_a -v "$blue_grep" output >normal
+	return 0
 }

 test_expect_success default '
