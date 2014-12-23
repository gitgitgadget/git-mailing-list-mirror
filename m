From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to warnings
Date: Tue, 23 Dec 2014 09:20:03 -0800
Message-ID: <xmqq61d24724.fsf@gitster.dls.corp.google.com>
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
	<xmqqr3vq49w5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231723480.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:20:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3T82-0003YM-45
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbaLWRUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:20:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751543AbaLWRUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:20:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47FE9286DD;
	Tue, 23 Dec 2014 12:20:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sEMVMD5WvMuj6NoAHbg8UswqZnQ=; b=MuHCHo
	xJKpyCn8vYBud2rZdQYmuVOZ40qk//nVc2NhMPR0pTE/T5Rh+U/CRjqfWJr+yUkT
	tuHKsIwnadj35zy2Jko4Lz06H2CNvhlQCJ4gPe5wGOAymslsbSzcHXz9TUuxTkuU
	gCIbu/QGXwH84rtqmPDfObcPs3J8vlTW9kRxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YHqNb2GHTL4W1aKhiF46afBpVPUrYHGB
	sV5xK5n05i3RKTZyxRh/c6Kc3u4d1dsVcGshZePGzDihLn3Q0XjEkrKeYbhfofa9
	XWtUr8ipZlf9xhHEm8xuoJB6DCLSqA14o+6IVP0Ky16cJbms40Z/VPYqUy4Ywdeg
	ROaV6tdq37E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D611286DC;
	Tue, 23 Dec 2014 12:20:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4726286DB;
	Tue, 23 Dec 2014 12:20:04 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412231723480.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 23 Dec 2014 17:30:02 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF657F8E-8AC7-11E4-90B7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261745>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And *still*, this is *just* a global table with defaults. I would *still*
> need to copy-on-write when the first customization of the severity level
> takes place because I cannot allow the global defaults to be modified by
> one caller (that would defeat the whole purpose of having per-caller
> settings bundled in the fsck_options struct).

If you allocate a per-invocation fsck_options struct, then the
initialization the default with code is dead easy---you can just do
it immediately after you x[cm]alloc()---no?

What am I missing?
