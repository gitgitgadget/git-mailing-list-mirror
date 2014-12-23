From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to warnings
Date: Tue, 23 Dec 2014 08:18:50 -0800
Message-ID: <xmqqr3vq49w5.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqoarbidv7.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
	<xmqqfvc78hwq.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info>
	<xmqqy4pz71g7.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
	<xmqqlhlz6zti.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231051320.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 17:18:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3SAj-0005kd-JP
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 17:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbaLWQSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 11:18:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932302AbaLWQSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 11:18:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EDB028369;
	Tue, 23 Dec 2014 11:18:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9hDDdVhx04IHCF838ZqhAsersLA=; b=IlPOLj
	AZCnkH43Je29x9KbPIWh/zE2Zhowb34w/K65ZFV0Z47HhDVsJ9NUWjYqnsg5bvby
	jBPvDLYHOSMoKtZTz6d0oxygKPS85jYNZkCApR6nPkBPoe9sOpP43kw2hcNP5w62
	qSNH4HwOrTF9oZDl0lBU1N+RmNwsUh4Xt0bpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j+yRtDTMgCI9oPO44sWFtJhyAZNk6Xp2
	fO8w5O5Wbi+oLrtCbsOiryvdHiVQ8kEZOD1WA4MHHmO+rJ5fUHjdtk5z6So90xpa
	RmrkWxWLnI1MsKK8xrvneBNvV4k2ri4scm6VGwrDk9VIOgWTjpRdXs134DaLvMZz
	oHleYgY09NU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14CED28368;
	Tue, 23 Dec 2014 11:18:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BEF328367;
	Tue, 23 Dec 2014 11:18:51 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412231051320.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 23 Dec 2014 11:53:36 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6204E89E-8ABF-11E4-B589-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261736>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, if we had to change the lookup such that it uses an array always,
> we would have to introduce a function to initialize the struct, always, in
> particular we would have to find a place to call that initialization
> function in, say, builtin/fsck.c (actually, in every code path that calls
> into the fsck machinery).

You would need to call a function to "initialize" the table if you
support customization by reading the configuration files anyway.  I
am not sure why you think finding such a place is hard.  Puzzled.

Also I suspect that you can tell the compiler to initialize the
array in place with default values, perhaps like this?

-- >8 --
#include <stdio.h>

/* sorted by the default severity (lowest impact first) */
#define EVENT_LIST(F) \
	F(EVENT_A), \
	F(EVENT_B), \
	F(EVENT_C), \
	F(EVENT_D)

#define ID_(event) ID_ ## event
enum event_id {
	EVENT_LIST(ID_)
};


enum severity_level {
	severity_info, severity_warn, severity_error
};

/* below this one are INFO */
#define FIRST_WARN_EVENT_ID		ID_EVENT_B
/* below this one are WARN */
#define FIRST_ERROR_EVENT_ID		ID_EVENT_C

#define STRING_(s) #s
#define DESC_(event) \
	{ \
		ID_ ## event, \
		STRING_(event), \
		(ID_ ## event < FIRST_WARN_EVENT_ID \
		? severity_info \
		: ID_ ## event < FIRST_ERROR_EVENT_ID \
		? severity_warn \
		: severity_error) \
	}

struct event_config {
	enum event_id id;
	const char * name;
	enum severity_level level;
} event[] = {
	EVENT_LIST(DESC_)
};

int main(int ac, char **av)
{
	int i;

	for (i = 0; i < sizeof(event) / sizeof(event[0]); i++) {
		printf("%d, %s, %d\n",
		       event[i].id, event[i].name, event[i].level);
	}
	return 0;
}
