From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] commit: add tests of commit races
Date: Wed, 11 Feb 2015 10:54:38 -0800
Message-ID: <xmqqy4o4th1t.fsf@gitster.dls.corp.google.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-7-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kYmgeXt1k22h3fbDR04BTHOQRxryNVSJDOL2DC5yLLHpw@mail.gmail.com>
	<xmqq1tlxwpgi.fsf@gitster.dls.corp.google.com>
	<54DB6F9C.7060600@alum.mit.edu>
	<xmqqk2zouxnx.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYFvLWsasWsEevLqugY_Yts5K4e3WRJtKmN4S67F9W6+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:54:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLcR5-0007yD-DJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 19:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbbBKSyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 13:54:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753658AbbBKSyl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 13:54:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA92C3897A;
	Wed, 11 Feb 2015 13:54:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z/9KhppMcRGxU+tu7kHhptJPy0k=; b=oxMfmc
	PLG23EVOVbuzmAFE2EbLsG+3711tWVuOoPpmB1iBWiHL+ME1zGxFm7665Kmjbeyf
	bm6DzKN8x9jxMkLXcGLxRlnid/KW/EbvyO9dkZhQGZW2RWDJCkQZakwoovL8kNw+
	QGMPxNNBQGUIP6Dj5ILaVWmOMX08GkX+fxiGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NtG3S63/zeeFEHsIvtIaKEO2I7gV4mkm
	dzjbU1ytKPmdXgfdx7+lPUVzeh0NH2o9WYZESLOPX88PWeL2Z2ZAWxRA0O5UGNZ3
	5nNtr/a6Xllnx7o0XwHm2HdOn0OxR/0n/rqqWa+SI0REbY24Bap4FjxU0LuL8Bk1
	WVXblhJMaqc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDAA738979;
	Wed, 11 Feb 2015 13:54:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37C9238976;
	Wed, 11 Feb 2015 13:54:40 -0500 (EST)
In-Reply-To: <CAGZ79kYFvLWsasWsEevLqugY_Yts5K4e3WRJtKmN4S67F9W6+Q@mail.gmail.com>
	(Stefan Beller's message of "Wed, 11 Feb 2015 10:24:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EF2B2FC-B21F-11E4-8FC0-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263688>

Stefan Beller <sbeller@google.com> writes:

> Quoting from wikipedia[1]
>
> (note however that when the United States joined the Convention
> in 1988, it continued to make statutory damages and attorney's fees
> only available for registered works).
>
> Does that mean if somebody would infringe the GPL on git (e.g. selling
> a modified git version without giving sources), it would be harder to
> tell him to stop because of the missing attorney's fees in case we drop
> out the copyright notices? (I have no deep understanding of legal
> processes in the US).

No.  "registered works" in that sentence is about registering
copyright with U.S. Copyright Office.  In-file Copyright circle-c
line does not have much to do with that.
