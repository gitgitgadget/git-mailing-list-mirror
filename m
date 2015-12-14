From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] format-patch: check that header line has expected format
Date: Mon, 14 Dec 2015 11:11:49 -0800
Message-ID: <xmqqmvtckfpm.fsf@gitster.mtv.corp.google.com>
References: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
	<1450027638-788102-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:12:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YXQ-00050g-Vo
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbbLNTLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:11:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932287AbbLNTLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:11:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3D723198D;
	Mon, 14 Dec 2015 14:11:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GLQWSaTSL9Zhk7tfJ/tkZfi5UwM=; b=GAKycK
	mzYCeX/ZYvEkSHalhQ/tSn0EPC6aSdk5TnfnOXLx2qMzoIQ/dlR6HoKqaTkoMpMj
	irh/ViqG6yoA34I74XB1rFSsNsjOHU5t47ifcEwqwVBPGrd6PH5BcKSgyl4ui35x
	NTDWx+uB+dN4+Ui3IvbnDIGk4sW3UqEV6aYC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RjZyZdNfA84XgM2UytzOJrU9dde4MFnx
	CK8dGwSannzVU4gwUEIAwmgUAJ0lN+LNq55wMX7Xs2vf3eJujKqi3C/D1y1WCBqX
	5JShdKKzSXtMgoKneKsTbsC0UjFZVTaAG6WC3Oa8gdap+Kw374vglkcXTf+cQwxy
	/ou2aGjHrOg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC0633198B;
	Mon, 14 Dec 2015 14:11:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 294A931989;
	Mon, 14 Dec 2015 14:11:51 -0500 (EST)
In-Reply-To: <1450027638-788102-4-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 13 Dec 2015 17:27:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 87CCDD3A-A296-11E5-A26B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282380>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The format of the "From " header line is very specific to allow
> utilities to detect Git-style patches.  Add a test that the patches
> created are in the expected format.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t4014-format-patch.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index b740e3da..362bc228 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1437,4 +1437,10 @@ test_expect_success 'format-patch --zero-commit' '
>  	test $cnt = 3
>  '
>  
> +test_expect_success 'From line has expected format' '
> +	git format-patch --stdout v2..v1 >patch2 &&
> +	cnt=$(egrep "^From [0-9a-f]{40} Mon Sep 17 00:00:00 2001" patch2 | wc -l) &&

Don't you want to anchor the pattern to the right as well?

> +	test $cnt = 3
> +'
> +
>  test_done
