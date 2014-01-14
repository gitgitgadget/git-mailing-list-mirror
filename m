From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] blame: new option --prefer-first to better handle merged cherry-picks
Date: Mon, 13 Jan 2014 17:00:46 -0800
Message-ID: <xmqq7ga35qdd.fsf@gitster.dls.corp.google.com>
References: <20140113063008.GA3072@client.brlink.eu>
	<xmqqfvor5xil.fsf@gitster.dls.corp.google.com>
	<20140113225229.GA3418@client.brlink.eu>
	<xmqqbnzf5vvu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Tue Jan 14 02:01:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2sNR-0001y4-18
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 02:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbaANBA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 20:00:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbaANBAy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 20:00:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0A5163C9D;
	Mon, 13 Jan 2014 20:00:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bTqOPxfBdk93qBSbsJd5Cc6sIM0=; b=sm77j9
	dNSblNqF25uxGCLVFpghq03A7eDBBYCXWsV2wquweSjYmVumBnfLyeDxKo2ty1Yy
	MYgidXtrb70R9BvZ/PGqQUgBDkfagNda9gwzD8kUAQKvuW/gf3uetuaRVRD8Faev
	ZzkzyJ49NfpqWtB21eGDq2eBn2d8P2x5e2QQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EC2nKwM0Ld7KEOzh4Z1n8VnDXID3GvW8
	PfQE8em3m1wx4N3hsTKZUpB46cR63dyBssO+gfN5lVOwzLgsTFU6YEL6CgEE/fF9
	BhRFe8Ff3PqLhWx9HzvUy5ym/aFhqayxU78mntCyYNSLsmQlmMSajH7XXhBk7Vvs
	A4gupViMJEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7787063C92;
	Mon, 13 Jan 2014 20:00:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6874C63C8E;
	Mon, 13 Jan 2014 20:00:49 -0500 (EST)
In-Reply-To: <xmqqbnzf5vvu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 13 Jan 2014 15:01:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4ED050AE-7CB7-11E3-BB96-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240382>

Junio C Hamano <gitster@pobox.com> writes:

>> While the result is more consistent and more predictable in the case
>> of merged cherry picks, it is also slower in every case.
>
> Consistent and predictable, perhaps, but I am not sure "exact" would
> be a good word.

Another thing I am not enthusiasitc about this change is that I am
afraid that this may make "git blame -- path" and "git log -- path"
work inconsistenly.  The both cull side branches whenever one of the
parents gave the resulting blob, even that parent is not the first
one.  But "git blame --prefer-first -- path", afaict, behaves quite
differently from "git log --first-parent -- path", even though they
share similar option names, adding more to the confusion.
