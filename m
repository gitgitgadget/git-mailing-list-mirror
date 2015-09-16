From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] remote: add get-url subcommand
Date: Wed, 16 Sep 2015 15:51:54 -0700
Message-ID: <xmqqtwqukmet.fsf@gitster.mtv.corp.google.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
	<1442368427-3311-1-git-send-email-mathstuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcLYX-00046m-F5
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbbIPWv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:51:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbbIPWv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:51:56 -0400
Received: by padhk3 with SMTP id hk3so884585pad.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XfDm4Z0MS6lLpIIMycSgmMu054K2UnyTQHTcflMM16w=;
        b=mbUTrQrfdWTED0ENiIf2tGqDWUuOMY28c2RFGyurETThouIAImoR7IQ7e9woQ/TiVv
         UUGaVV6y/fiNaUuqJBfPCJUIcoGTAlvSi8NEmLAdYVCvFVny0aEhl9QBRuZXlAMy7DvG
         TgEPxAS/WeV5GjiPkDvPD6K2FjruqxxikclPVjfpIdg7+kAy4zDjeCrHYl0nH/giZ6Xh
         G8ZuQQ9e6BEvMUZQGq7XlM6nrnBd5ZB0JacRvJvWt8sfDfQNgJs3NAxAmSRDi91wWwcW
         BIHowMN4qlcjcFI8fz9dDljJUNf1awKXw0ZcH630XH8wg7sBPW42Lmja22W1XA+iLtZB
         GNfw==
X-Received: by 10.68.196.35 with SMTP id ij3mr34436028pbc.52.1442443916019;
        Wed, 16 Sep 2015 15:51:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id k10sm160315pbq.78.2015.09.16.15.51.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 15:51:54 -0700 (PDT)
In-Reply-To: <1442368427-3311-1-git-send-email-mathstuf@gmail.com> (Ben
	Boeckel's message of "Tue, 15 Sep 2015 21:53:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278083>

Ben Boeckel <mathstuf@gmail.com> writes:

> +get_url_test () {
> +	cat >expect &&
> +	test_expect_success "get-url $*" "
> +		git remote get-url $* >actual &&
> +		test_cmp expect actual
> +	"
> +}

This makes any use of get_url_test inside test_expect_success wrong,
I suspect.  Try running the tests under prove.  I think it will
complain that the test numbers do not match or something.

Minimally, this would probably fix the breakage.

 t/t5505-remote.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f03ba4c..dfaf9d9 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -921,10 +921,8 @@ test_expect_success 'new remote' '
 
 get_url_test () {
 	cat >expect &&
-	test_expect_success "get-url $*" "
-		git remote get-url $* >actual &&
-		test_cmp expect actual
-	"
+	git remote get-url "$@" >actual &&
+	test_cmp expect actual
 }
 
 test_expect_success 'get-url on new remote' '
