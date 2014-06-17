From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Annotated tags by default?
Date: Tue, 17 Jun 2014 14:02:37 -0700
Message-ID: <xmqqppi7l05u.fsf@gitster.dls.corp.google.com>
References: <CAHd499Bszq1nw=cu9UZpnodR1ZzmX2Bw2kJr8X13_mEUd7ombA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx0o6-0002VM-Dl
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbaFQVCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:02:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54497 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965083AbaFQVCo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:02:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 398C81F03E;
	Tue, 17 Jun 2014 17:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6wzEVmPtJ+VJ8Fg5rlESHNQAiGw=; b=bjij72
	1xQop2yKqs0GwHO4Eg6rC3p8yphCJJkGlbITwVKHDNQc01C8tCmbXRdL27Yd+/39
	/TBRDQsh+5V06gc8w9ZC408QNVYWpSTW25LILZK8yQp+J6efCI0l/vP+ZUqi+/ym
	jmNwfT4gWnFCFKCj2sAIqYbF4E7o3Bh2dPGhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KbSYlRBCH0t2lB6lA6BBpkXCMGODtQeQ
	P/RPANZk64ShaQWu9XhKMY3eAOsauumSzwMMoOapSKB2bLvjmqZNOdVJjVAj72dG
	XO5eAm4brv4PY2P2/Dq1pb9YRZiPPtkuxFfEs4SsoxAdUsp3+GWWlbNrLerPNAjY
	NRBvf14WRP4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EB6E1F03D;
	Tue, 17 Jun 2014 17:02:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E4B501F036;
	Tue, 17 Jun 2014 17:02:36 -0400 (EDT)
In-Reply-To: <CAHd499Bszq1nw=cu9UZpnodR1ZzmX2Bw2kJr8X13_mEUd7ombA@mail.gmail.com>
	(Robert Dailey's message of "Tue, 17 Jun 2014 15:04:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B5DAB18E-F662-11E3-9FB1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251951>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> Is there a config option or some way for `git tag -a` to be the
> default? I could create an alias but would make more sense to have a
> config:
>
> git config --global tag.alwaysannotate true

If you really wanted to, you could do the following (and you must to
do all of the following):

 * Introduce "git tag --no-annotate" option, that defeats the effect
   of such a configuration variable.

 * Devise some way to reliably catch scripts that use "git tag"
   without saying what kind of tag they want to create.  Add new
   code to issue a warning message saying that the script will be
   horribly broken when user starts using the configuration variable
   that will be introduced in the future.  This will force them to
   be updated to pass the "--no-annotate" option.

 * Wait for several releases to make sure that no script that want
   to use light-weight tags use "git tag" without "--no-annotate"
   option.

 * Introduce the configuration variable.

I personally do not think it is worth it, and also I do not know what
that "some way to reliably catch" would look like.

We gave short-and-sweet "-a" and "-s" options exactly because we
wanted to make it easy to type them.  Also, "tag -m msg" will DWIM
to "-a".
