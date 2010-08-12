From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V5 16/17] Add tests for line history browser
Date: Thu, 12 Aug 2010 14:06:02 -0700
Message-ID: <7vwrrvr16t.fsf@alter.siamese.dyndns.org>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
 <1281539022-31616-17-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 23:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojeym-0005Va-43
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 23:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759977Ab0HLVGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 17:06:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021Ab0HLVGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 17:06:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 736B8CDB26;
	Thu, 12 Aug 2010 17:06:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HR0sViZsCir9i6dFj8qH3iTcEO4=; b=E4Kay4
	Nj/P4250AZsh+PtDvO/wiYXnQn18UwNRiGNknklHtJ9c2U/9v3gzRuesNrUU/dOs
	HhvfnuPDXZjggInPDa7ZA4HcbeivM39+9hfdSWQgagsXSCkwucVSbHGxsdFxihWc
	fKeTYAZvXGubp4caBn/nygFJfmm4HI7+6MPuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dB+XWvlPDg8/zQj9adKa6YP7gQAihx+b
	APEdITPwP1BOIs2mwc5mbAz/o9YsNRL90p1pPN9PLjpYOvWnKKmLu9/QZWdxTQ0r
	YhtDD17SF7ahjsGDE6PZm8v310E2GxCj8Ztw5l88uXQTSOgKImUgMgbgu5E0Q3w4
	IyREtkPbRFM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F654CDB23;
	Thu, 12 Aug 2010 17:06:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2E85CDB22; Thu, 12 Aug
 2010 17:06:03 -0400 (EDT)
In-Reply-To: <1281539022-31616-17-git-send-email-struggleyb.nku@gmail.com>
 (Bo Yang's message of "Wed\, 11 Aug 2010 23\:03\:41 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6DEBA092-A655-11DF-B635-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153418>

Bo Yang <struggleyb.nku@gmail.com> writes:

> +test_description='Test git log -L with single line of history
> +
> +'
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/diff-lib.sh
> +
> +echo >path0 'void func(){
> +	int a = 0;
> +	int b = 1;
> +	int c;
> +	c = a + b;
> +}
> +'

Please do not have a set-up code like this one outside of test.

You may want to also adjust the coding style of the sample code ;-)  The
brace at the beginning of a function body sits at the leftmost column.

> +echo >path1 'void output(){
> +	printf("hello world");
> +}
> +'
> +
> +test_expect_success \
> +    'add path0/path1 and commit.' \
> +    'git add path0 path1 &&
> +     git commit -m "Base commit"'

And these days we indent and quote like this:

	test_expect_success 'what this test does' '
        	the body of the
                test
                comes
                here
	'

which makes it easier to read and by not requiring excessive use of
backslashes.

Perhaps like this (or use 'sed -e "s/^	|//"' instead of cat and indent the
here text by one tabstop plus a vertical bar)?

test_expect_success 'add path0/path1 and commit' '
	cat >path0 <<\EOF &&
void func(void)
{
        int a = 0;
        int b = 1;
	int c;
        c = a + b;
}
EOF
	cat >path1 <<\EOF &&
void output(void)
{
        printf("Hello, World!");
}
EOF
	git add path0 path1 &&
        test_tick &&
        git commit -m "Base commit"
'
