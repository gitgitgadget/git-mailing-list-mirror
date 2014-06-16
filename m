From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] test-lib: add test_dir_is_empty()
Date: Mon, 16 Jun 2014 15:05:47 -0700
Message-ID: <xmqq7g4gpl1g.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <539DD068.6020301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwf2M-0000iD-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 00:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbaFPWFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 18:05:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54762 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbaFPWFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 18:05:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F87320E33;
	Mon, 16 Jun 2014 18:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kkzDcb7yr8PfwMmnuT9tuJOT3Dw=; b=ZWDWol
	i+dmlclWeyiRvEvcgOPYZCzc4up/9gpm/zPi5g/l0k4lPMzZyjIf/TLjQvZRWol3
	6SUS15ckt9o17PfUtqHHFmGqFu9TFsqUWjXAPvlWjAJyUd3FhrnIy6pTOPn2m8IC
	1hXoGYPB5QL3TeDmzMs6setzwuXOqNvPLEuDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LZOKd6eS28D0Qu/T9yPl0IOBR/4UrEdT
	ka/M3jx/oRPp46ERiyfT/50vBae2DPMO8F1abNCMiSPDV4mqtj+cEWBR03OW/eoy
	vIuFh+QcumWvgSl9xeNBagW9F6kw33PvHvKXDXyhxyI8YfyW3H0CjWMw5sN0OPfN
	fNresqhMXoM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 857AD20E32;
	Mon, 16 Jun 2014 18:05:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2767520E2A;
	Mon, 16 Jun 2014 18:05:47 -0400 (EDT)
In-Reply-To: <539DD068.6020301@web.de> (Jens Lehmann's message of "Sun, 15 Jun
	2014 18:57:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E976B58-F5A2-11E3-8135-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251826>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> For the upcoming submodule test framework we often need to assert that an
> empty directory exists in the work tree. Add the test_dir_is_empty()
> function which asserts that the given argument is an empty directory.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  t/test-lib-functions.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 158e10a..546f0a6 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -489,6 +489,17 @@ test_path_is_dir () {
>  	fi
>  }
>
> +# Check if the directory exists and is empty as expected, barf otherwise.
> +test_dir_is_empty () {
> +	test_path_is_dir "$1" &&
> +	if test "$(ls -a1 "$1" | egrep -v '^\.\.?$')"

It is safer to say "test -n" when testing an emptyness of a string
whose contents you do not know or control (e.g. the string may begin
with "-something").

> +	then
> +		echo "Directory '$1' is not empty, it contains:"
> +		ls -la "$1"
> +		return 1
> +	fi
> +}
> +
>  test_path_is_missing () {
>  	if [ -e "$1" ]
>  	then
