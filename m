From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git fetch one tag only
Date: Thu, 07 Jun 2012 10:08:41 -0700
Message-ID: <7v8vfzjbhi.fsf@alter.siamese.dyndns.org>
References: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
 <CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
 <CAH5vBdKPH_-cn=r-zxQKCOi5PB5D6vuSXrZxPeZJ+HYg-K9Yqw@mail.gmail.com>
 <7vpq9bk7o5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cheng renquan <crquan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 19:08:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScgCY-0005PZ-4w
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760834Ab2FGRIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:08:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760643Ab2FGRIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:08:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F4D58729;
	Thu,  7 Jun 2012 13:08:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rEtJxclmWVDZzddtNXNBY49xNDI=; b=OkDDr3
	6KtCQT2X6gOnz3iiNqFbzzczMqAViWqwPlXhB6IU20fSTrIomYQ/xjWFnu0ziYjY
	3Exghju5/1ebQ37X+Br3d/PgueZid+O+7Geg2WFSMOVA7VxeX2g/NdLi0myvJDSQ
	orfL031AIGyQkVNsa3mTrkKv/GzvmTwa0o4Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XGru9AGLV7M1oDtaeIqo66rK8TYMFevF
	6Zvb8tFmPQqJ0YMKU740gREMf4r+UXvZiyzo3HXcpkLGNSpD3N9Rn3QxDasRetUL
	UKNwWRdS67LtM2MRInMphSJOzjIlFhMTGw8p9p13E9iOMKXB7IDS1Ons6Abincgg
	toUvLcNE4kk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 974F58727;
	Thu,  7 Jun 2012 13:08:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2871E8723; Thu,  7 Jun 2012
 13:08:43 -0400 (EDT)
In-Reply-To: <7vpq9bk7o5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Jun 2012 22:33:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F640200-B0C3-11E1-BE3A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199420>

Junio C Hamano <gitster@pobox.com> writes:

> It is a separate matter if we should add some special case to further
> reduce the cases where auto-following happens. I personally do not
> think any change is needed.

I do not care too deeply either way, but after doing

	$ git init blank && cd blank

and in an empty repository:

        $ git fetch $over_there v1.0.0

will grab the named tag and drop it in FETCH_HEAD, without adding
anything to your local refs, while

	$ git fetch $over_there tag v1.0.0

will grab the named tag and copy it to your refs/tags/v1.0.0, and
auto-follow all the tags that point at commits that are reachable.

To grab and store _only_ v1.0.0 in the local refs, you need to say
"do not auto-follow" with

	$ git fetch $over_there --no-tags tag v1.0.0

While it may be workable, the user experience could be better in a
couple of different ways.

 * It is not fair to expect anybody to guess that "--no-tags" means
   "--no-auto-follow-tags" without reading documentation.

	$ git fetch $over_there --no-auto-follow-tags tag v1.0.0

   might be an improvement, but of course, it is a bit longer to
   spell ;-).

 * The auto-follow kicks in whenever you tell "fetch" to update some
   refs locally.  Maybe if we tweak the rule and auto-follow kick in
   only when you tell "fetch" to update some refs outside refs/tags
   locally,

	$ git fetch $over_there tag v1.0.0

   will fetch and store _only_ the v1.0.0 tag.

   Of course, any behaviour change is a regression, and if done
   without an escape hatch, such a change robs people one useful
   feature: grab tag v1.0.0 and others older than that tag in one
   go.

I won't be coding any of the above; just thinking aloud. 
