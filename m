From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] update-index: add --checkout/--no-checkout to update
 CE_NO_CHECKOUT bit
Date: Tue, 18 Nov 2008 18:18:10 -0800
Message-ID: <7v4p24tq59.fsf@gitster.siamese.dyndns.org>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
 <1222833849-22129-3-git-send-email-pclouds@gmail.com>
 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
 <1222833849-22129-5-git-send-email-pclouds@gmail.com>
 <1222833849-22129-6-git-send-email-pclouds@gmail.com>
 <20081118113316.GA18610@segfault.peff.net>
 <7vk5b0vp19.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:20:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2cgD-00069G-Va
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 03:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYKSCSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Nov 2008 21:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYKSCSj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 21:18:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYKSCSi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 21:18:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EDCCF17019;
	Tue, 18 Nov 2008 21:18:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 113FF17016; Tue,
 18 Nov 2008 21:18:12 -0500 (EST)
In-Reply-To: <7vk5b0vp19.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Nov 2008 10:59:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5F724C44-B5E0-11DD-8AE5-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101308>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Oct 01, 2008 at 11:04:05AM +0700, Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy wrote:
>>
>>> +test_expect_success 'setup' '
>>> +	mkdir sub &&
>>> +	touch 1 2 sub/1 sub/2 &&
>>> +	git add 1 2 sub/1 sub/2
>>
>> Mind-boggling, but this manages to break on Solaris. Fix is
>> below.
>
> I tend to avoid "touch", not specifically for this reason, but surely=
 this
> is another reason why ">sub/1" is much better way to create a throw-a=
way
> file ;-)
>
>> Note that this has implications for 'touch "$FOO" "$BAR"'
>> used in scripts if FOO might be entirely numeric. However, a
>> quick grep shows we usually touch one file at a time.
>
> You can always do:
>
> 	: >>"$FOO"

Having said all that, I wouldn't suggest redoing the patch using >>
redirection.  But change from "touch 1 nondigit" to "touch nondigit 1"
is a bit too subtle to my taste.  Let's write it this way instead:

diff --git a/t/t2104-update-index-no-checkout.sh b/t/t2104-update-index=
-no-checkout.sh
index be9f913..37a6861 100755
--- a/t/t2104-update-index-no-checkout.sh
+++ b/t/t2104-update-index-no-checkout.sh
@@ -9,7 +9,7 @@ test_description=3D'git update-index no-checkout bits (=
a.k.a sparse checkout)'
=20
 test_expect_success 'setup' '
 	mkdir sub &&
-	touch 1 2 sub/1 sub/2 &&
+	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2
 '
=20
