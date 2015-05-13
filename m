From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Wed, 13 May 2015 07:42:03 -0700
Message-ID: <xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 16:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsXrP-0002px-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 16:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934412AbbEMOmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 10:42:07 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35554 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933442AbbEMOmF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 10:42:05 -0400
Received: by iebpz10 with SMTP id pz10so34001083ieb.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FaNheHtCjWgELubuA+V8ihr7ZXxjroYucVKUvwuNB6E=;
        b=rH+7/OJWnQrQ14HSyG2H4f2vMxWLdhKHzJmpcF9zmCESvZO488GbpMTW3y1qjnikgJ
         c5Ao4LMVC6zmh+ggOWRfY3Zm+46SuWH4O14u0mznURktcW9JAAgSCKouDbXn3uMKcEiT
         TibCh85oNugtUFN3bMgSk4JDNNxS9DOtG8d3GoficQumJWTDxJJY3oc3RBv2/wRwgEUB
         oOmvvyFPSnFWppZ7glhRlg3J+ecuTNBK4BsicDyOr0zHvqWPq0WZEJPTIw7csOKibQoJ
         lVYgdsCRLWA9kt04kGXiZru+Xxcu3p6xsn8839ApBTQBeY29yc2A9o4mEd3bEcQcXrrT
         wqwA==
X-Received: by 10.42.197.65 with SMTP id ej1mr651831icb.13.1431528125136;
        Wed, 13 May 2015 07:42:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id m9sm3730206igv.4.2015.05.13.07.42.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 07:42:04 -0700 (PDT)
In-Reply-To: <xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 13 May 2015 07:01:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268985>

Junio C Hamano <gitster@pobox.com> writes:

> Paul Tan <pyokagan@gmail.com> writes:
>
>> Replace the above 2 forms with:
>>
>> 	verbose test "$(cat file)" = expected
>
> Quoting is very much a good idea, but I am not enthused by the
> vision of having to write verbose everywhere in our script.
>
> After seeing a script fail, you can run it again with -i -x options;
> wouldn't it be sufficient?

Just to avoid misunderstanding, I am unhappy if we have to keep
writing "verbose test" in that exact form.

Just like we invented to help debugging by wrapping "cmp" with
"test_cmp" (i.e. we want to see if the file contents are the same,
but a person who debugs can be helped by seeing the differences when
the expectation is not met), I do not mind if we had a shorter and
cleanly-named wrapper that we can use consistently.  E.g. I do not
mind something like this in test-lib-functions.sh

	test_file_contents () {
		if test "$(cat "$1")" != "$2"
		then
			echo "Contents of file $1 is not $2"
                        false
		fi
	}

and used like so:

	test_file_contents file expected_string
