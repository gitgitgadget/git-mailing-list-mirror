From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 08:30:46 -0700
Message-ID: <xmqqy488wb4p.fsf@gitster.mtv.corp.google.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
	<1461096530-82448-3-git-send-email-larsxschneider@gmail.com>
	<xmqqtwixz6i4.fsf@gitster.mtv.corp.google.com>
	<A6FD8E93-63E8-49EE-838D-2AF3FD3910D4@gmail.com>
	<xmqqh9exz4xq.fsf@gitster.mtv.corp.google.com>
	<CAHGBnuOuFYvf=CSyCLbhn7pyq4jsqH+p+xV9rxAtU1y3r+qjzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, luke@diamand.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:30:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asu5e-0003mU-8h
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbcDTPau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 11:30:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750701AbcDTPat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:30:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CC4B13F4C;
	Wed, 20 Apr 2016 11:30:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PfsygozJAF6WUXKCQVIDICZeaAo=; b=hkSAGz
	wUqjFCK0pkEb6L92i394ecgyWmaXC0aY8YDAqlHrpWtZypzYgsBR8bQ8wGAGf+lL
	DxYv4i1t7L4Cy/qlTml9GjuvL6X91ji6nXgNyoshZtGEeI41JvV0a/urM0kvndsq
	cRUwKEp1ATpFWWkq7M9yV2ORRrizwHoQ6vzaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BJfuCHpoZcoqReMdYonk81zx6lWY/l/F
	yJnbTyFcTzmvDLPFMDJJ9Q5YFzUwWpP1wBEssknChICzyKdinNp2cRn/k0AM9+T9
	ors6iIEnuLgsBYRgOE+H7UvLiRm71yo+rQ5UPu2dx55ARi2l2R4SJRF1HQLNPmBT
	EQMbNXvLrXg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 341E213F4A;
	Wed, 20 Apr 2016 11:30:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 943E313F48;
	Wed, 20 Apr 2016 11:30:47 -0400 (EDT)
In-Reply-To: <CAHGBnuOuFYvf=CSyCLbhn7pyq4jsqH+p+xV9rxAtU1y3r+qjzw@mail.gmail.com>
	(Sebastian Schuberth's message of "Wed, 20 Apr 2016 10:32:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DAF9E5AE-070C-11E6-B110-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292028>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> If clients rely on output targeted at human consumption it's not
> surprising that these clients need to be adjusted from time to time.
> What's troubling is not the change to git-lfs, but the very un-generic
> way git-p4 is implemented.

Sounds like the subcommand they are using is not meant for
scripting?  What is the kosher way to get at the information they
can use that is a supported interface for scripters?
