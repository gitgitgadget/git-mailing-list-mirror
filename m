From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 41/44] am: use be_silent in 'struct apply_state' to shut up applying patches
Date: Fri, 10 Jun 2016 15:07:58 -0700
Message-ID: <xmqq4m90elz5.fsf@gitster.mtv.corp.google.com>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
	<20160610201118.13813-42-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:08:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBUbE-00036o-4w
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 00:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbcFJWII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 18:08:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161097AbcFJWIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 18:08:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B221C24CE4;
	Fri, 10 Jun 2016 18:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hqwec33nfnaRg4zRno2jpw110Hs=; b=AMeeFs
	TkercXegXyl8RpzFnkz88n7x7RgkcMdFME860FC7jGCuxN0KRAgIpUXfan9EKoqH
	mwu4DXhAUHtk3vKg2oKm7Zc8acXdD/Aoywk4cLYDZ6z824ab1mRCpuhd0gnDjlmo
	PI1jDsmCsRAIlB3rgMx9xGi+HTCJXknC/7Vn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FQSjeA/nuHZt9mqq7n9hN+2UwbRqA9Xl
	dNeFUqYFcxbF7T6LeSuqwtVWQQQhWaJaQiO6MCJZN5cQbyhfs70fwVGB1345kgbz
	t/LYNfugr1qyWzu1uCk1Z5v6/j2dxIi6IYmdF6+Ivaa8m0qELMcOQRmYr7HfFvCG
	kVviH8RlA48=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA05224CE3;
	Fri, 10 Jun 2016 18:08:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D62F24CE2;
	Fri, 10 Jun 2016 18:08:02 -0400 (EDT)
In-Reply-To: <20160610201118.13813-42-chriscool@tuxfamily.org> (Christian
	Couder's message of "Fri, 10 Jun 2016 22:11:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC97795E-2F57-11E6-BD7E-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297078>

The update in 33/44 to make am call into apply that is not ready to
be called (e.g. the caller needs the dup(2) dance with /dev/null to
be silent) gets finally corrected with this step, which makes the
progress of the topic somewhat ugly and reviewing it a bit harder
than necessary.  As it stands, the last several patches in the
series smells more like "oops, we realize these things were not done
properly the first time, and here are the follow-up patches to fix
them up".

I wonder if it is a good idea to delay integrating the apply
machinery into "am" until it is ready?
