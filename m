From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v7 4/4] config: allow http.<url>.* any user matching
Date: Mon, 22 Jul 2013 05:52:49 -0700
Message-ID: <A7388818-53EA-4D77-9342-B15D74495811@gmail.com>
References: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79> <b8fedff6e14fded3929e2b835aac6f9@f74d39fa044aa309eaea14b9f57fe79> <7va9lfqi3b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 14:52:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Fbm-0005jV-0R
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 14:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab3GVMwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 08:52:54 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50136 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab3GVMwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 08:52:53 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so1667356pad.33
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=aoedYZY69239KEDPzYBYbdWxiuGaXZi2+LAaNQ1K63c=;
        b=Ei0QIKtLtr79Ihv9Ic2cFgq2f1Fd4MAPKDiee78q2hYAoWdMqd5NFGvFv8qRKYRf0T
         NewqY4ckzzZmTh5VLD2qcISkxiPfkj9PGvXzLBiZeIG/RjOXqGMzw307zS8XmLEkyHzC
         2CBSgWnxIbbVdhoITgW0O4sitzGt56eBFP4MBu3QkTIe77FI7YRrTcqsUiiJ7fN1vfG2
         iR5SE6oFESBm4PhNwcyAfBYP4PL/NQF3JNFZgzd0bZcUgNE2t+np5DeKzoptangkuYd9
         oxgf2lroh7so4zoW4dE1RwEyf/WqWewPMohE2ILmTkklK0yAcUo8hl2wvCK6A8RLkKdl
         UhYw==
X-Received: by 10.68.238.230 with SMTP id vn6mr16410233pbc.66.1374497572793;
        Mon, 22 Jul 2013 05:52:52 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kc8sm35745110pbc.18.2013.07.22.05.52.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 05:52:51 -0700 (PDT)
In-Reply-To: <7va9lfqi3b.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230976>

On Jul 21, 2013, at 22:28, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> diff --git a/test-url-normalize.c b/test-url-normalize.c
>> index d68312d..f325571 100644
>> --- a/test-url-normalize.c
>> +++ b/test-url-normalize.c
>> @@ -9,7 +9,7 @@ int main()
>
> It looks like that this program could also drive http_options()
> directly, or alternatively make a call
>
> 	git_config(http_options, &info);
>
> in its main() to let the config parser do its work, to make sure
> that the machinery picks up the right values from the desired entry
> in the configuration file, with a bit more effort.

OK.

> OK, so if there is a configuration for a generic URL that is longer,
> it defeats a shorter URL with a specific username, e.g. when talking
> to host.xz/name as kyle, with configuration for these two keys
> exist:
>
> 	scheme://kyle@host.xz/path
>        scheme://host.xz/path/name
>
> the value for the latter one is used.
>
> I am not complaining; just making sure that is what we want to give
> users, as it was not quite clear in the Documentation/config.txt
> part of the patch.

Will add example to Documentation/config.txt to make it clearer.
