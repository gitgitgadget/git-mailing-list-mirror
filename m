From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 12:32:37 -0800
Message-ID: <xmqqziuomsyi.fsf@gitster.mtv.corp.google.com>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
	<20160225014149.GA31616@sigill.intra.peff.net>
	<CA+P7+xpfuPkwcdeXVTiTdqRCX16J4pus-wmxe7Sipu_GXCNSoA@mail.gmail.com>
	<20160225070036.GA5654@sigill.intra.peff.net>
	<20160225071159.GA22529@sigill.intra.peff.net>
	<CA+P7+xqa8+DopurNGnuW1HKMOmj2r2mvahossK_11SyMSWm2_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:32:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2ae-0007Be-Hn
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbcBYUcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:32:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751661AbcBYUck (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:32:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3671347AC0;
	Thu, 25 Feb 2016 15:32:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VPwQxahxDuhOI5RqLsF9IAd6MRg=; b=x8CTB1
	x8jp9P4vTJDDIe14RlszlYE0g96e+eaqN4CKoqUpYgcCTZrP4D2lyaz6T6FzXLew
	52EppURsGUdBwIZFhFtLC6aJzhdDLBJBRu2YSuu6hHECv7wRZAw2wAGptnAtwbYo
	FMEDl4Pol3ipDl6iXAmaM0wkXSRHRkR1kCTSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z6QbK6fJKolueyo52vsuviMUbCLQsmS/
	l2peTpWAA9ZW9iHhQD49h9p9ww5MsdM7OdfgZCO3jjb2+HeWPyOp0FWy9fozNsQl
	C6nymLaDWCPRtOYYKb76kvl9/WcU9RIkXVWdxUFfkCH/dgc42k03wTZwFSWkQCSQ
	WplFwuGgyDA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D38247ABE;
	Thu, 25 Feb 2016 15:32:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A4D347AB6;
	Thu, 25 Feb 2016 15:32:38 -0500 (EST)
In-Reply-To: <CA+P7+xqa8+DopurNGnuW1HKMOmj2r2mvahossK_11SyMSWm2_g@mail.gmail.com>
	(Jacob Keller's message of "Thu, 25 Feb 2016 10:51:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E9503380-DBFE-11E5-827C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287435>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Feb 24, 2016 at 11:11 PM, Jeff King <peff@peff.net> wrote:
>>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>>                            const char *depth, const char *reference, int quiet)
>>  {
>> @@ -145,7 +166,7 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>>         argv_array_push(&cp.args, path);
>>
>>         cp.git_cmd = 1;
>> -       cp.env = local_repo_env;
>> +       add_submodule_repo_env(&cp.env_array);
>>         cp.no_stdin = 1;
>>
>>         return run_command(&cp);
>
>
> Ignore my previous comment. The cp.env API is *very* subtle. If the
> line is just a name, it removes the environment variable, while
> "name=value" adds it. That is definitely not what I was expecting
> here, so I misread how it works.

I think that is modelled after how putenv(3) is made capable of
removing an existing environment variable.
