From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression?] trailing slash required in .gitattributes
Date: Tue, 19 Mar 2013 11:10:08 -0700
Message-ID: <7vsj3ri7lr.fsf@alter.siamese.dyndns.org>
References: <20130319175756.GA13760@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 19:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI0zi-0000Ty-07
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 19:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415Ab3CSSKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 14:10:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933390Ab3CSSKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 14:10:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F741B9FF;
	Tue, 19 Mar 2013 14:10:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=olQKdvu+Ol63Od8OYJsZpN0aS4E=; b=Fx/TEd
	3uicHfe2JxY2DB/9w7aXXdfD/N6RMTK1DPE8TRrKZIdhY9b2SGC1FoG/RNiCbIxu
	Gx+AcwzaHmFbJGtSQXlJ2S96Ym0dB1pDNQ79eLy1Zwbj2XCjkMponk8gSvzV69it
	gOaWk8I47C2RDeiNP8YuVs8YRGx5a6sPLov+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X9NNqqD2s90ht6oryWNsL1YtL1WVC1lS
	C7R82fW7kFL8m8O7S/stfIePj19lwSQd3Axp7aBT1hUBiZETWwqDCIucQNnqM5Ca
	RQPeyXJYofzbUycXn1+TAVFUlBPmV4Nb4zLrjzofxOO79YUspAYC6K4/w+7ZUzjN
	/IPiF5l7bqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E39B9FE;
	Tue, 19 Mar 2013 14:10:11 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60F43B9FC; Tue, 19 Mar 2013
 14:10:10 -0400 (EDT)
In-Reply-To: <20130319175756.GA13760@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Mar 2013 13:57:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CE153B8-90C0-11E2-87AE-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218545>

Jeff King <peff@peff.net> writes:

> Prior to v1.8.1.1, if I did this:
>
>   git init
>   echo content >foo &&
>   mkdir subdir &&
>   echo content >subdir/bar &&
>   echo "subdir export-ignore" >.gitattributes
>   git add . &&
>   git commit -m one &&
>   git archive HEAD | tar tf -
>
> my archive would contain only "foo" and ".gitattributes", not subdir. As
> of v1.8.1.1, the attribute on subdir is ignored unless it is written
> with a trailing slash, like:
>
>   subdir/ export-ignore
>
> The issue bisects to 94bc671 (Add directory pattern matching to
> attributes, 2012-12-08). That commit actually tests not only that
> "subdir/" matches, but also that just "subdir" does not match.
>
> The commit message there is vague about the reasoning, but my
> understanding is that it was meant to harmonize gitignore and
> gitattributes, the former of which can take "dir/". I don't have a
> problem with offering "dir/" to match only directories, but what is the
> point in disallowing just "dir" to match a directory?
>
> It seems like a pointless regression to me, but I'm not clear whether it
> was intentional or not (and if it was intentional, I think we would need
> to handle it with a proper transition period, not in a maint release).

I agree that is a pointless regression.
