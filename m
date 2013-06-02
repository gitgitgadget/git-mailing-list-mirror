From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Sun, 02 Jun 2013 16:44:23 -0700
Message-ID: <7vr4gkkrhk.fsf@alter.siamese.dyndns.org>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
	<87bo7slrz1.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 03 01:44:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjHwu-0003w1-1A
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 01:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab3FBXo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 19:44:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab3FBXo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 19:44:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C87FE24F15;
	Sun,  2 Jun 2013 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=efsXUAkcxUE9wCIN+4/4/zM0UcI=; b=JYqzivetmiPYHQzhpK/z
	yUQR+FkAqKU6/dQ3qSV0QIGHhtuxLxMR8UzG+A5nu1fqhFpuQ6DaIgyfSBktnceA
	bZ/VUGacvWqRYFLb0JX4iGugfst/2tZZbqLZzNxpbWR2DROCPG8esx40OBCQcju0
	WHs4wuyo2F4OOkcn21/+rWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=luufkrdhiWnnosdw/1RT1oP0F9baZGc9PIt7ZfIehBn7c2
	LZpPSRzlA+faKEiiAG6+VGViu3DAPCgy6M64kitDA91dSlLc7NiKgMUqvs+hVSts
	BryKnQmFEfQRO4D6Z/5gmfG48USi2LdQcGGi2ODLX59aJLM2k8IY85Ir1lFfI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB0B524F14;
	Sun,  2 Jun 2013 23:44:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16A9424F12;
	Sun,  2 Jun 2013 23:44:24 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B6455F2-CBDE-11E2-BE8D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226195>

Thomas Rast <trast@inf.ethz.ch> writes:

> This interacts with the tests from
>
>> * fc/at-head (2013-05-08) 13 commits
>
> to fail valgrind in t1508 like so:
>
>   ==22927== Invalid read of size 1
>   ==22927==    at 0x4C2C71B: __GI_strnlen (mc_replace_strmem.c:377)
>   ==22927==    by 0x567FF6B: vfprintf (in /lib64/libc-2.17.so)
>   ==22927==    by 0x56AC194: vsnprintf (in /lib64/libc-2.17.so)
>   ==22927==    by 0x4EAC39: vreportf (usage.c:12)
>   ==22927==    by 0x4EACA4: die_builtin (usage.c:36)
>   ==22927==    by 0x4EAEE0: die (usage.c:103)
>   ==22927==    by 0x4D8C51: get_sha1_1 (sha1_name.c:542)
>   ==22927==    by 0x4D8E5D: get_sha1_with_context_1 (sha1_name.c:1299)
>   ==22927==    by 0x4D992A: get_sha1_with_context (sha1_name.c:1417)
>   ==22927==    by 0x4D99E1: get_sha1 (sha1_name.c:1124)
>   ==22927==    by 0x45E1AC: cmd_rev_parse (rev-parse.c:761)
>   ==22927==    by 0x4051B3: handle_internal_command (git.c:284)
>   ==22927==  Address 0x5bebccb is 11 bytes inside a block of size 22 free'd
>   ==22927==    at 0x4C2ACDA: free (vg_replace_malloc.c:468)
>   ==22927==    by 0x4D8C37: get_sha1_1 (sha1_name.c:541)
>   ==22927==    by 0x4D8E5D: get_sha1_with_context_1 (sha1_name.c:1299)
>   ==22927==    by 0x4D992A: get_sha1_with_context (sha1_name.c:1417)
>   ==22927==    by 0x4D99E1: get_sha1 (sha1_name.c:1124)
>   ==22927==    by 0x45E1AC: cmd_rev_parse (rev-parse.c:761)
>   ==22927==    by 0x4051B3: handle_internal_command (git.c:284)
>   ==22927==    by 0x4053E7: main (git.c:492)
>
> I think it's enough to squash this little change; leaking some memory
> immediately before die() is not too bad, especially if we're going to
> pass real_ref+11 into die()...

Good catch, thanks.  when !len and real_ref is the current branch,
str just points into real_ref that is geting freed.

>
> diff --git i/sha1_name.c w/sha1_name.c
> index 5ea16ff..a07558d 100644
> --- i/sha1_name.c
> +++ w/sha1_name.c
> @@ -538,7 +538,6 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  					"back to %s.", len, str,
>  					show_date(co_time, co_tz, DATE_RFC2822));
>  			else {
> -				free(real_ref);
>  				die("Log for '%.*s' only has %d entries.",
>  				    len, str, co_cnt);
>  			}
