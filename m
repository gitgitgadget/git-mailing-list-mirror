From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH 4/9] Teach merge the --[no-]recurse-submodules option
Date: Mon, 03 Feb 2014 15:01:10 -0800
Message-ID: <xmqq4n4fdcnd.fsf@gitster.dls.corp.google.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
	<52CC3E16.4060909@web.de>
	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
	<52EFF25E.6080306@web.de> <52EFF311.1090202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:01:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASVx-0007OH-RN
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbaBCXBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:01:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbaBCXBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:01:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7AB069729;
	Mon,  3 Feb 2014 18:01:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=60KitUtk6eD8r8Vt1VyRKgjNdL4=; b=dh+oI6
	pxYyp2V5jeMfZaHN5XM/4kDGATMSf/sqaCemG+HtJ614lYfc3GOc+K6eg6KEjD5h
	Ne/wUKbRSVzLwx/nhm35EuPJ0Bndz4g62XJlBaxivYsJuqsuQvkhuZ9Wlfu/uF2W
	y6cjLAoA33w7rk0O9ui6sgQfCo9iqX4SBJPFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P2zzVzgo8otyrf0WeOA1Or987rukOb66
	QzZnubwLNJxiFjOJV/JHiKqkmx9CIT1uClB3raJUaxVBltoy+zpgrXJxPc/vQENl
	iYtCEFVwnXrLocjdjDnx4KdL3i5upKPrKNwr+oX8YrJb+wyqdotARBAal2QkjUki
	ArxUYlUf8Qg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96CFD69728;
	Mon,  3 Feb 2014 18:01:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC73C69722;
	Mon,  3 Feb 2014 18:01:11 -0500 (EST)
In-Reply-To: <52EFF311.1090202@web.de> (Jens Lehmann's message of "Mon, 03 Feb
	2014 20:50:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 13636A30-8D27-11E3-B69F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241489>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This new option will allow the user to not only update the work tree of
> the superproject according to the merge result but to also update the
> work tree of all initialized submodules (so they match the SHA-1 recorded
> in the superproject). But this commit only adds the option without any
> functionality, that will be added to unpack_trees() in subsequent commits.

When the two branches of the superproject being merged wants to put
a submodule project to commit A and B, that conflict needs to be
resolved, but if they agree that the submodule project should be at
C (which is different from what the current superproject HEAD has
for the submodule in its gitlink), then we want a checkout of that
commit to happen in that submodule.  Makes sense.

After resolving such a conflict between A and B, who is responsible
to adjust the working tree state of the submodule involved, by the
way?  "git merge --continue" does not exist and its moral equivalent
to conclude such an interrupted merge is "git commit".  Should it
learn to do "recurse-submodule", or should the user run a separate
"checkout --recurse-submodule"?
