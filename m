From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to ignore instead?
Date: Fri, 04 Dec 2015 10:55:32 -0800
Message-ID: <xmqqpoymrql7.fsf@gitster.mtv.corp.google.com>
References: <20151027184702.GB12717@sigill.intra.peff.net>
	<CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
	<20151030001000.GA2123@sigill.intra.peff.net>
	<CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
	<20151030005057.GA23251@sigill.intra.peff.net>
	<CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
	<20151030210849.GA7149@sigill.intra.peff.net>
	<CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
	<20151109155342.GB27224@sigill.intra.peff.net>
	<CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
	<20151110122501.GA14418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:55:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4vW9-0005pO-N1
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 19:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbbLDSzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 13:55:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751228AbbLDSzg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 13:55:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A50DC3035C;
	Fri,  4 Dec 2015 13:55:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NpQuPLoUbgE57cjWXMQwnSG2uUg=; b=IZQaz+
	tE4nc29KxCRvKRiJkDTifbi80g468I05Bit2qrKjPfdeAhYDqkMtsI8f5ImKgfAR
	ppBZXH6EbFHMNCiS6RZB3rlWRiF6QaC2fXGoqU+5ai+ARRQv50xM4OiCm1/eg5ON
	ooszG1Ai+LtWA8b98BPQIayyQNSw0G9pSrL9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iL+exhrjsM7iwXAPjkx+GRIoj7hX54MU
	2aJ7JlLChLE/iVB6oMYTnOvmWQDyApnUY17hKLjr0yW5HVu6F5yZH8v8WiqZYeou
	GW2L5oVyr9ZBEl26+8jOrX2zsHlUY9aBCpqNkBIn5JJyKRSpN4W318ONeRXBJolB
	caCnFYZFaq8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90E6D3035B;
	Fri,  4 Dec 2015 13:55:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01D4630359;
	Fri,  4 Dec 2015 13:55:34 -0500 (EST)
In-Reply-To: <20151110122501.GA14418@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 10 Nov 2015 07:25:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99D533F0-9AB8-11E5-922A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281995>

Jeff King <peff@peff.net> writes:

>> diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
>> index eef6fce..6cda9c0 100644
>> --- a/credential-cache--daemon.c
>> +++ b/credential-cache--daemon.c
>> @@ -256,6 +256,9 @@ int main(int argc, const char **argv)
>>  		OPT_END()
>>  	};
>>  
>> +	int ignore_sighup = 0;
>> +	git_config_get_bool("credentialcache.ignoresighup", &ignore_sighup);
>> +
>
> Style-wise, I think the declaration should go above the options-list.

I was about to merge this to 'master', following your last issue of
"What's cooking" report.

I was puzzled that git_config_get_bool() is used here without even
checking if we are inside any Git repository and wondered if it was
correct.  I'd imagine this is not a problem, as this process is
spawned by "credential-cache" that was spawned by somebody (either
push or fetch) who has read $GIT_DIR/config for credential.helper to
determine that credential-cache needs to be used.

>> @@ -264,6 +267,10 @@ int main(int argc, const char **argv)
>>  
>>  	check_socket_directory(socket_path);
>>  	register_tempfile(&socket_file, socket_path);
>> +
>> +	if (ignore_sighup)
>> +		signal(SIGHUP, SIG_IGN);
>> +
>
> This part looks obviously correct. :)
>
> I don't think there's any need to use sigchain_push here (we have no
> intention of ever popping it).
>
> -Peff
