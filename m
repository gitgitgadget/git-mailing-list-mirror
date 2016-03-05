From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] fetch-pack: fix object_id of exact sha1
Date: Sat, 05 Mar 2016 10:54:13 -0800
Message-ID: <xmqqd1r8vjqi.fsf@gitster.mtv.corp.google.com>
References: <20160304005000.GA1074@sigill.intra.peff.net>
	<1457140298-2400-1-git-send-email-gabrielfrancosouza@gmail.com>
	<20160305165946.GA23114@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 05 19:54:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acHLI-0002rd-TL
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 19:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbcCESyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 13:54:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750724AbcCESyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 13:54:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C46A24A36A;
	Sat,  5 Mar 2016 13:54:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G78ucn2CzuJX3AckdLTZ9zEla0M=; b=mbzFdw
	d818g1L+B0nXsqCTKDIu5VNXwn1L+aiX0bzl94Nc1NLRov/9d0AgexzcuAH0gmNG
	+RUjoNrL4tri+nAra1zPzd0XlvxdO1gVXTux9q03Osm5svc41LT0thxa87bnCRp4
	13bXBnsoI1CEOuRVyuXYgQl+8m80nkZooNcts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TMuXLkSVK25Fx1Z1wofQhE4he/JRzUZu
	YU8Co2/Zi8iEClu5w6d4tYhvdYBok/RX+XSrgzHE0Zd0La+FFPdJDq7mssSNiFRD
	J9aw8eMUgVbQQrpBEkIlz5sXkTfFj0FcjtK6cCjYVbeAcwZy6IEY2tXDi/OKaQqA
	zx4RTSR7Qls=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB8F44A369;
	Sat,  5 Mar 2016 13:54:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E4A54A368;
	Sat,  5 Mar 2016 13:54:14 -0500 (EST)
In-Reply-To: <20160305165946.GA23114@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 5 Mar 2016 11:59:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7B408C8-E303-11E5-9F0D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288320>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 04, 2016 at 10:11:38PM -0300, Gabriel Souza Franco wrote:
>
>> Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
>> 2013-12-05) added support for specifying a SHA-1 as well as a ref name.
>> Add support for specifying just a SHA-1 and set the ref name to the same
>> value in this case.
>> 
>> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
>> ---
>>  Documentation/git-fetch-pack.txt |  4 ++++
>>  builtin/fetch-pack.c             | 16 +++++++++++++---
>>  t/t5500-fetch-pack.sh            | 14 ++++++++++++++
>>  3 files changed, 31 insertions(+), 3 deletions(-)
>
> Thanks, this version looks good to me.

It does to me too, but unfortunately the previous one is already in
'next'.  Something like this as an incremental update would suffice.

-- >8 --
From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Date: Fri,  4 Mar 2016 22:11:38 -0300
Subject: fetch-pack: update the documentation for "<refs>..." arguments

When we started allowing an exact object name to be fetched from the
command line, we forgot to update the documentation. 

Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
--
 Documentation/git-fetch-pack.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 8680f45..239623c 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -104,6 +104,10 @@ be in a separate packet, and the list must end with a flush packet.
 	The remote heads to update from. This is relative to
 	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
 	unspecified, update from all heads the remote side has.
++
+If the remote has enabled the options `uploadpack.allowTipSHA1InWant` or
+`uploadpack.allowReachableSHA1InWant`, they may alternatively be 40-hex
+sha1s present on the remote.
 
 SEE ALSO
 --------
