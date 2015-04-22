From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file: freshen existing objects
Date: Wed, 22 Apr 2015 15:00:06 -0700
Message-ID: <xmqqoamfddsp.fsf@gitster.dls.corp.google.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
	<20150417140315.GA13506@peff.net>
	<CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
	<20150420195337.GA15447@peff.net>
	<xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
	<20150420200956.GA16249@peff.net>
	<CADoxLGOdvJVgjRFrC81nM6A4=PRABSiL_EGOUtN7d-MAKXrzzg@mail.gmail.com>
	<xmqqiocpif8p.fsf@gitster.dls.corp.google.com>
	<xmqq4mo9gnq3.fsf@gitster.dls.corp.google.com>
	<CADoxLGOEE8rT7SS1n+wxmBbWWsLY+a5QstM=WPC=c5EajqfVkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 00:00:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl2gp-0001x0-IT
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 00:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752AbbDVWAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 18:00:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756316AbbDVWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 18:00:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2CC34B017;
	Wed, 22 Apr 2015 18:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K4T4tHyJObUN0wTI8Ecx4NrbM1U=; b=QUwBu6
	w8wvExzIgPPhEseB/fqlMuZZWO1soAAJEc5EmU7CJq7GR/LUBFU75B7PD8l/MHLe
	GtB6e7Jgp4lMQXz6WX4PxGfMjqR9OOdcVKPTO68WDeYN6b/QpPyA/9pDbkzSyxxG
	mQksWorl+2Yz03qzWP1IzDXMz7buQ8SRNymk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r1d5eRhXDCwU+pwJgpLKWBlH75FYPNU3
	5bVdivtLbQL8DfMzt7Qke8yiIv9JuWMZmuxACmjwQh5TTNTcXe8u0rSgLgKe/5/m
	T1yKJc3a+rK/qKd+F/cdEVHZF4OURrwlQ32beB6xMR5N2YscJCIkS3eT0aXFTAZr
	I6B334ypVU4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A92174B016;
	Wed, 22 Apr 2015 18:00:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 154D44B010;
	Wed, 22 Apr 2015 18:00:08 -0400 (EDT)
In-Reply-To: <CADoxLGOEE8rT7SS1n+wxmBbWWsLY+a5QstM=WPC=c5EajqfVkA@mail.gmail.com>
	(Stefan Saasen's message of "Wed, 22 Apr 2015 11:46:17 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F08BFCA4-E93A-11E4-A987-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267646>

Stefan Saasen <ssaasen@atlassian.com> writes:

> Anyway, long story short. We're interested to help but I'm not
> entirely sure what that would look like at the moment. Are there
> formed ideas floating around or would you be looking for some form of
> proposal instead?

I am not proposing anything or looking for proposals myself,
actually.  It is just somebody expressed interest in having tested
older maintenance track that is kept alive in the past, so I was
merely trying to help connect you with that old thread.

If those who are interested in having such LTS track(s) need
something specific from me, and if it will not be unrealistic
maintenance burden, I am willing to help.  That's all.

For example, LTS group for whatever reason may nominate 2.2.x track
as a base that they want to keep alive longer than other maintenance
tracks and promise to test changes to them to keep it stable.  Then
I can help the effort by making sure people's bugfix patches would
apply down to 2.2.x track (often people make mistake of using newer
facility to fix or test the fix for an ancient bug, and bugfix topic
branch ends up forked at a point much newer than where it should
be).
