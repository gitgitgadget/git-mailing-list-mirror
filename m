From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Mon, 20 May 2013 15:22:46 -0700
Message-ID: <7v1u91uw95.fsf@alter.siamese.dyndns.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-3-git-send-email-philipoakley@iee.org>
	<20130519173924.GB3362@elie.Belkin>
	<7v38thwn6l.fsf@alter.siamese.dyndns.org>
	<BDA138F1A58247F4A4940B3436A94485@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue May 21 00:22:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYTm-0000UA-A4
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab3ETWWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:22:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436Ab3ETWWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:22:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5E1720184;
	Mon, 20 May 2013 22:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X1o4fpmzGsJKxJzU4qIIuLZD7uU=; b=Yn9u+i
	LBEHUEI76LQdTjBlqo+4EFIJG4qJZAtLbdvvsOBV+r1CiXK8sqRBR50yQ2HME03v
	KeYiQQYBmJl+DZCsTZeII0kM0nRfYky2/yCFrCuq9xJB1BlUBZ7j0Xv1DnY3BTik
	d82WS3rRiGXtpcTvD74so5kz4OvRVBs5Frkoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qDvZ+/p2v6pYTK3WCnNvaP+WI+ZAMP1W
	U1c7yLdRwsUGlSrmKh6ZnpbbuGJzu0OkUDrOI59WRkqHtub8xJ6YFbmzeyH7pIw6
	JKV2U4z1Bl/tN1rTNaGi/DDbX0RsWy0wMtbVeBRslmdIyiFNnz39xGP59UdLFtra
	Tj7zyTjJlpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B934720183;
	Mon, 20 May 2013 22:22:48 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2010A20182;
	Mon, 20 May 2013 22:22:48 +0000 (UTC)
In-Reply-To: <BDA138F1A58247F4A4940B3436A94485@PhilipOakley> (Philip Oakley's
	message of "Mon, 20 May 2013 22:09:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD34FA3A-C19B-11E2-A9B3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224987>

"Philip Oakley" <philipoakley@iee.org> writes:

> So we can have a branch whose remote is '.'
> _and_ a remote whose URL is '.'

Yes, and they are two separate concepts.

"git fetch" while on "mywork" branch with this:

    [branch "mywork"]
        remote = git://git.k.org/pub/scm/git/git.git
        merge = refs/heads/master

without having any named remote whose remote.$name.url is set to
that URL may happen to work but it is by accident as far as I know.
As you do not copy to any remote tracking branches, @{u} would not
work, so it is not something useful.  But on the other hand

    [branch "mywork"]
        remote = .
        merge = refs/heads/master

works _as if_ you have

    [remote "."]
        url = "."
	;; no fetch refspec like +refs/heads/*:refs/heads/*
        ;; no push refspec like +refs/heads/*:refs/heads/*

so in that sense, you _could_ think of branch.$name.remote as a
(generic) URL or a name of a (special) remote, but it is easier to
think about it as the latter.

And remote.$name.url = "." for any name, e.g.

    [remote "here"]
        url = "."

is a special case of local repository that is named with a relative
filesystem path.

> Can there be a clash with a named remote that is actually '.', where
> the push/fetch is actually a no-op?

Nobody sane would do it in the first place, so...
