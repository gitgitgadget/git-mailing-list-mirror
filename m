From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 21:53:06 +0100
Message-ID: <50D37AB2.1040508@web.de>
References: <20121217010538.GC3673@gmail.com> <20121220145519.GB27211@sigill.intra.peff.net> <7vk3sc606f.fsf@alter.siamese.dyndns.org> <7vobho4hxa.fsf@alter.siamese.dyndns.org> <20121220200109.GC21785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	git mailing list <git@vger.kernel.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 21:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tln7Q-0003Y1-I3
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 21:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab2LTUxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 15:53:11 -0500
Received: from mout.web.de ([212.227.17.12]:57042 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab2LTUxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 15:53:09 -0500
Received: from [192.168.37.101] ([93.222.63.50]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MXYWA-1TZ1Xg31hW-00WURC; Thu, 20 Dec 2012 21:53:07
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121220200109.GC21785@sigill.intra.peff.net>
X-Provags-ID: V02:K0:CvZONU72Hnf1Ix41d1rmFsS6lOhp6ngubXSCfHpz6IZ
 9pMbwx1zerGQbKLAwmqHlZCIcbjn9TIiQgWGrBzN5Ki6wxv4wq
 POkukFTtu6X6G8ZhTLj9Npw03L0bphSXjSnSRHhCKP8sRMmyAk
 hpzNH2Aya/CcnxrO7vr0wy6jKqMr1QhGBH1rRitH6sSIgOjz0M
 t1wMq4mS3oOBo06eiVPWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211926>

On 20.12.12 21:01, Jeff King wrote:
> +test_fully_contains () {
>> +	sort "$1" >expect.sorted &&
>> +	sort "$2" >actual.sorted &&
>> +	test $(comm -23 expect.sorted actual.sorted | wc -l) = 0
>> +}

(Good to learn about the comm command, thanks )
What do we think about this:


diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3cd53f8..82eeba7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -62,12 +62,16 @@ test_completion ()
 {
 	if test $# -gt 1
 	then
-		printf '%s\n' "$2" >expected
+		printf '%s\n' "$2" | sort >expected.sorted
 	else
-		sed -e 's/Z$//' >expected
+		sed -e 's/Z$//' | sort >expected.sorted
 	fi &&
 	run_completion "$1" &&
-	test_cmp expected out
+	sort <out >actual.sorted &&
+	>empty &&
+	comm -23 expected.sorted actual.sorted >actual &&
+	test_cmp empty actual &&
+	rm empty actual
 }
 
 # Test __gitcomp.
