From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Fri, 25 Mar 2016 10:01:08 -0700
Message-ID: <xmqqlh564hm3.fsf@gitster.mtv.corp.google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-4-git-send-email-sbeller@google.com>
	<xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ684W46df9zPQATr3zWKt+e1BhGY6DZ84psfXWH4tGNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:01:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajV6r-0003Jq-1x
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbcCYRBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 13:01:12 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753321AbcCYRBL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:01:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DCD94DF9E;
	Fri, 25 Mar 2016 13:01:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yw+Hi4gAxvp4aQXZTvOCftHjo3Q=; b=SoMQG5
	ce+DzRvqAEyADggY3h3HgisJCOgsAsvjZdqiJrDsA/bmfVNENv5kqSfLC+WoMlda
	WyRVcVT159rGGKzgDdMicyeH8yXTV6U3AnOq0qHO5Q3WOhTFE/E5eoSq3xPYA4pD
	xBIJQNfN0dDd5570d57z394urd/mkS+kFx/IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yPwv49YvLez2TIkS+afWax8mRH1eGz2z
	ALxPsy+hhNmaaddv2bLc7PjOhVyvZEH5qfYITd4qjYDzqOJOFr0zhPSJB+PzooIP
	ayJ8BjCJnonK+fG8qO5FYwWBe6bE9+58CNrlnfhc0Oj2xvNqZIYFr/XhJsmxVqJ1
	A6t8b7ZOul4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 151D44DF9D;
	Fri, 25 Mar 2016 13:01:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 554C14DF9C;
	Fri, 25 Mar 2016 13:01:09 -0400 (EDT)
In-Reply-To: <CAGZ79kZ684W46df9zPQATr3zWKt+e1BhGY6DZ84psfXWH4tGNw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 25 Mar 2016 09:49:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2BE4C234-F2AB-11E5-B217-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289907>

Stefan Beller <sbeller@google.com> writes:

> The other reason you gave below is also convincing: By having it in the prefix,
> the C code is more likely correct and future proof.
>
> On rewriting the whole submodule command in C (probably
> reiterating): It is not my endgoal to rewrite every submodule
> related part in C. It would be nice if it would happen eventually,
> but for now I only rewrite parts that I need in C.

Well, what you personally would want to do yourself is irrelevant.
Doing submodule--helper in such a way that it is sufficient in a
half-way conversion but cannot be reused in future full rewrite is
something we would want to avoid, whether you would be doing the
full rewrite in the future.  In fact, if you are not inclined to do
so yourself, that is one more reason to make sure that the C pieces
in submodule--helper are reusable (i.e. your "correct and future
proof" above); otherwise you'd be making it _more_ difficult for
other people who would want to pick it up where you left.
