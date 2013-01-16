From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Wed, 16 Jan 2013 07:50:30 -0800
Message-ID: <7v622xyvnd.fsf@alter.siamese.dyndns.org>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
 <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
 <50F40316.7010308@drmicha.warpmail.net>
 <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
 <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com>
 <7vpq1755jb.fsf@alter.siamese.dyndns.org>
 <7vip6z54rh.fsf@alter.siamese.dyndns.org>
 <50F524F8.5090803@drmicha.warpmail.net>
 <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
 <50F668FB.5000805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 16:50:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvVGP-0000oD-MI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 16:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab3APPud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 10:50:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab3APPuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 10:50:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5FCB609;
	Wed, 16 Jan 2013 10:50:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ABUMeGpiVPcGsUIZF1jgeFgbwLM=; b=p9AzcR
	HWfzutJSHaVfrxJfDyii1tcIdx8J5X8JkBQIjzO/5JmhRb0N3zrZBFxgO/YCj6JM
	P2qwh+jugz6SudyYuREhAoC8BaYCbWFxio2ifilCNUwr/oYR/iMaE+FyOSbXRpuJ
	WM6QELo3zcncjiC9t0WuY6brmea7mJ99GebeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qaUYajW2oNFf8SiFCtqxN9l4pHrXhlNQ
	cGtGQ1od7ZoTLwwuNw9bDNpnKr10el3YCTvx8SSmnjBhoIfsjyUoY1T9kK44fmHe
	6Pad2+XA25aOwhK5FUaWdGdrO9QHlenbGx1q8jTa0wrdNWz0yp2b4vgQwcEoXTiz
	AB29NMIBYuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 418C7B608;
	Wed, 16 Jan 2013 10:50:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92938B606; Wed, 16 Jan 2013
 10:50:31 -0500 (EST)
In-Reply-To: <50F668FB.5000805@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 16 Jan 2013 09:46:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 751DDE92-5FF4-11E2-B62A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213761>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 15.01.2013 16:53:
> ...
>>  * When there are more than one URLs, and there is no pushURL, then
>>    show the first URL as (fetch/push), and the remainder in a
>>    notation that says it is used only for push, but it shouldn't be
>>    the same "(push)"; the user has to be able to distinguish it from
>>    the pushURLs in a repository that also has URLs.
>
> Maybe "(fetch fallback/push)" if we do use it as a fallback? If we don't
> we probably should?

I actually think my earlier "it shouldn't be the same (push)" is not
needed and probably is actively wrong.  Just like you can tell
between

    (only one .url)                     (both .url and .pushurl)

    origin there (fetch/push)           origin there (fetch)
                                        origin there (push)

even when the value of the URL/PushURL, i.e. "there", is the same
between .url and .pushurl, you should be able to tell between

    (two .url, no .pushurl)             (one .url and one .pushurl)

    origin there (fetch/push)           origin there (fetch)
    origin another (push)               origin another (push)

So let's not make it too complex and forget about the different kind
of "(push)".

A case that is a potential misconfiguration would look like:

    (two .url, one .pushurl)

    origin there (fetch)
    origin some  (unused)
    origin another (push)

I think.
