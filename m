From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 16:26:42 -0700
Message-ID: <7v1uyoaxu5.fsf@alter.siamese.dyndns.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <20110620213001.GB32765@one.firstfloor.org>
 <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
 <20110620220347.GE32765@one.firstfloor.org> <20110620223156.GA695@elie>
 <20110620223705.GG32765@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 01:26:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYnrm-0008W1-8X
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 01:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131Ab1FTX0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 19:26:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab1FTX0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 19:26:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B38396E8E;
	Mon, 20 Jun 2011 19:28:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Synh+D02Wa8SxpC2ZaipJlSbAM=; b=FpllCJ
	in9Ej4oSSB4j+Gh/AAJ3qOA7w5EUdiqron5gdyJBnGTm5I1iTh6tCRFvT8badEEa
	22/H11n8ARhV4vT4QSN5oPO2/MUsoZS+brisOYVCSg3zNgNaOLIYXJVHizNkmfYe
	acHTn4k7fPiscbVzOqdtfVQI2F5RRV/8hzW2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9rAnXjkVQUT2UJFU4h+PnN5Y9zZT6hk
	AkmVlH+MNfBakvoUGVw3bn232JLMtSj+xSuOyy8LZLnhrox5wRcq4BEM7ygxyPKj
	pAfNktSIWiEEJlRImLRwQwnRWf/FG0rAtmRjgHPOhYd5SSZJaWp1PJpwMFj+ibwL
	qZZhM44OjwA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC3166E8D;
	Mon, 20 Jun 2011 19:28:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 059016E8C; Mon, 20 Jun 2011
 19:28:55 -0400 (EDT)
In-Reply-To: <20110620223705.GG32765@one.firstfloor.org> (Andi Kleen's
 message of "Tue, 21 Jun 2011 00:37:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1117DE5E-9B95-11E0-898A-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176110>

Andi Kleen <andi@firstfloor.org> writes:

>> Please remember to think for yourself. ;-)  Junio generally gives good
>> advice, but if you don't see the wisdom in it, that's the time to ask
>> questions, not blindly do a wrong thing.
>
> To be honest it's still not clear to me what was wrong with patch (2).

For example.

    diff --git a/builtin/commit.c b/builtin/commit.c
    index 5286432..51ee2e5 100644
    --- a/builtin/commit.c
    +++ b/builtin/commit.c
    @@ -962,6 +962,7 @@ static const char *find_author_by_nickname(const char *name)
                    return strbuf_detach(&buf, NULL);
            }
            die(_("No existing author found with '%s'"), name);
    +	return NULL;
     }

When the above is applied and compiled without NO_NORETURN, the extra
return may be optimized out by the compiler as your commit log messages
said, but wouldn't it introduce a new warning:

  builtin/commit.c: In function 'find_author_by_nickname':
  builtin/commit.c:965: error: will never be executed

under -Wunreachable-code?
