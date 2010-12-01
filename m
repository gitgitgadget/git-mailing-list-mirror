From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Remove backward goto in read_craft_line()
Date: Wed, 01 Dec 2010 12:19:59 -0800
Message-ID: <7vaakputxs.fsf@alter.siamese.dyndns.org>
References: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
 <20101201194441.GB27347@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 21:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtA5-00049y-Kt
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922Ab0LAUUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:20:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab0LAUUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:20:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C94B313E;
	Wed,  1 Dec 2010 15:20:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=94aAKSnb7PzeKYGF0bNdKk0CiSg=; b=iT0kD4
	n1B237bbLsPE5YlUCINDUDUkVdBVH0O+Adw2k3CEVeDD+YXg1B8PVwITcKgUOIxr
	X4aItbthRtkQwzngYKQu718uv9wvrcRoioHJzovCfb30pXEudCzzNhu887Vs3IXl
	Nm68esbfm07EZBXOp9lOQQOHaeQC/5iJPvhUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hq3Dmum0n4gwrEe/GnVfafjUojj8akhE
	6b2olmFezG0OwfWlc2GkQ2saACb8qTB5UcHYS1hZqw0A1ljKtmbWfjW/x1eq/OBX
	o5Eq12tJhIDqKXRbz85D8+MgXkagKRagoFXcVCxJ6Q8vDaaPtrQJumvqNerbqDfM
	IlTyzxPgfYo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8515313D;
	Wed,  1 Dec 2010 15:20:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7A00A313B; Wed,  1 Dec 2010
 15:20:19 -0500 (EST)
In-Reply-To: <20101201194441.GB27347@burratino> (Jonathan Nieder's message of
 "Wed\, 1 Dec 2010 13\:44\:42 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6EA0BA74-FD88-11DF-8704-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162601>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -155,6 +151,11 @@ struct commit_graft *read_graft_line(char *buf, int len)
>>  			goto bad_graft_data;
>>  	}
>>  	return graft;
>> +
>> +bad_graft_data:
>> +	error("bad graft data: %s", buf);
>
> A space before the "bad_graft_data:" label would improve future
> diff --show-c-function output.

Hmm, I actually do not think we encourage that (nor we should).

    $ git grep -e '^ [a-z0-9]*:' -- '*.c' | wc -l
    23
    $ git grep -e '^[a-z0-9]*:' -- '*.c' | wc -l
    42

If "--show-c-function" output is the problem, perhaps we should know a bit
better about what C function header looks like?
